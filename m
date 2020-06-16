Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F470C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFE9208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmwst1uD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgFPSSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFPSSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:18:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB682C061573;
        Tue, 16 Jun 2020 11:18:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b82so3780289wmb.1;
        Tue, 16 Jun 2020 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LmTayBVPTW7ENh+5gUw2mLnloWnahd4HWesLcexzGo=;
        b=Wmwst1uDZnj0G6rQmKnFIjglBbaV6IRWpaOCshlQeIyVPGyNS+85y9fL1KeHsx1hkq
         fu15VLouNuSqAe7iT9xuFobBH1oDZ4mEcyBXIndvBEGLJWMl1MRBGqLfR0pDPSAYnpxw
         cx5MYkkemqqLDTt2YahSQBJ5rxHFXsYndFSm+Qb8a9xJWN7n1h1fMIiRU45znDWdvmew
         7qqP2yt9GGQWQkF3yTa5HS51mWUswxTPo15K6XR/PEzvKc6Fop+D5FlMe0Y2dcMAgO4V
         fkmTGDSkKv4+zfFKtNthqFRMMA0MCft8n1qWWiDjwdwzxfaej0hinRHd12GkahbadXDy
         QIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LmTayBVPTW7ENh+5gUw2mLnloWnahd4HWesLcexzGo=;
        b=LhRYrKLeNmtpzN7Glzx1DkZm5898OPmmZrj+Ih8Z/Ld6i7ArEKirDZCt1z7BA59Oin
         6KKdpqQT1Fe1XdSnURzQZmhd+H4hxfXr+O7JzzaDNoUwLUQLkc7RW99xnIbjPlA98ith
         /il7h83zJWHS5EmkRPRmalccMxoKMC2bcdJ7JAektPTnQ//qFLNgwDyjB6t7gSQl7UwR
         j+/iMbbS8v9DPDVpqUv2T/pr+iNoHA8CXLrQngHWVs9uhwOuXCsEh/on4FS8INTsW7W3
         fzmlz/UQu+jqKcMf/IVEYpvtEBfK1RWoYxS2lzlYLxC84Fj3DL1K0arYeUuxmiDyxTM6
         XVPA==
X-Gm-Message-State: AOAM531CovtekS5qA8Ztb7oUWEsVsnUDTQxPuWP/lFxkisWmXI0drMwQ
        nRJz5BcBpAADiSEs5asuvgE=
X-Google-Smtp-Source: ABdhPJxfsQl4YYQbvO8WxxGctX/5GUoJol6KmDxSRoCYT5kgEI/5RSxDBWDb7Yt4qlMFh96CYZMyNA==
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr4690151wmg.85.1592331485223;
        Tue, 16 Jun 2020 11:18:05 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id u3sm28651091wrw.89.2020.06.16.11.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:18:04 -0700 (PDT)
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
Subject: [PATCH v2 0/2] phy: bcm63xx-usbh: Add BCM63xx USBH driver
Date:   Tue, 16 Jun 2020 20:18:00 +0200
Message-Id: <20200616181802.3498745-1-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM63xx USBH PHY driver for BMIPS.

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
 drivers/phy/broadcom/phy-bcm63xx-usbh.c       | 433 ++++++++++++++++++
 4 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
 create mode 100644 drivers/phy/broadcom/phy-bcm63xx-usbh.c

-- 
2.27.0

