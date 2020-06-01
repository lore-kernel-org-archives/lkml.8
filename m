Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA36C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EB1206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037511;
	bh=xh++Q2c68oFOs5csXY6QWz3/3kKklg1Fea7GlH9mvXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=swj30cfEtKtIydNibyvYDrbuR3IrAOnHj56y04QtEfSMG5GCUgIfWsUYfCQQaXPka
	 8bJ+LxdXsz4hA5z8t9CthVLNo5+um7N83XIELqphYFpANYWJboyNkifOhJZKmpyidz
	 LeFlSd6ezI0Rz+pWL8gb6nUjN6NZiJxI97+e+orQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgFASEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:04:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730197AbgFASEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147AC207D0;
        Mon,  1 Jun 2020 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034662;
        bh=xh++Q2c68oFOs5csXY6QWz3/3kKklg1Fea7GlH9mvXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1EgDuGSgUmgvEWafe/vKw2/rMYKpKYPsI1uw7R91zFjgbxMGQOUapnOBPhS7VJXW
         ojedJDF9dki5yV3MnSmqEraqBFzRzGXhwuthqBKbKrcz0SAPspGZRgkBXp/oaq+6zu
         yJ5XRlJRpWK5UN2AH99y5x7qP4lrTyTZrzFUeCKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/95] ARM: dts: bcm2835-rpi-zero-w: Fix led polarity
Date:   Mon,  1 Jun 2020 19:53:53 +0200
Message-Id: <20200601174029.712170513@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Stehlé <vincent.stehle@laposte.net>

[ Upstream commit 58bb90ab415562eededb932455046924e65df342 ]

The status "ACT" led on the Raspberry Pi Zero W is on when GPIO 47 is low.

This has been verified on a board and somewhat confirmed by both the GPIO
name ("STATUS_LED_N") and the reduced schematics [1].

[1]: https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_ZeroW_1p1_reduced.pdf

Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 5fcadb9cf992..9f7145b1cc5e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -25,7 +25,7 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.25.1



