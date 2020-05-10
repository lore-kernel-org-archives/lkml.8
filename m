Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F233C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F30D208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdRmvjap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEJMln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEJMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:41:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC563C061A0C;
        Sun, 10 May 2020 05:41:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b26so5095054lfa.5;
        Sun, 10 May 2020 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BSj9Ea7QdyKMkOvyobV8j2yH2DQNcdVYE7WHmzdD778=;
        b=cdRmvjap2+BTgGU7Sj187JE3I7MmS1QJSnLN1+JfzYQ3IVhSpej/hlNFcmPSIT6se/
         lo7XaR5cMPHY+NkGNNffiu/E2zK3EeeRU04uXDMK24CXr6sFpFZ084ivo8WMnsd3UrW2
         RcqUvVvQGbaRcgMvZraKapkkNd1wYCZGIDP8jE2ZBl2wr+WWCA7N8Y84HAkFBFbZ2cyN
         gkUjSPABClSWcq1xd0KPWM1aekC2cIK9wSMJIZ42V5e5OooU8lK+bKeStwT0Xqf928MT
         C2Y+JB/XigsDCbMnVndJwW6DGoqEqKSw8gfEgoC4Ib7HgvXeAY7kugbe7Q+Tcm2fiFfL
         i35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BSj9Ea7QdyKMkOvyobV8j2yH2DQNcdVYE7WHmzdD778=;
        b=URnJ2aneqnFodSMsE8pV+NF8Ee3mrepMUJ9PDM6uzjlHjTMWcvYXnsVYBURgAZoNeu
         MK53yoZ0F/UPvgdKbo1qt5kRAwxf7len+o51swJC2jwXvH+QhiyIzxTV4b/KtRN3lj73
         0Y6TGs0DPVKRblqBOEQimHBRVTX2e6k8C6u+JKpT/eyzC1dxfBiftdmfMLR6dcgy3JFm
         mCI/F1UDG1lkdv5wqovCzE5xJwWptJhTZ89iihQ8xL7gH8eTGBjd809cNnUtQruBfZwr
         d+maFhjeleMCfHTC/5ck9crudbpBkoUiar9ysJC6goidHaAa4dDe+x93fE0QsGVZ1P3/
         JgBw==
X-Gm-Message-State: AOAM532psKitzQ0tzM1pv88/S/yCo++tIIoSlR9/YlzQdWr/wpR6DJ9S
        IpxlMMrNw/oeS03nL/x0jHQ=
X-Google-Smtp-Source: ABdhPJzEgzJo/0DS9T6pFms2DFabK7ZYHD5s9Pv14F3Jay1UFPkwzzBqziTn/VF5sxroDedY+6jH4Q==
X-Received: by 2002:a19:2389:: with SMTP id j131mr8016624lfj.116.1589114500273;
        Sun, 10 May 2020 05:41:40 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m11sm7136611lfo.55.2020.05.10.05.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:41:39 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v8 2/3] dt-bindings: arm: amlogic: add support for the Smartlabs SML-5442TW
Date:   Sun, 10 May 2020 12:41:28 +0000
Message-Id: <20200510124129.31575-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510124129.31575-1-christianshewitt@gmail.com>
References: <20200510124129.31575-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-T/T2 based on the
Amlogic P231 reference design using the S905D chipset. Specs:

2GB DDR3 RAM
8GB eMMC storage
10/100 Base-T Ethernet
802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
2x single colour and 1x dual colour LEDs on the front panel
1x reset button on the front panel
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
Single DVB-T/T2 tuner (AVL6762/MxL608)
2x USB 2.0 ports
1x micro SD card slot
UART pins (internal)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba48cec1..c0c0f6619fb3 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -107,6 +107,7 @@ properties:
               - amlogic,p231
               - libretech,aml-s905d-pc
               - phicomm,n1
+              - smartlabs,sml5442tw
           - const: amlogic,s905d
           - const: amlogic,meson-gxl
 
-- 
2.17.1

