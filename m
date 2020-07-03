Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A81C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9042084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGCJJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:09:22 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57195 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCJJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:09:19 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jul 2020 05:09:15 EDT
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Jul 2020 02:03:15 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Jul 2020 02:03:13 -0700
Received: from gokulsri-linux.qualcomm.com ([10.201.2.207])
  by ironmsg02-blr.qualcomm.com with ESMTP; 03 Jul 2020 14:32:53 +0530
Received: by gokulsri-linux.qualcomm.com (Postfix, from userid 432570)
        id 8113E21691; Fri,  3 Jul 2020 14:32:52 +0530 (IST)
From:   Gokul Sriram Palanisamy <gokulsri@codeaurora.org>
To:     gokulsri@codeaurora.org, sboyd@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, ohad@wizery.com,
        robh+dt@kernel.org, sricharan@codeaurora.org,
        nprakash@codeaurora.org
Subject: [PATCH V6 00/10] remoteproc: qcom: q6v5-wcss: Add support for secure pil
Date:   Fri,  3 Jul 2020 14:32:42 +0530
Message-Id: <1593766972-29101-1-git-send-email-gokulsri@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 needs support for secure pil as well.
Also, currently only unified firmware is supported.
IPQ8074 supports split firmware for q6 and m3, so
adding support for that.

This series is based on Govind's
"[v7] Add non PAS wcss Q6 support for QCS404"

changes since v5:
 - Rebased on top of linux-5.8-rc3

changes since v4:
 - Rebased patch 8

changes since v3:
 - In patch 10, Added release_firmware to free up
   memory requested for m3 firmware.

changes since v2:
 - In patch 5, Added a driver data 'bcr_reset_required'
   to select if bcr reset is required
 - In patch 10, Removed syscon implementation and moved
   to mailbox framework to access APCS IPC

changes since v1:
 - In patch 10, Addressed minor review comments.

Gokul Sriram Palanisamy (10):
  remoteproc: qcom: Add PRNG proxy clock
  remoteproc: qcom: Add secure PIL support
  remoteproc: qcom: Add support for split q6 + m3 wlan firmware
  remoteproc: qcom: Add ssr subdevice identifier
  remoteproc: qcom: Update regmap offsets for halt register
  dt-bindings: clock: qcom: Add reset for WCSSAON
  clk: qcom: Add WCSSAON reset
  dt-bindings: firmware: qcom: Add compatible for IPQ8074 SoC
  arm64: dts: Add support for scm on IPQ8074 SoCs
  arm64: dts: qcom: Enable Q6v5 WCSS for ipq8074 SoC

 .../devicetree/bindings/firmware/qcom,scm.txt      |   1 +
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 127 +++++++++++++++++
 drivers/clk/qcom/gcc-ipq8074.c                     |   1 +
 drivers/remoteproc/qcom_q6v5_wcss.c                | 157 +++++++++++++++++----
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |   1 +
 5 files changed, 258 insertions(+), 29 deletions(-)

-- 
2.7.4

