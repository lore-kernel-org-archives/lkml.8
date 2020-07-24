Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F4C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA79020714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGXD6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:58:51 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:25514 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgGXD6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:58:48 -0400
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Jul 2020 20:58:47 -0700
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jul 2020 20:58:46 -0700
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 24 Jul 2020 09:28:21 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id D84F74272; Fri, 24 Jul 2020 09:28:19 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        satya priya <skakit@codeaurora.org>
Subject: [PATCH V2 0/3]  Add wakeup support over UART RX
Date:   Fri, 24 Jul 2020 09:27:59 +0530
Message-Id: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V2:
 - As per Matthias's comment added wakeup support for all the UARTs
   of SC7180.
 - Added sleep state in sc7180-idp.dts file.
 - Modify the if check in set_mctrl API in serial driver to avoid
   making RFR high during suspend.

Hi Greg,

These patches are based on qcom tree. Please ack the serial driver
patch to land via qcom-tree.

Thanks,
Satya Priya

satya priya (3):
  arm64: dts: sc7180: Add wakeup support over UART RX
  arm64: dts: qcom: sc7180: Add sleep pin ctrl for BT uart
  tty: serial: qcom_geni_serial: Fix the UART wakeup issue

 arch/arm64/boot/dts/qcom/sc7180-idp.dts | 42 ++++++++++++--
 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 98 ++++++++++++++++++++++++++++-----
 drivers/tty/serial/qcom_geni_serial.c   |  2 +-
 3 files changed, 121 insertions(+), 21 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

