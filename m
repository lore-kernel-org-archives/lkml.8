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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB72EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F9720725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJlkwayJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGKBwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKBwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:52:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB78C08C5DC;
        Fri, 10 Jul 2020 18:52:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j20so3314747pfe.5;
        Fri, 10 Jul 2020 18:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8/wOH535DrhUpntjXB/3t3siSTV65FweAt9cxpPyzI=;
        b=AJlkwayJhg/iD2qnXFpGB1GR0fSZOCtkFyAIry84r2Sr8mbntH/O7MTNOCfrFFNFIj
         ojxvXydrRZa0Xi3VguFuIxDYuhJi3C8G8xxFZGaeOAJyJdzbFHuw3zAemq0qaPzRJy38
         0F13+JWN3s79K2fpCVLt7wV0r5YAnxvZr2JGURTu5eLK8qBoiHXaDXI+ZFbUmoHPfjYI
         XtNeWzkvJhjV5oldAJCVw8CNEIULR5QkdlYSXwQsmCV1Fc25iJFLKDHgWlm0gc+L/Q5M
         0nJ+GNzXlcyMuG2yJV5DxrZ2ljz/SzPMJ8pYOO/v3w2Bo8zpiebnktHDzfY95ADiL10d
         NKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e8/wOH535DrhUpntjXB/3t3siSTV65FweAt9cxpPyzI=;
        b=cbBdmdRJDAivKORiUl8y7Mi5cZFpXkphgDXw8wGqTqVtdHZ1+IGTT5z5dzW9ixU2lX
         cO9S1Ds/+VmpYrZd9uMgi+iGqS/yrWhClD9O1sq3aI1e8k3IQCT6MUrYlNZ3e3M+zqbF
         tnq4gmsj+R/M0FY42c+sc1iWIcUIWsW8bZf/4MoOMxbvqTWw0W9RYCyBj4UI4DkTKwdK
         4g34VHjfUu6iZoJ2QGf9ByK+MLjeDA/r222ydTfCrCDP25gIQFU43INGgehNwD2RDkpS
         kZ5l3p/Vcps6/FIKNB76gytwTeNXqEZFz8LQvtsD3FNXLLA7N5xAArw5wzxaPfdKjJwf
         35GQ==
X-Gm-Message-State: AOAM532iEnOc1s9xx3wYJf3pqWnFvvE0iyfV/9FOulJdTiTHTAoYpAyo
        Zxj4S4gmRdqggOT2dYiIIcs=
X-Google-Smtp-Source: ABdhPJyV6qGoRYPALQCPNk8PU2nFldovgenHYOMoO6Tk8HbU8ZrFRCXLzu22tEn3DW8J5SggadEuhA==
X-Received: by 2002:a05:6a00:2b0:: with SMTP id q16mr11409725pfs.79.1594432361636;
        Fri, 10 Jul 2020 18:52:41 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id x66sm7030999pgb.12.2020.07.10.18.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 18:52:40 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        horia.geanta@nxp.com
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Subject: [PATCH v3] ARM: dts: vfxxx: Add node for CAAM
Date:   Fri, 10 Jul 2020 18:52:23 -0700
Message-Id: <20200711015223.5555-1-cphealy@gmail.com>
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
---
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

