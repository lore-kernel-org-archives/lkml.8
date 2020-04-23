Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A6C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5DD2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684172;
	bh=ivo0z+DIYH1GRhCzrVqTBwe4Weg2TnJmEEFHCwRLG+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rvbwv0+0l7mFONoeFsavBU6aVcdw6wR3Sng9otMx7If0pxZAlFKbCS0j8PE/PWQ/v
	 reqp1oGppBA7VGdE8iuCLJfNE7atoASenyoyMxz+wvAkXKL7L8TqR0ZQZanQbV0Bes
	 njT4s12lVmH3Yp7LABAcUiju3hJb0jVCJHUegpwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgDWXWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbgDWXWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166EA21707;
        Thu, 23 Apr 2020 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684154;
        bh=ivo0z+DIYH1GRhCzrVqTBwe4Weg2TnJmEEFHCwRLG+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SszlA6vv76+ziEFV4/a1mNGDyoBrZzvY4io3vzurvChGQvRrYSBH3lb2+cpbp/jC9
         k7eiE1htH+yfnTo1D4Lmkpop+nKaLQ4g6ZeTKHpbEg6GIlJM52sR1F+KL9n8BJcqJl
         R6tLBzVGj0LSTe2/G7skjY4yXHqmxQBDA3D/7aQ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 16/18] x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken bit
Date:   Thu, 23 Apr 2020 19:22:05 -0400
Message-Id: <20200423232207.5797-17-sashal@kernel.org>
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

Now that FSGSBASE is fully supported, remove unsafe_fsgsbase, enable
FSGSBASE by default, and add nofsgsbase to disable it.

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
 .../admin-guide/kernel-parameters.txt         |  3 +-
 arch/x86/kernel/cpu/common.c                  | 32 ++++++++-----------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 79753f97ecbc8..01ec0edeaba5e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3033,8 +3033,7 @@
 	no5lvl		[X86-64] Disable 5-level paging mode. Forces
 			kernel to use 4-level paging instead.
 
-	unsafe_fsgsbase	[X86] Allow FSGSBASE instructions.  This will be
-			replaced with a nofsgsbase flag.
+	nofsgsbase	[X86] Disables FSGSBASE instructions.
 
 	no_console_suspend
 			[HW] Never suspend the console
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4224760c74e27..0d480cbadc7dc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -418,21 +418,21 @@ static void __init setup_cr_pinning(void)
 	static_key_enable(&cr_pinning.key);
 }
 
-/*
- * Temporary hack: FSGSBASE is unsafe until a few kernel code paths are
- * updated. This allows us to get the kernel ready incrementally.
- *
- * Once all the pieces are in place, these will go away and be replaced with
- * a nofsgsbase chicken flag.
- */
-static bool unsafe_fsgsbase;
-
-static __init int setup_unsafe_fsgsbase(char *arg)
+static __init int x86_nofsgsbase_setup(char *arg)
 {
-	unsafe_fsgsbase = true;
+	/* Require an exact match without trailing characters. */
+	if (strlen(arg))
+		return 0;
+
+	/* Do not emit a message if the feature is not present. */
+	if (!boot_cpu_has(X86_FEATURE_FSGSBASE))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
+	pr_info("FSGSBASE disabled via kernel command line\n");
 	return 1;
 }
-__setup("unsafe_fsgsbase", setup_unsafe_fsgsbase);
+__setup("nofsgsbase", x86_nofsgsbase_setup);
 
 /*
  * Protection Keys are not available in 32-bit mode.
@@ -1495,12 +1495,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-		if (unsafe_fsgsbase)
-			cr4_set_bits(X86_CR4_FSGSBASE);
-		else
-			clear_cpu_cap(c, X86_FEATURE_FSGSBASE);
-	}
+	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+		cr4_set_bits(X86_CR4_FSGSBASE);
 
 	/*
 	 * The vendor-specific functions might have changed features.
-- 
2.20.1

