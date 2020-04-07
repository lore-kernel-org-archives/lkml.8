Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC3FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039C920747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ba1Ju2Pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDGWYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:24:08 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37732 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbgDGWYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586298240; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zb9gBubLqpCRCY9HKdRqpmX1NGtX4V5sdNkRDWjR9R0=; b=Ba1Ju2PteoEnYCgtaWM4BpRD6ZvqiFUf5pU2VBXrwWZOm1iuhseNI87wyBPsg5EcTC4dSyLz
 VoesmT+MGmgWgW5k47XXy5AcY0c6Gw3vJY7wjhfyfKSNuaj/EZQ5LzGAqGMwcI05gQPf6VlW
 mYbPcAS8Sa+mUmcYQ7aWmNXwTOY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8cfd6a.7f90da0bbce0-smtp-out-n05;
 Tue, 07 Apr 2020 22:23:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55505C43637; Tue,  7 Apr 2020 22:23:38 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5246BC433F2;
        Tue,  7 Apr 2020 22:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5246BC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        vinod.koul@linaro.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v3 0/4] Add SS/HS-USB changes for Qualcomm SM8150 chipset
Date:   Tue,  7 Apr 2020 15:23:25 -0700
Message-Id: <1586298209-4589-1-git-send-email-wcheng@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Synopsis 7nm HSPHY USB driver being
used in QCOM chipsets.  The HSPHY register map differs compared to 
other PHY revisions.  In addition, modifications and updates are done
to the QMP driver to add new registers/offsets, and to update the
initialization sequence for enabling the SSUSB path on SM8150.

Changes in v3:
 - Use devm_reset_control_get_exclusive instead of referencing index for
   reset handle

Changes in v2:
 - Fixed YAML errors caught by dt_binding_check

Jack Pham (1):
  phy: qcom-qmp: Add SM8150 QMP USB3 PHY support

Wesley Cheng (3):
  dt-bindings: phy: Add binding for qcom,usb-hs-7nm
  phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
  phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB

 .../devicetree/bindings/phy/qcom,usb-hs-7nm.yaml   |  76 ++++++
 drivers/phy/qualcomm/Kconfig                       |  10 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 157 +++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 198 +++++++++++++-
 drivers/phy/qualcomm/phy-qcom-snps-7nm.c           | 294 +++++++++++++++++++++
 6 files changed, 734 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-7nm.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-7nm.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
