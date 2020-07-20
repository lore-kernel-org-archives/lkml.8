Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF63C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566A4206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="oRB58usa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgGTRBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:01:30 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8966 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgGTRB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:01:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f15cddb0000>; Mon, 20 Jul 2020 10:01:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Jul 2020 10:01:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 20 Jul 2020 10:01:27 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 17:01:27 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 20 Jul 2020 17:01:27 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.236]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f15cdc9000a>; Mon, 20 Jul 2020 10:01:03 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <luca@lucaceresoli.net>, <leonl@leopardimaging.com>,
        <robh+dt@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] media: i2c: imx274: Fix Y_OUT_SIZE register setting
Date:   Mon, 20 Jul 2020 10:01:32 -0700
Message-ID: <1595264494-2400-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595264475; bh=DLvQ6chRzbjeKicuQdxuqVcpH3d1W/1R1Kay/NtRj70=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=oRB58usaUszFh373ZNkh1jIAkt/msLEvJFPqta47sM7I+lUbqmv7qO9AiVuctVxHg
         TfZFPQVnT0s9D4OpJckVHs1MUr1gUaFjMQ0o42MnfpdISZnqRQUWow2jxjSpHzHbIC
         +QSLg+/amRB4Dlmw6hNGllVlGpQPmHyIsGbga4x2mMTpmCiBTLNwbDR6ZfTZ/ZuTCX
         I8JmDslw/VkgE4WDfwh0FhcxY9m/WbxsFAavGuNcvy/m4E2XpU1qDwD10SnRavhq01
         Dxv8uS3cuPyG1rJ39xhlgGOBPYo+c0ZDWk3h1PvlMCfEMrP96UQXdFb1mo83OCWMlY
         a4sgcoB+l0J3A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Sony IMX274 Y_OUT_SIZE should be the height of effective
image output from the sensor which are the actual total lines
sent over MIPI CSI to receiver.

So, Y_OUT_SIZE should be same as crop height and this patch fixes it.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/media/i2c/imx274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index e6aa9f3..55869ff 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -1163,7 +1163,7 @@ static int imx274_apply_trimming(struct stimx274 *imx274)
 		(-imx274->crop.top / 2) : (imx274->crop.top / 2);
 	v_cut = (IMX274_MAX_HEIGHT - imx274->crop.height) / 2;
 	write_v_size = imx274->crop.height + 22;
-	y_out_size   = imx274->crop.height + 14;
+	y_out_size   = imx274->crop.height;
 
 	err = imx274_write_mbreg(imx274, IMX274_HMAX_REG_LSB, hmax, 2);
 	if (!err)
-- 
2.7.4

