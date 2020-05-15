Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8439CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F8920758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEOCjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:39:55 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:31696 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgEOCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:39:55 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 May 2020 08:09:52 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 May 2020 08:09:29 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id 7422929A7; Fri, 15 May 2020 08:09:28 +0530 (IST)
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
Subject: [PATCH v7 0/4] Add QMP V3 USB3 PHY support for SC7180 
Date:   Fri, 15 May 2020 08:09:14 +0530
Message-Id: <1589510358-3865-1-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QMP V3 USB3 PHY entries for SC7180 in phy driver and
device tree bindings.

changes in v7:
*As per Matthias comments conversion to yaml and splitting out DP PHY bindings
 patches are separated.
*PATCH v7 1/4 is for coversion to yaml.
*PATCH v7 2/4 has splitting out DP PHY bindings and adding as separate yaml
 for DP PHY  bindings.
*No changes in PATCH v7 3/4 and 4/4.

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

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 313 +++++++++++++++++++++
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 136 +++++++++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 247 ----------------
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  38 +++
 4 files changed, 487 insertions(+), 247 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

