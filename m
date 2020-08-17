Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852E2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C11E20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692868;
	bh=xQk7ht4cPTsZR/FeIbsKIFsxjiGGKtE9EyT6lV99ffo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aj8pnHLW6n8e7rTeOsmYQvV1EDaorL5hkxQ2KT+qA9ZWjTEIwvQe4dpkFh/gUKENp
	 AJzkRzE/uiA/HEm9DS1wStLqDXlpqiBxNBpgdA41Pl7jJijDQbSygeI+sCpviYRWGM
	 VmK6VKCROyMVnjMvD+rTgWv+tw4TAckT7JBCSVZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgHQTe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbgHQPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:30:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A826D23C2D;
        Mon, 17 Aug 2020 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678207;
        bh=xQk7ht4cPTsZR/FeIbsKIFsxjiGGKtE9EyT6lV99ffo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnv6DZARgNwAEkmGcCE51ZZ/Gv2DEJtb/Vn9VXBFq3g9UgKzrvd5QAIl0P6wtKiH7
         2QBYq0qKUUYMrt0Kq4nukztIfjqEyjbL+NaieUO72fQknsrVO0tZA/JUXKcWbitcrR
         m3qNTxcLomFnUiszACRsPx3UcMMGDkzggu7tmtaU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 224/464] phy: exynos5-usbdrd: Calibrating makes sense only for USB2.0 PHY
Date:   Mon, 17 Aug 2020 17:12:57 +0200
Message-Id: <20200817143844.527219489@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit dcbabfeb17c3c2fdb6bc92a3031ecd37df1834a8 ]

PHY calibration is needed only for USB2.0 (UTMI) PHY, so skip calling
calibration code when phy_calibrate() is called for USB3.0 (PIPE3) PHY.

Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20200708133800.3336-1-m.szyprowski@samsung.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index e510732afb8b0..7f6279fb4f8fa 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -714,7 +714,9 @@ static int exynos5_usbdrd_phy_calibrate(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	if (inst->phy_cfg->id == EXYNOS5_DRDPHY_UTMI)
+		return exynos5420_usbdrd_phy_calibrate(phy_drd);
+	return 0;
 }
 
 static const struct phy_ops exynos5_usbdrd_phy_ops = {
-- 
2.25.1



