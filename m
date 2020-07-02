Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7C0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E234520874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653095;
	bh=gT5drgVkggJ7IsVykwTuD9LohfHoV0Is9KZ7YA3lFi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TXqlQ/KOWO19e8X09rFZGZF0LhEClsDxzVIrcF00070hPYS383wyKJ0KGySKuRPyF
	 ckcTm05p2fylGp1pp4paQ7kBZf1WZbO5bDpPE2Dl87aLybtBE57/9YmMWhylncm8qC
	 V6J/W677DA/8SqA2LW9qZmSdqXYnf1DkrFFgU++o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGBBYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgGBBX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AD082082F;
        Thu,  2 Jul 2020 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653037;
        bh=gT5drgVkggJ7IsVykwTuD9LohfHoV0Is9KZ7YA3lFi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KkSo6zlDPM1yEdJakPvcFzqWdifUqcimcCT1XjW7YN9Xf5+SH1D3gpQW1zdbtj9W
         QYOOD7g4UWe3Y9u7qTsugjxiQ+C8PshdsZpB0nAsITU7dYq5n28aPl7ygT1hrcwIJ0
         euxiJEphE0s3rySANGyqZggq8dgp6EB/+5AyDQjc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 50/53] arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist
Date:   Wed,  1 Jul 2020 21:21:59 -0400
Message-Id: <20200702012202.2700645-50-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

[ Upstream commit 108447fd0d1a34b0929cd26dc637c917a734ebab ]

QCOM KRYO{3,4}XX silver/LITTLE CPU cores are based on
Cortex-A55 and are SSB safe, hence add them to SSB
safelist -> arm64_ssb_cpus[].

Reported-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200625103123.7240-1-saiprakash.ranjan@codeaurora.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpu_errata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index df56d2295d165..0f37045fafab3 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -460,6 +460,8 @@ static const struct midr_range arm64_ssb_cpus[] = {
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
 	MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+	MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 	{},
 };
 
-- 
2.25.1

