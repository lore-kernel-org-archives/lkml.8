Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901AC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD6C206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S93imiwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgAQDh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:37:57 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:39970 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAQDh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:37:56 -0500
Received: by mail-pj1-f43.google.com with SMTP id bg7so2643844pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 19:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3ZrmALb04VJvJYJRFDnB2xc6oarHSelUabhN5PENno=;
        b=S93imiwqTJgV9ntX1fa1Q4p88MPfMvVD6Z0uhgELxYfARwZGOCZkDu3BcPpqKPVcDm
         /rV0AiXUemaxpZro3ZodBQeZi8D7mKx54Z3yC6A5IjlE5ul5gU2e++Jo1EGMPQcxUB5b
         dTHjUYrKitks66CvR3LLUvGzMPibI3EBQvY4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W3ZrmALb04VJvJYJRFDnB2xc6oarHSelUabhN5PENno=;
        b=qQRbfIDTHI4PXT6DF0I+LInZeQZh8f4Me2vrLnSC9Gt8n3wcEympbG88L3BRdWdZt+
         c+gfxaMxIuzHTOq4l4w3RfFYt3jWxM1mNZWpssJgKaCgcF/A5LYtAR5P1FX/ew1F0JH1
         O6ZJvOEf3cFZ8raqpyYklzfIy0Wwg8SEnbsaw95BvfzHouvK/pNTRRtSk/8GzpnKd2DL
         2dhAEeRcDwL09JIgMitGKRcsomI0G0XOJMePUBpilv/IGWuozxWAAzCmtOpGvIZ4Sr/y
         U6p5Sa9RX9Ee1VS798st98vbsMfQ/c7+A4xrY3AxY7LcxwJ9vGOoVZNGjuaqllCSKOmn
         gbBg==
X-Gm-Message-State: APjAAAXkW0eiYi14K/Hg0iBrR7axADIeQAZMli/CtcHokJZ9ZWGO+4hv
        sfspoiRFS+sF9pD2nAp073uo0EJETDE=
X-Google-Smtp-Source: APXvYqz8oNglxNkmhRqIcnk3Hs0gldj3Lgjt+22dbA0S2qnTnMZGFb0p0ixnztKYQ0yeztInjhjuxA==
X-Received: by 2002:a17:90a:d986:: with SMTP id d6mr3245192pjv.78.1579232275097;
        Thu, 16 Jan 2020 19:37:55 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id j38sm25940259pgj.27.2020.01.16.19.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 19:37:54 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v4 0/3] Add mt8173 elm and hana board
Date:   Fri, 17 Jan 2020 11:37:46 +0800
Message-Id: <20200117033749.137420-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds devicetree and binding document for Acer Chromebook R13 (elm)
and Lenovo Chromebook (hana), which are using mt8173 as SoC.

Changes in v4:
- fix dtbs_check errors on cros-ec-keyboard
- add comments for second source touchscreen and trackpad

Changes in v3:
- address comments in v2, major changes include:
  * move uart aliases from mt8173-elm.dtsi to mt8173.dtsi
  * remove brightness-levels in backlight
  * add interrupt for da9211
  * move pinmux for sdio_fixed_3v3 from mmc3_pins_default
  * remove some non upstream property
  * checked on schematic, cd-gpio in mmc1 should be GPIO_ACTIVE_LOW

Changes in v2:
- fix mediatek.yaml
- fixup some nodes and remove unused nodes in dts


Hsin-Yi Wang (3):
  dt-bindings: arm64: dts: mediatek: Add mt8173 elm and hana
  arm64: dts: mt8173: add uart aliases
  arm64: dts: mediatek: add mt8173 elm and hana board

 .../devicetree/bindings/arm/mediatek.yaml     |   22 +
 arch/arm64/boot/dts/mediatek/Makefile         |    3 +
 .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
 .../boot/dts/mediatek/mt8173-elm-hana.dts     |   14 +
 .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   70 ++
 arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   14 +
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1029 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |    5 +-
 8 files changed, 1183 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi

-- 
2.25.0.rc1.283.g88dfdc4193-goog

