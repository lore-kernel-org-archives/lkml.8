Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BDA20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586899972;
	bh=7PFsi1xvzYVZoaCa9uiNYX672sFrV56eIDLTk1BtspU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Shz18K567+B3SeYG9z0EDbKCQBMs/0GyM+zJ8mInF6m7w3UUMz+wWyoyVXMCm3WNa
	 RCTRq3cmtBCwzVnrOvoSiu+Kwvm5yCSDm6x8xWu6TZk3uDtXEWNgPGsgTXyKkBVoQQ
	 pvozoadKH5YZMo16ZgHEkgWcfiT6vQ5h0ox/hMnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633914AbgDNVcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633855AbgDNVbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:31:42 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 548AD2074D;
        Tue, 14 Apr 2020 21:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586899901;
        bh=7PFsi1xvzYVZoaCa9uiNYX672sFrV56eIDLTk1BtspU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xx7GmJBT4ZOUEVA+T9roxrH0h7NnqUqVJz7MSHrqgrYTR5P5mfTORJHvNPHo7CsTT
         xVkpRQq5NiOEiJCoJwWXlmo04MW3La1H7oAVSkTx8U+1Sc/Zih2FC9B9zOX2ZViOHU
         fVNQhywIJO1UOW+0gxqwbwuQdInNzZ0938DXIeqQ=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: [PATCH 7/8] arm64: cpufeature: Relax checks for AArch32 support at EL[0-2]
Date:   Tue, 14 Apr 2020 22:31:13 +0100
Message-Id: <20200414213114.2378-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414213114.2378-1-will@kernel.org>
References: <20200414213114.2378-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to be quite as strict about mismatched AArch32 support,
which is good because the friendly hardware folks have been busy
mismatching this to their hearts' content.

  * We don't care about EL2 or EL3 (there are silly comments concerning
    the latter, so remove those)

  * EL1 support is gated by the ARM64_HAS_32BIT_EL1 capability and handled
    gracefully when a mismatch occurs

  * EL1 support is gated by the ARM64_HAS_32BIT_EL0 capability and handled
    gracefully when a mismatch occurs

Relax the AArch32 checks to FTR_NONSTRICT.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9e0321e3e581..680a453ca8c4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -172,11 +172,10 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
-	/* Linux doesn't care about the EL3 */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL3_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_SHIFT, 4, ID_AA64PFR0_EL1_64BIT_ONLY),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_SHIFT, 4, ID_AA64PFR0_EL1_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
 	ARM64_FTR_END,
 };
 
@@ -867,9 +866,6 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64MMFR2_EL1, cpu,
 				      info->reg_id_aa64mmfr2, boot->reg_id_aa64mmfr2);
 
-	/*
-	 * EL3 is not our concern.
-	 */
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR0_EL1, cpu,
 				      info->reg_id_aa64pfr0, boot->reg_id_aa64pfr0);
 	taint |= check_update_ftr_reg(SYS_ID_AA64PFR1_EL1, cpu,
-- 
2.26.0.110.g2183baf09c-goog

