Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE34C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C0F2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 21:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="dupIz7K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgBKVmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:42:01 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:23707 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgBKVly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581457310;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=tz5FT9e8j/vOF6dHesX7jElKIt8MXbKvwaqQV2chsVc=;
        b=dupIz7K1QDO5pGf0QzjaY/pv9gX+ybe0O1d3Bobc6KX5ZyzXJFni4IpZASVsyF7+Ri
        r0+tbbsNO/SQ79AAgQ+tUFt9EBmXUmIIQMn6XNk17hvLd2ROC8FdVONpck59jqOc5ZzE
        uiyvx23s7XXMNuZLSulLxIfVS+LNmwCuMH76/NcnczU+WodrKh914bmvtqsZhYdTAsnv
        bruuayI0ER2VfsoFasLekSNbzYH4b0UvmInlqSaZnpVStIAf0lLrkueCMnldhodZPHzE
        6i1gTpTfKvlcFEcnrHzv+LYTz0vGGxZwafAJvD9R+AaKGmIU4rBetwjwNt4r1SEOdeGw
        lyjQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0P2mp10IM"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1BLfe0EQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 11 Feb 2020 22:41:40 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Paul Boddie <paul@boddie.org.uk>,
        Alex Smith <alex.smith@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andi Kleen <ak@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: [PATCH 10/14] MIPS: DTS: CI20: add DT node for IR sensor
Date:   Tue, 11 Feb 2020 22:41:27 +0100
Message-Id: <5ba2ba43f06955bbfcd8465271bb01cfc1101d13.1581457290.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581457290.git.hns@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Smith <alex.smith@imgtec.com>

The infrared sensor on the CI20 board is connected to a GPIO and can
be operated by using the gpio-ir-recv driver. Add a DT node for the
sensor to allow that driver to be used.

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index e1364f941c7d..b4a820313992 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -62,6 +62,11 @@
 		enable-active-high;
 	};
 
+	ir: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
+	};
+
 	wlan0_power: fixedregulator@1 {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan0_power";
-- 
2.23.0

