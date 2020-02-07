Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528D0C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224E420715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJRE5Oqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBGURA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:17:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52586 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgBGUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:16:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so3834797wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wW2T2Hf0VfuSYnJQMUU+IIJaZFO8kXPo9LciCrLguQ=;
        b=nJRE5Oqg80/6zlUNLtjSSi5V0IhlQuxcxDib7pTKZi3Czuw3lN22oJ97lXCcigyQbX
         ksmmt1T6Ynvcj39HiMiD4CsmQQH7KeluVEAjxEwvCgh9V75Xz4X2G+2kjxtMmQyF10kv
         TEzK3FKN7vZjDSropS8pxWCxUsCpAY+p9AU0N8nEf+p95VpqjNaGU238Jy0fEHICosr1
         B9+R0pCEFIG0G+XjH1qOhvW7Z0o+GlYKKwRbmpdIksvbT0egR+hZ0ZdK8EXN7n7s+/lm
         rl1ND+S585EteurjK1j5MiUxGZA0tP3B09qnlMUSmwKr+KGJ6dKffTTmJkILnlxNMLnT
         8mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4wW2T2Hf0VfuSYnJQMUU+IIJaZFO8kXPo9LciCrLguQ=;
        b=KCKGDi9bOXWp2btJ0OmtCl5XXfEZ9XAG6KsbK5oSdsg+YuqgqGu20wC8dPg2ETyhDY
         tJgqGIgiktmgRhHHeo2J/1d6tXCJh0fHE2YIyQVdfTyjb0Jq43vshI6pdAHCpSPhhyBy
         sG8eOAPIQiPqnGl4fU7nz4SgwQOrRvmifFMjJDhXOszmXk7YYmI8dJVjAHstnzxvIM1p
         K4nJN2lzZdEHmleVmKaUW/b3gNKUuxfRnT3DbvKetYwdZLcCbuuvFLToIq6ks1fpid8J
         IVdXW1OGcp09b+zFunLgnCSPwNYTuZ6j1m2AGg1YiZI+k7MsJx9AzaH/x722dDv8EYTV
         O8bg==
X-Gm-Message-State: APjAAAX+m18zLiiDC4LFqv2lGhik+jIHAjhUJleWXxJekyEHTgZWarFA
        il95j9osMBAbdROyGiRspwElDQ==
X-Google-Smtp-Source: APXvYqxLoLnAheBAIMTB5ALNDAeFHFdgKeOOSwJyrZY832oHFlYsuJKyZc3qvvxRv88E9Q1d3EFJ7w==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr24171wmf.55.1581106609635;
        Fri, 07 Feb 2020 12:16:49 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id h2sm5018542wrt.45.2020.02.07.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:16:48 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v5 00/18] Enable Qualcomm QCS 404 HS/SS USB
Date:   Fri,  7 Feb 2020 20:16:36 +0000
Message-Id: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
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

V3:
- Fixes typo generating YAML warning - Rob's YAML robot

V4:

https://lore.kernel.org/linux-arm-msm/20200122185610.131930-1-bryan.odonoghue@linaro.org/

- Churn names of PHYs - Rob Herring
  Rob questioned the name of the SuperSpeed PHY in V3.
  Looking at available data 

  usb-hs-28nm - There are two possible PHYs on 28nm litho node
		so it makes sense to name the PHY relating to its relevant
		litho node.

  usb-ss - This is not litho node dependent and is used on  multiple SoCs
	   and litho nodes.

- Drop default mode for role switching - Felipe Balbi
  Felipe asked if the default mode for role switching was
  required and the answer is no. It makes no difference
  becuase the USB ID pin ultimately dictates the mode of operation.

- Change "gpio_usb_connector" to "connector" - Rob
  This was a minor change in terms of DTS but, means I need to look for the
  DTS compatible string as opposed to a label given in the DTS.
  No matter what the name of the label, this is he right thing to do.

- Used IS_ENABLED() - Felipe
  The logic is the same but IS_ENABLED() is used now.

- Retained example of USB connector in dwc.txt - Rob, Felipe
  Rob pointed out adding the connector was redundant as the documentation
  already implies it.
  Felipe seemed in favour of I think adding the example.
  I've dropped the documentation of the connector and kept the example.
  https://lore.kernel.org/linux-arm-msm/20200122185610.131930-7-bryan.odonoghue@linaro.org/

- Added example of usb-role-switch in dwc3.txt - BOD
  
- Incorporated various inputs from Rob on DTS/YAML
  - Added required:
  - Added additionalProperties:
  - Renamed "phy" clock to "ahb"
  - maxItems dropped as indicated

V5:
- https://lkml.org/lkml/2020/2/6/913

- Adds a notifier to DWC3 - BOD
  This is done in order to allow propagation of role-switch events from the
  DWC3 core to an associated binding layer.

- Re-use the existent EXTCON VBUS power lane toggle logic - Jack Pham
  Jack flagged this for inclusion and as a result we need to make a
  small change to the qcom binding layer.

- Squash DTS changes - BOD
  I've squashed down some of the DTS changes to stop the patch count in
  this series going  up any further.

Bjorn Andersson (1):
  arm64: dts: qcom: qcs404: Add USB devices and PHYs

Bryan O'Donoghue (11):
  dt-bindings: usb: dwc3: Add a gpio-usb-connector example
  dt-bindings: usb: dwc3: Add a usb-role-switch to the example
  usb: dwc3: qcom: Add support for usb-conn-gpio connectors
  usb: dwc3: Add support for usb-conn-gpio connectors
  usb: dwc3: Add support for a role-switch notifier
  usb: dwc3: qcom: Enable gpio-usb-conn based role-switching
  arm64: dts: qcom: qcs404-evb: Define VBUS pins
  arm64: dts: qcom: qcs404-evb: Define USB ID pin
  arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
  arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
  arm64: dts: qcom: qcs404-evb: Enable USB controllers

Jorge Ramirez-Ortiz (3):
  dt-bindings: phy: remove qcom-dwc3-usb-phy
  dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
  phy: qualcomm: usb: Add SuperSpeed PHY driver

Shawn Guo (1):
  phy: qualcomm: Add Synopsys 28nm Hi-Speed USB PHY driver

Sriharsha Allenki (1):
  dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding

Yu Chen (1):
  usb: dwc3: Registering a role switch in the DRD code.

 .../bindings/phy/qcom,usb-hs-28nm.yaml        |  90 ++++
 .../devicetree/bindings/phy/qcom,usb-ss.yaml  |  83 ++++
 .../bindings/phy/qcom-dwc3-usb-phy.txt        |  37 --
 .../devicetree/bindings/usb/dwc3.txt          |   9 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |  90 +++-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 100 +++++
 drivers/phy/qualcomm/Kconfig                  |  20 +
 drivers/phy/qualcomm/Makefile                 |   2 +
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c   | 415 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        | 246 +++++++++++
 drivers/usb/dwc3/core.h                       |  22 +
 drivers/usb/dwc3/drd.c                        | 117 ++++-
 drivers/usb/dwc3/dwc3-qcom.c                  |  31 +-
 13 files changed, 1221 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.25.0

