Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D51C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D332076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrjK4d9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGQPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQPXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E0C0619D2;
        Fri, 17 Jul 2020 08:23:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so11549242wrl.8;
        Fri, 17 Jul 2020 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPVCDr4im/hPh3ecaLSwEPVliXPN7RfgtalCBE3XxpQ=;
        b=mrjK4d9Fyc/X5drHE+cgZxtWRsZpGiWvOpOJt0rQri+PHL+J+HGizUX/AKhn8k+7kt
         owQytKjnNtItblPZ7LtZJldpht/j/tnzpPnFVXjFe/0WegaiTuw4x84npAx0gIlQr22e
         U+1MKiBv9ArgH0MJeCoqTxCnOD/+Mzt1vf0RjJMBdd+xrshWvpzh6h/0w/4B5ud+Ek/g
         tmc4OLtJlII+VbwelIgq2nqhhdOneZNw6yh7eijzaGeLMLbane9kMYprQdfXg3XI0tlF
         QeGirKB7mk0HdYlPGHkm81ZFe/0bB6qCprPzWp1QimrSThGgogGHd+iAduEqbCia1MJ1
         D+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPVCDr4im/hPh3ecaLSwEPVliXPN7RfgtalCBE3XxpQ=;
        b=SvAXJQXHI+lFziMO9g0derT8EzTwrHeIU++Y10McbXmTWp5e4bLV06fw2Yyl8eRcQ+
         tPwOlCCF8kJHN/kyZxgqkXHSAwCYRY2ITm/K7hUhYLJKnZE4/nQxeKkDg/60lqCDHXZ5
         fdV6Zm26XrjsCYjGrjiH14Zxm/+MvTGCiyCrg0MtLJDMjtgrvkyxrvCBzcy0MNgS/Qp4
         ciMtaVL6uNOIZPtgAA8OihQmoeRFGiInWIH5n1lWFSEM4cXBZchFko1DyBLar6OoMgsD
         yZdwoiTDaP6ZTmTvSy2/JWayJZvrFz2Pr5soHSRXPyFbWHeTkc/PFnxTviwA0yjH+fN1
         9IaQ==
X-Gm-Message-State: AOAM533iuzfWpFrlm+JCrfj/6zNgiNyeEL/BUlI4TPRyECKiGWhIw7uL
        ctrfMiRJ2Padm+a7Rzr6ml5+eNSH
X-Google-Smtp-Source: ABdhPJz6uhtDSvPKuE35q1b3k4iV1HswM0+93tmJfA9hEQi+3tPqTU/S2xLRGYfQTc8WB6uNrPgl1Q==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr11105669wrx.203.1594999422622;
        Fri, 17 Jul 2020 08:23:42 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:42 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH 1/7] dt-bindings: usb: bdc: Update compatible strings
Date:   Fri, 17 Jul 2020 11:23:01 -0400
Message-Id: <20200717152307.36705-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "brcm,bdc-v0.16" because it was never used on any system.
Add "brcm,bdc-udc-v3.1" which exists for any STB system with BDC.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 Documentation/devicetree/bindings/usb/brcm,bdc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.txt b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
index 63e63af3bf59..597f3902d857 100644
--- a/Documentation/devicetree/bindings/usb/brcm,bdc.txt
+++ b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
@@ -4,7 +4,7 @@ Broadcom USB Device Controller (BDC)
 Required properties:
 
 - compatible: must be one of:
-                "brcm,bdc-v0.16"
+                "brcm,bdc-udc-v3.1"
                 "brcm,bdc"
 - reg: the base register address and length
 - interrupts: the interrupt line for this controller
@@ -21,7 +21,7 @@ On Broadcom STB platforms, these properties are required:
 Example:
 
         bdc@f0b02000 {
-                compatible = "brcm,bdc-v0.16";
+                compatible = "brcm,bdc-udc-v3.1";
                 reg = <0xf0b02000 0xfc4>;
                 interrupts = <0x0 0x60 0x0>;
                 phys = <&usbphy_0 0x0>;
-- 
2.17.1

