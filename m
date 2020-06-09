Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE36CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AC720734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F0p8OK8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgFIU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:59:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15073 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbgFIU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:59:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591736343; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=beRbT9nazG0y9JQq1jhnco2lsPOiB7MB09hn5iNtxXg=; b=F0p8OK8q3UsMLuK+Bjyf/YwJcw6NiHxfvhVIZ5sY0WypfFzr9Vvb47nZf+znsmE9p22xzplG
 tP6sIzJgsqFLDhPnTxpv8ObiGPrF3ArdTMPHmGJupyiCytBJpGxlfSragWLZIK021Sfo5OVA
 3MYIkdv1PY30ptzMsGcc0PdRG+0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5edff811fe1db4db8952ee15 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 20:58:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83C9CC433CA; Tue,  9 Jun 2020 20:58:57 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3E5FC433CA;
        Tue,  9 Jun 2020 20:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3E5FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        mark.rutland@arm.com, robh+dt@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org, bryan.odonoghue@linaro.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH 0/3] Introduce PMIC based USB type C detection
Date:   Tue,  9 Jun 2020 13:58:48 -0700
Message-Id: <20200609205851.30113-1-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required drivers for implementing type C orientation and role
detection using the Qualcomm PMIC.  Currently, PMICs such as the PM8150B
have an integrated type C block, which can be utilized for this.  This
series adds the dt-binding, PMIC type C driver, and DTS nodes.

The PMIC type C driver will register itself as a type C port w/ a
registered type C switch for orientation, and will fetch a USB role switch
handle for the role notifications.  It will also have the ability to enable
the VBUS output to any connected devices based on if the device is behaving
as a UFP or DFP.

Wesley Cheng (3):
  usb: typec: Add QCOM PMIC typec detection driver
  dt-bindings: usb: Add Qualcomm PMIC type C controller dt-binding
  arm64: boot: dts: qcom: pm8150b: Add node for USB type C block

 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   | 118 +++++++++
 arch/arm64/boot/dts/qcom/pm8150b.dtsi              |   7 +
 drivers/usb/typec/Kconfig                          |  11 +
 drivers/usb/typec/Makefile                         |   1 +
 drivers/usb/typec/qcom-pmic-typec.c                | 278 +++++++++++++++++++++
 5 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
 create mode 100644 drivers/usb/typec/qcom-pmic-typec.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

