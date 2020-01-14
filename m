Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E8BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB66206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgANLPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:15:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45235 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:15:21 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1irKA6-0004SV-1T; Tue, 14 Jan 2020 11:15:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode/amd: fix uninitalized structure cp
Date:   Tue, 14 Jan 2020 11:15:05 +0000
Message-Id: <20200114111505.320186-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where cp is not assigned to the return from
the call to find_microcode_in_initrd cp is uninitialized when
it is assigned to *ret.   Functions that call __load_ucode_amd
such as load_ucode_amd_bsp can therefore end up checking bogus
values cp.data and cp.size.  Fix this by ensuring cp is
initialized as all zero and remove the redundant initialization
of cp in load_ucode_amd_bsp.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: e71bb4ec0739 ("x86/microcode/AMD: Unify load_ucode_amd_ap()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3f6b137ef4e6..675704019df2 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -473,7 +473,7 @@ static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
 {
 	struct ucode_cpu_info *uci;
-	struct cpio_data cp;
+	struct cpio_data cp = { };
 	const char *path;
 	bool use_pa;
 
@@ -498,7 +498,7 @@ static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
 
 void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 {
-	struct cpio_data cp = { };
+	struct cpio_data cp;
 
 	__load_ucode_amd(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
-- 
2.24.0

