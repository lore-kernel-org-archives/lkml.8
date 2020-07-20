Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185EBC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E892520729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh/wpx6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGTNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgGTNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:12:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228C1C061794;
        Mon, 20 Jul 2020 06:12:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so17770660wrp.7;
        Mon, 20 Jul 2020 06:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I74xvJtzsjaudxa1pxR363b/RUGO1Y/C083f203Hn7A=;
        b=Mh/wpx6se2TY3xjfuT4WtX01b4++wFyyvqYyF5kKVHeRaqzaZcp1UF4lbZGxMPjE5Z
         c7B4tfEtirkSpO22dByuNkIFDkkhmaT4evS6BrE6jltrjTDdva3p256bmEXRF9B3/Jsf
         qREOo8z6eJDoMVdQfShivC+YISM78l8jiFZnQJ70p2J6FlCBgTv3y404DYyZS5uVx6Av
         /bXgNO83O8w1hbqrkjQhoPz6DDH27d8tjgC2Gu3xHMqEVhfjDlObJwTLBDpgXynJMqFE
         ty9Sb0KXjH/TLOUAzW4jGQgikuR6volcQ53gYsb69BbF7CsTnXqIxPXsacGAERh1j0xz
         V6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I74xvJtzsjaudxa1pxR363b/RUGO1Y/C083f203Hn7A=;
        b=XT33Pz/TO+9fFvYOGVRqlizK7bQuZk3ggL4xOiW0a09WAX/tQaedTGyihyMmZebsfU
         7JI04zDPiobwyJ9o2rRb0oHNO7SVg2LHhmcbZcA0LPEFlSrimfTRB2hE8Ox3/03YG6qY
         VLgbQ41Zulh2VKlN0iNBeVpm2P5QGXXXRV5SzL6EzK8ZnsRaRxnIwhs+vbtNdrII975c
         M1nSdi3mJ3zpllD1hSptf6J3SmBtnunUMJeM2oHCfbq3Eo9Um1HAVuGR8kuEriKV9C7O
         JzCLOLHiRTwIpRNw7uNbBr5k5RxsaqLpVWs/aDAL3OY7MlKOVytmxjKTBmKJAKNAKHgo
         6isg==
X-Gm-Message-State: AOAM533PaP5FzLdMIYx+h+m6xcpo8nsSQI0l7tB0EFdSg7Mlz44UMNiX
        HTI2TM+2g/2fUrnRQvAgMJA=
X-Google-Smtp-Source: ABdhPJw9OqceBedFy/lUsoQxaiIvRQLMWn8OErAt8tUirgIKJSf/VYRP2xcZNP10zxf5lKN91cSXbw==
X-Received: by 2002:adf:f542:: with SMTP id j2mr22255065wrp.61.1595250736743;
        Mon, 20 Jul 2020 06:12:16 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id j24sm2725293wrb.49.2020.07.20.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:12:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v8 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Mon, 20 Jul 2020 15:12:07 +0200
Message-Id: <20200720131209.1236590-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

v8: readd Simon as author and remove his email address from the source code.
v7: remove Simon from authors and introduce changes suggested by Rob:
  - Move clock conditions to the main section.
  - Set missing additionalProperties to false.
v6: introduce changes suggested by Rob and Vinod:
 - Remove BMIPS_GENERIC default from kconfig.
 - Print registered message as debug.
 - Add another if case to device tree binding for SoCs with just 1 clock.
 - Ignored "additionalProperties: false" suggestion since it triggers a
  warning. This has been reported, but I haven't received any answer yet.
v5: use devm_reset_control_get_exclusive.
v4: fix dt-bindings documentation and improve device mode config.
v3: introduce changes suggested by Florian:
 - Add support for device mode.
v2: introduce changes suggested by Florian:
 - phy-cells changed to 1.
 - Drop OF dependency (use device_get_match_data).
 - Drop __initconst from variant tables.
 - Use devm_clk_get_optional.

Álvaro Fernández Rojas (2):
  dt-bindings: phy: add bcm63xx-usbh bindings
  phy: bcm63xx-usbh: Add BCM63xx USBH driver

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   |  79 +++
 drivers/phy/broadcom/Kconfig                  |   8 +
 drivers/phy/broadcom/Makefile                 |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 457 ++++++++++++++++++
 4 files changed, 545 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

