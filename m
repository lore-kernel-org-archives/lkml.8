Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F17C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331612075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgEFSIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgEFSIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:08:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16976C061A10;
        Wed,  6 May 2020 11:08:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWOT7-0001F7-C9; Wed, 06 May 2020 20:08:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 057331C0092;
        Wed,  6 May 2020 20:08:29 +0200 (CEST)
Date:   Wed, 06 May 2020 18:08:28 -0000
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove unnecessary RMID checks
Cc:     Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cc9a3b60d34091840c8b0bd1c6fab15e5ba92cb17=2E15887?=
 =?utf-8?q?15690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cc9a3b60d34091840c8b0bd1c6fab15e5ba92cb17=2E158871?=
 =?utf-8?q?5690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158878850898.8414.17455198568537149878.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     f0d339db56478e3bcd98d5e985d3d69cacf27549
Gitweb:        https://git.kernel.org/tip/f0d339db56478e3bcd98d5e985d3d69cacf27549
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 05 May 2020 15:36:14 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 17:53:46 +02:00

x86/resctrl: Remove unnecessary RMID checks

The cache and memory bandwidth monitoring properties are read using
CPUID on every CPU. After the information is read from the system a
sanity check is run to

 (1) ensure that the RMID data is initialized for the boot CPU in case
     the information was not available on the boot CPU and

 (2) the boot CPU's RMID is set to the minimum of RMID obtained
     from all CPUs.

Every known platform that supports resctrl has the same maximum RMID
on all CPUs. Both sanity checks found in x86_init_cache_qos() can thus
safely be removed.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/c9a3b60d34091840c8b0bd1c6fab15e5ba92cb17.1588715690.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/common.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a8f0f22..556a96d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1354,20 +1354,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void x86_init_cache_qos(struct cpuinfo_x86 *c)
-{
-	/*
-	 * The heavy lifting of max_rmid and cache_occ_scale are handled
-	 * in get_cpu_cap().  Here we just set the max_rmid for the boot_cpu
-	 * in case CQM bits really aren't there in this CPU.
-	 */
-	if (c != &boot_cpu_data) {
-		boot_cpu_data.x86_cache_max_rmid =
-			min(boot_cpu_data.x86_cache_max_rmid,
-			    c->x86_cache_max_rmid);
-	}
-}
-
 /*
  * Validate that ACPI/mptables have the same information about the
  * effective APIC id and update the package map.
@@ -1480,7 +1466,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 
 	x86_init_rdrand(c);
-	x86_init_cache_qos(c);
 	setup_pku(c);
 
 	/*
