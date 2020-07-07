Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99E4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795532078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135363;
	bh=4IZmwLBc4b1k4DcYWXQa0y3dm3kYmW1EZ2wcvtA/LKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=amEgRY+ng06LxMiDdd4Dt+1H30hfKDHyH3dDEKRLUTTa1/W7FpL0BFH4yVBEJF7yC
	 1nF3NVdAojXuK3R98GhtGmFv/oQl0XMeq1qjUYvSROwzU9v3RtiYY/NFD0feasdDCc
	 WYl1H78xhWweGztFRfYSW00jtJl1fqiBT1Gph86o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgGGPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729868AbgGGPWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:22:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F46920773;
        Tue,  7 Jul 2020 15:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135352;
        bh=4IZmwLBc4b1k4DcYWXQa0y3dm3kYmW1EZ2wcvtA/LKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS2oHvf5SZRPIfLJS/ldsYXww5eZNVVliQCj6S1N9YI8yhb0LRH6J9G1wY/fRQGbS
         4nkPvzMXF+iI00Uc4ISfHslQ/78PGSkG4U12WJ4OjiqcuVICmNV1AUiSwb/nAemrHX
         H4l/Gk0q0mCN0vVkWOvTSUG28dnYoqj3kHQ2d0FY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 32/65] thermal/drivers/mediatek: Fix bank number settings on mt8183
Date:   Tue,  7 Jul 2020 17:17:11 +0200
Message-Id: <20200707145754.017890334@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

[ Upstream commit 14533a5a6c12e8d7de79d309d4085bf186058fe1 ]

MT8183_NUM_ZONES should be set to 1
because MT8183 doesn't have multiple banks.

Fixes: a4ffe6b52d27 ("thermal: mediatek: add support for MT8183")
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200323121537.22697-6-michael.kao@mediatek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mtk_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index acf4854cbb8b8..d6fabd0a7da69 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -211,6 +211,9 @@ enum {
 /* The total number of temperature sensors in the MT8183 */
 #define MT8183_NUM_SENSORS	6
 
+/* The number of banks in the MT8183 */
+#define MT8183_NUM_ZONES               1
+
 /* The number of sensing points per bank */
 #define MT8183_NUM_SENSORS_PER_ZONE	 6
 
@@ -498,7 +501,7 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 
 static const struct mtk_thermal_data mt8183_thermal_data = {
 	.auxadc_channel = MT8183_TEMP_AUXADC_CHANNEL,
-	.num_banks = MT8183_NUM_SENSORS_PER_ZONE,
+	.num_banks = MT8183_NUM_ZONES,
 	.num_sensors = MT8183_NUM_SENSORS,
 	.vts_index = mt8183_vts_index,
 	.cali_val = MT8183_CALIBRATION,
-- 
2.25.1



