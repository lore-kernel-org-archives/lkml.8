Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A67C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4602078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944886;
	bh=3oDLluTkol/OareQdaN2QUjywg203CaPLcyc4tWhaaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mw9LEqt2gXrDRPKTaREGKO7BG2jdyjQvfTk/vL23fEitgiI8kt9KMg3V2yEfAuKzA
	 +QKP4vUXDvLx67cxtyiwwrXNuovqBrw6dldwEaymn+Qa5qorZ/kxvcq22v/m9j3UP8
	 /SxurUyPKg687bxB/n0x0MkWoK+LkFAu3yL993RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbgFWUlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392172AbgFWUlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:41:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F200B20675;
        Tue, 23 Jun 2020 20:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944871;
        bh=3oDLluTkol/OareQdaN2QUjywg203CaPLcyc4tWhaaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KUPt/KF6ZqYz64rO7lyYoSRDRIkcSGxojg0lCevlJT3hO30Gl4HaeBdH+RvF1Gn6C
         TdJ2M29N2KqOa4pCioIhWX0xB6tnxEODTGEUFF4zF+98z/RdaYHdADMLPyR4Fzo6SF
         hKnzyXrvV3h0Z1XSJcuWwmMw2kYvKMrMmp0c/2Pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 156/206] ASoC: rt5645: Add platform-data for Asus T101HA
Date:   Tue, 23 Jun 2020 21:58:04 +0200
Message-Id: <20200623195324.667397367@linuxfoundation.org>
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

[ Upstream commit 79d4f823a06796656289f97b922493da5690e46c ]

The Asus T101HA uses the default jack-detect mode 3, but instead of
using an analog microphone it is using a DMIC on dmic-data-pin 1,
like the Asus T100HA. Note unlike the T100HA its jack-detect is not
inverted.

Add a DMI quirk with the correct settings for this model.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200608204634.93407-2-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 7e3b47eeea044..9185bd7c5a6dc 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3656,6 +3656,12 @@ static const struct rt5645_platform_data asus_t100ha_platform_data = {
 	.inv_jd1_1 = true,
 };
 
+static const struct rt5645_platform_data asus_t101ha_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC_DATA_IN2N,
+	.dmic2_data_pin = RT5645_DMIC2_DISABLE,
+	.jd_mode = 3,
+};
+
 static const struct rt5645_platform_data lenovo_ideapad_miix_310_pdata = {
 	.jd_mode = 3,
 	.in2_diff = true,
@@ -3733,6 +3739,14 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&asus_t100ha_platform_data,
 	},
+	{
+		.ident = "ASUS T101HA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T101HA"),
+		},
+		.driver_data = (void *)&asus_t101ha_platform_data,
+	},
 	{
 		.ident = "MINIX Z83-4",
 		.matches = {
-- 
2.25.1



