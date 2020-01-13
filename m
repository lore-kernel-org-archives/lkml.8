Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D75C33C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A472080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="N+Di7oJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMKEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:04:42 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51878 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728731AbgAMKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:04:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578909880; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2VLlvvePkhwbNWgY08l12MGTLHGCfKM0Z8oHlUQZfGY=; b=N+Di7oJCEzh55s6MoTvIHvmiV58DOHq9NAaVWiMsZUvTNm0FIq4QFLceWZw8nmtFMuNWahg4
 xb3RKZZ2si3HGjbog+Kj6dhLdj76DJaF/V+vG9/VPcedcm9xZDKmhduQ1dSn3N1E//dI2rML
 Pu4cYTPy0hHwjTTkr2q+bKgGv3k=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1c40b4.7fec150055a8-smtp-out-n01;
 Mon, 13 Jan 2020 10:04:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 247E0C447A2; Mon, 13 Jan 2020 10:04:35 +0000 (UTC)
Received: from [10.206.28.9] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 992C6C433CB;
        Mon, 13 Jan 2020 10:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 992C6C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 3/3] clk: qcom: Add modem clock controller driver for
 SC7180
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        linux-arm-msm-owner@vger.kernel.org
References: <1577421760-1174-1-git-send-email-tdas@codeaurora.org>
 <1577421760-1174-4-git-send-email-tdas@codeaurora.org>
 <7e63d3a91264e7c237c4cb10508182bf@codeaurora.org>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <af34688b-656c-d6df-982a-ec7708c4d228@codeaurora.org>
Date:   Mon, 13 Jan 2020 15:34:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <7e63d3a91264e7c237c4cb10508182bf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

Thanks for your review.

On 12/27/2019 12:50 PM, Sibi Sankar wrote:
> Hey Taniya,
> 

>>  static const struct qcom_reset_map gcc_sc7180_resets[] = {
>> diff --git a/drivers/clk/qcom/mss-sc7180.c 
>> b/drivers/clk/qcom/mss-sc7180.c
>> new file mode 100644
>> index 0000000..24c38dc
>> --- /dev/null
>> +++ b/drivers/clk/qcom/mss-sc7180.c
>> @@ -0,0 +1,94 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <dt-bindings/clock/qcom,mss-sc7180.h>
>> +
>> +#include "clk-regmap.h"
>> +#include "clk-branch.h"
>> +#include "common.h"
>> +
>> +static struct clk_branch mss_axi_nav_clk = {
>> +    .halt_reg = 0xbc,
> 
> if we use the entire mpss_perph
> reg space it should be 0x20bc
> instead.
> 
>> +    .halt_check = BRANCH_HALT,
>> +    .clkr = {
>> +        .enable_reg = 0xbc,
> 
> 0x20bc
> 

yes, will take care in the next patch.

>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "mss_axi_nav_clk",
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct clk_branch mss_axi_crypto_clk = {
>> +    .halt_reg = 0xcc,
> 
> if we use the entire mpss_perph
> reg space it should be 0x20cc
> instead.
> 
>> +    .halt_check = BRANCH_HALT,
>> +    .clkr = {
>> +        .enable_reg = 0xcc,
> 
> 0x20cc
> 

same as above.

>> +        .enable_mask = BIT(0),
>> +        .hw.init = &(struct clk_init_data){
>> +            .name = "mss_axi_crypto_clk",
>> +            .ops = &clk_branch2_ops,
>> +        },
>> +    },
>> +};
>> +
>> +static struct regmap_config mss_regmap_config = {
>> +    .reg_bits    = 32,
>> +    .reg_stride    = 4,
>> +    .val_bits    = 32,
>> +    .fast_io    = true,
>> +};
>> +
>> +static struct clk_regmap *mss_sc7180_clocks[] = {
>> +    [MSS_AXI_CRYPTO_CLK] = &mss_axi_crypto_clk.clkr,
>> +    [MSS_AXI_NAV_CLK] = &mss_axi_nav_clk.clkr,
>> +};
>> +
>> +static const struct qcom_cc_desc mss_sc7180_desc = {
>> +    .config = &mss_regmap_config,
>> +    .clks = mss_sc7180_clocks,
>> +    .num_clks = ARRAY_SIZE(mss_sc7180_clocks),
>> +};
>> +
>> +static int mss_sc7180_probe(struct platform_device *pdev)
>> +{
>> +    return qcom_cc_probe(pdev, &mss_sc7180_desc);
> 
> Similar to turingcc-qcs404 and q6sstop-qcs404
> shouldn't we model the iface clk dependency
> here since  both the above clocks cant be turned
> on/off without it.
> 

Could we skip and proceed with the above for now?

>> +}
>> +
>> +static const struct of_device_id mss_sc7180_match_table[] = {
>> +    { .compatible = "qcom,sc7180-mss" },
>> +    { }
>> +};
>> +MODULE_DEVICE_TABLE(of, mss_sc7180_match_table);
>> +
>> +static struct platform_driver mss_sc7180_driver = {
>> +    .probe        = mss_sc7180_probe,
>> +    .driver        = {
>> +        .name        = "sc7180-mss",
>> +        .of_match_table = mss_sc7180_match_table,
>> +    },
>> +};
>> +
>> +static int __init mss_sc7180_init(void)
>> +{
>> +    return platform_driver_register(&mss_sc7180_driver);
>> +}
>> +subsys_initcall(mss_sc7180_init);
>> +
>> +static void __exit mss_sc7180_exit(void)
>> +{
>> +    platform_driver_unregister(&mss_sc7180_driver);
>> +}
>> +module_exit(mss_sc7180_exit);
>> +
>> +MODULE_DESCRIPTION("QTI MSS SC7180 Driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
