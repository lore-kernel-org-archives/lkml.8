Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20B220884
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445616;
	bh=G7iSEQC/Bv3YJXSwK3IkyjlfaOkm9fBHFZU5Zmr3tjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nEAhz/4GL8wI2uhP3TWqXt/C4+jfHF8ZWtUBHiLduXw9IQVzsjfNqHihSG5WA9HjM
	 VTSX7A5fmHTy/ZpwKauKi9yv3aZPUxp/ZBD92FflzTFbI12yK2MsR0r4zibsIbloSK
	 J96H1FKk1QCQSR7bxufolk9DZqOuN5y9y9q269hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgFRCAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbgFRBY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:24:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B3720B1F;
        Thu, 18 Jun 2020 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443466;
        bh=G7iSEQC/Bv3YJXSwK3IkyjlfaOkm9fBHFZU5Zmr3tjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9Tz/1EhA1EPl6Pjh8tNe2q3X/tyChLenxKDVQNFqGCvfRNc8RIEUVoqw5Gcsz5n5
         wKuatcha85Ngj2BWByeFTBAzJ8n3ILPub9e1uEj9V4WEsG5dI2Mlo+A4t93xMAVIlf
         NFTu9Ad0QgOXcU96YQrCngNoAAZtvih/XdY1Di5E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 098/172] ASoC: Intel: bytcr_rt5640: Add quirk for Toshiba Encore WT8-A tablet
Date:   Wed, 17 Jun 2020 21:21:04 -0400
Message-Id: <20200618012218.607130-98-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index f29014a7d672..5dfc17987b2b 100644
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

