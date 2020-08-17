Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D84C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A6C206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 00:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHQAp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 20:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgHQApW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 20:45:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 713C2AB8B;
        Mon, 17 Aug 2020 00:45:45 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     oleg@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -next 0/2] tasklist_lock vs get/set priority syscalls
Date:   Sun, 16 Aug 2020 17:31:46 -0700
Message-Id: <20200817003148.23691-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a (late) update on trying to reduce some of the scope of the tasklist_lock
for get/setpriority(2) as well as the block io equivalent. This version addresses
Oleg's previous concerns and incorporates his feedback.

Changes from v1:
https://lore.kernel.org/lkml/20200512000353.23653-1-dave@stgolabs.net/

 - only take the lock for PGID cases.
 - drop bogus PF_EXITING checks (and live with the small exit race).
 - add patch for IOPRIO_WHO_PGRP.

Please consider for v5.10.

Thanks!

Davidlohr Bueso (2):
  kernel/sys: only take tasklist_lock for get/setpriority(PRIO_PGRP)
  block: fix ioprio_get/set(IOPRIO_WHO_PGRP) vs setuid(2)

 block/ioprio.c |  4 ++++
 kernel/sys.c   | 16 ++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

--
2.26.2

