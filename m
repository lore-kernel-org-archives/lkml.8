Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB1DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF0420716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693772;
	bh=8INbqVHcC//Bj7jsi7PEmcghl29Dn+dGUL9hboMj/8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZypxsbjVzzSiXwodmlx9xBBqk8fwrEjttryjbLPqok13IovP3lyI3AglKBttkvUja
	 WSg5nqJwO6KIErCBhashOm7Xijo+nnUIOevOIY0zCKrr3erXC08EyOmtGM+S1efVek
	 /hu+KriI6rBgXNuEWPTRUuiXDQ2BE6vFKCFBYkeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgHQTt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgHQPUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:20:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906D4206FA;
        Mon, 17 Aug 2020 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677606;
        bh=8INbqVHcC//Bj7jsi7PEmcghl29Dn+dGUL9hboMj/8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZn8Xzt46J+XsXtKyqSDNkyXvVNAlQfBfJgFugS0vwUyc16XoX581o4ZOAsSA/tKQ
         2GJ+lfIvdjuNeN3QrTzn7YNMlcLiHK4N7xwHvb2jRKtMt50IkZBwvdDnEbb6/quUUp
         R000A8olE3GwM04wtxmRrX/L0NA2MMySAzz52AGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 042/464] ARM: dts: at91: sama5d3_xplained: change phy-mode
Date:   Mon, 17 Aug 2020 17:09:55 +0200
Message-Id: <20200817143835.769246910@linuxfoundation.org>
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 7dbf4bbf1c320d82058878bd44805724d171e1e8 ]

Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
KSZ9031 PHY"), networking is broken on sama5d3 xplained.

The device tree has phy-mode = "rgmii" and this worked before, because
KSZ9031 PHY started with default RGMII internal delays configuration (TX
off, RX on 1.2 ns) and MAC provided TX delay. After above commit, the
KSZ9031 PHY starts handling phy mode properly and disables RX delay, as
result networking is become broken.

Fix it by switching to phy-mode = "rgmii-rxid" to reflect previous
behavior.

Fixes: bcf3440c6dd78bfe ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20200717233644.841080-1-alexandre.belloni@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 61f068a7b362a..7abf555cd2fe3 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -128,7 +128,7 @@ vddana_reg: LDO_REG2 {
 			};
 
 			macb0: ethernet@f0028000 {
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-rxid";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "okay";
-- 
2.25.1



