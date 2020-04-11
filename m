Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB8C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4227B2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDKFDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:03:08 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:51061 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgDKFCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:02:53 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 Apr 2020 22:02:53 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 10 Apr 2020 22:02:50 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id B1D5C21673; Sat, 11 Apr 2020 10:32:48 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V2 0/5] Enable USB support in IPQ8074
Date:   Sat, 11 Apr 2020 10:32:27 +0530
Message-Id: <1586581352-27017-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
This patch set enables the USB PHYs and USB dwc3 in IPQ8074.

This patch set depends on Sandeep's QMP PHY binding patch
https://patchwork.ozlabs.org/patch/1265442/
and Sivaprakash's IPQ8074 dts re-arrange patch
https://lkml.org/lkml/2020/4/10/706

[V2]
 * Added new device compatible qcom,ipq8074-qusb2-phy for qusb2
 * Addressed Bjorn's review comments on dts and binding

Sivaprakash Murugesan (5):
  dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt bindings
  dt-bindings: phy: qcom,qusb2: Add ipq8074 device compatible
  phy: qcom-qmp: Add USB QMP PHY support for IPQ8074
  phy: qcom-qusb2: Add ipq8074 device compatible
  arm64: dts: ipq8074: enable USB support

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |   1 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |  24 +++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 167 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 102 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |   3 +
 6 files changed, 299 insertions(+)

-- 
2.7.4

