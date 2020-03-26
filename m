Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A1C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB90F206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O6pHgO2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCZNpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgCZNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so7811853wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRpXPRnvMHphy1rE/lS9Q+pcM8R6cY/UAWlotJHG3f8=;
        b=O6pHgO2UFROBlOyqKsOduNAxXJHE7whRi12MWJkDR/vx8irlnJ0SY0ok5h/aWe00EJ
         rQTJKYaERdS060GGm0vAYGSrGzrpTgC8N790w/PF5VD3H+uG8iJdrn+EkKi0sEfwwO63
         HabTQD5+ETQBG4k+KW8B9Wugyq/pi64hloxe30oX4PBEEBuAgGHo9vOEHbuc/Lc0VOx/
         QIt5Jr8KM+CwlnmL5ApZKwMTlzRIJYobhaupkXHNJHc1DmD9CUv5YD7OCTP3/sdxcJDh
         2PvOh9l59vFe4m5KRFwnfQz7FmEG2ayWeqZqB13lyWXVOsJTNZhvyV9LZmZ60IlJBz3i
         zFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRpXPRnvMHphy1rE/lS9Q+pcM8R6cY/UAWlotJHG3f8=;
        b=W1sHjJaaCTTdIaEK7YcepVSrhK+XSKBzu070euel88azTwQ4j+1SWOtC1Jh4WiR8Cy
         Ck+Kx6eqo+PoZ2HXMNZKgtwV3WQGFGytevUV+Af+OUkdyHKDwDAKp0qQxyA7TgCH/QhH
         wcy10N84SkurNygAu8DzYB1zPjXJkyn9UYHtnVSrsUVSM3o296mnSYXVlDpvNIaar2uS
         1eXLayRGIE5NK4qwP1c+36MJOu6xzZRvh5+kia/bRM6WSMsmMX1UmBIaap7fhO9z4kFI
         5FloCsBokIFtug21uHjvW5MjmQZeudO9YQ26+a+pDoOBCVH0vgHDANqHvrlOu7wm8/HC
         +FLg==
X-Gm-Message-State: ANhLgQ3BsaqTB+qpXCZ0OGmvlQ+au5dUFCOaz9zPgAY4fhw0KI7x7WnO
        6SVm9OSON2pcOMi2leqxYSO0Hg==
X-Google-Smtp-Source: ADFU+vvXGkEfouXX7y1+sdqh+EsGCX1Rk8sMRmpR+O8yOAt2hdBafRMo+nYkAAFLziTJ7sTB8kpp2g==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr9840366wrw.313.1585230310112;
        Thu, 26 Mar 2020 06:45:10 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] usb: dwc3: meson: add OTG support for GXL/GXM
Date:   Thu, 26 Mar 2020 14:44:52 +0100
Message-Id: <20200326134507.4808-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB support was initialy done with a set of PHYs and dwc3-of-simple
because the architecture of the USB complex was not understood correctly
at the time (and proper documentation was missing...).

But with the G12A family, the USB complex was correctly understood and
implemented correctly.
But seems the G12A architecture was derived for the GXL USB architecture,
with minor differences and looks we can share most of the USB DWC3 glue
driver.

This patchset refactors and adds callbacks to handle the architecture
difference while keeping the main code shared.

The main difference is that on GXL/GXM the USB2 PHY control registers
are mixed with the PHY registers (we already handle correctly), and
the GLUE registers are allmost (99%) the same as G12A.

But, the GXL/GXM HW is buggy, here are the quirks :
- for the DWC2 controller to reset correctly, the GLUE mux must be switched
  to peripheral when the DWC2 controller probes. For now it's handled by simply
  switching to device when probing the subnodes, but it may be not enough
- when manually switching from Host to Device when the USB port is not
  populated (should not happen with proper Micro-USB/USB-C OTG switch), it
  makes the DWC3 to crash. The only way to avoid that is to use the Host
  Disconnect bit to disconnect the DWC3 controller from the port, but we can't
  recover the Host functionnality unless resetting the DWC3 controller.
  This bit is set when only manual switch is done, and a warning is printed
  on manual switching.

The patches 1-9 should be applied first, then either waiting the next release
or if the usb maintainer can provide us a stable tag, we can use it to merge
the DT and bindings.

Changes since v1 at [1]:
- Fixed DT bindings to take in account usb2-phy2 on GXM
- Added comment in patch2
- Fixed patch 5 and moved fix out
- Collected tags
- Lower DT patch changes, switch p20x-q20x port B as OTG by default

[1] http://lkml.kernel.org/r/20200324102030.31000-1-narmstrong@baylibre.com

Martin Blumenstingl (4):
  arm64: dts: amlogic: use the new USB control driver for GXL and GXM
  phy: amlogic: meson-gxl-usb3: remove code for non-existing PHY
  usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles
  dt-bindings: usb: dwc3: remove old DWC3 wrapper

Neil Armstrong (10):
  dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic GXL and
    GXM Families USB Glue Bindings
  usb: dwc3: meson-g12a: specify phy names in soc data
  usb: dwc3: meson-g12a: handle the phy and glue registers separately
  usb: dwc3: meson-g12a: get the reset as shared
  usb: dwc3: meson-g12a: check return of dwc3_meson_g12a_usb_init
  usb: dwc3: meson-g12a: refactor usb2 phy init
  usb: dwc3: meson-g12a: refactor usb init
  usb: dwc3: meson-g12a: support the GXL/GXM DWC3 host phy disconnect
  usb: dwc3: meson-g12a: add support for GXL and GXM SoCs
  doc: dt: bindings: usb: dwc3: remove amlogic compatible entries

 .../bindings/phy/meson-gxl-usb3-phy.txt       |  31 --
 .../devicetree/bindings/usb/amlogic,dwc3.txt  |  42 --
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      |  73 ++-
 .../devicetree/bindings/usb/dwc3.txt          |   2 -
 .../dts/amlogic/meson-gx-libretech-pc.dtsi    |   3 +-
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi  |   3 +-
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  |   3 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts |   3 +-
 .../amlogic/meson-gxl-s905d-phicomm-n1.dts    |   4 +
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts |   4 +
 .../dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |   4 +
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    |   4 +
 .../amlogic/meson-gxl-s905x-libretech-cc.dts  |   3 +-
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |   3 +-
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  45 +-
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     |   3 +-
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts  |   3 +-
 .../boot/dts/amlogic/meson-gxm-vega-s96.dts   |   4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    |   7 +-
 drivers/phy/amlogic/Kconfig                   |  12 -
 drivers/phy/amlogic/Makefile                  |   1 -
 drivers/phy/amlogic/phy-meson-gxl-usb3.c      | 283 ------------
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 415 ++++++++++++++----
 drivers/usb/dwc3/dwc3-of-simple.c             |  30 +-
 25 files changed, 477 insertions(+), 511 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
 delete mode 100644 drivers/phy/amlogic/phy-meson-gxl-usb3.c

-- 
2.22.0

