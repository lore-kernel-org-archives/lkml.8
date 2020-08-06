Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA7C38153
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F35E23128
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgHFJhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:37:35 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:45388 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbgHFJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:32:32 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 Aug 2020 02:32:32 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Aug 2020 02:32:31 -0700
Received: from gokulsri-linux.qualcomm.com ([10.201.2.207])
  by ironmsg01-blr.qualcomm.com with ESMTP; 06 Aug 2020 15:02:13 +0530
Received: by gokulsri-linux.qualcomm.com (Postfix, from userid 432570)
        id A053D219DD; Thu,  6 Aug 2020 15:02:12 +0530 (IST)
From:   Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org, gokulsri@codeaurora.org
Subject: [PATCH v2 0/3] Add board support for HK10 board variants
Date:   Thu,  6 Aug 2020 15:02:09 +0530
Message-Id: <1596706332-12957-1-git-send-email-gokulsri@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for HK10-C1 and HK10-C2 board variants based on IPQ8074 SoC.
Both these variants support dual QCN9000 PCIe cards that uses MHI communication
protocol over PCIe. In addition, HK10-C1 support on-chip radio.
Both these variants slightly differ in clock configuation for ethernet.

This series depends on below series:
[V2,0/7] Add PCIe support for IPQ8074
[v7,0/9] remoteproc: qcom: q6v5-wcss: Add support for secure pil

Gokul Sriram Palanisamy (3):
  dt-bindings: qcom: Add ipq8074 bindings
  arm64: dts: Add board support for HK10
  arm64: dts: Enabled mhi device over PCIe

 Documentation/devicetree/bindings/arm/qcom.yaml |   4 +
 arch/arm64/boot/dts/qcom/Makefile               |   2 +
 arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts    |  11 ++
 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts    |  14 +++
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi      | 134 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi           |   8 ++
 6 files changed, 173 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi

-- 
2.7.4

