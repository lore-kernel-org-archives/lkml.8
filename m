Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCDC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275F524689
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579373584;
	bh=EDgOMnAEagyyXVIMDxATru26drBJv4OxJ6ZTx8UxUGY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RVmsUjrqKTDak1MY7C/x8OPTnt1tX/sUkGm+mKdxtXcdo8Q3xmzLl8trNNZ8pDatz
	 ivHC1QSm4OlqnGZxc9j9n4Zd15QiYyBf9XvODHtYB5ZDjcqX5v3Z8j2ZTaJpZ+Cjax
	 77LUUyP+SMJ/f0ocuRjvFZhEhWJRdrXzTbWXxbSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARSxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 13:53:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43134 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgARSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:53:02 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so25699098wre.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 10:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K9wQPcVZRtLTjb06NU1Vo+tFi1AE6139t3dzmVvZahk=;
        b=YjptB5n/ojo12CuJukBq2/prQSnp8vGBwP7EHskJcsPtLJ2/pEYIuZJs3L8QCwPRhN
         XPBMrlk4bufflw/1mROBllidwnIEfpEZVlVxlF4T2+pjoqsky5SwfNd6r2rDHrafMnGs
         lI7yJWl0yGsoxe0nMmTn7Wa5lGo9RgYHnedg86WQd56cEAezAexnpV2/dn6Pxh1rb8ce
         K5uI6hVol9fdafoC69/2E+086ALzrNvG4lr6JFqobcdlf6kZdwawh/76ig339kGhPKho
         QFgmJ+rHUX7OcXGfJgffqZRDJeRK1ZHbt3aviHGW6pKpCMdy+pkytsE1VWBi61aqx8mH
         VS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=K9wQPcVZRtLTjb06NU1Vo+tFi1AE6139t3dzmVvZahk=;
        b=Y/Cpi5CGrjDfjrF2TXMWOn4z8qm7ptFJiYA7bHqiTvo7HBW8a7LZnSqmWs4Q3jHbxG
         01VH+MMSH6Wcuw1iU2JtmxrlgG8YuyEtCrZhyCzqQmPhGXuY6Hz3IvppHuE0wPMMyomb
         7+2t25Kx1kizaZ9r4sI2Q9D8iQz1cgiXyUapLsYrg0qLyAMdVRZ9DxGBSKtRWThaJHYU
         VFGH8FXyPWfzAyov7IpGXukeNVPQmPK3U2rR3HRvlzotSWXso0SMm+2CeVINt0Y0On8L
         0ncLy9ywmMXEf4KFpxucDPNvtMIJv9XHryKtSQPflSHd16WKyyyeF+tYOa97E/i7jfJ3
         Mt1w==
X-Gm-Message-State: APjAAAW/i+B6xc71WXVaqauNmUvuypIrGdm9DvozSJhy+MVsFVa4HPr6
        8VeCMDLxtus6TwN9qMUvRd7JCqXm
X-Google-Smtp-Source: APXvYqzZhsREYfVfrc2WEkyHMYC2t/h43WPO0zBfPAVXm5JCFE3q/R7g3opycC8s2pxOLgIvew6ViQ==
X-Received: by 2002:adf:f484:: with SMTP id l4mr10177167wro.207.1579373581270;
        Sat, 18 Jan 2020 10:53:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p17sm39615291wrx.20.2020.01.18.10.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 10:53:00 -0800 (PST)
Date:   Sat, 18 Jan 2020 19:52:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20200118185258.GA19672@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: a006483b2f97af685f0e60f3a547c9ad4c9b9e94 x86/CPU/AMD: Ensure clearing of SME/SEV features is maintained

Misc fixes:

 - a resctrl fix for uninitialized objects found by debugobjects,

 - a resctrl memory leak fix,

 - fix the unintended re-enabling of the of SME and SEV CPU flags if 
   memory encryption was disabled at bootup via the MSR space.

 Thanks,

	Ingo

------------------>
Qian Cai (1):
      x86/resctrl: Fix an imbalance in domain_remove_cpu()

Shakeel Butt (1):
      x86/resctrl: Fix potential memory leak

Tom Lendacky (1):
      x86/CPU/AMD: Ensure clearing of SME/SEV features is maintained


 arch/x86/kernel/cpu/amd.c              | 4 ++--
 arch/x86/kernel/cpu/resctrl/core.c     | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 90f75e515876..62c30279be77 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -615,9 +615,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		return;
 
 clear_all:
-		clear_cpu_cap(c, X86_FEATURE_SME);
+		setup_clear_cpu_cap(X86_FEATURE_SME);
 clear_sev:
-		clear_cpu_cap(c, X86_FEATURE_SEV);
+		setup_clear_cpu_cap(X86_FEATURE_SEV);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 03eb90d00af0..89049b343c7a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -618,7 +618,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (static_branch_unlikely(&rdt_mon_enable_key))
 			rmdir_mondata_subdir_allrdtgrp(r, d->id);
 		list_del(&d->list);
-		if (is_mbm_enabled())
+		if (r->mon_capable && is_mbm_enabled())
 			cancel_delayed_work(&d->mbm_over);
 		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
 			/*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2e3b06d6bbc6..dac7209a0708 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1741,9 +1741,6 @@ static int set_cache_qos_cfg(int level, bool enable)
 	struct rdt_domain *d;
 	int cpu;
 
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
 	if (level == RDT_RESOURCE_L3)
 		update = l3_qos_cfg_update;
 	else if (level == RDT_RESOURCE_L2)
@@ -1751,6 +1748,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 	else
 		return -EINVAL;
 
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
 		/* Pick one CPU from each domain instance to update MSR */
