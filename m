Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6612082F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riDMOp/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgFPSpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFPSpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:45:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17220C061573;
        Tue, 16 Jun 2020 11:45:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x13so21841256wrv.4;
        Tue, 16 Jun 2020 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FjxCYQYl9EMftF7v9IlEHBGvOY++fyDl8EmryaQNdvY=;
        b=riDMOp/DDEoYdyHybE++8SKdmytMqyA+4bXpnTYugw1SmZOxtpQQIz9p8wITF3uAU4
         /HDw8AtDzN5p6lVJJgA//Tj1o4Yls4NsjivbDU1XUIO85ZihAsaVcnoDcv06izr58HzL
         rEHCI1ZRbeDARdPPTSHN3i/hCdFdg3vcrYdPG7Jfrda40FPvhCOPBZdwAM5uHU3fHyNc
         DymsRwu6xXF6D6YQlNtq+RIB5LAXOL2fy1fy+hhioKyzAdoldxMjDO/ZI25HfSq2vxx6
         yjjRId0cSJ7hrbIYz5zHVGt2PHOxKg2gNR1CfeuMbzOwOP9olmdpc6/5tHI5n/9KlMgz
         K1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FjxCYQYl9EMftF7v9IlEHBGvOY++fyDl8EmryaQNdvY=;
        b=Ne14IxtizWdFM2gkiLbW5PIm6ubuwvIyINTpFhglnwlS/NeHlRnpGNffEfC+t8HHyk
         21crVTjkiZpNZPz9idQe362s9NcmlrZZ2wdyc2BKl0jHjYDTJEsJv5kt9Ja+/He6YiyI
         oyG8PGgseNlHeds6iFobIfeOZOxSGKAoUPSiQYuOXB5Y5t2lToBjQdYyNY7iJtZvjuhV
         ASgzxfp09ogUTtmhDhrhEV2V4Rioz0UgQbqhngBmqADzxu1WPnHc+8I8wGoEnfTUvHy/
         H9havT33PboMaE0RXJTZ11rUuxQitC9CgKz/igEY4I75RQU7kgR8rMS4nH1GYCz0GeoP
         WErA==
X-Gm-Message-State: AOAM532N+pgUHWuyShq5F0SGJlgMUIpy2iW4LwnGtIMRtAwIOB/jpXz1
        I40shYMmVSw6LHR6W6yjt9w=
X-Google-Smtp-Source: ABdhPJyikGcJQsO8D/dTakls4yexXP9cUZt5JVzF8fbB5xzwpnEqpL5O8C3urwUr/MCjuWXWFXrz/w==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr4479019wrr.264.1592333144741;
        Tue, 16 Jun 2020 11:45:44 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id q11sm30528707wrv.67.2020.06.16.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:45:44 -0700 (PDT)
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
Subject: [PATCH v3 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Tue, 16 Jun 2020 20:45:40 +0200
Message-Id: <20200616184542.3504965-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

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

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   |  72 +++
 drivers/phy/broadcom/Kconfig                  |   9 +
 drivers/phy/broadcom/Makefile                 |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 456 ++++++++++++++++++
 4 files changed, 538 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

