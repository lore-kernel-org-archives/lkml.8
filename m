Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4964EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEE72073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036706;
	bh=gqu03fH8g89anh/WMKH7IiocPYeUfj7QTFSKO32mq9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJaXPbM2IbJw+MuZcKM87ic1hsB8o1qTQKC/vLNhIRdBfoiEo4xGdxG7Nt8GmXqGq
	 a/A/1m7n0IDCHV3mHg+jzGBj53DSan9iNrGHOlUONr2xkFjKDtM66iuI6lbPlIVoGs
	 6KvgRv5v6ki62hPRYxBbu1io9L1oC2+0TiDK/a4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgFASiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgFASPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:15:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE76F2068D;
        Mon,  1 Jun 2020 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035314;
        bh=gqu03fH8g89anh/WMKH7IiocPYeUfj7QTFSKO32mq9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIHbCf8S2SuLV2KuqrgtoK0sCKMOBAMxtNeS7CFcYpJlb9WBjBBKmaeof0LH384qH
         lJHGQLpuvGvUk484L5UbUTbs+TfoujxCCasmE1Ml5JSJNysGLmyFaOQv/rhaM0rC2q
         L2B+A2RPywvyyKYZHLWd4f0uXGiPmEuRhPGGqtDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 104/177] ARM: dts: bcm2835-rpi-zero-w: Fix led polarity
Date:   Mon,  1 Jun 2020 19:54:02 +0200
Message-Id: <20200601174057.300801289@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
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
index 4c3f606e5b8d..f65448c01e31 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -24,7 +24,7 @@
 
 	leds {
 		act {
-			gpios = <&gpio 47 GPIO_ACTIVE_HIGH>;
+			gpios = <&gpio 47 GPIO_ACTIVE_LOW>;
 		};
 	};
 
-- 
2.25.1



