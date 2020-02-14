Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10897C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDDF222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="DPm2fp5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403890AbgBNRTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:19:18 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.124]:19639 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391607AbgBNQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581696642;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3oO7x2A3vdUHmUPMqDNJJ9DsdN1nPGYoXmW4gDFFS+k=;
        b=DPm2fp5U1fSACRGiAgOjmYWs7+jNqufvSiK2JUET9VWvfbKBXUFnSFfk+CQdH5v8kS
        sfxtQ7ne5Mg9dh6kacDYiRNiDY1D40MAx4Bv2eXxTZLRkS1wkXoTFEKMdfs4OmbOMwgJ
        CZQy0eIldUQPPsN2UyMYS2coPHDQF0T+cIgnksQHuGnYVZxMDWG4JzyROEfxCDjkoWzd
        OydLAWUqPizxg7CiHF9x4FbCi65mK4FgjAYmDgKw3K/tTw1/1fSCK436IasMtR0dMhiy
        T7ZKmek8AivltBVTZ1bL+5mabQuODbeV9VZh/LCXn7LWIUSdafwWz26d2lHmEYiCiWwg
        tZRg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7OMfsfQx3"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id U06217w1EGAXFl7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 14 Feb 2020 17:10:33 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Boddie <paul@boddie.org.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andi Kleen <ak@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kees Cook <keescook@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: [PATCH v2 12/12] MIPS: DTS: CI20: fix interrupt for pcf8563 RTC
Date:   Fri, 14 Feb 2020 17:10:24 +0100
Message-Id: <42aed0c7c063fa6c289fcbf361645056e15f513c.1581696624.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1581696624.git.hns@goldelico.com>
References: <cover.1581696624.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts should not be specified by interrupt line but by
gpio parent and reference.

Fixes: 73f2b940474d ("MIPS: CI20: DTS: Add I2C nodes")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 8f9d182566db..4bacefa2cfce 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -298,7 +298,9 @@ Optional input supply properties:
 		rtc@51 {
 			compatible = "nxp,pcf8563";
 			reg = <0x51>;
-			interrupts = <110>;
+
+			interrupt-parent = <&gpf>;
+			interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
 		};
 };
 
-- 
2.23.0

