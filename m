Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E387208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a/oIX2tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgG3OZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:25:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40898 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgG3OZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:25:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UEOPK0120202;
        Thu, 30 Jul 2020 09:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596119065;
        bh=Tg6ayNdN7O4/CjjcMHoaiFkUayvdOa+Ei5rN0VtBwB0=;
        h=From:To:CC:Subject:Date;
        b=a/oIX2tA3Vi6briZJB3wH4zAU3Zt3eBiB+n1ONHq1Ll6fOMCQFdMWp0/MzhzeaTm3
         4AXIBI1C+WSF7jbC32W4mjIUwMRlVIY6NPTwdWV4Hz2QnxL/3ISIfxR8C0qXmZSPF7
         fCUqc8tRxkE0fKe+MUVONtAwffct2GAyldawBDPg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UEOPdS075710
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 09:24:25 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 09:24:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 09:24:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UEOPlG115124;
        Thu, 30 Jul 2020 09:24:25 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320adcx140: Fix GPO register start address
Date:   Thu, 30 Jul 2020 09:24:18 -0500
Message-ID: <20200730142419.28205-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header was updated to align with the data sheet to start the GPO_CFG
at GPO_CFG0.  The code was not updated to the change and therefore the
GPO_CFG0 register was not written to.

Fixes: 6617cff6a05e ("ASoC: tlv320adcx140: Add GPO configuration and drive output config")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 7bb9e9aa0c0a..fc7616dcf9b5 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -790,7 +790,7 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
 
 		gpo_output_val = gpo_outputs[0] << ADCX140_GPO_SHIFT |
 				 gpo_outputs[1];
-		ret = regmap_write(adcx140->regmap, ADCX140_GPO_CFG1 + i,
+		ret = regmap_write(adcx140->regmap, ADCX140_GPO_CFG0 + i,
 				   gpo_output_val);
 		if (ret)
 			return ret;
-- 
2.28.0

