Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8888C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B052020774
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGFTfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:35:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:49500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFTfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:35:11 -0400
IronPort-SDR: 3qnslLAeZ/X99kB2JIpsLiBQe/Z6xisKlJmvtbpDyWSQ9c1BF5d+84wYtKGE5czAIqFxPgItS0
 qIl59TaszbOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="209013624"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="209013624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 12:35:10 -0700
IronPort-SDR: VSEbc/NmVuct6JehfGYreWWGi6iL6SJxGytq20wx7PTiWqEsAJmpXq2cGT2kTflRo9xJUlz5xV
 +NWdIuNIqSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="322456978"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jul 2020 12:35:08 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC] Makes sd->flags sysctl writable
Date:   Tue,  7 Jul 2020 03:36:13 +0800
Message-Id: <cover.1594062828.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that recently the flags of sched domain could
not be customized via sysctl, which might make it a little
inconenient for performance tuning/debugging.

echo 343 > /proc/sys/kernel/sched_domain/cpu0/domain0/flags
bash: flags: Permission denied

343 stands for:
(SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE)

As mentioned in Commit 9818427c6270 ("sched/debug: Make sd->flags
sysctl read-only"), the flags field is made read-only, due to the
concerns that the sd flags and the per cpu cache domain pointer are
not coherent.

This trial patch tries to address the issue by updating the cache
domain pointer once the flag has been modified. So that the sd->flags
could be changed via sysctl.

I'm not sure if there is other purpose that we've set the flags to
read-only, but it seems that keeping the sd->flags writable could
help diagnose the system easier. Any comment would be appreciated.

Chen Yu (2):
  sched/topology: Add update_domain_cpu()
  sched/debug: Make sd->flags sysctl writable again

 include/linux/sched/topology.h |  5 +++++
 kernel/sched/debug.c           | 30 +++++++++++++++++++++++++++---
 kernel/sched/topology.c        | 11 +++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.17.1

