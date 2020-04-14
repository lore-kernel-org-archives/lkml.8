Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E5120644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404335AbgDNC5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:57:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:51904 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404224AbgDNCzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:55:31 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2020 19:55:29 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 13 Apr 2020 19:55:25 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 0145421634; Tue, 14 Apr 2020 08:25:23 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Subject: [PATCH V3 0/8] Add APSS clock controller support for IPQ6018
Date:   Tue, 14 Apr 2020 08:25:14 +0530
Message-Id: <1586832922-29191-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU on Qualcomm's IPQ6018 devices are primarily fed by A53 PLL and XO,
these are connected to a clock mux and enable block.

This patch series adds support for these clocks and inturn enables clocks
required for CPU freq.

[V3]
 * Fixed dt binding check error in patch2
   dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
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

