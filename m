Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11EAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D11206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201248;
	bh=DQevq35eZcY/6uKjVTxzSch3yt1tNIAU/7C1wfdh/+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZnO36BksYEtr9fNPUfdomzPj8Qp5vCnnHH9eFRlN0AmnV2O3H9YcseXuMwHHaj27U
	 pomEGbR/FN0zADCjxBigTvUGowfRxwo7xPhaTR0sBsFILkNp4jbavKQZzCCi3SYHjT
	 oxtIcxd1sYFAd7K0DCR/+zc623yM57WM+XV8aSIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbgAPRGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388468AbgAPRGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5963A214AF;
        Thu, 16 Jan 2020 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194362;
        bh=DQevq35eZcY/6uKjVTxzSch3yt1tNIAU/7C1wfdh/+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cON38ipauTLCTmc2xZEMaltTsXTg3bJgY2IrFdMHUlONEEUxdnF41imTwiYM/R9ud
         rjjLMzPYWLe6aJsk52XsQdppn41nq1tSDToooM3Jfvd62Ls49QW5rGAlSxEQGfvJRj
         sGYR8Mch6w8HsuuDFV+/dyuXsarLU3EkquGlcMm4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 298/671] soc: amlogic: meson-gx-pwrc-vpu: Fix power on/off register bitmask
Date:   Thu, 16 Jan 2020 11:58:56 -0500
Message-Id: <20200116170509.12787-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 2fe3b4bbc93ec30a173ebae7d2b8c530416df3af ]

The register bitmask to power on/off the VPU memories was incorectly set
to 0x2 instead of 0x3. While still working, let's use the recommended
vendor value instead.

Fixes: 75fcb5ca4b46 ("soc: amlogic: add Meson GX VPU Domains driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 6289965c42e9..05421d029dff 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -54,12 +54,12 @@ static int meson_gx_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
 	/* Power Down Memories */
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x2 << i, 0x3 << i);
+				   0x3 << i, 0x3 << i);
 		udelay(5);
 	}
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x2 << i, 0x3 << i);
+				   0x3 << i, 0x3 << i);
 		udelay(5);
 	}
 	for (i = 8; i < 16; i++) {
@@ -108,13 +108,13 @@ static int meson_gx_pwrc_vpu_power_on(struct generic_pm_domain *genpd)
 	/* Power Up Memories */
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x2 << i, 0);
+				   0x3 << i, 0);
 		udelay(5);
 	}
 
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x2 << i, 0);
+				   0x3 << i, 0);
 		udelay(5);
 	}
 
-- 
2.20.1

