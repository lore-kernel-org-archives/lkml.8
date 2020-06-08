Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A312065C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgFHOL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:11:57 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:32932 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729451AbgFHOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:11:26 -0400
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Jun 2020 07:11:25 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg04-sd.qualcomm.com with ESMTP; 08 Jun 2020 07:11:22 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id E2B53217EC; Mon,  8 Jun 2020 19:41:20 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V3 0/5] Enable USB support in IPQ8074
Date:   Mon,  8 Jun 2020 19:41:14 +0530
Message-Id: <1591625479-4483-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
This patch set enables the USB PHYs and USB dwc3 in IPQ8074.

[V3]
 * Rebased patch 3 on 5.7 and linux-next tag next-20200608
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

