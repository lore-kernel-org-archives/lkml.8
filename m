Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD34C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD0A320672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261360;
	bh=MR7PYcRcX1ev1bmrHvvbkcLvKZOjWSCMRCzeKzi9goI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbRg7I7Eny1MGRbMniigkts6JpXfmiA86KDgpp0SvIFhKOAgNUdORo5Ei5Xa+9TXa
	 WN5RRJ3aVwy3TzOiED5SBPfBvHHo/IvnhKcLOxqlJ7HGQMRGVAplo6cLpfTeDQG5Vy
	 T6GTk8a6izu/LWYfzYe81LRwHoVO92YDk3UXuGGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgGTQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387490AbgGTQJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:09:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EA7206E9;
        Mon, 20 Jul 2020 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261350;
        bh=MR7PYcRcX1ev1bmrHvvbkcLvKZOjWSCMRCzeKzi9goI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzcLSQathvc6IZD8j2uK4Ck4263ID3a3VXvS/OYuck6XCJRdpDtKx89Q8yBvRXn4t
         s9IDleYGBDo+LFGd0Er3T9hWbNauHhIlTVS0+WvC1/YN+JqwEm6N5GupUKfExxBmMb
         YTXKwPQBbc+EV63SSUrIDCVX9jUsOj7zESPunj0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Heiko Stuebner <heiko@sntech.de>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 085/244] phy: rockchip: Fix return value of inno_dsidphy_probe()
Date:   Mon, 20 Jul 2020 17:35:56 +0200
Message-Id: <20200720152829.880983999@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit fdc355a03df537bc8d8909b86d1688fe07c7032b ]

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: b7535a3bc0ba ("phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/1590412138-13903-1-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index a7c6c940a3a8c..8af8c6c5cc028 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -607,8 +607,8 @@ static int inno_dsidphy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, inno);
 
 	inno->phy_base = devm_platform_ioremap_resource(pdev, 0);
-	if (!inno->phy_base)
-		return -ENOMEM;
+	if (IS_ERR(inno->phy_base))
+		return PTR_ERR(inno->phy_base);
 
 	inno->ref_clk = devm_clk_get(dev, "ref");
 	if (IS_ERR(inno->ref_clk)) {
-- 
2.25.1



