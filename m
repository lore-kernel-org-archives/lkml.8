Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101EAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4886206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951597;
	bh=R/EkibC1xiHR1BW+LamJK6V0IuMDFME4qS/zquvUOgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MPRp+IgvGn5x4aebT1N7TwDkekct0vtjyfJ6tI6sKlpZ+ZS8ZbuX1Jey7rdUswD4z
	 nSuvVn3uz6zms38MIHCJkL6br6BvMACIqhDUdBoIN8Uav19F60JSqyBco+Sw0DEaDa
	 lEfjz1muDKBG/avGJMWBm0LaVIzYb6uJC0IHgiDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897804AbgDOLxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409137AbgDOLpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:45:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBFFC20732;
        Wed, 15 Apr 2020 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951108;
        bh=R/EkibC1xiHR1BW+LamJK6V0IuMDFME4qS/zquvUOgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y3Eq5piSE6yqyTYL67VAPvjZfhHkuxu55+d7ja7xTdro9V1ZlpYdHIpt0W59o48Xo
         dwP5sKMAHR0f6aJ3dDJ24AK95jCmNGz9Sg6TcHT2DrpUJ5Sr/EiUMzQhvPR/6VkIaP
         BKSrwmwfeMBSvHekgIXQD7U5VDB1nHTrqHWyiWYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 23/84] phy: uniphier-usb3ss: Add Pro5 support
Date:   Wed, 15 Apr 2020 07:43:40 -0400
Message-Id: <20200415114442.14166-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit 9376fa634afc207a3ce99e0957e04948c34d6510 ]

Pro5 SoC has same scheme of USB3 ss-phy as Pro4, so the data for Pro5 is
equivalent to Pro4.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/socionext/phy-uniphier-usb3ss.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
index ec231e40ef2ac..a7577e316baf5 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3ss.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
@@ -314,6 +314,10 @@ static const struct of_device_id uniphier_u3ssphy_match[] = {
 		.compatible = "socionext,uniphier-pro4-usb3-ssphy",
 		.data = &uniphier_pro4_data,
 	},
+	{
+		.compatible = "socionext,uniphier-pro5-usb3-ssphy",
+		.data = &uniphier_pro4_data,
+	},
 	{
 		.compatible = "socionext,uniphier-pxs2-usb3-ssphy",
 		.data = &uniphier_pxs2_data,
-- 
2.20.1

