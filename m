Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2ADC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE9320658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptbeYJ8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgGONSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbgGONSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:18:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4D7C061755;
        Wed, 15 Jul 2020 06:18:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so2680770wrw.5;
        Wed, 15 Jul 2020 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+sFqN9sN9u8KSbVLbHvrEOC/vigJwrwrBwNSxJrlGE=;
        b=ptbeYJ8b8Itx2JPr+Vi2ehiYl7BtnUh75cmsCXhRvBG13rjFc7fcmw9mv4MZWRBi0L
         APKBBVvwWQ8bYU47iMvmN7f3QcvVjInQnneAl0Bc89NEbpZKc8ZN6AhuYkx6W2H70w+h
         JwWaxsoG8IuIYot9M0s/Zyt5kBK22ZSyobYSALle3g6tBX0KL6rYjwUevAbZtN6cuxH+
         g3XeeLRGk/4J3qSOS4w8RtcFawtWTQIbQvNTuqI66fCfG/0lQ3h83hA+4Q3Tbm0/3p9H
         DKDhF4wGKh8GSa1YDqSc8zgcMRfhXJzeZEeFwkMUUkEumRAaNYJgKLl11xW1EFs4LAQR
         zvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D+sFqN9sN9u8KSbVLbHvrEOC/vigJwrwrBwNSxJrlGE=;
        b=DQXvAXsHGWkvzhQrm5u9Wb1CcsNFDGpXL6/X3089FH8Imz7iV/PUtqJOXmY5EcOQva
         J2Gwo4/c3H3WH8eqGIuggYvJqCOeYdzWogll0TjH37AZoPMR2cWa7/uUs+Lp8Y2Nuf1J
         iDf+CmQgTGau4ltJSdqO5SXpb1KSQ/cB4QPJXhDZQFY/NLTLXX7g5cvokd8dkFTq4bLl
         A+h+sputP/oIJ+eLzxe+JzdmQMDnXQf6jUPVvQTW+Icj/tdNrOxGM2uC08/tUVSlIdos
         Aa0cDPIPR3SHJACDNNzswJ+WfUqB10C3wyr2JG9vAq4O/GnogT74Qm1+4qUcoFKWGwXY
         0JUA==
X-Gm-Message-State: AOAM530D8CmQlDJhkh6QDA3lwD5S8bzLmjp8kZ4tw5Z52O9i8uND+jiJ
        13ukikxL7iNA6J3cy0Hyu8E=
X-Google-Smtp-Source: ABdhPJzm7nUNRhmtfRaBAIP8Zh/cAWGq6eZAIWwgs/FpxfZ3NMqDsmX4SM8uOLiElEWuxE2eld+t3A==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr10996043wrt.119.1594819086573;
        Wed, 15 Jul 2020 06:18:06 -0700 (PDT)
Received: from skynet.lan (67.red-88-15-120.dynamicip.rima-tde.net. [88.15.120.67])
        by smtp.gmail.com with ESMTPSA id j145sm3623650wmj.7.2020.07.15.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:18:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     simon@arlott.org, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v6 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Wed, 15 Jul 2020 15:18:01 +0200
Message-Id: <20200715131803.1762064-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   |  97 ++++
 drivers/phy/broadcom/Kconfig                  |   8 +
 drivers/phy/broadcom/Makefile                 |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 457 ++++++++++++++++++
 4 files changed, 563 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

