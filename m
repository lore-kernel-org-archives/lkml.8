Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C72C3F34E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C9620578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811561;
	bh=6yTA9J7M6UqIl53dhGVKg5suYmxT0bix2lCGeHbCN7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBhOjbqDE1ljMBlfly1V3iVbdO9Fvm1ccyaR4qhOqQXznPMfwVcDusW3XqkB9zgG/
	 qDozEqePNDxIJaVM0FRPnLUypA8BAHXLMvylTstyqacL+ULOW5VUd8YK4nLSdP1qu6
	 GlLnlnYVyaQ10cW9Eu5Unxv/jwCj96fT1L+40vpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgB0Nwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:52:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbgB0Nwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:52:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89CC20578;
        Thu, 27 Feb 2020 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811553;
        bh=6yTA9J7M6UqIl53dhGVKg5suYmxT0bix2lCGeHbCN7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxibzYiSxLA0WHr9oSHK1WPjLZtUnw+Img6tQNLVRLpgJSPgJqc5N40gaJJonegHT
         d6sj8QaRJRTaRcyKdbtt65RNLbBcw0Z+jo444TxHuMxGb6soaq+e0CFUc01O3HVT3d
         9MmnDBSw3WUmW6LhHzCFtEgpiPVY/ULVvbMyuWm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 012/237] arm64: ptrace: nofpsimd: Fail FP/SIMD regset operations
Date:   Thu, 27 Feb 2020 14:33:46 +0100
Message-Id: <20200227132256.888148215@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit c9d66999f064947e6b577ceacc1eb2fbca6a8d3c upstream

When fp/simd is not supported on the system, fail the operations
of FP/SIMD regsets.

Cc: stable@vger.kernel.org # v4.14
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 242527f29c410..e230b4dff9602 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -624,6 +624,13 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	return 0;
 }
 
+static int fpr_active(struct task_struct *target, const struct user_regset *regset)
+{
+	if (!system_supports_fpsimd())
+		return -ENODEV;
+	return regset->n;
+}
+
 /*
  * TODO: update fp accessors for lazy context switching (sync/flush hwstate)
  */
@@ -634,6 +641,9 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 	struct user_fpsimd_state *uregs;
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
 
+	if (!system_supports_fpsimd())
+		return -EINVAL;
+
 	if (target == current)
 		fpsimd_preserve_current_state();
 
@@ -648,6 +658,9 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 	struct user_fpsimd_state newstate =
 		target->thread.fpsimd_state.user_fpsimd;
 
+	if (!system_supports_fpsimd())
+		return -EINVAL;
+
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0, -1);
 	if (ret)
 		return ret;
@@ -740,6 +753,7 @@ static const struct user_regset aarch64_regsets[] = {
 		 */
 		.size = sizeof(u32),
 		.align = sizeof(u32),
+		.active = fpr_active,
 		.get = fpr_get,
 		.set = fpr_set
 	},
@@ -914,6 +928,9 @@ static int compat_vfp_get(struct task_struct *target,
 	compat_ulong_t fpscr;
 	int ret, vregs_end_pos;
 
+	if (!system_supports_fpsimd())
+		return -EINVAL;
+
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
 
 	if (target == current)
@@ -947,6 +964,9 @@ static int compat_vfp_set(struct task_struct *target,
 	compat_ulong_t fpscr;
 	int ret, vregs_end_pos;
 
+	if (!system_supports_fpsimd())
+		return -EINVAL;
+
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
 
 	vregs_end_pos = VFP_STATE_SIZE - sizeof(compat_ulong_t);
@@ -1004,6 +1024,7 @@ static const struct user_regset aarch32_regsets[] = {
 		.n = VFP_STATE_SIZE / sizeof(compat_ulong_t),
 		.size = sizeof(compat_ulong_t),
 		.align = sizeof(compat_ulong_t),
+		.active = fpr_active,
 		.get = compat_vfp_get,
 		.set = compat_vfp_set
 	},
-- 
2.20.1



