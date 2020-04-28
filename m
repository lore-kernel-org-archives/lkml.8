Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4AC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D21620775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgD1OGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:06:46 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:61561 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgD1OGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:06:46 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Apr 2020 19:36:43 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg02-blr.qualcomm.com with ESMTP; 28 Apr 2020 19:36:24 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id BD7E328DA; Tue, 28 Apr 2020 19:36:23 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v6 0/4] Add QMP V3 USB3 PHY support for SC7180 
Date:   Tue, 28 Apr 2020 19:36:11 +0530
Message-Id: <1588082775-19959-1-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QMP V3 USB3 PHY entries for SC7180 in phy driver and
device tree bindings.

changes in v6:
*Added separate yaml file for USB3 DP PHY bindings.

changes in v5:
*Addressed comments from Matthias in yaml file.
*Dropped PATCH 4/4 as it is landed in linux-next. 

changes in v4:
*Addressed comments from Matthias and Rob in yaml file.

changes in v3:
*Addressed Rob's comments in yaml file.
*Sepearated the SC7180 support in yaml patch.
*corrected the phy reset entries in device tree.

changes in v2:
*Remove global phy reset in QMP PHY.
*Convert QMP PHY bindings to yaml.

Sandeep Maheswaram (4):
  dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml
  dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY
  dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7180
  phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 311 +++++++++++++++++++++
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 136 +++++++++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 242 ----------------
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  38 +++
 4 files changed, 485 insertions(+), 242 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

