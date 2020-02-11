Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDBEC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D79214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBKNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:54:11 -0500
Received: from 8bytes.org ([81.169.241.247]:52278 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbgBKNxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1CE82EAF; Tue, 11 Feb 2020 14:53:18 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 61/62] x86/cpufeature: Add SEV_ES_GUEST CPU Feature
Date:   Tue, 11 Feb 2020 14:52:55 +0100
Message-Id: <20200211135256.24617-62-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The feature bit will indicate whether the kernel runs as an SEV-ES
guest. This can be used to apply alternatives at boot for SEV-ES guests
and provides a way for user-space to detect whether it runs as an SEV-ES
guest.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/amd.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 26e4ee209f7b..e864327812e2 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -234,6 +234,7 @@
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
+#define X86_FEATURE_SEV_ES_GUEST	( 8*32+20) /* SEV-ES Guest */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index aad2223862ef..a1eb39153771 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -484,7 +484,6 @@ static void early_init_amd_mc(struct cpuinfo_x86 *c)
 
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
-
 #ifdef CONFIG_X86_64
 	if (c->x86 >= 0xf) {
 		unsigned long long tseg;
@@ -614,6 +613,11 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		setup_clear_cpu_cap(X86_FEATURE_SEV);
 		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
 	}
+
+	if (!rdmsrl_safe(MSR_AMD64_SEV, &msr)) {
+		if (msr & MSR_AMD64_SEV_ES_ENABLED)
+			set_cpu_cap(c, X86_FEATURE_SEV_ES_GUEST);
+	}
 }
 
 static void early_init_amd(struct cpuinfo_x86 *c)
-- 
2.17.1

