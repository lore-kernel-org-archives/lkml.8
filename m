Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB00CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE48246B7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696794;
	bh=LzYNPR9J2ibU/qyDs0q0oCcykAYhAy9FH0BzO5SvP3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ytFMpqOXtkUu1WqMsXjJ+gVB4scLveS8XAVBM/kI83wVTf97vop6Vh7+NxTcZZfWL
	 zU7GVUlwelwrtADF65IiZavFIQuJzITXC3AqDJj94gVpOf3yT/ASSU0jv6q4R8rnkN
	 n3fkcGDa7lb5SNlK1jxbmEB3YhAiVHdGqfnDn6z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392137AbgBNQNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391992AbgBNQMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0A8246AB;
        Fri, 14 Feb 2020 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696744;
        bh=LzYNPR9J2ibU/qyDs0q0oCcykAYhAy9FH0BzO5SvP3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTTG+dbZ8U1/i7/r7FzmsWAJLOjV2NrGAJDzo7/wmVgXzak/8eCn0v/lfRovQahKT
         Q6kSpAtf2nocTQc3p80/LfdHydAgBzVBuJL7tW7D9oyT8fujg8pQkNFFpoALgPdrcz
         sSGYNT/ukBzDSZqVNDoeS0lLEbMoGmGXkjYrFao0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 028/252] arm64: cpufeature: Fix the type of no FP/SIMD capability
Date:   Fri, 14 Feb 2020 11:08:03 -0500
Message-Id: <20200214161147.15842-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 449443c03d8cfdacf7313e17779a2594ebf87e6d ]

The NO_FPSIMD capability is defined with scope SYSTEM, which implies
that the "absence" of FP/SIMD on at least one CPU is detected only
after all the SMP CPUs are brought up. However, we use the status
of this capability for every context switch. So, let us change
the scope to LOCAL_CPU to allow the detection of this capability
as and when the first CPU without FP is brought up.

Also, the current type allows hotplugged CPU to be brought up without
FP/SIMD when all the current CPUs have FP/SIMD and we have the userspace
up. Fix both of these issues by changing the capability to
BOOT_RESTRICTED_LOCAL_CPU_FEATURE.

Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 220ebfa0ece6e..1375307fbe4d2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1241,7 +1241,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		/* FP/SIMD is not implemented */
 		.capability = ARM64_HAS_NO_FPSIMD,
-		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_BOOT_RESTRICTED_CPU_LOCAL_FEATURE,
 		.min_field_value = 0,
 		.matches = has_no_fpsimd,
 	},
-- 
2.20.1

