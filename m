Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B6C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C4206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDELaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:30:04 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:7406 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgDELaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:30:04 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Apr 2020 04:30:03 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg05-sd.qualcomm.com with ESMTP; 05 Apr 2020 04:29:59 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id C52C9215F4; Sun,  5 Apr 2020 16:59:57 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sivaprak@codeaurora.org
Subject: [PATCH V2 0/8] Add APSS clock controller support for IPQ6018
Date:   Sun,  5 Apr 2020 16:59:17 +0530
Message-Id: <1586086165-19426-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU on Qualcomm's IPQ6018 devices are primarily fed by A53 PLL and XO,
these are connected to a clock mux and enable block.

This patch series adds support for these clocks and inturn enables
clocks required for CPU freq.

[V2]
 * Restructred the patch series as there are two different HW blocks,
   the mux and enable belongs to the apcs block and PLL has a separate HW
   block.
 * Converted qcom mailbox and qcom a53 pll documentation to yaml.
 * Addressed review comments from Stephen, Rob and Sibi where it is applicable.
 * Changed this cover letter to state the purpose of this patch series

Sivaprakash Murugesan (8):
  dt-bindings: mailbox: Add YAML schemas for QCOM APCS global block
  dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
  clk: qcom: Add A53 PLL support for ipq6018 devices
  clk: qcom: Add DT bindings for ipq6018 apss clock controller
  clk: qcom: Add ipq apss clock controller
  dt-bindings: mailbox: Add dt-bindings for ipq6018 apcs global block
  mailbox: qcom: Add ipq6018 apcs compatible
  arm64: dts: ipq6018: Add a53 pll and apcs clock

 .../devicetree/bindings/clock/qcom,a53pll.txt      |  22 ----
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |  60 +++++++++
 .../bindings/mailbox/qcom,apcs-kpss-global.txt     |  88 -------------
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    | 101 +++++++++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  16 ++-
 drivers/clk/qcom/Kconfig                           |  10 ++
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/a53-pll.c                         | 136 +++++++++++++++++----
 drivers/clk/qcom/apss-ipq.c                        | 107 ++++++++++++++++
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  22 ++--
 include/dt-bindings/clock/qcom,apss-ipq.h          |  12 ++
 11 files changed, 430 insertions(+), 145 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
 create mode 100644 drivers/clk/qcom/apss-ipq.c
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq.h

-- 
2.7.4

