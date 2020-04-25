Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB835C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8D820704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh/YxgYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDYMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:23:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9622C09B04B;
        Sat, 25 Apr 2020 05:23:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so14656660wrm.13;
        Sat, 25 Apr 2020 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c08OzdbQ1jE2QKx73owHlaSBf5XrQfOgZDyVrQRe5NE=;
        b=Uh/YxgYrTgZm8cH7x+rLL64FIq82XOzzZDijkhS9sHgRdyfLMD/FImyOANWUtI0X3Z
         MGtQg53S8vd8vXVy0dZQDwHprtF0QDAjizqUCMyFFlRqAaAZiYkEchZr7uDlaryCrDrt
         7Otk2t/c6Nr85RCeC2V163G1cXTCBflRW7hOomfmDjQdH1VLPppXS3gHbZdKarWReiKs
         srkiAdwQ7LFjNUO21rK/JS0vR35lr2NV5jEFjWfAH/4igFTtSD0jwnvScl9nJ9LSxA7U
         yxhFKMjLoD5qWB3POqMKhwqWvDJe36uIdpFEnfOA7z+P7Klhz90Q3fEn0oRq8J9TuP7O
         1U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c08OzdbQ1jE2QKx73owHlaSBf5XrQfOgZDyVrQRe5NE=;
        b=XmVPLMykUgTCNPRTwAkm3BuRbEKowrODm2Jugepu8BNhlfrwxFwjV4Mj5dkB/V/Bqy
         C5cVQjbSDAW4aGxwD13YXt0vGo9ys5mrwNhFNKdTuOVQABBbxVoUONOhj67ZCsdJxmtN
         srpeAjm5j2Hdn6Y8kZsKoGaaRnY+2uiVIdwbCLmh45u2WP5zkFVKaXO/ONmjNU8Sxudu
         pwbLnn/jeMkdwQwLb6kpAaMWWQ9DxgWqwZ+GBu77ZBUsPIbHxXW3vlrRt6pN84VqrLBu
         dA4rTGa6Kvc18ZfixvTIs/O/5vndRTsoxKIdggEanrJPLeieBgk2pXgrOAWGlIBD+46u
         T6hg==
X-Gm-Message-State: AGi0PuYXaeBQy7sEPUP5jvRvC2QR7OGrGDvs80pJTzL0E8rOxvH281tN
        lVFPV1wFzww99NzedWKQyyi/Qm5H
X-Google-Smtp-Source: APiQypKqV1QTBOAvxcY1sOfn6lI7/CzLvVHNS8erVBArRldAOpnsmJD7HkBmATIOd07gEBWAxue0aw==
X-Received: by 2002:adf:e3c2:: with SMTP id k2mr16436150wrm.287.1587817432474;
        Sat, 25 Apr 2020 05:23:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o6sm3248461wrw.63.2020.04.25.05.23.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 05:23:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: remove extra assigned-clocks property from &gmac2phy node in rk3328-evb.dts
Date:   Sat, 25 Apr 2020 14:23:44 +0200
Message-Id: <20200425122345.12902-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 'assigned-clocks' properties in the '&gmac2phy'
node in 'rk3328-evb.dts', so remove one of them.

Info from clk-rk3328.c:

MUXGRF(SCLK_MAC2PHY, "clk_mac2phy", mux_mac2phy_src_p,
CLK_SET_RATE_NO_REPARENT,
RK3328_GRF_MAC_CON2, 10, 1, MFLAGS),

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 49c4b96da..ab69b493d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -82,7 +82,6 @@
 &gmac2phy {
 	phy-supply = <&vcc_phy>;
 	clock_in_out = "output";
-	assigned-clocks = <&cru SCLK_MAC2PHY_SRC>;
 	assigned-clock-rate = <50000000>;
 	assigned-clocks = <&cru SCLK_MAC2PHY>;
 	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
-- 
2.11.0

