Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEF8C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CE120708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 17:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=laposte.net header.i=@laposte.net header.b="mkGurfY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDKRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 13:54:22 -0400
Received: from smtp-outgoing.laposte.net ([160.92.124.99]:48455 "EHLO
        smtp-outgoing.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgDKRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 13:54:22 -0400
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
        by mlpnf0114.laposte.net (SMTP Server) with ESMTP id 4902SC4TF8z1GBw0;
        Sat, 11 Apr 2020 19:48:59 +0200 (CEST)
X-mail-filterd: 0.4.0.2
X-mail-filterd: 0.4.0.2
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
X-lpn-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrgeduhedrvdeggdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecunfetrffquffvgfdpqfgfvfdpggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepgghinhgtvghnthcuufhtvghhlhoruceovhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtqeenucffohhmrghinhepsggrnhgrnhgrqdhpihdrohhrghenucfkphepkeekrdduvddurddugeelrdegleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehrohhmuhgrlhgurdgsvghrghgvrhhivgdpihhnvghtpeekkedruddvuddrudegledrgeelpdhmrghilhhfrhhomhepvhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtpdhrtghpthhtohepihgtvghnohifhiesrghoshgtrdhiohdprhgtphhtthhopeifvghnshestghsihgvrdhorhhgpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfr
 hgruggvrggurdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-lpn-mailing: LEGIT
Received: from romuald.bergerie (unknown [88.121.149.49])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mlpnf0114.laposte.net (SMTP Server) with ESMTPSA id 4902SC0h0Vz1GBvc;
        Sat, 11 Apr 2020 19:48:59 +0200 (CEST)
Received: from radicelle.bergerie (radicelle.bergerie [192.168.124.12])
        by romuald.bergerie (Postfix) with ESMTPS id A70DA37FE060;
        Sat, 11 Apr 2020 19:48:58 +0200 (CEST)
Received: from vincent by radicelle.bergerie with local (Exim 4.93)
        (envelope-from <vincent@radicelle.bergerie>)
        id 1jNKFW-000152-BQ; Sat, 11 Apr 2020 19:48:58 +0200
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: Fix led polarity
Date:   Sat, 11 Apr 2020 19:48:43 +0200
Message-Id: <20200411174843.4112-1-vincent.stehle@laposte.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=lpn-wlmd; t=1586627661; bh=AcBvHLPmHFu6rApjMG0R0hlig2Vi1pp7NLIlCkMKiWA=; h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding; b=mkGurfY1d9S6Ue4dAGWSFzQaZ9AH9SCCZ7y+AaZ0FyFPrAW8riNXdW29a/efqbxqpoURABDJM8Gesxckd5O6JBAaSHcDUPDY+GMqrOc4ShfKjza7S1N+y+PH/Xa2mGE6vb8Kklc2PYSrlgczw5fKjqWJt6NepjjkoxrckpKaJiURqwP5++zCk+2krAzYupfE19bXhPiuqFyzQA8QjoE/osdQMRVLjpzKGmIPMPhvmBumq7wEVEkMRNQmA/ryTPMIB8CcLVbW2RbkSynN5D95eQ8Z/vwUisjjEixgC0C0vm87RdDkf3pCgP0dxrz8R3C1hqo/+vwNOdpGQAebquPpRQ==;
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWR-LED on the bananapi m2 zero board is on when gpio PL10 is low.
This has been verified on a board and in the schematics [1].

[1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#Documents

Fixes: 8b8061fcbfae ("ARM: dts: sun8i: h2+: add support for Banana Pi M2 =
Zero board")
Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <mripard@kernel.org>
---
 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index d277d043031b2..4c6704e4c57ec 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -31,7 +31,7 @@ leds {
=20
 		pwr_led {
 			label =3D "bananapi-m2-zero:red:pwr";
-			gpios =3D <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+			gpios =3D <&r_pio 0 10 GPIO_ACTIVE_LOW>; /* PL10 */
 			default-state =3D "on";
 		};
 	};
--=20
2.25.1

