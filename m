Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C7720809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IOqH2X26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgIJHy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:54:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34066 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIJHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:54:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08A7sen9078068;
        Thu, 10 Sep 2020 02:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599724480;
        bh=xLqhM8JuqWpOLMHetzz/8/24VkctoaW/pS2UjG1I9j0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IOqH2X26tjkpkVPLBtpXQLFa0xKbnADsV53eCehLtJlDidoAlrsbZM5oIpPkPt2Si
         33/J6ruOJ/ZuSSmsUugEAly3/FZwgxc9WHel6iN0GlnEinS5HEjWsWoaloIO+iNBMl
         Re74c0JC1DYdpZ1Dc5Mfhe/KXYJZipznuZ0xVGxk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08A7se6s086300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 02:54:40 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 02:54:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 02:54:39 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7sXCU123142;
        Thu, 10 Sep 2020 02:54:38 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: ti: j721e-evm: Add support for j7200-cpb audio
Date:   Thu, 10 Sep 2020 10:54:33 +0300
Message-ID: <20200910075433.26718-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910075433.26718-1-peter.ujfalusi@ti.com>
References: <20200910075433.26718-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When j7200 SOM is attached to the CPB we only have parent clock for 48KHz
family and the rate of the parent clock is 2359296000Hz.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/j721e-evm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index cb074af47a7d..f66674fd5f64 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -525,6 +525,14 @@ static const struct j721e_audio_match_data j721e_cpb_ivi_data = {
 	},
 };
 
+static const struct j721e_audio_match_data j7200_cpb_data = {
+	.board_type = J721E_BOARD_CPB,
+	.num_links = 2, /* CPB pcm3168a */
+	.pll_rates = {
+		[J721E_CLK_PARENT_48000] = 2359296000, /* PLL4 */
+	},
+};
+
 static const struct of_device_id j721e_audio_of_match[] = {
 	{
 		.compatible = "ti,j721e-cpb-audio",
@@ -532,6 +540,9 @@ static const struct of_device_id j721e_audio_of_match[] = {
 	}, {
 		.compatible = "ti,j721e-cpb-ivi-audio",
 		.data = &j721e_cpb_ivi_data,
+	}, {
+		.compatible = "ti,j7200-cpb-audio",
+		.data = &j7200_cpb_data,
 	},
 	{ },
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

