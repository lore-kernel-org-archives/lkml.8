Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C1CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9892076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 05:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT3ae4B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgGRFXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 01:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgGRFXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 01:23:04 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D54C0619D2;
        Fri, 17 Jul 2020 22:23:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so13140791wru.6;
        Fri, 17 Jul 2020 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=68XVIKJYC51HwphePdTA9Lwzvvw+s3PKoRyB8S+VPNI=;
        b=cT3ae4B/9OU66h0+rkwDY8k47sIDc5dudndIC/G5UXIUUsAcygze5S3w750uxyVDwS
         +M/5SpQMP9H6WNj0zXtwEb7i8HeRczJfv3WJNjOcVV5zAKV8hj1oPTNY37psbPQ7X86I
         zmlFiDQOg8ICG8V4rM37eB+nIm0nI4IGKKtHlx7hjDntLmYAoo1i+dS6/E+hUMtvLn2u
         gE1SjsK2V1t5bRTptUNZoya0Tb/gdFklNhpYcDAt+ulK1Y51dXitN9jg1f0oaRgG8mm0
         v7BlAiuho/oII5ptg8HDc6MFOadOQoYEWqPu5CwyONYACPTeTCtscIyQawMVpBNxPnbH
         y9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=68XVIKJYC51HwphePdTA9Lwzvvw+s3PKoRyB8S+VPNI=;
        b=EJt+LPoVUrIJjY3o15ilOPDTwGjo6QQFnrnGEZ0Ny+oP3IwHonxMf4v5THk8es5BHs
         p6o0H21hrOtNbE7e3pK5m/m+heluR68urTbzx0J/4WRSJw1R8bPEOhE79H57KeJVidq8
         6+ddNcuhbcU2Kl3+yJy4/x/O69PxrFT45MOtUE58UFQDyHlG0MXvwaMETOsPqZPW/AT2
         1NjexjKDK1xP3D8HfgHjIiOachbjhqXjlnJubcyBSfIzgvqy61t6prbWrBk+H0p/4KCi
         Dla/GWAl8YPNPTZhOXRDHRvnjf80epA8uJ82xOHJ1HXqFGujSNGftd6OpCH/Fum3RO9V
         7xUw==
X-Gm-Message-State: AOAM532m7WoPez86pYd24st1kKXRLDqY38sLSqmIguhMMx/YVwuI793i
        iJOZyfMNmr4DoH4vfkwC30w=
X-Google-Smtp-Source: ABdhPJwFA04O0Vo827+TYXELnidVX5qxVKJEDLQCoYfwdm8pKzam0cDcrr0PdyGYzXfqhn/u8xJ3fg==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr13158030wrp.299.1595049782582;
        Fri, 17 Jul 2020 22:23:02 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id f16sm17536608wmf.17.2020.07.17.22.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 22:23:02 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Beelink GS-King-X
Date:   Sat, 18 Jul 2020 05:22:57 +0000
Message-Id: <20200718052258.2890-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
board with an S922X-H chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 378229fa8310..8711fa57ee25 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -149,6 +149,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
               - hardkernel,odroid-n2
-- 
2.17.1

