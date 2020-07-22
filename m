Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5DAC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77085207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH46zeob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgGVRII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGVRIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29725C0619DC;
        Wed, 22 Jul 2020 10:08:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so2590994wrj.13;
        Wed, 22 Jul 2020 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTkSYkc9gpH4QzORDGHTScWkiYwqJXVWEMIKvBCkKyc=;
        b=UH46zeobCwaJFYyPwZvWcK6ymFrftwuWWkiLwaiVBLEBoWEZdTu20LPxYhjHVqJyLH
         rGZrIdY4g0ta6Rjfynx/qGeV0V5zEwxjhv+lf7S4eV5kJFUe2SqOl4iPpQgDdj1UDsnI
         tUhzsPl3R5CVYBjeXQjn+BySZxex3c8jGKgS8zAtCSZsGKQsUSNP2+G9JR2W+o6IKZL/
         XbVBVh3zIvTlNjItu6V9YlWsngqTXi4Qs1JQCAO/2wKfQeJhWc25aGqj1fE17JpIStG4
         j347/afDPGSKWRgDYX7LQb8lFgxLenQADUm6ywMOy69UJ7UqV4OBEgcHsfHbHdYj25ry
         Iq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTkSYkc9gpH4QzORDGHTScWkiYwqJXVWEMIKvBCkKyc=;
        b=ckd/I1IWlE44HdmJgE8yDfdCZABdxws6Gs8+XyGEEbqXZxVaOsf4uNrvZspGapXyQQ
         HuX1Gu/q/5mHnbQwI2j6CGDnjEzjpyyLinQHmLRG3U7O2z6VnPDWgL/ONDez1H3ainbs
         8XMDqqlZ8scFnvP2PSvGc8Za5ty8PMS0/QClImvDF4taS2VvK/uARz3egPHA1NAIXcLb
         YV9irDHT2wqKl3ogaeJZjJRsLfSckWdYTvJd+xHIXoUGeuT08jUE4I6P/vEoYbXpb3qs
         pR6vTdAzH0aXLfoLbBEcxAhAkqlP67GbZxMnBOuk2uaIqPRZyhJObTG3jN+R2PjsDP9y
         fMDA==
X-Gm-Message-State: AOAM532z0Fx6SgHZ/jdj1Iw0lYGS/eJkzb7K5uYvVsOR327FzoPjueNe
        zQ2Cx2XDYjukzbXXITxyKDPq1BuJ
X-Google-Smtp-Source: ABdhPJwTOh2rhjvGCrOA/uauW1xqhc8MkWy54c8dlod8HBoEWMw25Q2JCHPHEty3EIli/1YMXIr6ag==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr495644wrs.306.1595437681522;
        Wed, 22 Jul 2020 10:08:01 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:01 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v3 1/7] dt-bindings: usb: bdc: Update compatible strings
Date:   Wed, 22 Jul 2020 13:07:40 -0400
Message-Id: <20200722170746.5222-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "brcm,bdc-v0.16" because it was never used on any system.
Add "brcm,bdc-udc-v2" which exists for any STB system with BDC.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/usb/brcm,bdc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/brcm,bdc.txt b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
index 63e63af3bf59..c9f52b97cef1 100644
--- a/Documentation/devicetree/bindings/usb/brcm,bdc.txt
+++ b/Documentation/devicetree/bindings/usb/brcm,bdc.txt
@@ -4,7 +4,7 @@ Broadcom USB Device Controller (BDC)
 Required properties:
 
 - compatible: must be one of:
-                "brcm,bdc-v0.16"
+                "brcm,bdc-udc-v2"
                 "brcm,bdc"
 - reg: the base register address and length
 - interrupts: the interrupt line for this controller
@@ -21,7 +21,7 @@ On Broadcom STB platforms, these properties are required:
 Example:
 
         bdc@f0b02000 {
-                compatible = "brcm,bdc-v0.16";
+                compatible = "brcm,bdc-udc-v2";
                 reg = <0xf0b02000 0xfc4>;
                 interrupts = <0x0 0x60 0x0>;
                 phys = <&usbphy_0 0x0>;
-- 
2.17.1

