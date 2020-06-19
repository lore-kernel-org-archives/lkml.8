Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE93F20739
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjdV8onD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbgFSKAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgFSKAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:00:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B41C06174E;
        Fri, 19 Jun 2020 03:00:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so9048173wrm.13;
        Fri, 19 Jun 2020 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZXWIhi2JKTWw6Cc/lNPfLOjvy62Sib67v3SwJdAy9E=;
        b=TjdV8onDBzT2Fd5JUETTWnxdRXMWvNSPi67LA6nIqFPpqNiJvobLr0ALm9aRibwrHX
         YaTjaIZZ6p5StfugYuDi63G88gDDBSKRz/PlrRIts6IaGq88ODld47jQFXkvAJ+0Kcn0
         bQSWZ5vQhGfCLFlKWYnkIJyvKoAwFvfRslVJzIjTzw9FISHJxymMTd86EETalUOUTAzw
         NRfAMrOSBxynfNkfPIGplyFLrm6QiI87tnbVq34bVCbZtgEn5Y8P27BWCgKksyPagdLX
         8BNRO0PRaNITkYUMIFTh/w12Wvit+Nmlk/xE2zeYqqf/JIhBvPNUfrww9nnPCKOycdpi
         70mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZXWIhi2JKTWw6Cc/lNPfLOjvy62Sib67v3SwJdAy9E=;
        b=DxbS4B4Ofa3vhzUhMLFZBilJM0JtRoNJ2Cx6RiEuwK2kT7WtAA+UhZkE1rd3weIaM/
         N5FyhF09g+t++dT0hfQ83WlYieZLTwleK0hY2Zke9HWZpilelv0O7G57StO/QpX0LQWl
         zq5rFQEd4gE+PSeyXt/xeT2HwGd2ga8lVI0016MWepjyTh/rhoLxpfcOw8FGxkAZOWiq
         xsXUG/iqY5oJ/SwRWQYf23vkXiWfKwb1++pujaJ9IQ7jEh00hiViyEFBsefbQTPwDgmL
         ayW+uqGLVL4EBGp/TSc0WBSq+XC+DzLwsvd+CpZMEEyuz7zPg5JaGBxic0ubWuNW5t8g
         QFbQ==
X-Gm-Message-State: AOAM532+TQLeZYZuVttHa7Y+H1/5M6BuQNWnfmcgqXpNQI6pw/oSnsju
        3AaeXbAbbHCLMjbm1xXgGjA=
X-Google-Smtp-Source: ABdhPJws5B4LSw3cMCL6rCQZt8DnliiIlRTYO2H/69HpgityD4xdHMWr1VCyqIzCIzn25aAs1eDWhw==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr3421592wrq.175.1592560838362;
        Fri, 19 Jun 2020 03:00:38 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id v6sm7164961wrf.61.2020.06.19.03.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 03:00:37 -0700 (PDT)
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
Subject: [PATCH v5 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Fri, 19 Jun 2020 12:00:33 +0200
Message-Id: <20200619100035.4032596-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

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

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   |  84 ++++
 drivers/phy/broadcom/Kconfig                  |   9 +
 drivers/phy/broadcom/Makefile                 |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 457 ++++++++++++++++++
 4 files changed, 551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

