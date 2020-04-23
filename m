Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75918C55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D122077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587684165;
	bh=hLMKYmJyiWGannRLywh3Dp0bYs9jxWDR8ibDbApWLOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClWybF1RippzIrE7tTaFWCa7GgdrYyZrlrY3m20iJYorwXxyJ0i2CGMiNGuXiShme
	 jxOvfr+Ta6nxigkzkOZN0mjHIFXrnSjYjS2EvDz9gFGqJx0l2V6DUlwp8rDISWDPJ8
	 8YNQ2F+i/TLxnoUmzBfRSZcD+9blDAISj5VTVBO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgDWXWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbgDWXWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:22:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F7F20784;
        Thu, 23 Apr 2020 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587684155;
        bh=hLMKYmJyiWGannRLywh3Dp0bYs9jxWDR8ibDbApWLOg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZp9z0BxBC+Bhc3rryu+K8WKqc3dDEvvZhmaHExtSmqXbEH9tDmAwqApYqlb8Xctl
         n5tjJRLBXerVuTIuyE2E5CZ0CJTe9MZSuHdsTGujcvh/x5zrNUNFWixRHZyHt9DyKw
         yzbjPudzBob66rHHVNWlJXhMCh6ukFkXwfc7sEuY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v10 17/18] x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
Date:   Thu, 23 Apr 2020 19:22:06 -0400
Message-Id: <20200423232207.5797-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
References: <20200423232207.5797-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The kernel needs to explicitly enable FSGSBASE. So, the application needs
to know if it can safely use these instructions. Just looking at the CPUID
bit is not enough because it may be running in a kernel that does not
enable the instructions.

One way for the application would be to just try and catch the SIGILL.
But that is difficult to do in libraries which may not want to overwrite
the signal handlers of the main application.

Enumerate the enabled FSGSBASE capability in bit 1 of AT_HWCAP2 in the ELF
aux vector. AT_HWCAP2 is already used by PPC for similar purposes.

The application can access it open coded or by using the getauxval()
function in newer versions of glibc.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
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
 arch/x86/include/uapi/asm/hwcap2.h | 3 +++
 arch/x86/kernel/cpu/common.c       | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 8b2effe6efb82..5fdfcb47000f9 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -5,4 +5,7 @@
 /* MONITOR/MWAIT enabled in Ring 3 */
 #define HWCAP2_RING3MWAIT		(1 << 0)
 
+/* Kernel allows FSGSBASE instructions available in Ring 3 */
+#define HWCAP2_FSGSBASE			BIT(1)
+
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0d480cbadc7dc..b5a086ea34258 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1495,8 +1495,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
 		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
 
 	/*
 	 * The vendor-specific functions might have changed features.
-- 
2.20.1

