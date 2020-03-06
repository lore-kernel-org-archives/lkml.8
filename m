Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE0D20714
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="iJDRs8kl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCFVGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:06:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:17652 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583528798;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=bK/BibRyT71/ND5TtK3+5pHcq6COywL/GI3c3CyuBQc=;
        b=iJDRs8klmiuv3d1W2mzhmi/+sX0bFaX3HU/Dr/Fx6o6G0xt1KvQTa7+00QOAllDVlI
        tL5pUV14WiXsgRz62RnL1s0Nk8nGlh8yLWmdex9r/q74rq3te5/A9SK8MDvSRiCwk53r
        0I3XM9iESjeONXl9t/uC2j1n4XsYSL0y74HmF9lbcf0YqM2TnQAYLZqYl9qZu9MS53tA
        uWsi2KZssqflcDGevkJVONgbcj9bLOcLwifKOji57itYtZDQdqgT7HGVrmnWTuVrpZPk
        YxHBr2XmLFQJQd+F6aZidMreDafnLrqHDPGiO/vaP9M+fWe6WhN2R9xWE4poRpKQrWj2
        eJMA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6GQjzrz4="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id y0a02cw26L6aaJc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 6 Mar 2020 22:06:36 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Alex Smith <alex.smith@imgtec.com>
Subject: [PATCH v7 1/3] MIPS: DTS: CI20: add DT node for IR sensor
Date:   Fri,  6 Mar 2020 22:06:31 +0100
Message-Id: <4bc5f062ca9d51457dec245cf8e11850c67207a9.1583528793.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1583528793.git.hns@goldelico.com>
References: <cover.1583528793.git.hns@goldelico.com>
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
index c340f947baa0..fc4e64200c3d 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -62,6 +62,11 @@
 		enable-active-high;
 	};
 
+	ir: ir {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpe 3 GPIO_ACTIVE_LOW>;
+	};
+
 	wlan0_power: fixedregulator@1 {
 		compatible = "regulator-fixed";
 		regulator-name = "wlan0_power";
-- 
2.23.0

