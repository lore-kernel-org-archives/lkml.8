Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA79C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44692084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDJS3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:29:54 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:36512 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726671AbgDJS3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:29:42 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Apr 2020 11:29:41 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 10 Apr 2020 11:29:37 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 2C07521680; Fri, 10 Apr 2020 23:59:36 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH 0/3] Enable USB support in IPQ8074
Date:   Fri, 10 Apr 2020 23:59:29 +0530
Message-Id: <1586543372-13969-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has two super speed USB ports, with QMP and QUSB2 PHYs.
This patch set enables the USB PHYs and USB dwc3 in IPQ8074.

This patch set depends on Sandeep's QMP PHY binding patch
https://patchwork.ozlabs.org/patch/1265442/

Sivaprakash Murugesan (3):
  dt-bindings: phy: qcom,qmp: Add ipq8074 usb dt bindings
  phy: qcom-qmp: Add USB QMP PHY support for IPQ8074
  arm64: dts: ipq8074: enable USB support

 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   2 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |  24 +++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 168 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 102 +++++++++++++
 4 files changed, 296 insertions(+)

-- 
2.7.4

