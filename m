Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55453206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgEUPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:39:36 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:54256 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgEUPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:39:36 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 May 2020 21:08:52 +0530
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 May 2020 21:08:27 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id 1C2262A34; Thu, 21 May 2020 21:08:26 +0530 (IST)
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
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v7 0/2] Add USB DWC3 support for SC7180
Date:   Thu, 21 May 2020 21:08:17 +0530
Message-Id: <1590075499-21350-1-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting dt binding to yaml.
Adding compatible for SC7180 in dt bindings.

Changes in v7:
Solved the dt binding check error by adding soc field in example.

Changes in v6:
Addressed the comments from Stephen on interrupts.
Added ranges property and dropped maxItems field for assigned-clock-rates.

Changes in v5:
Addressed the comments from Stephen in yaml file.

Changes in v4:
Addressed the comments from Doug in yaml file.

Changes in v3:
Dropped the patch for adding the compatible in dwc3 driver from the series.
Addressed the comments from Doug in yaml file.

Changes in v2:
Sorted the compatible in dwc3 driver.
Converted dt binding to yaml.
Added compatible in yaml.

Sandeep Maheswaram (2):
  dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
  dt-bindings: usb: qcom,dwc3: Add compatible for SC7180

 .../devicetree/bindings/usb/qcom,dwc3.txt          | 104 -------------
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 168 +++++++++++++++++++++
 2 files changed, 168 insertions(+), 104 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/qcom,dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

