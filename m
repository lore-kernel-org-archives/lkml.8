Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B1FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5FE20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZEhxfi1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgFVOtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgFVOtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DEFC061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d6so8729710pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stp1IX1mmPHX1rj5/nK/QmlVoQRLEAbDl7LJG7bMgaI=;
        b=ZEhxfi1u8JLhx/tPQ4f98TQ5H60Fp9wuN8Fi1Fd4NTr8i9+lHYLOtLwz38YlAIHkU3
         yh5ikvQmAqvgM6OgWb8L/1RRuxC/NVmHWc+Oxj1FXxDdqO4u22ERLPIvzbf94nYlqOx6
         hgO4IpDZDbDAMebXoHJ90eH73wg6srMYDio0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=stp1IX1mmPHX1rj5/nK/QmlVoQRLEAbDl7LJG7bMgaI=;
        b=GVN2ajaCFhwUQfYLUC5y6G3fNqR33HR0kUPe5YXA9gS6LGOpHufe1nfxAIUQg8t9FN
         0yLw9nohMPbZTDUlk0YyBCJ880UoGKw3BVPI92MZE2G8H7fu0tdn8YGtP1nUM3Kdxp2d
         UVioNRAyngILPlBbXSPJW+C1op0Lszueip6ULVLVyuN6ADwM/qBx2keYgyTHUhwNbGfX
         uxkNWf2+ZL1kxmE5QsZ3y6meP34mrH0YNILY+Cz/h+Z9Gw3AQzM2diRBIvunb4KWymuy
         Y3PjnAA7BZhyB+eOB3IK/GubYP3/fNh65/nYmnaLiAPSUtUROtS4se1kxtFKtn/DBGMq
         mmvw==
X-Gm-Message-State: AOAM531Poi3y1CIcqng3bC/FRvFbLOkkTCGH3tv3QxW1s++daOFdDEjb
        7QhRQB65it/utEUZZuDb/ifNlA==
X-Google-Smtp-Source: ABdhPJyEjVbfdxq0yEtd5ulcNWM0zz+5gEFUT1RwYiu/sTfqIRJRmjV+RUTXtuN1p300nEZ5DpNmmA==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr18651602pjs.155.1592837388727;
        Mon, 22 Jun 2020 07:49:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 77sm13903018pfu.139.2020.06.22.07.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:49:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     mturney@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        rnayak@codeaurora.org, dhavalp@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sparate@codeaurora.org,
        linux-arm-msm@vger.kernel.org, mkurumel@codeaurora.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] nvmem: qfprom: Patches for fuse blowing on Qualcomm SoCs
Date:   Mon, 22 Jun 2020 07:49:25 -0700
Message-Id: <20200622144929.230498-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series enables blowing of fuses on Qualcomm SoCs by extending the
existing qfprom driver with write support.

A few notes:
- Though I don't have any firsthand knowledge of it, it's my
  understanding that these changes could be used on any Qualcomm SoC.
  However, it's likely not very useful on most boards because the
  bootloader protects against this.  Thus the write support here is
  likely only useful with a cooperating bootloader.
- Blowing fuses is truly a one-way process.  If you mess around with
  this and do something wrong you could irreparably brick your chip.
  You have been warned.

Versions 1 and 2 of this series were posted by Ravi Kumar Bokka.  I
posted version 3 containing my changes / fixups with his consent.  I
have left authorship as Ravi but added my own Signed-off-by.

Version 4 is a minor spin over version 3.

Changes in v4:
- Maintainer now listed as Srinivas.
- Example under "soc" to get #address-cells and #size-cells.
- Clock name is "core", not "sec".
- Example under "soc" to get #address-cells and #size-cells.
- Only get clock/regulator if all address ranges are provided.
- Don't use optional version of clk_get now.
- Clock name is "core", not "sec".
- Cleaned up error message if couldn't get clock.
- Fixed up minor version mask.
- Use GENMASK to generate masks.
- Clock name is "core", not "sec".

Changes in v3:
- Split conversion to yaml into separate patch new in v3.
- Use 'const' for compatible instead of a 1-entry enum.
- Changed filename to match compatible string.
- Add #address-cells and #size-cells to list of properties.
- Fixed up example.
- Add an extra reg range (at 0x6000 offset for SoCs checked)
- Define two options for reg: 1 item or 4 items.
- No reg-names.
- Add "clocks" and "clock-names" to list of properties.
- Clock is now "sec", not "secclk".
- Add "vcc-supply" to list of properties.
- Fixed up example.
- Don't provide "reset" value for things; just save/restore.
- Use the major/minor version read from 0x6000.
- Reading should still read "corrected", not "raw".
- Added a sysfs knob to allow you to read "raw" instead of "corrected"
- Simplified the SoC data structure.
- No need for quite so many levels of abstraction for clocks/regulator.
- Don't set regulator voltage.  Rely on device tree to make sure it's right.
- Properly undo things in the case of failure.
- Don't just keep enabling the regulator over and over again.
- Enable / disable the clock each time
- Polling every 100 us but timing out in 10 us didn't make sense; swap.
- No reason for 100 us to be SoC specific.
- No need for reg-names.
- We shouldn't be creating two separate nvmem devices.
- Name is now 'efuse' to match what schema checker wants.
- Reorganized ranges to match driver/bindings changes.
- Added 4th range as per driver/binding changes.
- No more reg-names as per driver/binding changes.
- Clock name is now just "sec" as per driver/binding changes.

Ravi Kumar Bokka (4):
  dt-bindings: nvmem: qfprom: Convert to yaml
  dt-bindings: nvmem: Add properties needed for blowing fuses
  nvmem: qfprom: Add fuse blowing support
  arm64: dts: qcom: sc7180: Add properties to qfprom for fuse blowing

 .../bindings/nvmem/qcom,qfprom.yaml           |  96 ++++++
 .../devicetree/bindings/nvmem/qfprom.txt      |  35 --
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |   4 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  10 +-
 drivers/nvmem/qfprom.c                        | 314 +++++++++++++++++-
 5 files changed, 411 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt

-- 
2.27.0.111.gc72c7da667-goog

