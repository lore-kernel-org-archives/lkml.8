Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE1C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 02:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689612076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 02:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pexbHFZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGKCDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 22:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKCDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 22:03:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F2C08C5DC;
        Fri, 10 Jul 2020 19:03:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a14so3327701pfi.2;
        Fri, 10 Jul 2020 19:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbXn9/LbfccX/WcyC9q9uipj2oRJQsKfZJOM3Z1Pth4=;
        b=pexbHFZo9I1VFtnsDcLs94m+wRe7+5CFRHZ9NFDn40PpF8tQE9GbOhHECPE4uLit+F
         DjI8xdUGmn9PJNgwTw+d9wRBWuSSPBxiSbasxSVqSSP0bhMXRD+hYIkaiwxPfwTW5ecJ
         E6/cgwn80/N29sS3JmRJGP3H5XX0RYTw6AVL0t6luvIy3WI/aPLufc8aa8NxrztZgxp4
         MueuHWqQS4C/MbiVmIvlKkk28bRupn6RHbKu1RM783l5B3HXKR2Xkq8UQltuuqbB/RrV
         tXSyrW+PZ8yiWqpZOQvl5CP9tVke2jKkRan3a/J0dy9UcLyEVHuL8OtvfAqZGcXmmFYi
         WnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbXn9/LbfccX/WcyC9q9uipj2oRJQsKfZJOM3Z1Pth4=;
        b=Y5nfsthv54oFFB8TkmTUZ3q1XLLErmS0msYYbmZbws8o828++jY7VEnjb9qcaNA+me
         s9MfYs2jzmksHa8MZnRSA6CrITNyL5oe9qGnTQCqPxppGUOs6rq/j1t99ydJouDgMYsV
         1objqJgqQlejSYff2ptkmuoVxD7P2WxwGsv6FmdFe/rrjlqjmf8HX1oIYZDgCHbTV2vF
         oPGYRepSwQ4wbB78sVjFA9nQ2UqY2HGzKWgSgKrS6Hca3o9WpTC/zn+miKUOgHdD8nr8
         Nv13eUbwx6TxHEZbRkvkXUPKooozQg6Pjr/n8rEIm9KvNbooJR7Rp8o4stc0jNZzE+A5
         /y+w==
X-Gm-Message-State: AOAM532AcBr9j4m5WTC1Opyly5nYG0BEqdDTj7jv5ShLDIXFaGWvGqw2
        tiEyn5uUpgpXyNb8TLfHZSI=
X-Google-Smtp-Source: ABdhPJxpY+EUWSrsQ26m4vlmtmmShqIXwB+jrHUW6u8phslm+cwKaDGOCgaomX2gKW7i1kL2CUslYg==
X-Received: by 2002:a63:6d48:: with SMTP id i69mr60316084pgc.354.1594432986752;
        Fri, 10 Jul 2020 19:03:06 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id v10sm7557832pfc.118.2020.07.10.19.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 19:03:05 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        horia.geanta@nxp.com
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v4] ARM: dts: vfxxx: Add node for CAAM
Date:   Fri, 10 Jul 2020 19:02:45 -0700
Message-Id: <20200711020245.6056-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com> 

Add node for CAAM device in NXP Vybrid SoC.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
v4:
- really add reviewed by from Fabio Estevam
v3:
- put version information in the correct place
- add reviewed by from Fabio Estevam
v2:
- fixup commit to show that this patch is from Andrey Smirnov

 arch/arm/boot/dts/vfxxx.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2d547e7b21ad..0fe03aa0367f 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -729,6 +729,28 @@
 				dma-names = "rx","tx";
 				status = "disabled";
 			};
+
+			crypto: crypto@400f0000 {
+				compatible = "fsl,sec-v4.0";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x400f0000 0x9000>;
+				ranges = <0 0x400f0000 0x9000>;
+				clocks = <&clks VF610_CLK_CAAM>;
+				clock-names = "ipg";
+
+				sec_jr0: jr0@1000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x1000 0x1000>;
+					interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr1@2000 {
+					compatible = "fsl,sec-v4.0-job-ring";
+					reg = <0x2000 0x1000>;
+					interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
 		};
 	};
 };
-- 
2.21.3

