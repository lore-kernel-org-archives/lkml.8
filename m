Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3BBC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B50320714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC0Vnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:43:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgC0Vnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:43:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D6945ABAE;
        Fri, 27 Mar 2020 21:43:39 +0000 (UTC)
Date:   Fri, 27 Mar 2020 22:43:34 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/vtime: Fix an unitialized variable warning
Message-ID: <20200327214334.GF8015@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dude,

right before I was going to send the trivial, shut-up-gcc variant, I
thought that maybe we should do this instead.

Thoughts?

---
Fix:

  kernel/sched/cputime.c: In function ‘kcpustat_field’:
  kernel/sched/cputime.c:1007:6: warning: ‘val’ may be used \
	  uninitialized in this function [-Wmaybe-uninitialized]
   1007 |  u64 val;
        | ^~~

because gcc can't see that val is used only when err is 0.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/sched/cputime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index dac9104d126f..ff9435dee1df 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1003,12 +1003,12 @@ u64 kcpustat_field(struct kernel_cpustat *kcpustat,
 		   enum cpu_usage_stat usage, int cpu)
 {
 	u64 *cpustat = kcpustat->cpustat;
+	u64 val = cpustat[usage];
 	struct rq *rq;
-	u64 val;
 	int err;
 
 	if (!vtime_accounting_enabled_cpu(cpu))
-		return cpustat[usage];
+		return val;
 
 	rq = cpu_rq(cpu);
 
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
