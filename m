Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F345C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCFD207FF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpu0w6eO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgFMIWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgFMIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 04:21:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F97C08C5C4;
        Sat, 13 Jun 2020 01:21:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so9923104wmj.0;
        Sat, 13 Jun 2020 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7N+5A0qfgXDiByKb642Lyly7EAHnzetKXSyZeUALaf8=;
        b=Zpu0w6eOMU0Bx5LscRdOg3AVp9Oq4XBOuStbINf/1VCS+wERXcO/1uZ0jckJTyG4YJ
         AH4scQRqjImjJBEmGHTDn+lppEQJii2a/ayy0f3JiS9knyOuSuIng0mLOBirMtgczl2H
         E2zV3lUN3OJS6h1S/KCKj7SW7AtCvVdssDGWM7Bcizq8QtHPlyt0Vs3qBLEfnr5BwM63
         gKIklbSUmNn5QMsKxs1cC8MFBHyT2FzATv7DCjhRyaDYA6BBowlT4UsXmLbF5jXnDe9m
         a64Y2PqxqW3DBuAfQ/aO4Hl4QeFnU6CW9bhuKsH2I9YNiEEqjkLUlnkI68pJjRsp/AIF
         aqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7N+5A0qfgXDiByKb642Lyly7EAHnzetKXSyZeUALaf8=;
        b=VHJHmdZpGjY0J3ecwHHhANWuX822jwUNgQCYeofjhjCybEIfce/uRxxMmIPZlPHXqb
         Q00WR3KXgHA3zzgsWLHm6fRGztOzGlgjLS7Yc3GHeduvb7kBS7771WVHD484vOJ5deOX
         G8E1PyuxJQDfROCEFKMrTyi3lwD2w04KZbtWFtr5Vga40EELaS9ZG8kDgrqSI/aKuId+
         bP+15OU4EeRBXwZ+NpmU4AuckmpuBT4Pvgjr9CtU1C9TpCljbcei99gBSO/P/ZJY8q4B
         17UKmVSEeXFALT57fXXuBVL2fweZUESogijVja6teepUcJUszF2QOuz1FAVNQc8G2LTP
         cHOQ==
X-Gm-Message-State: AOAM533V3IHNLOtrsW1o7xS/ZBwACbA0V+BpN7K9akdB4JRrq68wDFn1
        e9D9WyBvw6vVe2dbgcJ5HaY=
X-Google-Smtp-Source: ABdhPJwxVIkKaBjI9z5Oq8oDX+uoWFdTmxrV8oTiDI9ydbUyEpOtsH3hNRius7MT+0gD3hjvAFerZA==
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr2869698wmg.130.1592036512036;
        Sat, 13 Jun 2020 01:21:52 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id n189sm12243603wmb.43.2020.06.13.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 01:21:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 8/9] mips: bmips: dts: add BCM6362 power domain support
Date:   Sat, 13 Jun 2020 10:21:39 +0200
Message-Id: <20200613082140.2009461-9-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613082140.2009461-1-noltari@gmail.com>
References: <20200610171630.465579-1-noltari@gmail.com>
 <20200613082140.2009461-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6362 SoCs have a power domain controller to enable/disable certain
components in order to save power.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v4: no changes.
 v3: Separate dt-bindings definitions from power domain .dtsi support.
 v2: Add dt-bindings header files.

 arch/mips/boot/dts/brcm/bcm6362.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm6362.dtsi b/arch/mips/boot/dts/brcm/bcm6362.dtsi
index 8ae6981735b8..c98f9111e3c8 100644
--- a/arch/mips/boot/dts/brcm/bcm6362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6362.dtsi
@@ -108,6 +108,12 @@ uart1: serial@10000120 {
 			status = "disabled";
 		};
 
+		periph_pwr: power-controller@10001848 {
+			compatible = "brcm,bcm6362-power-controller";
+			reg = <0x10001848 0x4>;
+			#power-domain-cells = <1>;
+		};
+
 		leds0: led-controller@10001900 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.27.0

