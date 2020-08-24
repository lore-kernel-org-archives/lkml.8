Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008C9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C587B206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288436;
	bh=mHJBKvhnUJ/S+3nxeAcbt10YL0vWVfmMtJO8E7cMELs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jETxQO68huTTCQa0MgqOsEUraU5DKCaPJj7BSxbPpNfEQyv4XSvvfNT3frGnrGVkP
	 Qfsr3Nd4YqfHZkCoX+HivXRUXYyV6aDdkRkb4ku9y3FvFcXTMI+BkoQqa4F0otehQB
	 Yu0rRporDg71WXRpA074NoaB6XJOSK8xw/fPzXgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHXRAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgHXQio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7532722BED;
        Mon, 24 Aug 2020 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287124;
        bh=mHJBKvhnUJ/S+3nxeAcbt10YL0vWVfmMtJO8E7cMELs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eihs6L9uFR7BWc5oKGmQYyBta0C3BM6bffKO0wF60Q23vpR+MDzJ+yhUUVYwO7dKm
         BEfiqrSE2oK/T5avgM7bNI0pNa6LiuhEHrECfovqXqAXPZmDJzsikEXQCN8tCTbkV3
         KcdsVoFgmfYbo1lQOa55J6v2Xvttl+eM1ljaXPeQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 38/38] arm64: Allow booting of late CPUs affected by erratum 1418040
Date:   Mon, 24 Aug 2020 12:37:50 -0400
Message-Id: <20200824163751.606577-38-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit bf87bb0881d0f59181fe3bbcf29c609f36483ff8 ]

As we can now switch from a system that isn't affected by 1418040
to a system that globally is affected, let's allow affected CPUs
to come in at a later time.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200731173824.107480-3-maz@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpu_errata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0b2830379fe03..51462c59ab5da 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -917,6 +917,8 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.desc = "ARM erratum 1418040",
 		.capability = ARM64_WORKAROUND_1418040,
 		ERRATA_MIDR_RANGE_LIST(erratum_1418040_list),
+		.type = (ARM64_CPUCAP_SCOPE_LOCAL_CPU |
+			 ARM64_CPUCAP_PERMITTED_FOR_LATE_CPU),
 	},
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_1165522
-- 
2.25.1

