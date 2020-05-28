Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6032078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PLg6Bulq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405220AbgE1Qyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:54:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56434 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405170AbgE1Qys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:54:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684888; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PuV4XxaODNNsGmwJmsdqjbs43srMyt9aYqHZbXeCHC0=; b=PLg6Bulq1PTR3Gj6l3o42ahYs/hpjKOpa40rY2Kqdo1E/zQvXKa6LCzt6NlOqzIoiIISfw+A
 COgKwPttlC0joVZKrp21KaXaZX09xnAmICpD49e0CYhHUWh9Qh6+j90P8WygOacLH8Uy7b1F
 /ZfeUL8VECM+sAgOj4bR1kX+GBU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ecfecd62c549984753a8387 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:54:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4946DC433A1; Thu, 28 May 2020 16:54:45 +0000 (UTC)
Received: from jprakash-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 089F7C433C9;
        Thu, 28 May 2020 16:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 089F7C433C9
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
Subject: [PATCH V6 0/7] iio: adc: Add support for QCOM SPMI PMIC7 ADC
Date:   Thu, 28 May 2020 22:24:22 +0530
Message-Id: <1590684869-15400-1-git-send-email-jprakash@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes are made in V6:

The third patch is now the change to add iio_info under adc_data,
split out from fifth patch of V5.

The fourth patch is the change to add support for PMIC7 ADC, same
as third patch from V5 with the following differences:
Return value corrections are split out into the next patch.
Add PMIC7 ADC info changes directly rather than in later patch.
Made some other recommended changes.

The fifth patch has corrections for return values, split out from
previous patch.

The sixth patch is for updating debug prints, same as fourth patch
of V5.

The sixth patch is to add a common function used for read_raw callback
for both PMIC5 and PMIC7 ADC. Its the same change included in fifth
patch of V5, except that ADC exit function is removed and info change
is split out to third patch now.

Jishnu Prakash (7):
  iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format
  iio: adc: Add PMIC7 ADC bindings
  iio: adc: Add info property under adc_data
  iio: adc: Add support for PMIC7 ADC
  iio: adc: Update return value checks
  iio: adc: Update debug prints
  iio: adc: Combine read functions for PMIC5 and PMIC7

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 173 -------------
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 278 +++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   | 250 ++++++++++++++++--
 drivers/iio/adc/qcom-vadc-common.c                 | 262 +++++++++++++++++++
 drivers/iio/adc/qcom-vadc-common.h                 |  15 ++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    |  67 +++++
 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   |  88 +++++++
 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   |  46 ++++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   |  28 +++
 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   |  28 +++
 include/dt-bindings/iio/qcom,spmi-vadc.h           |  78 +++++-
 11 files changed, 1117 insertions(+), 196 deletions(-)
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

