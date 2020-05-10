Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCE6C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A341208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoPU/c2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgEJMlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgEJMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:41:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FBC061A0C;
        Sun, 10 May 2020 05:41:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 188so5077860lfa.10;
        Sun, 10 May 2020 05:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0AyjPmU7cn4BL2KfMfomHiNoXCghCD471CVQpZJ9/fA=;
        b=VoPU/c2qR6kaasYGmq75epVPaJ7EX1CNYybYsdh1EZdTegUmWKOsLBAQKv7hp6p7aU
         ulB/CtLmA4KHX72RDM+ppAU1bq9rQr9aqgmhYCavrPhj3B0nrQ0t0HLkW+a0aKTdqmWd
         Ot9Os80PYnd6NTDwshKerDa9nsLLwr9P+eyTda6LWBOXCqLkd6txcB8VjCgiJGm5h2V2
         IbgTmoNcN1B78SzcOKwSUaeCe6ue9Ly/NBeqD0nrKgHG8mnBQm7ZhJZ6oS/SbY2D0XX4
         /7AxTN6barEYBGFroWlHEEndwZrCbn1udU55wkNcInSwI3UlOkFym/99parkpzIqmchB
         exgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0AyjPmU7cn4BL2KfMfomHiNoXCghCD471CVQpZJ9/fA=;
        b=VNV3ZtUO9PjfDb5CfxC14nwalb+5dK+s6Q7AdxMhfibFFlnTcBI5pZ3BUvccvDumyo
         vhEdTPT2Lda/BN8qE6ozoqaTQaIGmCaNgqjot5n1RRfNe70Rgm/mMaGcDcHEwBYuVHbI
         L7Swq1DZBNzlJI8PSHh8bH52MMPdBrMDbVn/iB9eBY3u8FCSYh4wKA4ytFPVJWMjmaTz
         smxZCwm1wawC8yii2VB00UszFYCdSF5qBM5PVNzLCxLXBx2gp3xaLVKKJ0lKN6s5cErY
         UzVEk+XWHG31J0izpfLOkxlvc1nBnQrQzjGsQbdLYUiWltUdOX/LOqw/zTMOaw1CZaVN
         7wOA==
X-Gm-Message-State: AOAM530XNE964dj33W6PCwrAxI4xRFi6v0uffXRGLpxZ/5Vyw2ofS9rB
        VrrdcVOOQOhFmtX82AwyEig=
X-Google-Smtp-Source: ABdhPJxmyYroaExtRfpqTEZIzCVhUi16AUhZ0f52+ranCiNyS1GYl1IwuOIihO9UzZuRtWlWB9vIiQ==
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr7748654lfo.104.1589114494913;
        Sun, 10 May 2020 05:41:34 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m11sm7136611lfo.55.2020.05.10.05.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:41:34 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v8 0/3] arm64: dts: meson: add dts/bindings for SmartLabs SML-5442TW
Date:   Sun, 10 May 2020 12:41:26 +0000
Message-Id: <20200510124129.31575-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds new bindings and a device-tree file for the Smartlabs
SML-5442TW set-top box which is based on the P231 reference design.

As requested, I have reworked the device-tree on the p23x-q20x dtsi. I
have also re-added the BT device with new bindings that have now  been
merged in bluetooth-next for inclusion in Linux 5.8. See [1].

v8 - reworked on p23x-q20x dtsi
   - add BT module

v7 - update gpio-led nodes
   - remove gpio-hog for BT enable
   - add bindings acks from Rob

v6 - removed audio nodes again

v5 - typo in card name

v4 - typos/corrections from Andreas
   - convert to yaml bindings
   - add sound node back
   - confirmed gpio-hog is necessary

v3 - change to Smartlabs LLC
   - removed sound node

v2 - removed audio nodes
   - changes soundcard name to "meson-gx-audio"
   - added missing uart-has-rtscts;

[1] https://patchwork.kernel.org/cover/11504823/

Christian Hewitt (3):
  dt-bindings: add vendor prefix for Smartlabs LLC
  dt-bindings: arm: amlogic: add support for the Smartlabs SML-5442TW
  arm64: dts: meson: add support for the Smartlabs SML-5442TW

 .../devicetree/bindings/arm/amlogic.yaml      |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxl-s905d-sml5442tw.dts | 80 +++++++++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dts

-- 
2.17.1

