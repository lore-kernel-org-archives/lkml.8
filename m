Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D8D20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PaA2G/Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbgDMUOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:14:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:13878 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733229AbgDMUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:14:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586808888; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dQ3ANcP/pX6ryr1N5RQms0oXAaxrTwW5UvzmiW5OdgQ=; b=PaA2G/Bro3zOdJuOkFOYn62Do+MMRG1WIvjtlhxN3FsAbQTjIrTuO1OUS5/jDtadUVYLZbms
 e6E1J1B5lVet4LzznxoxF8Q+NazXQYe1gGtaGXw+SQE66848z/Fjw/g1QcJkcvZK4eG3IsPp
 /Mbl4qL9njIpqJkUB8FHZpG8zMo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e94c82c.7f8e7509b650-smtp-out-n04;
 Mon, 13 Apr 2020 20:14:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D264C44788; Mon, 13 Apr 2020 20:14:35 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DF57C433F2;
        Mon, 13 Apr 2020 20:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DF57C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, vkoul@kernel.org, sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v7 0/5] Add SS/HS-USB changes for Qualcomm SM8150 chipset
Date:   Mon, 13 Apr 2020 13:14:21 -0700
Message-Id: <1586808866-21350-1-git-send-email-wcheng@codeaurora.org>
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

Changes in v7:
 - Use _relaxed() variants for writel/readl calls in
   phy-qcom-snps-femto-v2.c
 - Remove comments in the phy init function
 - Use devm_platform_ioremap_resource instead of devm_ioremap_resource
 - Fix chipset naming in Kconfig
 - Address minor fixups in the YAML file (remove status in example, fix
   "Hi-speed" to "High-speed", add a newline at the end)

Changes in v6:
 - Addressed coding style errors in phy-qcom-snps-femto-v2.c

Changes in v5:
 - Reorganize IF check for when to use the proper PWRDOWN CTRL offset
 - Rename UFS specific offset definitions in the QMP PHY driver to clearly
   denote they are UFS specific
 - Rename the phy-qcom-snps-7nm driver to phy-qcom-snps-femto-v2

Changes in v4:
 - Fix POWERDOWN offset for QMP PHY exit routine, and check for
   has_phy_dp_com_ctrl instead of !has_phy_com_ctrl

Changes in v3:
 - Use devm_reset_control_get_exclusive instead of referencing index for
   reset handle

Changes in v2:
 - Fixed YAML errors caught by dt_binding_check

Jack Pham (1):
  phy: qcom-qmp: Add SM8150 QMP USB3 PHY support

Wesley Cheng (4):
  dt-bindings: phy: Add binding for qcom,usb-snps-femto-v2
  phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
  phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
  phy: qcom-qmp: Rename UFS PCS QMP v4 registers

 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  77 ++++++
 drivers/phy/qualcomm/Kconfig                       |  10 +
 drivers/phy/qualcomm/Makefile                      |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 193 +++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 238 +++++++++++++++--
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 283 +++++++++++++++++++++
 6 files changed, 766 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
