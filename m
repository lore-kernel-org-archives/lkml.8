Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E2C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0E720714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spJqdw66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgGUOnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:43:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C30C061794;
        Tue, 21 Jul 2020 07:43:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so21460924wru.6;
        Tue, 21 Jul 2020 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pV3mDsRWw05RxHtxCCVWe4M4nYTBOLl+uENBN/cmeeQ=;
        b=spJqdw66s1wknB0735bCSDqINJ9d7+XbTtNCHNYVDElaVLC3izBRx6cw7jLtVvbMXC
         N9DusxpxguqczEHelydAQDOqOFDhdNXsFs0cEA7oWy5Hx7UsqS+CCMs9sSSW0b8mOaS9
         H0jrnqImeXCIK+dxy2nhYe5og77Ihb/tQ0cVVk2ElPeH0G/eBjkkomYm0YeIuCGYWiA5
         /ivCMR0Rf6vk5Hg4M6OuLaQJs/4Gs/xPKAHCzPe/sm4TZziwILIYAmDeIUz0hn6xiy//
         cOgxcBZbLzH+crw9cwCl3P2+r2EsKRIodkR/kxu5x8r4FFl8mIjAxSk1BNa9bvKtqDny
         QQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pV3mDsRWw05RxHtxCCVWe4M4nYTBOLl+uENBN/cmeeQ=;
        b=n1H3rmaZv1XxbAQa9ijKBeWWrzTOJ+BTSNUP9AWXJ0n7yZiRADZEvYHzjjKD6ycnNn
         ilEB0jd/w4wJ5j9Pj7PVclBNQMsP4BHXAQ0k7sA05qmXThgjKi8Vdu3LLgisgRCZIJwf
         ZTMKIHMkpJ+JRJGHviXN41G2LZ+jlieh9iPdBEgF+pcpmSX8ZaLWuqTvp0oXjNj8dpbp
         ohZY3oyvePGgSnhfoPU8KOBCaIUVrNPUg8/cXvodYmic3QbzBG7Bko6ZnUEKf/Tjyv/5
         +PTG2OipdXCgIfj4ygDWqXh2v+Otp5Bu8EPj7wzKltnEQrj+0QTYl4I1qbGK1z0vqoSC
         RYPQ==
X-Gm-Message-State: AOAM531mLNHr+uKNygfJVcGH8SjZO3sDqBNNOJF1m4hX1hUCDC2J5bWw
        aGgNfGlG41dccpOgDhIGmUja2Xt2
X-Google-Smtp-Source: ABdhPJztIjYkIKu/TbY1HTnVuqchz4xJgC5V4VUOHIPmEU5nOBQW0HoOL1ZGYCtZg7g7efbJfjmCrQ==
X-Received: by 2002:adf:b7c2:: with SMTP id t2mr2952173wre.282.1595342629565;
        Tue, 21 Jul 2020 07:43:49 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:43:49 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sasi Kumar <sasi.kumar@broadcom.com>
Subject: [PATCH v2 1/7] dt-bindings: usb: bdc: Update compatible strings
Date:   Tue, 21 Jul 2020 10:43:20 -0400
Message-Id: <20200721144326.7976-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "brcm,bdc-v0.16" because it was never used on any system.
Add "brcm,bdc-udc-v2" which exists for any STB system with BDC.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
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

