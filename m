Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA47C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641152074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fZGxoK9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgGaE5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:57:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:38943 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbgGaE5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:57:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596171442; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=jcFirJ/dUhDWyz1vByGCswLs5dDzUqVUvnRcpcUgCac=; b=fZGxoK9BOrkU4NJufoG0uM/5136tYk4rxrgXhx0TDYDu9xFCfoMX/LrzcglS55Hyxuo3xdwL
 2/w1eKmqInTOLjQutjm1r54AcAhiEW6zREYjER6BbkMpa7BaxVd908V6NuSzoA7ESS1UsuGh
 YBj8Tw5gGobHMI99skMcKjQBjNo=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f23a4ad9403087e1060546e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 31 Jul 2020 04:57:17
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B3891C43395; Fri, 31 Jul 2020 04:57:16 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A93F2C433C9;
        Fri, 31 Jul 2020 04:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A93F2C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     bjorn.andersson@linaro.org, kishon@ti.com, vkoul@kernel.org,
        agross@kernel.org, balbi@kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 0/3] Enable USB type C support on SM8150
Date:   Thu, 30 Jul 2020 21:57:09 -0700
Message-Id: <20200731045712.28495-1-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for setting of the orientation multiplexor within the
QMP PHY based on the detection output from the PM8150B.  It will also introduce
a role switch in DWC3 QCOM, which is used so that the DWC3 QCOM glue can receive
role switch change events, and set the vbus override accordingly.  This event
will then be propagated down to the DWC3 core driver, by the DWC3 QCOM getting a
handle to the DWC3 core's role switch.

Wesley Cheng (3):
  arm64: boot: dts: qcom: sm8150: Add nodes for PMIC based typec
    detection
  phy: qcom-qmp: Register as a typec switch for orientation detection
  usb: dwc3: dwc3-qcom: Find USB connector and register role switch

 arch/arm64/boot/dts/qcom/sm8150-mtp.dts |  37 ++++++++-
 drivers/phy/qualcomm/Kconfig            |  11 +++
 drivers/phy/qualcomm/phy-qcom-qmp.c     |  71 +++++++++++++++-
 drivers/usb/dwc3/dwc3-qcom.c            | 103 +++++++++++++++++++++++-
 4 files changed, 216 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

