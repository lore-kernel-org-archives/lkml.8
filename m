Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B6C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860D720722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbgEKQjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbgEKQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:39:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6810C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:39:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5BD812A07F2
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org,
        breeves@redhat.com, mpatocka@redhat.com, khazhy@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 0/2] Historical Service Time Path Selector
Date:   Mon, 11 May 2020 12:39:08 -0400
Message-Id: <20200511163910.3778467-1-krisman@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fourth version of HST applies the suggestion from Mikulas Patocka
to do the ktime_get_ns inside the mpath map_bio instead of generic
device-mapper code. This means that struct dm_mpath_io gained another
64bit field.  For the request-based case, we continue to use the block
layer start time information.

With this modification, I was able obtain similar performance on  BIO
to request-based multipath with HST on the benchmarks shared in v1.

v3: https://www.redhat.com/archives/dm-devel/2020-April/msg00308.html
v2: https://www.redhat.com/archives/dm-devel/2020-April/msg00270.html
v1: https://www.redhat.com/archives/dm-devel/2020-April/msg00176.html

Gabriel Krisman Bertazi (1):
  md: mpath: Pass IO start time to path selector

Khazhismel Kumykov (1):
  md: mpath: Add Historical Service Time Path Selector

 drivers/md/Kconfig                      |  11 +
 drivers/md/Makefile                     |   1 +
 drivers/md/dm-historical-service-time.c | 561 ++++++++++++++++++++++++
 drivers/md/dm-mpath.c                   |  12 +-
 drivers/md/dm-path-selector.h           |   2 +-
 drivers/md/dm-queue-length.c            |   2 +-
 drivers/md/dm-service-time.c            |   2 +-
 7 files changed, 585 insertions(+), 6 deletions(-)
 create mode 100644 drivers/md/dm-historical-service-time.c

-- 
2.26.2

