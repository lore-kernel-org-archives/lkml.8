Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF4EC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEC723126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hQvwoJ0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgELWYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730394AbgELWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32448C061A0C;
        Tue, 12 May 2020 15:24:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d207so7446534wmd.0;
        Tue, 12 May 2020 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3JYtCC160grnwE6BvzFFT35Znva2JhGH/nT4YDuTlc=;
        b=hQvwoJ0sGtbGXc/vgE08RpNq8NhCXWwbCYEAw4DdaOMFvlvGwQq1geEbh1X7M2eTKy
         4oLUxSPSkXscP0Nxs0cx6IHK96imv/vwnucMyZkl40CO2vwhNxJnGqKoWdDrRwA1BcNx
         Ph1tljbnb1NEEvAeZ2zUnVD82u8fPfkLAeJ3lwcYcMMbwanqulK84LMjywJ8tJT/imK0
         dBhNP0wAfOBoqyVxhD1UaUMw903d69lo86FVDvEJCY/wkstJVDCV8NIRV6jujIVcxZ13
         E37RwPQVbRymP/7cf/p8pBdoWlxVI6Fwh5bp3YgaVXbUPaM+kgnJHH+CjMVA41qYFAgw
         qI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3JYtCC160grnwE6BvzFFT35Znva2JhGH/nT4YDuTlc=;
        b=Z6Zf78bRzzSLf4NiFREaobbQZzYX12wYpsGUirAmqxj5C56gMbY+w8rEQepH7+q7ln
         ZqTK/n8pYiD7R9JiiHR37VaQnv4e8JrowGabZZF4NrmAuzTk8Ua8kp7YR0nVYGUjDmU4
         7GFh3F8zfF822mD1y3DU3nrlH8N/gMUAuk3YE2f+uFieHq9FZwnPom8vlzE2ixt5F2lh
         CUWhksnlDz8x2SxX0Vq+EbgCTpyTYNFTs9lWZ9C8tbK4VsEQ6DucvQoRT0ZvI0XMEXDj
         ra5ub0rfUStD0Y3+Y8bxr1I1CzppwPDfgpBTRylIC1uzuwXIeqYXuKkGhSdnsZE2/7oq
         4lnQ==
X-Gm-Message-State: AGi0PuYW0hjxLdOnqCRaniPBzrKaF1M42+tmI0SAJfBZPIctQItTpBTJ
        eKwMM19OaHFcfGwi+knIm/k=
X-Google-Smtp-Source: APiQypJMD560C6FToyg3qo2nTuZXPqWd03WMPLbFvRw4fTasGxutlwQXHPM1M2jgjkLV9Nm9/AXE3g==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr38545472wme.71.1589322273850;
        Tue, 12 May 2020 15:24:33 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b2sm21758758wrm.30.2020.05.12.15.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     kishon@ti.com, robh+dt@kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hexdump0815@googlemail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/6] phy: meson8b-usb2: small fixes and improvements
Date:   Wed, 13 May 2020 00:24:18 +0200
Message-Id: <20200512222424.549351-1-martin.blumenstingl@googlemail.com>
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


Changes since v1 at [0]:
- added Thomas' Tested-bys (thank you!)
- also switched to the correct email address of Thomas for Reported-by
  in patch #4
- added two more spaces for the indentation of the compatible "enum",
  fixed the indentation (was three instead of two spaces) of the
  phy-supply property and added additionalProperties: false. All
  spotted in patch #1 by Rob - thank you!
- added Rob's Acked-by to patch #2 (thank you!), after fixing up the
  indentation to also use four spaces (same as in patch #1)


[0] https://patchwork.kernel.org/cover/11523811/


Martin Blumenstingl (6):
  dt-bindings: phy: meson8b-usb2: Convert to json-schema
  dt-bindings: phy: meson8b-usb2: Add compatible string for Meson8m2
  phy: amlogic: meson8b-usb2: Use a MMIO regmap
  phy: amlogic: meson8b-usb2: Don't set REG_ADP_BC_ACA_ENABLE on Meson8
  phy: amlogic: meson8b-usb2: unset the IDDQ bit during PHY power-on
  phy: amlogic: meson8b-usb2: Add a compatible string for Meson8m2

 .../phy/amlogic,meson8b-usb2-phy.yaml         |  64 ++++++++
 .../bindings/phy/meson8b-usb2-phy.txt         |  28 ----
 drivers/phy/amlogic/Kconfig                   |   3 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c        | 149 ++++++++++++------
 4 files changed, 164 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt

-- 
2.26.2

