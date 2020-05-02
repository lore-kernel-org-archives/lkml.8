Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519DBC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D662137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 11:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LxjJWlYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEBLs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 07:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726793AbgEBLs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 07:48:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F1C061A0C;
        Sat,  2 May 2020 04:48:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so14991389wrx.3;
        Sat, 02 May 2020 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJ04P7TSqYHI0BEsYEPy5ZIV1UfajleYqyakQOSdSE8=;
        b=LxjJWlYBZodSX5E2jkNwT/W4PziNmRdCiio+Z1evlx1zNwhx/yoPrIcoN+ucvrGU0C
         +76kBrRHgROeieclsMy6Weh53cFFIfVQxaL1UDjweptSecxGeMQdTPkCtUWmv38445QZ
         GjNbivCQX2PR+qSifcZOWNVU7Zt0nsXQQ9TW5kvtXijoBYjJvhxxpyJbHdeh/t+V4zBk
         R9tpxCGDRH+eY+rt9G3yD38xmnoocJv9Zg4yLZ7xizk4F2KXoyhCmMsAGlgzqARbwEu8
         te2xwl/bJoHf95zTo2s5rTY1QIZVL/zqfNqe8AJU4MKRsaDzGhkoAKPxDsKyxeijxQgf
         ir7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kJ04P7TSqYHI0BEsYEPy5ZIV1UfajleYqyakQOSdSE8=;
        b=PwgSEMJcB0oZXP4zoUV/Ev+nCTYxn4uFW5o/so4I3DTdFaTuc2e+jkP07y2IDoElIR
         cKX8SiaPjlih0BMgqNcjUnPxKx3UT3S8kevwiBmmTK6x7PMTbirwkgaoJhJsHcO5tKvt
         7jF1XAEoj5U9ctwxz6eNyRtqkONzhQPEeRtIPQGuEVr6GzbLzDIhxANeqmDOXQqtrQ2r
         GPLYmVsML/oab1SDipj5XmtIS0pvUJOJMli5wAR8TuVPsXajowTzhZ+UMN30mcM7xrv3
         v/bJAdjMYrFQpuMkV7V9aFQIOl9YGWUeR08YU119urMRU6yLdjfVnDTpkwjs/qtgrINK
         v4WQ==
X-Gm-Message-State: AGi0Pubhj0BO0/wjR6ZYHkwNrDGD0zrz9Mj+Xt+PCFQWEEuTq4MGYkAO
        ahAosvyjqSDRwZRFtftg/3w=
X-Google-Smtp-Source: APiQypI4ZUBAtewD7nQbJlc7jakXABjmhVSfjjkwsJjCou8f1sz0NzCq6maAGyorKQSE9MIlA+3JPQ==
X-Received: by 2002:a5d:45cf:: with SMTP id b15mr8718208wrs.78.1588420107254;
        Sat, 02 May 2020 04:48:27 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id s17sm3801599wmc.48.2020.05.02.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 04:48:26 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/6] phy: meson8b-usb2: small fixes and improvements
Date:   Sat,  2 May 2020 13:47:46 +0200
Message-Id: <20200502114752.1048500-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a batch of fixes and improvements for the phy-meson8b-usb2
driver:
- convert the existing dt-bindings to json-schema and add a fallback
  compatible string which is already in existing .dtsi files
- differentiate between Meson8 and Meson8m2 using a new compatible
  string for the latter
- simplify the code by using a MMIO regmap
- set / unset the IDDQ and ACA enable bits depending on the operating
  mode (and for the latter also the compatible string)

I suggest that all of these are applied to -next because we will need a
separate .dts patch (which I already have prepared) to use the new
Meson8m2 compatible string in meson8m2.dtsi. Otherwise we will be
changing behavior in patch #4, because meson8m2.dtsi currently inherits
the Meson8 compatible string.
The number of actual Meson8 users is very small (I only know one case),
so keeping Meson8m2 working is more important to me (because I know
several users with boards that have a Meson8m2 SoC).


Martin Blumenstingl (6):
  dt-bindings: phy: meson8b-usb2: Convert to json-schema
  dt-bindings: phy: meson8b-usb2: Add compatible string for Meson8m2
  phy: amlogic: meson8b-usb2: Use a MMIO regmap
  phy: amlogic: meson8b-usb2: Don't set REG_ADP_BC_ACA_ENABLE on Meson8
  phy: amlogic: meson8b-usb2: unset the IDDQ bit during PHY power-on
  phy: amlogic: meson8b-usb2: Add a compatible string for Meson8m2

 .../phy/amlogic,meson8b-usb2-phy.yaml         |  62 ++++++++
 .../bindings/phy/meson8b-usb2-phy.txt         |  28 ----
 drivers/phy/amlogic/Kconfig                   |   3 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c        | 149 ++++++++++++------
 4 files changed, 162 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt

-- 
2.26.2

