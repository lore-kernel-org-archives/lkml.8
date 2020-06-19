Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF045214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr0x9R1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgFSIvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgFSIv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:51:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEAEC06174E;
        Fri, 19 Jun 2020 01:51:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f185so8374924wmf.3;
        Fri, 19 Jun 2020 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNz1wqgYkZ4nhaFJ3Q49yOh75bUAhI2XzNoMFaOBP2c=;
        b=Cr0x9R1l118oYOHpAxQu6yt75qygnLjjnOUJUITYkjjFBLi1PbwPtCovaOCs6CzM/c
         dnLwV9KJCMNRReLuJ1a/Tqmc8K/PzZmq6vm4konGmjHRYp2hapfpofsNl5xH+nQERsN3
         rmSD7Vbd+CIlMAKvYph3fNjDtrXSRE28s5vh9+9mPp/pZJF8GbX9PB7SOAmVssFCUswg
         tqL2XNf+rJaMWlYzETNoby2M2pSJ86Hz5WfNhFhTUFjvjB6vP2cFFY5chJg45h9sfNiw
         Pcq5n9DA1ONWs0HGhSsv1VCZzz/ygrEf+iwJDX3j6YAKkUUrjA8apzwEc5i2hi9hq1E9
         cC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VNz1wqgYkZ4nhaFJ3Q49yOh75bUAhI2XzNoMFaOBP2c=;
        b=kjDRk5IGu7QZYIS2tjubeD/WoXFnbGKdK4uRBinz3nQ3cMET2pgLabJlF9l/NA5wu6
         pEkLTLF6TIMiz2TyEjzKjydel06G/svyx8uhJcZxJBMcpX+I/384xzavlDg6cL9NhdSd
         rEthV2u8V97FRnxRlmPNdJ2KMIquT8RLU18f+RcxQ59tsLNjg8GHfo0ezcEBUgCZB1S3
         ZeGDY1dmgG77o4Hk9qJ19VHKbmMd758sVCwUqhL3JLR7HOy7CmEaFnoWPXo0VwVq+RNX
         B9Ka3xRmIF/5vA8RASelIxMa9ro4nTqn72RNJ6XtWqDWe46BJNSSnDi4pueUqZDAZTr1
         UqvA==
X-Gm-Message-State: AOAM533MhmfwK+TACr9E2X8UbCAdzC0uvHsD+O3paXqXWiBpgTNM/X/n
        xjWcoHJM6bXz/wnQrtJ1GrQ=
X-Google-Smtp-Source: ABdhPJzVGH3ksKTZpYDC7GC36NRN1yR/52R3NNWLxirM/G482gskN7sgucPaMdIlLEWLsnmLotV8gA==
X-Received: by 2002:a1c:7e49:: with SMTP id z70mr2575009wmc.24.1592556687637;
        Fri, 19 Jun 2020 01:51:27 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id l1sm6674331wrb.31.2020.06.19.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:51:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Fri, 19 Jun 2020 10:51:22 +0200
Message-Id: <20200619085124.4029400-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

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

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   |  84 ++++
 drivers/phy/broadcom/Kconfig                  |   9 +
 drivers/phy/broadcom/Makefile                 |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 457 ++++++++++++++++++
 4 files changed, 551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

