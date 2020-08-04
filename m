Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC071C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16EC2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 01:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgHDBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:20:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:35805 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728037AbgHDBUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:20:02 -0400
IronPort-SDR: zy8bMbpY9Fzvethr/eR30k1+FUeVvB+ga+0mc5IPhUQdAY7n/g4sXqYqsClu0Fp0bBBGf0u/27
 lzWRhsYx4/0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170319215"
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; 
   d="scan'208";a="170319215"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 18:20:01 -0700
IronPort-SDR: ih3plJPOUr86ZaDzhUpcBpYgi4VBrU8kXxWFd/YUmtYgUzQ4V/V86OPzGbtw5XizFTJv+Ej65p
 VWUrAl5fiW1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,432,1589266800"; 
   d="scan'208";a="466828964"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Aug 2020 18:19:59 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2lcU-0000LU-FB; Tue, 04 Aug 2020 01:19:58 +0000
Date:   Tue, 4 Aug 2020 09:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xi Wang <xii@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Xi Wang <xii@google.com>
Subject: [RFC PATCH] sched: __rebuild_sched_domains() can be static
Message-ID: <20200804011922.GA47754@cda59a0f6a5b>
References: <20200728070131.1629670-1-xii@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728070131.1629670-1-xii@google.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 cpuset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5087b90c4c47b..c871b4f4a7a3e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1015,7 +1015,7 @@ static void rebuild_sched_domains_locked(int force_update)
 }
 #endif /* CONFIG_SMP */
 
-void __rebuild_sched_domains(int force_update)
+static void __rebuild_sched_domains(int force_update)
 {
 	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
