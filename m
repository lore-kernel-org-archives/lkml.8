Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE211C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E74E2074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587806903;
	bh=bFlmO2PC94Yvdz3A/VzNo0f6Qbxukz2yRrMu6RwUjp8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ZDUCwsZpbBfXUpGXljhhM19rbytzfMywbfAfw8e2OZA3WVI2o24/VPUazsQDyoKfz
	 VI7cU/Ia/zfBK6Te1FolSbQUzS/M2qhpD+QjSlLy3DG3cqzlcuV5mxWAYN8978tDNA
	 LNN+kQV81gKtzBmFRPn7AdRrpZlWV6NPdPsDBBJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDYJ2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgDYJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:28:22 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0EC09B04B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:28:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u127so14439772wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4Ov1WJ/PgS4EbQynFQx8PgzeBkw/xgApXHyA3MQ0+9M=;
        b=qjLglRGNuU2bK+hrhzInqG9IEVIcOdbIGNB9SPi9R2vlbJ/aYgpt3UicGGLKVUsw18
         Gk7KG3ML9v4AtAF3fUg8qXmIyWLV7y1iVjl8xWlI1O+SE5FNOdNKCR6GMpFf4cR7Nvsq
         B2C9i3B8n4eLQg9TPU0RKIOO7MP/aojFwOdCj4zhMPlJbvCKok40hqv5WVKbVVxxJXh6
         mGT4kOMI8pPyIdP3cxsd/N6ucFELKz1540AlN9eSAFd3E/yFmubmsBp1Wqut61VA7Nno
         GV5nsPcyhe/wbfep1OLLm0lJr9zSr0ZxbmRLzWyM8k3ezG3NdGg78hWk8KMdI/DYYoDN
         LtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=4Ov1WJ/PgS4EbQynFQx8PgzeBkw/xgApXHyA3MQ0+9M=;
        b=B0nnkaCK5OJMUtCVD0zDook9eEuPb765+YLNVwEOIRpRLqH7pIuLt3DzELYrZZMl8v
         liGfi0LhRgyPr5ZtYNpxmJFmvfbZa7tJA68YfJUsVgfKYa4PfQqCofos38mBIid/3zN1
         4x/QIGNl9c+kLjIZQk/xMgJKfbm1y3oAB9AStkMuINBHw/A68lLFNMQ/HOj5GRLVvEw0
         2ifRk0O1bF1pMWWL6EzfrkSNWEJliXzIY12fVfsSKWpFTE5vHIK5jCDDjCHtTXqsvknD
         VyvOOI9v0UlNfOoP0yR+zFoCZI4zIjy2ZnQiK0jGNjkx+KwO7340Vi3/ethW6TTv45hV
         Wb8Q==
X-Gm-Message-State: AGi0PuaXZ1X4v0L1Kf77BJDeqbvc3CetNlAse5vnybgPXk+IzmF1h2kf
        mriudqSs1BDSX6TcJ7mKLek=
X-Google-Smtp-Source: APiQypJUwBdJWIj3ddyLksHS5tELezEBjyOn68m5su5LlQoc5T3dj72/uG/DQMsa8by/BY1Oq33/iA==
X-Received: by 2002:a1c:32c7:: with SMTP id y190mr15942213wmy.13.1587806900517;
        Sat, 25 Apr 2020 02:28:20 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 145sm6700781wma.1.2020.04.25.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:28:19 -0700 (PDT)
Date:   Sat, 25 Apr 2020 11:28:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <20200425092818.GA58070@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-04-25

   # HEAD: eaf5a92ebde5bca3bb2565616115bd6d579486cd sched/core: Fix reset-on-fork from RT with uclamp

Misc fixes:

 - an uclamp accounting fix
 - three frequency invariance fixes and a readability improvement

 Thanks,

	Ingo

------------------>
Giovanni Gherdovich (3):
      x86, sched: Bail out of frequency invariance if base frequency is unknown
      x86, sched: Account for CPUs with less than 4 cores in freq. invariance
      x86, sched: Move check for CPU type to caller function

Peter Zijlstra (Intel) (1):
      x86, sched: Don't enable static key when starting secondary CPUs

Quentin Perret (1):
      sched/core: Fix reset-on-fork from RT with uclamp


 arch/x86/kernel/smpboot.c | 47 +++++++++++++++++++++++++++++++++--------------
 kernel/sched/core.c       |  9 ++-------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..8c89e4d9ad28 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -147,7 +147,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(void);
+static void init_freq_invariance(bool secondary);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -185,7 +185,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance();
+	init_freq_invariance(true);
 
 	/*
 	 * Get our bogomips.
@@ -1341,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance();
+	init_freq_invariance(false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -1877,9 +1877,6 @@ static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
 	int err, i;
 	u64 msr;
 
-	if (!x86_match_cpu(has_knl_turbo_ratio_limits))
-		return false;
-
 	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
@@ -1945,18 +1942,23 @@ static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
 
 static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 {
+	u64 msr;
 	int err;
 
 	err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
 	if (err)
 		return false;
 
-	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, turbo_freq);
+	err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
 	if (err)
 		return false;
 
-	*base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
-	*turbo_freq = (*turbo_freq >> 24) & 0xFF;   /* 4C turbo    */
+	*base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
+	*turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
+
+	/* The CPU may have less than 4 cores */
+	if (!*turbo_freq)
+		*turbo_freq = msr & 0xFF;         /* 1C turbo    */
 
 	return true;
 }
@@ -1972,7 +1974,8 @@ static bool intel_set_max_freq_ratio(void)
 	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
-	if (knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
+	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
+	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
 		goto out;
 
 	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
@@ -1985,13 +1988,22 @@ static bool intel_set_max_freq_ratio(void)
 	return false;
 
 out:
+	/*
+	 * Some hypervisors advertise X86_FEATURE_APERFMPERF
+	 * but then fill all MSR's with zeroes.
+	 */
+	if (!base_freq) {
+		pr_debug("Couldn't determine cpu base frequency, necessary for scale-invariant accounting.\n");
+		return false;
+	}
+
 	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
 	arch_set_max_freq_ratio(turbo_disabled());
 	return true;
 }
 
-static void init_counter_refs(void *arg)
+static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
 
@@ -2002,18 +2014,25 @@ static void init_counter_refs(void *arg)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(void)
+static void init_freq_invariance(bool secondary)
 {
 	bool ret = false;
 
-	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (secondary) {
+		if (static_branch_likely(&arch_scale_freq_key)) {
+			init_counter_refs();
+		}
+		return;
+	}
+
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 
 	if (ret) {
-		on_each_cpu(init_counter_refs, NULL, 1);
+		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a61a3b8eaa9..9a2fbf98fd6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1232,13 +1232,8 @@ static void uclamp_fork(struct task_struct *p)
 		return;
 
 	for_each_clamp_id(clamp_id) {
-		unsigned int clamp_value = uclamp_none(clamp_id);
-
-		/* By default, RT tasks always get 100% boost */
-		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
-			clamp_value = uclamp_none(UCLAMP_MAX);
-
-		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
+		uclamp_se_set(&p->uclamp_req[clamp_id],
+			      uclamp_none(clamp_id), false);
 	}
 }
 
