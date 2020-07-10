Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E3DC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711AF206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eOhC/yfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGJOfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:35:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F34C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:35:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so2321492pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9HrHqPUSzITIW7yfyMtrSSs67bqVARez79+kQQRCiU=;
        b=eOhC/yfyGAev8w7mTmTopkakwjlcvNp3mGfa3evSenT6qvF2LqWIivBh3wtRbTUpv5
         DRqO84KXN4dJ2+f+0hDhvW8AzOuD42V/VAcjnS0pe5yWeQH1pQ4sxcsHpgY2cbJ5vhZi
         skem5KBZ7ICCVRqEzP7OXeP/hU6ZdDU2jATNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9HrHqPUSzITIW7yfyMtrSSs67bqVARez79+kQQRCiU=;
        b=uOFmlZ7m8VEP63Dy3oHBPJREdZkPxVm+2mAmAUhOWFwjo3MPxKpysU4VoArfsfEzsa
         fdb3dACLg8q0opNI4gaoQSQfh+JBF7R+n6PxzHRtFsdbzPGnzv4jbmDF5XRBWB99N8nz
         ZtYj6eAiMR9y0Zoc3AIvlO3R+/Ia5v585MrbhDtvPoHfvAF51W7CXE+J4ERBi4TTEihD
         9gFsf5FccPqyAQlVQF3PBotUN0lq5BoSkQQP2uexgcMM2dlUSkr9+o8NdtzB0O35Su2e
         VUQGhlk9fQPCu+L+VsWswolNRyYryIc46sVms/Qwa1XjDiNFuNTKp0XUf9IYG4sMmuOV
         sSng==
X-Gm-Message-State: AOAM5300AEgAcZZps9eCh5tOn7Mw9xKqc1XxWhX+ba7w5SpZIeIfalUi
        1dke4mlFwggCWELI4LN5oa4tFw==
X-Google-Smtp-Source: ABdhPJxzIjZr+pig7oEHSaoBQa6MCG0kHzq8V3evp9Xib8/oPodkV6Ju7eNFbEfQeSLtp/6jyAOYQg==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr6082153pjq.185.1594391739990;
        Fri, 10 Jul 2020 07:35:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id gn5sm5951284pjb.23.2020.07.10.07.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:35:39 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     sparate@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        mturney@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>, dhavalp@codeaurora.org,
        rnayak@codeaurora.org, mkurumel@codeaurora.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] nvmem: qfprom: Patches for fuse blowing on Qualcomm SoCs
Date:   Fri, 10 Jul 2020 07:35:16 -0700
Message-Id: <20200710143520.1206846-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
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

Version 5 is an even more minor spin and just bumps up some timings to
fix a failure reported by Ravi on one device.  I've collected Rob
Herring's reviews and (as far as I know) this is ready to land.

Changes in v5:
- QFPROM_FUSE_BLOW_POLL_US 10 => 100
- QFPROM_FUSE_BLOW_TIMEOUT_US 100 => 1000

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
2.27.0.383.g050319c2ae-goog

