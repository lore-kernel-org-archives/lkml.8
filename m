Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34E6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0AD2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsLG0NJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGQJsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:48:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42401C061755;
        Fri, 17 Jul 2020 02:48:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c80so14018370wme.0;
        Fri, 17 Jul 2020 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xn11Kx8rcXbua8tBPeg0EbruiOtJJ32641w0VdDMghY=;
        b=RsLG0NJGz/I31ysE3f6DiUHUN38gC3eNLTLDPUYseWTDXzxJo1LgV2FcxJGPoUuTYJ
         2l4wzJBqHMqbJ2AECZ3cxEzUK2PuuRSVtxz/utSxJqOqiZS6baHHL4cftEImAPRuPxHc
         m5+6HEC0msxEHnMUtazfHQxXQ+/IfpX8lY52oBq/0QSU80xR9FNXyKflMjOLtMEWkngx
         DqqNzb8saaRCC1tLPXNsKTLmeD6euesQC9c/yoAZ7wkBn+HXghUOWwWvrB842kfT7Gn9
         bYBWZY+OaLIs8MMMGGbAwT0iatTpbTDvqDbx3zwsHSQ0cvuxA5ZKnlUu9SWceGo9MyNN
         XXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xn11Kx8rcXbua8tBPeg0EbruiOtJJ32641w0VdDMghY=;
        b=RjCrMR0rEnhlfVBFxgqXRO108KWH/xBRleLMPMWzEFnQsP6r6Ya847lIm2u4IqQfCA
         XfaGGUuNTgA8rhsTKDr/5Nk5qAEhGiaqIriTRbwpAYEB20d3iD4/807eOND6b13n4fo9
         ukrgp/RoI8rYsvmW6o/ibkRn838+cmrvqS0PWDo4cAvYVNoON63+hyoreLI6fMsLIm1F
         ZLivQrTXyUJPu7laDVlFQyJung9A4BDA3OPuQsAuleh+qLPujy7CacRzfgBWbFHiTKvZ
         b0mBT78qwG75qsxJCP5EX9P101wXaeBqNdmQ/43DGTSKU4L2+bFa0tDbCGxMGEBbNnZq
         +S4Q==
X-Gm-Message-State: AOAM532+dAcZovDA+a/CpKC6MKOFF8jU1KBJ5vdlxXRjfgH1GwTSVqAX
        1xoX75awZfQCAWTv58iIeO4=
X-Google-Smtp-Source: ABdhPJxElqxFFsYZPzofrHZfih3wVkFJgyHnVSX+J5kaaY0kNJ6by1zWcWIqvwyBlFSJsFSPPsLbiw==
X-Received: by 2002:a1c:5986:: with SMTP id n128mr8082523wmb.112.1594979286849;
        Fri, 17 Jul 2020 02:48:06 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id u84sm12816587wmg.7.2020.07.17.02.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:48:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     simon@octiron.net, simon@arlott.org, jonas.gorski@gmail.com,
        kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        p.zabel@pengutronix.de, krzk@kernel.org,
        gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v7 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Fri, 17 Jul 2020 11:47:54 +0200
Message-Id: <20200717094756.9951-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

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
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 456 ++++++++++++++++++
 4 files changed, 544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

