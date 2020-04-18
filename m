Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F9C38A2E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA9B21D79
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=laposte.net header.i=@laposte.net header.b="ZLDcPZvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDRMpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 08:45:35 -0400
Received: from smtpoutz29.laposte.net ([194.117.213.104]:60123 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbgDRMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:45:34 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2020 08:45:32 EDT
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout017 (Postfix) with ESMTP id BC339BC2BAE
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 14:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1587213343; bh=TR2OBvqi8UQ119Z63pajz6Z10HLZExtiXo+C91VQBis=;
        h=From:To:Cc:Subject:Date;
        b=ZLDcPZvxJ6XSGzcDWb1ist7gtLWFOv0k1x4npHSGcET6AE76GV7AMNvmTq4VZtWmv
         0I/qbpBV184OyZR/cOH805//HlHZeV3Wjuld/Ckl9Y05HMlGYo6zNkNhhCuCLabxiR
         UGF/6mrmVFPwh+Sht2oiDLyhCP6McPbT06nXHTbsTmReIVSEmEf/i6852mV/N02lqW
         +uU4tUsGkfXaL+X3VXw5YaI7cWO8CvWK7xwb7CArhieCzQ/UHOq3DM3zzOq487WRji
         iZ9NPIfG4g65bJ0FqF4qmZClrKQGwIxKvqQuN6U/IW5AzpaFjT4NxYiEU4Cof/3+0F
         LoBG13UmYjPkg==
Received: from outgoing-mail.laposte.net (unknown [10.94.128.80])
        by lpn-prd-vrout017 (Postfix) with ESMTP id B955FBC293A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 14:35:43 +0200 (CEST)
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
        by mlpnf0101.laposte.net (SMTP Server) with ESMTP id 494C9W52BzzFpTy;
        Sat, 18 Apr 2020 14:35:43 +0200 (CEST)
X-ppbforward: {"queueID":"494C9W52BzzFpTy","server":"mlpnf0101"}
X-mail-filterd: 0.4.0.2
X-mail-filterd: 0.4.0.2
X-ppbforward: {"queueID":"494C9W2c7bzFpTw","server":"mlpnf0101"}
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
X-lpn-spamcause: OK, (-100)(0000)gggruggvucftvghtrhhoucdtuddrgeduhedrfeelgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfntefrqffuvffgpdfqfgfvpdggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeggihhntggvnhhtucfuthgvhhhlrocuoehvihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvtheqnecuffhomhgrihhnpehrrghsphgsvghrrhihphhirdhorhhgnecukfhppeekkedruddvuddrudegledrgeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheprhhomhhurghlugdrsggvrhhgvghrihgvpdhinhgvthepkeekrdduvddurddugeelrdegledpmhgrihhlfhhrohhmpehvihhntggvnhhtrdhsthgvhhhlvgeslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtoheprhhjuhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopehssghrrghnuggvnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepfhdrfhgrihhnvghllhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghfrghnrdifrghhrhgvnhesihdvshgvrdgtohhmpdhrtghpthhto
 heprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhinhgtvghnthdrshhtvghhlhgvsehlrghpohhsthgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhpihdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhhsrggvnhiijhhulhhivghnnhgvsehsuhhsvgdruggvpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-lpn-mailing: LEGIT
Received: from romuald.bergerie (unknown [88.121.149.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mlpnf0101.laposte.net (SMTP Server) with ESMTPSA id 494C9W2c7bzFpTw;
        Sat, 18 Apr 2020 14:35:43 +0200 (CEST)
Received: from radicelle.bergerie (radicelle.bergerie [192.168.124.12])
        by romuald.bergerie (Postfix) with ESMTPS id 1329E381F5A4;
        Sat, 18 Apr 2020 14:35:43 +0200 (CEST)
Received: from vincent by radicelle.bergerie with local (Exim 4.93)
        (envelope-from <vincent@radicelle.bergerie>)
        id 1jPmhC-0001fl-Oi; Sat, 18 Apr 2020 14:35:42 +0200
From:   =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
To:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] ARM: dts: bcm2835-rpi-zero-w: Fix led polarity
Date:   Sat, 18 Apr 2020 14:35:22 +0200
Message-Id: <20200418123522.6390-1-vincent.stehle@laposte.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status "ACT" led on the Raspberry Pi Zero W is on when GPIO 47 is low.

This has been verified on a board and somewhat confirmed by both the GPIO
name ("STATUS_LED_N") and the reduced schematics [1].

[1]: https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_ZeroW_1p1_reduced.pdf

Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 4c3f606e5b8d8..f65448c01e317 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -24,7 +24,7 @@ chosen {
 
 	leds {
 		act {
-			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.25.1

