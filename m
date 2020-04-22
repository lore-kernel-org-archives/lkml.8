Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B97C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608D72073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551690;
	bh=R/EkibC1xiHR1BW+LamJK6V0IuMDFME4qS/zquvUOgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N9+kJDbTg6E7UuR7eomA30aV/jQ8+zAoqE51WBOkNRFaeGK6ANoe3iIwL27jB9lzS
	 nA6R/rrNflWFOx3Wc5vlEDFZKaRJfs0cRSK+76v1+HohJHfwGkkDG50aZRj6KN/PG3
	 CLVJd1n7YA+QhH3drMz9T5h0YgFaQ8Z3mPxSQZag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbgDVKet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbgDVKYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:24:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11C7C2076B;
        Wed, 22 Apr 2020 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551044;
        bh=R/EkibC1xiHR1BW+LamJK6V0IuMDFME4qS/zquvUOgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPUguWtT6Ip+AogbcEfVpukymXjIlCoGZsf4sG5H2yDlfZvSjcIM+DSMhmg4OI1qM
         tlovK3V64zHARHsD16cOX1P8r8ptNKSUFMB4HAvdpOHgRYCcPDh9wbOc6qjkGMGRcx
         HHB6371GBeVcpSN7s4VTxQ3YIvI+H8usudk9Y7b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 079/166] phy: uniphier-usb3ss: Add Pro5 support
Date:   Wed, 22 Apr 2020 11:56:46 +0200
Message-Id: <20200422095057.300703336@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



