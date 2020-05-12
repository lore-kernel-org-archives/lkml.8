Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAE3C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E54206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nePcfkZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgELNQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:16:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32940 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgELNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:16:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CDG3Fg031930;
        Tue, 12 May 2020 08:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589289363;
        bh=BumWFgjzJj940R4kMpydKFBlGDtIoxERn96VgXdZ9bc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nePcfkZ49UmdjEEneh+uNCxrM69Ja6+fA/vy6T309JixKwG2czg1QbwGHHf6NKMm4
         M0SzhFtoMTpG3LXNSnwzGwaFD/BH/TXCaxWyNU1b3+30bJNNY9+P0zSIGW1gCZtp7T
         BElGiiQbubKOqzFwvnBOwby3vmFjwUbr4Bq60Juk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CDG3Hq014807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 08:16:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 08:16:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 08:16:03 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CDFxab079268;
        Tue, 12 May 2020 08:16:01 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ASoC: ti: davinci-mcasp: Specify stream_name for playback/capture
Date:   Tue, 12 May 2020 16:16:31 +0300
Message-ID: <20200512131633.32668-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512131633.32668-1-peter.ujfalusi@ti.com>
References: <20200512131633.32668-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to dai stream widgets to be created the stream_name must be set.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 7a7db743dc5b..15d84493466f 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -1623,12 +1623,14 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		.name		= "davinci-mcasp.0",
 		.probe		= davinci_mcasp_dai_probe,
 		.playback	= {
+			.stream_name = "IIS Playback",
 			.channels_min	= 1,
 			.channels_max	= 32 * 16,
 			.rates 		= DAVINCI_MCASP_RATES,
 			.formats	= DAVINCI_MCASP_PCM_FMTS,
 		},
 		.capture 	= {
+			.stream_name = "IIS Capture",
 			.channels_min 	= 1,
 			.channels_max	= 32 * 16,
 			.rates 		= DAVINCI_MCASP_RATES,
@@ -1642,6 +1644,7 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
 		.name		= "davinci-mcasp.1",
 		.probe		= davinci_mcasp_dai_probe,
 		.playback 	= {
+			.stream_name = "DIT Playback",
 			.channels_min	= 1,
 			.channels_max	= 384,
 			.rates		= DAVINCI_MCASP_RATES,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

