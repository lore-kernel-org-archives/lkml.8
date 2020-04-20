Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B370C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805CA206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgDTPBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:01:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:48218 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgDTPBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:01:10 -0400
IronPort-SDR: Bo+CwO6brjrTEdHI7DwAYyCO1jr+5ZHRrOBuM013Hd/XVGjOIzrJvvDPdK2EngtmTgH/z552wa
 +Xmv2hvRVFHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 08:01:06 -0700
IronPort-SDR: n38Rg7HrYUkhUfLSZrRwY/W5+DT8LwFsFSdKOIDlzbVDXA92nc0Oycmz0PDhIlZZc3AxY9KYDk
 gZO1CTwGoY5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,406,1580803200"; 
   d="scan'208";a="279267745"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2020 08:01:03 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][v2] sched: Clean up newidle_balance() and pick_next_task()
Date:   Mon, 20 Apr 2020 23:01:27 +0800
Message-Id: <cover.1587393807.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Peter suggested, here are two minor code clean up in the scheduler:
1. turn newidle_balance() into a static function.
2. code extraction in pick_next_task() for future re-use.

Chen Yu (2):
  sched: Make newidle_balance() static again
  sched: Extract the task putting code from pick_next_task()

 kernel/sched/core.c  | 39 +++++++++++++++++++++++----------------
 kernel/sched/fair.c  |  6 ++++--
 kernel/sched/sched.h |  4 ----
 3 files changed, 27 insertions(+), 22 deletions(-)

-- 
2.17.1

