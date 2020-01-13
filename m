Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB6C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A660620678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 23:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgAMXbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:31:31 -0500
Received: from foss.arm.com ([217.140.110.172]:45708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729366AbgAMXb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:31:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E6F142F;
        Mon, 13 Jan 2020 15:31:27 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF5863F68E;
        Mon, 13 Jan 2020 15:31:25 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 6/7] arm64: signal: nofpsimd: Handle fp/simd context for signal frames
Date:   Mon, 13 Jan 2020 23:30:22 +0000
Message-Id: <20200113233023.928028-7-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113233023.928028-1-suzuki.poulose@arm.com>
References: <20200113233023.928028-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we try to save/restore the vfp/fpsimd context for signal
handling only when the fp/simd support is available. Otherwise, skip
the frames.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
  - Remove WARN_ON() from static functions already checked for
    the presence of fpsmid.
---
 arch/arm64/kernel/signal.c   | 6 ++++--
 arch/arm64/kernel/signal32.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index dd2cdc0d5be2..339882db5a91 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -371,6 +371,8 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			goto done;
 
 		case FPSIMD_MAGIC:
+			if (!system_supports_fpsimd())
+				goto invalid;
 			if (user->fpsimd)
 				goto invalid;
 
@@ -506,7 +508,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0)
 		err = parse_user_sigframe(&user, sf);
 
-	if (err == 0) {
+	if (err == 0 && system_supports_fpsimd()) {
 		if (!user.fpsimd)
 			return -EINVAL;
 
@@ -623,7 +625,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 
 	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
 
-	if (err == 0) {
+	if (err == 0 && system_supports_fpsimd()) {
 		struct fpsimd_context __user *fpsimd_ctx =
 			apply_user_offset(user, user->fpsimd_offset);
 		err |= preserve_fpsimd_context(fpsimd_ctx);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 12a585386c2f..82feca6f7052 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -223,7 +223,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	err |= !valid_user_regs(&regs->user_regs, current);
 
 	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
-	if (err == 0)
+	if (err == 0 && system_supports_fpsimd())
 		err |= compat_restore_vfp_context(&aux->vfp);
 
 	return err;
@@ -419,7 +419,7 @@ static int compat_setup_sigframe(struct compat_sigframe __user *sf,
 
 	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
 
-	if (err == 0)
+	if (err == 0 && system_supports_fpsimd())
 		err |= compat_preserve_vfp_context(&aux->vfp);
 	__put_user_error(0, &aux->end_magic, err);
 
-- 
2.24.1

