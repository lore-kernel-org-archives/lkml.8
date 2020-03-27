Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF327C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F1206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 19:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="phgKOWmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgC0Tsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:48:38 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49043 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbgC0Tsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 15:48:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585338516; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0fqTY0l0+n8WhQXdA6uQEsshpvosH4QlcVJn+mbYH6Q=; b=phgKOWmBtg57tor/53EobbxFo+nQ2AQZpzPFrBD9bG38QrKQcpb3rEeEnGF+6HuYCELkGGXb
 k+9FhjEL4OUXlylJuUUzC11FM6okL6gt3b5CDeyVjJTGs5LoFtj08H9aOCO/Va7xrRCRvOWw
 U4Te/SDMlX1Z70O2Yn2fOI1s8Go=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7e5883.7f98046e2228-smtp-out-n01;
 Fri, 27 Mar 2020 19:48:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28B8AC44788; Fri, 27 Mar 2020 19:48:19 +0000 (UTC)
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 098F2C433D2;
        Fri, 27 Mar 2020 19:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 098F2C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 0/4] clk: qcom: Support for Low Power Audio Clocks on SC7180
Date:   Sat, 28 Mar 2020 01:18:01 +0530
Message-Id: <1585338485-31820-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v1]
 * Add support for Retention of GDSCR.
 * Add YAML schema for LPASS clocks and clock IDs for LPASS.
 * Add clock driver for LPASS core clocks and GCC LPASS clock.

Taniya Das (4):
  clk: qcom: gdsc: Add support to enable retention of GSDCR
  dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7180
  clk: qcom: gcc: Add support for GCC LPASS clock for SC7180
  clk: qcom: lpass: Add support for LPASS clock controller for SC7180

 .../bindings/clock/qcom,sc7180-lpasscorecc.yaml    |  81 ++++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/gcc-sc7180.c                      |  14 +
 drivers/clk/qcom/gdsc.c                            |  12 +
 drivers/clk/qcom/gdsc.h                            |   1 +
 drivers/clk/qcom/lpasscorecc-sc7180.c              | 479 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sc7180.h        |   1 +
 .../dt-bindings/clock/qcom,lpasscorecc-sc7180.h    |  28 ++
 9 files changed, 626 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
 create mode 100644 drivers/clk/qcom/lpasscorecc-sc7180.c
 create mode 100644 include/dt-bindings/clock/qcom,lpasscorecc-sc7180.h

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
