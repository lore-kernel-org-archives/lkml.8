Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD18206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgDPVNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:13:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44144 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDPVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:13:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E8F742A23DF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org, song@kernel.org,
        khazhy@google.com, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] Historical Service Time Path Selector
Date:   Thu, 16 Apr 2020 17:13:34 -0400
Message-Id: <20200416211336.2423618-1-krisman@collabora.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This small series implements a new path selector that leverages
historical path IO time in order to estimate future path performance.
Implementation details can be found on Patch 2.

This selector yields better path distribution, considering the mean
deviation from the calculated optimal utilization, for small IO depths
when compared to the Service Time selector with fio benchmarks.  For
instance, on a multipath setup with 4 paths, where one path is 4 times
slower than the rest, issuing 500MB of randwrites, we have the following
path utilization rates:

      |    depth=1    |    depth=64   |       |
      |   ST  |   HST |   ST  |   HST |  Best |
|-----+-------+-------+-------+-------+-------|
| sda | 0.250 | 0.294 | 0.297 | 0.294 | 0.307 |
| sdb | 0.250 | 0.297 | 0.296 | 0.297 | 0.307 |
| sdc | 0.250 | 0.296 | 0.298 | 0.296 | 0.307 |
| sdd | 0.250 | 0.112 | 0.106 | 0.112 | 0.076 |

For small depths, HST is much quicker in detecting slow paths and has a
better selection than ST.  As the iodepth increases, ST gets close to
HST, which still behaves steadily.

The raw performance data for different depths types of IO can be found
at:

  <https://people.collabora.com/~krisman/GOO0012/hst-vs-st-bench.html>

This was tested primarily on a Google cloud SAN with real data and usage
patterns and with artificial benchmarks using fio.

Khazhismel Kumykov (2):
  md: Expose struct request to path selector
  md: Add Historical Service Time Path Selector

 drivers/md/Kconfig                      |  11 +
 drivers/md/Makefile                     |   1 +
 drivers/md/dm-historical-service-time.c | 561 ++++++++++++++++++++++++
 drivers/md/dm-mpath.c                   |  12 +-
 drivers/md/dm-path-selector.h           |   6 +
 5 files changed, 589 insertions(+), 2 deletions(-)
 create mode 100644 drivers/md/dm-historical-service-time.c

-- 
2.26.0

