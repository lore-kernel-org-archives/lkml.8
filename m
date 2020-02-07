Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE1C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D10B21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6qUx90I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBGB7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 20:59:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40865 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so768503wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdsTustiTEAc4Tujnfb7XjeqOI1Ge7rSeXSRqhcDXQ8=;
        b=s6qUx90IAnLtAjHisj7ZVYCroObME+Qh/y2ADkrrGBe33eyL3mHNl+gjvnysRTdNlX
         Fs0D1TG1d4X8/JTXAhkxu3cZsFzfb19M8MfjT+e4Kjomn4YsS6Ep8VTmoI588UB+/YIw
         moVqcxw5Y/CQqV9b1f2ziH0D+ec+reSaKFcl7ryh+G2rX3KXwzTOBFGaenPIskPiOVtS
         IhKajKrvDwomQVwsUE6VCLFy0+mVtsd+NdPTxd5bRZlfqO11cnhLVazmNeKAj5s/RoAH
         nm1B1waBRBcc+efwljkqbE/aYn1yx19fxNKTgVuEVTvBkQrEofiroZHX+40wdLKeH2Yb
         5plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YdsTustiTEAc4Tujnfb7XjeqOI1Ge7rSeXSRqhcDXQ8=;
        b=CLBnEGvbQHvdrO0b39Ku2l6nbLfxF00LJXaMbHcpgSqFlmmqG+Ah4Lvjk2m3ZCd72u
         6uhkXOMq5OiuGJ9XwTBm6PbnXTwu41PO2ZQw37iY/UoknxQ15mllcRQM8ypcI/hySTQo
         gxzdRHeSYZTc7XZ7p2M7euuBwm2PKGEGIqVMRMoK1YNodWegt9cmcnu+zzgMpQdfanw6
         DnZkXtUw25OBSN7MDR9Ph02Cmpk+77ANmzUsVySo0RS/xaA8+Bg5UPgCBUif/oI/q8DY
         4Deu5aDHSOrv4MGJQbiGO1vkXZ9WVRSjwH6YRUvRX36+XvpBb37rL38KaI6AVZ0b5aAk
         YzYQ==
X-Gm-Message-State: APjAAAUeEzSsMY0jlj0oxcx1ZZ1kl5UyYwuHSCSk0B6EKXAZbO7QVwHW
        UlOtC6C4KljNg3ljxCwiIlf5fw==
X-Google-Smtp-Source: APXvYqwF5HEMOBrGXTHYfz2ONwl2wcToOULo9S2TGMjk1ud3d+iuxkow0zqqLTaSETGvf/t3bp07jA==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr1252896wrm.219.1581040745956;
        Thu, 06 Feb 2020 17:59:05 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:05 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v4 00/18] Enable Qualcomm QCS 404 HS/SS USB
Date:   Fri,  7 Feb 2020 01:58:49 +0000
Message-Id: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
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

Bjorn Andersson (1):
  arm64: dts: qcom: qcs404: Add USB devices and PHYs

Bryan O'Donoghue (11):
  dt-bindings: usb: dwc3: Add a gpio-usb-connector example
  dt-bindings: usb: dwc3: Add a usb-role-switch to the example
  usb: dwc3: qcom: Override VBUS when using gpio_usb_connector
  usb: dwc3: Add support for usb-conn-gpio connectors
  arm64: dts: qcom: qcs404-evb: Define VBUS detect pin
  arm64: dts: qcom: qcs404-evb: Define VBUS boost pin
  arm64: dts: qcom: qcs404-evb: Define USB ID pin
  arm64: dts: qcom: qcs404-evb: Describe external VBUS regulator
  arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
  arm64: dts: qcom: qcs404-evb: Enable secondary USB controller
  arm64: dts: qcom: qcs404-evb: Enable primary USB controller

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
 drivers/usb/dwc3/core.h                       |   3 +
 drivers/usb/dwc3/drd.c                        | 100 ++++-
 drivers/usb/dwc3/dwc3-qcom.c                  |  22 +-
 13 files changed, 1175 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.25.0

