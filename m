Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5A5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0825C2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="S4mKUHGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLXTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:19:55 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:10683 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgFLXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:19:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592003982; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=fE3heu7IHyIgsQESfgZjPzMFAyntiQh36ilt5hn1fXk=; b=S4mKUHGnqUiW1CA6DoWGi6re8eKHqtVLQ19EZAz4/aeu/qIIV8j+pcyT59RM63PwVWxerJGV
 VacNsRSnjyZJKU0lP7uX0AKcZJp/iBSf3SoGcevMHBvuHAAwkz1vfDhxBPGfr+eb14Bto7vX
 ofsoQb1rRzLvc1NmrRhScKR3q0U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ee40d7c3a8a8b20b84d91a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 23:19:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66020C433A0; Fri, 12 Jun 2020 23:19:24 +0000 (UTC)
Received: from wcheng-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECE73C433C8;
        Fri, 12 Jun 2020 23:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECE73C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wcheng@codeaurora.org
From:   Wesley Cheng <wcheng@codeaurora.org>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        broonie@kernel.org, lgirdwood@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        lijun.kernel@gmail.com, rdunlap@infradead.org,
        jackp@codeaurora.org, bryan.odonoghue@linaro.org,
        Wesley Cheng <wcheng@codeaurora.org>
Subject: [PATCH v2 0/6] Introduce PMIC based USB type C detection
Date:   Fri, 12 Jun 2020 16:19:12 -0700
Message-Id: <20200612231918.8001-1-wcheng@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Use devm_kzalloc() in qcom_pmic_typec_probe()
 - Add checks to make sure return value of typec_find_port_power_role() is
   valid
 - Added a VBUS output regulator driver, which will be used by the PMIC USB
   type c driver to enable/disable the source
 - Added logic to control vbus source from the PMIC type c driver when
   UFP/DFP is detected
 - Added dt-binding for this new regulator driver
 - Fixed Kconfig typec notation to match others
 - Leave type C block disabled until enabled by a platform DTS

Add the required drivers for implementing type C orientation and role
detection using the Qualcomm PMIC.  Currently, PMICs such as the PM8150B
have an integrated type C block, which can be utilized for this.  This
series adds the dt-binding, PMIC type C driver, and DTS nodes.

The PMIC type C driver will register itself as a type C port w/ a
registered type C switch for orientation, and will fetch a USB role switch
handle for the role notifications.  It will also have the ability to enable
the VBUS output to any connected devices based on if the device is behaving
as a UFP or DFP.

Wesley Cheng (6):
  usb: typec: Add QCOM PMIC typec detection driver
  dt-bindings: usb: Add Qualcomm PMIC type C controller dt-binding
  arm64: boot: dts: qcom: pm8150b: Add node for USB type C block
  regulator: Add support for QCOM PMIC VBUS booster
  dt-bindings: regulator: Add dt-binding for QCOM PMIC VBUS output
    regulator
  arm64: boot: dts: qcom: pm8150b: Add DTS node for PMIC VBUS booster

 .../regulator/qcom,usb-vbus-regulator.yaml    |  41 +++
 .../bindings/usb/qcom,pmic-typec.yaml         | 117 ++++++++
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |  13 +
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts       |   7 +
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/qcom_usb_vbus-regulator.c   | 147 ++++++++++
 drivers/usb/typec/Kconfig                     |  12 +
 drivers/usb/typec/Makefile                    |   1 +
 drivers/usb/typec/qcom-pmic-typec.c           | 275 ++++++++++++++++++
 10 files changed, 624 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,pmic-typec.yaml
 create mode 100644 drivers/regulator/qcom_usb_vbus-regulator.c
 create mode 100644 drivers/usb/typec/qcom-pmic-typec.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

