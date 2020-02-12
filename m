Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC148C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFC920848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBLLXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:23:14 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:45688 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgBLLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:23:13 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Feb 2020 16:51:55 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Feb 2020 16:51:31 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id B996F24FD; Wed, 12 Feb 2020 16:51:30 +0530 (IST)
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
Subject: [PATCH v3 0/4] Add QMP V3 USB3 PHY support for SC7180
Date:   Wed, 12 Feb 2020 16:51:24 +0530
Message-Id: <1581506488-26881-1-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QMP V3 USB3 PHY entries for SC7180 in phy driver and
device tree bindings.

changes in v3:
*Addressed Rob's comments in yaml file.
*Sepearated the SC7180 support in yaml patch.
*corrected the phy reset entries in device tree.

changes in v2:
*Remove global phy reset in QMP phy.
*Convert QMP phy bindings to yaml.

Sandeep Maheswaram (4):
  dt-bindings: phy: qcom,qmp: Convert QMP phy bindings to yaml
  dt-bindings: phy: qcom,qmp: Add support for SC7180
  phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180
  arm64: dts: qcom: sc7180: Correct qmp phy reset entries

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 287 +++++++++++++++++++++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 227 ----------------
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  38 +++
 4 files changed, 327 insertions(+), 229 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

