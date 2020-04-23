Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34897C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1137220780
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684138;
	bh=ogXWs905hfZL7YwX8Y6fHJMaPvE8RYHg9lf4bzA7z00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cELF4AzBqrfMVc+X8JL2mK1vDyP2O21C56N0aSzqvyHa83HL8R3BRGrLFpBeOLAvA
	 1sYyO8xsrMDN2Wbad/+HeEhcz+ZuHdKzqMGPLSVr8dWVg0SbquPJnytIwVCLXScP0U
	 cBD9v69EYiAhzOIVqp9/dHXKYFKLVWs55lscO/v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgDWXWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgDWXWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341B321655;
        Thu, 23 Apr 2020 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684135;
        bh=ogXWs905hfZL7YwX8Y6fHJMaPvE8RYHg9lf4bzA7z00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vbJGNbylllhl5pMU+Eiot4VCrVrc1l5+WQKFy8Skgr4nLRVi4umB401L885ZX7p+G
         enK/o2lUcebWVgxZ248CCKjQ80z8+hLZMGWj825MiEy5AhlCVzFVPdugc0Z8LPAlA+
         e/Ax1ARjdNohF2atHV2J3116KjvDIK1gDcr1dvn0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 03/18] x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
Date:   Thu, 23 Apr 2020 19:21:52 -0400
Message-Id: <20200423232207.5797-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

This is temporary.  It will allow the next few patches to be tested
incrementally.

Setting unsafe_fsgsbase is a root hole.  Don't do it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/x86/kernel/cpu/common.c                  | 24 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8679e88..79753f97ecbc8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3033,6 +3033,9 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
+	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
+			replaced with a nofsgsbase flag.
+
 	no_console_suspend
 			[HW] Never suspend the console
 			Disable suspending of consoles during suspend and
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index bed0cb83fe245..4224760c74e27 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -418,6 +418,22 @@ static void __init setup_cr_pinning(void)
 	static_key_enable(&cr_pinning.key);
 }
 
+/*
+ * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
+ * updated. This allows us to get the kernel ready incrementally.
+ *
+ * Once all the pieces are in place, these will go away and be replaced with
+ * a nofsgsbase chicken flag.
+ */
+static bool unsafe_fsgsbase;
+
+static __init int setup_unsafe_fsgsbase(char *arg)
+{
+	unsafe_fsgsbase = true;
+	return 1;
+}
+__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+
 /*
  * Protection Keys are not available in 32-bit mode.
  */
@@ -1478,6 +1494,14 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_smap(c);
 	setup_umip(c);
 
+	/* Enable FSGSBASE instructions if available. */
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
+		if (unsafe_fsgsbase)
+			cr4_set_bits(X86_CR4_FSGSBASE);
+		else
+			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
+	}
+
 	/*
 	 * The vendor-specific functions might have changed features.
 	 * Now we do "generic changes."
-- 
2.20.1

