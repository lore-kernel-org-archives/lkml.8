Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAB4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FC520873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgBNIZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:25:50 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:45291 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728859AbgBNIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:25:45 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Feb 2020 13:55:34 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 14 Feb 2020 13:55:05 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id 6474F25BF; Fri, 14 Feb 2020 13:55:04 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v5 0/3] ADD interconnect support for Qualcomm DWC3 driver
Date:   Fri, 14 Feb 2020 13:54:41 +0530
Message-Id: <1581668684-4182-1-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path series aims to add interconnect support in
dwc3-qcom driver on SDM845 SoCs.

Changes from v4 -> v5
  > [PATCH 1/3] Added the interconnect properties in yaml. This patch depends
    on series https://patchwork.kernel.org/cover/11372641/.
  > [PATCH 2/3] Fixed review comments from Matthias in DWC3 driver.
  > [PATCH 3/3] Modified as per the new interconnect nodes in sdm845. Depends
    on series https://patchwork.kernel.org/cover/11372211/. 


Changes from v3 -> v4
  > Fixed review comments from Matthias
  > [PATCH 1/3] and [PATCH 3/3] remains unchanged

Changes from v2 -> v3
  > Fixed review comments from Matthias and Manu
  > changed the functions prefix from usb_* to dwc3_qcom_*

Changes since V1:
  > Comments by Georgi Djakov on "[PATCH 2/3]" addressed
  > [PATCH 1/3] and [PATCH 3/3] remains unchanged

Sandeep Maheswaram (3):
  dt-bindings: usb: qcom,dwc3: Introduce interconnect properties for
    Qualcomm DWC3 driver
  usb: dwc3: qcom: Add interconnect support in dwc3 driver
  arm64: dts: sdm845: Add interconnect properties for USB

 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  16 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  12 ++
 drivers/usb/dwc3/dwc3-qcom.c                       | 135 ++++++++++++++++++++-
 3 files changed, 161 insertions(+), 2 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

