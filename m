Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47678C33CB8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FC52087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LF3yVSVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgATQau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:30:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42911 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgATQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:30:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so68607wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoZQ4MDBRUdbgqKcBBLpOhZbtBTRulxhzwCr2jBWHos=;
        b=LF3yVSVOqXCe0xUVfph/VQMUg8nNVPFO7u9LoUNcOqmzZHwsvzDhHL2uVdNSRpgycb
         0ldw+hqiXEhgXTC5x40WgPawJ4M5CyspDr9/Ntc0Jb/adzlGLwC3D+VHrvDd8CRFo8cq
         S72twq0T2BUoGZh4twWheIjcc+Z66p1ROgayGyNOyf34NhIHlzkTtL2EiPMNN6jrQca2
         rIWMcTY+7KX7ufPN28PI6Zbv9wbI9PFLG6OB6tO3j2UH5OEYnK/6AkyWroK1zhBSJ0dn
         QsVlVYD4+btU+MrT54H6fbKelkyqLeoMvkCAMpFkNeljnbPVOV9YY+1fxlysv7OELuQU
         FQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RoZQ4MDBRUdbgqKcBBLpOhZbtBTRulxhzwCr2jBWHos=;
        b=G8lB0KynhhfKaQS3PHhrRo+x9ZutJtiB83Nm5/GuGc9YUJPJjiSNRk8Eqc6AMcPBiU
         gKUVgBS6S5w9XQ21X8kX7sdbktBm/h1+e3VfVPLe3g/icUN5mCGjRNxTwJ7ALhfJ1Fur
         imz+hb0Lunq3Rs5fL9Dert3E07z9S2ht/QTZIQ2uGrkB+Sx58zD5Zbu9rBpDnUkqlHrF
         xPsQ5AnzNc7pVTqUrqrB/bbaRN089Kp+T0nanQO621W+5UAOCA4vUKykhypshCKIrKwU
         XALEdm6ELdrNPjgQs9HB3Qdvk73pV2x+FTmrtsGl1FeXxsbulGZGVTvUDs4VHBSGi1Cf
         MmNA==
X-Gm-Message-State: APjAAAWYtTS6dMnLPKMNewR2IqpmS3QCznV33UGyVSkRmoq//UTM4eXI
        qOC18pko2vnpm3m6p+1MD3IWBQ==
X-Google-Smtp-Source: APXvYqwismUSyObhaOPUhL75CCagqg8iGc2j2Uw0f8b/ZgbpCZGcod1cfFhQJ09t88/S+qyxZz26Zw==
X-Received: by 2002:adf:f311:: with SMTP id i17mr336951wro.81.1579537846828;
        Mon, 20 Jan 2020 08:30:46 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:30:46 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 00/19] Enable Qualcomm QCS 404 HS/SS USB
Date:   Mon, 20 Jan 2020 16:30:57 +0000
Message-Id: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1:
This series enables the Primary and Secondary USB controllers on the
QCS404, associated PHYs, role-switching and DTS descriptions.

The series takes in a number of patches worked on by a number of people
over the past few years from downstream, through to previous upstream
submissions for both of these interfaces. Additional work has been done to
enable USB role-switching.

1. USB SS
   - extcon has been dropped in favour of gpio-usb-conn as discussed and
     agreed previously by Jorge, Bjorn, Stephen Boyd and Jack Pham [1].

   - Regulator API has been updated following suggestions from Bjorn.
   
   - Sanitzation of the DT compatible name - dropped "snps" entirely
     from the name - it made almost no sense to me and doesn't appear
     consistent with similar naming conventions for Snopsys based IP.

2. USB HS
   - Regulator API changes here.
   - Dropped "snps" from the namespace for similar reasons as above.
   - Dropped "28nm" from the namespace, looked superfluous.
   - Changed "High-Speed" to "Hi-Speed".
   - [2]

3. DWC3 Role switching
   - At the time usb-gpio-conn was discussed it was mentioned that
     role-switching was absent from the DWC3 driver.
   - John Stultz has some patches in-flight for that, that I've included in
     this series for completeness.
   - Adds my SoB to relevant patches.
   - Drops gerrit ChangeId.

4. DWC3 usb-gpio-conn
   Needs to be a child node of the DWC3 driver so some code and DT binding
   is required for that.

5. QCOM-DWC3
   Since we are role-switching with an external PMIC supplying VBUS we want
   to skip past toggling VBUS from QCOM-DWC3 controlled registers, so a
   patch is added to the qcom-dwc3 driver to do that.

References:

1: USB SS PHY for Qualcomm's QCS404
https://lwn.net/ml/devicetree/20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org/

2: Add Synopsys High-Speed USB PHY driver for Qualcomm SoCs
https://lore.kernel.org/linux-arm-msm/20181127100722.9993-3-shawn.guo@linaro.org/

https://www.spinics.net/lists/linux-usb/msg190003.html

V2:
- Fixes yaml error - Rob's YAML robot
- Exclusive control of reset in PHY drivers - Philipp Zabel

Bjorn Andersson (1):
  arm64: dts: qcom: qcs404: Add USB devices and PHYs

Bryan O'Donoghue (10):
  dt-bindings: usb: dwc3: Add a gpio-usb-connector description
  usb: dwc3: qcom: Override VBUS when using gpio_usb_connector
  usb: dwc3: Add support for usb-conn-gpio connectors
  arm64: dts: qcom: qcs404-evb: Define VBUS detect pin
  arm64: dts: qcom: qcs404-evb: Define VBUS boost pin
  arm64: dts: qcom: qcs404-evb: Define USB ID pin
  arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
  arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
  arm64: dts: qcom: qcs404-evb: Enable secondary USB controller
  arm64: dts: qcom: qcs404-evb: Enable primary USB controller

John Stultz (2):
  dt-bindings: usb: generic: Add role-switch-default-mode binding
  usb: dwc3: Add support for role-switch-default-mode binding

Jorge Ramirez-Ortiz (3):
  dt-bindings: phy: remove qcom-dwc3-usb-phy
  dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
  phy: qualcomm: usb: Add SuperSpeed PHY driver

Shawn Guo (1):
  phy: qualcomm: Add Synopsys Hi-Speed USB PHY driver

Sriharsha Allenki (1):
  dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding

Yu Chen (1):
  usb: dwc3: Registering a role switch in the DRD code.

 .../bindings/phy/qcom,qcs404-usb-hs.yaml      |  77 ++++
 .../devicetree/bindings/phy/qcom,usb-ss.yaml  |  75 ++++
 .../bindings/phy/qcom-dwc3-usb-phy.txt        |  37 --
 .../devicetree/bindings/usb/dwc3.txt          |  11 +
 .../devicetree/bindings/usb/generic.txt       |   6 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |  90 +++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 100 +++++
 drivers/phy/qualcomm/Kconfig                  |  21 +
 drivers/phy/qualcomm/Makefile                 |   2 +
 drivers/phy/qualcomm/phy-qcom-qcs404-usb-hs.c | 415 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        | 246 +++++++++++
 drivers/usb/dwc3/core.h                       |   6 +
 drivers/usb/dwc3/drd.c                        | 123 +++++-
 drivers/usb/dwc3/dwc3-qcom.c                  |  17 +-
 14 files changed, 1184 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qcs404-usb-hs.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.25.0

