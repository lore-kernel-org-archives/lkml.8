Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC906C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9195224D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SPKLTErp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgEVOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:24:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:14743 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729891AbgEVOYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:24:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590157472; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=izU/QtXyI63XKrg4KbliRHNn378C77H7JwT8dcC64NE=; b=SPKLTErprBWFrIKpGRcaRh6Z+3XTdZaIeqhErJ1IjEvdVbpM/6XgrLmxHV28BYt76uFYuRFK
 3Oc634wbYdYJu86qrSJDtqNzppcPglnMnqHdDa6RMoNqIUTYiJQaG2ddc8xs3z0K49/RlEoV
 41ac7HO28ZOxh4q1Wyfs5xi6j0w=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ec7e09e4110e14718aa588e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 14:24:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1838CC4339C; Fri, 22 May 2020 14:24:29 +0000 (UTC)
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1873C433C6;
        Fri, 22 May 2020 14:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1873C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
From:   Jishnu Prakash <jprakash@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, andy.shevchenko@gmail.com,
        amit.kucheria@verdurent.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: [PATCH V5 0/5] iio: adc: Add support for QCOM SPMI PMIC7 ADC
Date:   Fri, 22 May 2020 19:54:07 +0530
Message-Id: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes are made in V5:

Made some recommended minor changes in the third patch and
accordingly moved some return value check corrections From
fourth patch to third.

Cleaned up commit message of fifth patch.

Jishnu Prakash (5):
  iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format
  iio: adc: Add PMIC7 ADC bindings
  iio: adc: Add support for PMIC7 ADC
  iio: adc: Update debug prints
  iio: adc: Clean up ADC code common to PMIC5 and PMIC7

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 -------------
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 278 +++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   | 266 ++++++++++++++++++--
 drivers/iio/adc/qcom-vadc-common.c                 | 260 +++++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.h                 |  15 ++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    |  67 +++++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   |  88 +++++++
 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   |  46 ++++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   |  28 +++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   |  28 +++
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  78 +++++-
 11 files changed, 1131 insertions(+), 196 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
 create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

