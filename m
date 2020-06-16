Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB216C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2120767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="segt4oTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFPIeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFPIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:34:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA6BC05BD43;
        Tue, 16 Jun 2020 01:34:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t18so19817855wru.6;
        Tue, 16 Jun 2020 01:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0zKxkidxBoqL2sZN9RpjSHDtjGRezB4oDkxwd9tphA=;
        b=segt4oTI79JJbhAr8FHGJ02nd8XIH2jNl1ctQmmqmbCY57xbMHYYeJ1VTyx2thu/yb
         D1BKMQe2TPhlKf+qsBIhffhIzHzeKNo4fT3eZWvSMbZQ7ILv9O6zpXOE6r6pkf5X48OA
         WUED4BC9PCK5TgLeCoB9u/6h0oagmFUxPEBi0xVxS4FC2NSKoJya5QSs3mnmQLERe0Yl
         k6jLAuhORZSUIIFf62tfpSH44MlzoYBN1pYrpu77lPjSEbk1ioFlMbLtAoA9RrKLlHQZ
         LDcZTosAr/WApdySQGzkhA86ZXKdTRAEEI8OvXX4xHvbsXKrnUHnjvkm8ao8uev6LBst
         NDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0zKxkidxBoqL2sZN9RpjSHDtjGRezB4oDkxwd9tphA=;
        b=skfA/wDSUzHmZCGUDTJipXRHFBFXRbB9MZn89P90iuD5qWxCORt/cpE7sniECGKlzg
         lyDu6ka2bglyuoBSMFdt6/jCg0Z06djRAHmB4sfCYrTT322LCF+p+ioo3Wfai83jYERe
         bKTs+z3oF/C46Vyu7Q+uZ0Ogd7zPHbFnlhiFl3xEymKFg18RKo5hpiv6D9RTcK5uRWA4
         6tF5V7aJi85GgcN2OJ8gEk7bnjfNZ0VCVA01uv6Aw2TDlKB90PrSSKxm4K9KyM97k6Sk
         /WlUTETVo5saVXHNgln9cuOBn3bg1PLf1nY8d9tYQr2ElYf16FPg6R3Bfzw/O2uQ7fwE
         /8sA==
X-Gm-Message-State: AOAM533aGGz3gwj5XbysupR8NZIbtTK2BnAM9LmpYTGvEC4+MJyr52kf
        0s374omW0abDWYoTNIlPyws=
X-Google-Smtp-Source: ABdhPJxma8oeQOxUjCipeLcrjPMgDEuXEOpadeijHFyc8cHTTOv27MxqDi0+luB6twXRql/BToxDkg==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr1735468wrs.87.1592296450429;
        Tue, 16 Jun 2020 01:34:10 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id s18sm34318981wra.85.2020.06.16.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:34:09 -0700 (PDT)
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
Subject: [PATCH 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Tue, 16 Jun 2020 10:34:06 +0200
Message-Id: <20200616083408.3426435-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

Álvaro Fernández Rojas (2):
  dt-bindings: phy: add bcm63xx-usbh bindings
  phy: bcm63xx-usbh: Add BCM63xx USBH driver

 .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   |  72 +++
 drivers/phy/broadcom/Kconfig                  |  10 +
 drivers/phy/broadcom/Makefile                 |   1 +
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 463 ++++++++++++++++++
 4 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

