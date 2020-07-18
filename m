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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48787C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2391520759
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTjGxonL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGRJoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgGRJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:44:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BDAC0619D2;
        Sat, 18 Jul 2020 02:44:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c80so17975094wme.0;
        Sat, 18 Jul 2020 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EfRpQHmTESiZa6dhnw2iqpiFLGjitNFlRILsGoZarsc=;
        b=GTjGxonLjkWGrMuLbbJvKhXcTeSeWvXJqUELgSwAm3OIwyFFfCMC/UyPFzebhhnUn0
         IboBUh0Rqf1XqDDnCLZtrj6lxn1veK0X5ks95qXwH2KjgmlGoJoSwqbgITA5+a636cma
         v3GO6xYfcbgr5cMdh9/vtDtgNj2nchoao28sNBLkhjh9KxoiH4qkW8Dc+KrWngqyjbge
         j76qKpZdBtcQyVGZCrpDuUDZkt4/kr3Lx8b0Bg+coweAUOao7E8q1F6EnytYK1A+7SjN
         XZdgEAu0+rUElcQeGli2ySDP6BHm1Ifoi8IbVBUlGmyxp1or5pCVjb62xIKftAncg0hA
         EcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EfRpQHmTESiZa6dhnw2iqpiFLGjitNFlRILsGoZarsc=;
        b=OyXTEEmm17dDsKFTJfwO7TzvC2w1H0MlzGkMaUU/5zDzqukPJ970UOgESHk4LqKoAB
         cxBk0nEFlTQayOUNx13rVQ/2lHm0kcvFu042zoKftgWl/y8LvDR0cpSQjVTHPNehFeJO
         HcQ7jtwh5uDK7xT/Ewar5PEJAljGnzAdFhPbBQBjNvEPJP/vwhdpDlZMdnd0tDpamajT
         k9+Dg4PgRg4b5E9KEr3ZSGhCWiQJd8b9VaKu1x4y0+Rp4vKFNcsdKs5tQgP6KeBigjUU
         L9vWhnaIEcm+noe+XUoNxD0Gm3wlr4pke045+vJ3SP7TXCBnqyaY/vmhUWNsmhiTU6to
         Nc1Q==
X-Gm-Message-State: AOAM5339gEAyoHVMxRzvgmN8w3VkyaAV3XAb+c92A/Hd2XhXzlcihL5Q
        lnfpTXpEnrDkh+y942xTeHQ=
X-Google-Smtp-Source: ABdhPJxGFHDqfM/xtoygZRnkiL6JT1wqGkfnbCWi4IOx7FgEddgf0xEIgvpiJ7+QBPUxTJI4o4DxhA==
X-Received: by 2002:a05:600c:313:: with SMTP id q19mr13662362wmd.9.1595065445206;
        Sat, 18 Jul 2020 02:44:05 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id v11sm16764554wmb.3.2020.07.18.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:44:04 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for the WeTek Core 2
Date:   Sat, 18 Jul 2020 09:43:59 +0000
Message-Id: <20200718094400.1185-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WeTek Core 2 is a commercial Android device based on the Amlogic Q200
reference design using the S912-H chipset. Specs:

3GB DDR3 RAM
32GB eMMC storage
10/100 Ethernet using Realtek RTL8152 (internal USB)
802.11 a/b/g/n/ac + BT 4.1 sdio wireless module (AP6356S)
2x single colour LEDs to indicate power
1x power button
1x reset button on the underside of the box
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
2x USB 2.0 ports
1x USB OTG port (internal)
1x micro SD card slot
UART pins (internal)
IR Sensor

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 378229fa8310..5eba9f48823e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -121,6 +121,7 @@ properties:
               - libretech,aml-s912-pc
               - nexbox,a1
               - tronsmart,vega-s96
+              - wetek,core2
           - const: amlogic,s912
           - const: amlogic,meson-gxm
 
-- 
2.17.1

