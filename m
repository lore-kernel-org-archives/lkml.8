Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F0AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B0420663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946043;
	bh=yXwVar8IQUxZsnCIsTTURQDCEoJNnl62mOjjSTjIJLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gr9YOCfdA38QVl5aNciJwVpH7sCnsShyzlHFfjNKi/VWSP3vdt0s348D+EreyYDLO
	 b1KX5dtBM3nLf02RPDYbo59Pu+BekT+nCO3V1YDtpPrba4dBGFlC5PNskkFAhxNGW3
	 mrid9Vf4vX/RaplgpjLfo10jkPg3kIcyH2BbQPto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404241AbgFWVAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390015AbgFWUkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B2C21883;
        Tue, 23 Jun 2020 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944809;
        bh=yXwVar8IQUxZsnCIsTTURQDCEoJNnl62mOjjSTjIJLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7hw/hp2eZtN/crKH87GLb8JyQ3XPJf90i9tZe4GWOjcvUloohLc7hqvB2SQVTPkk
         jZOCA9wIojeyheM2ZKnj2yeK6LeHLkCOpGKjX8EAjgYfinyMmh8Ayb/wo8XEUF/FDu
         Ke4HeP0xDpQ9odgvp9G1Ea+IJquma/mINYXd6Uwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 093/206] ASoC: Intel: bytcr_rt5640: Add quirk for Toshiba Encore WT8-A tablet
Date:   Tue, 23 Jun 2020 21:57:01 +0200
Message-Id: <20200623195321.515659816@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0e0e10fde0e9808d1991268f5dca69fb36c025f7 ]

The Toshiba Encore WT8-A tablet almost fully works with the default
settings for non-CR Bay Trail devices. The only problem is that its
jack-detect switch is not inverted (it is active high instead of
the normal active low).

Add a quirk for this model using the default settings +
BYT_RT5640_JD_NOT_INV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200518072416.5348-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index f29014a7d6723..5dfc17987b2b9 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -712,6 +712,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* Toshiba Encore WT8-A */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "TOSHIBA WT8-A"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* Catch-all for generic Insyde tablets, must be last */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
-- 
2.25.1



