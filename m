Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799BCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53499206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="hZPqkhIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEDGKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 02:10:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11133 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726743AbgEDGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 02:10:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588572646; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: To:
 Subject: Sender; bh=OM7vAdA5EUcwkvHdBUkp6F45UBPb44v8PjbZaSt6pV0=; b=hZPqkhItRO994MPoIaqIKptTB8jZJC3wS9/sP2mrBqh4h5pVlRKDfuQ0z9jLN9V2FHZlLnzS
 DPPyjwQtWBmnPtEtKPI8y9EAJ9xopA9kGL7HVami7W4ogz+Xgr6TUHJNpmAy90biEugX8zz6
 IK9g2gsmdvmnE45XMdzBU/RgYQc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eafb1e3.7f5ff85f9c00-smtp-out-n02;
 Mon, 04 May 2020 06:10:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1B774C433BA; Mon,  4 May 2020 06:10:43 +0000 (UTC)
Received: from [192.168.0.105] (unknown [49.206.125.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sivaprak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83F0DC433D2;
        Mon,  4 May 2020 06:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83F0DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sivaprak@codeaurora.org
Subject: Re: [PATCH V3 5/8] clk: qcom: Add ipq apss clock controller
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org
References: <1586832922-29191-1-git-send-email-sivaprak@codeaurora.org>
 <1586832922-29191-6-git-send-email-sivaprak@codeaurora.org>
 <158754626202.132238.18279860573775399302@swboyd.mtv.corp.google.com>
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
Message-ID: <203cc044-5854-3fb9-6681-a685bc50821a@codeaurora.org>
Date:   Mon, 4 May 2020 11:40:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158754626202.132238.18279860573775399302@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 4/22/2020 2:34 PM, Stephen Boyd wrote:
> Quoting Sivaprakash Murugesan (2020-04-13 19:55:19)
>> The CPU on Qualcomm's IPQ platform devices are clocked primarily by a
>> PLL and xo which are connected to a mux and enable block, This patch adds
> The comma should be a period? Don't write "This patch" in commit text.
ok.
>
>> support for the mux and the enable.
>>
>> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
>> ---
>>   drivers/clk/qcom/Kconfig    |  10 +++++
>>   drivers/clk/qcom/Makefile   |   1 +
>>   drivers/clk/qcom/apss-ipq.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 118 insertions(+)
>>   create mode 100644 drivers/clk/qcom/apss-ipq.c
>>
>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
>> index 15cdcdc..8573f2e 100644
>> --- a/drivers/clk/qcom/Kconfig
>> +++ b/drivers/clk/qcom/Kconfig
>> @@ -89,6 +89,16 @@ config APQ_MMCC_8084
>>            Say Y if you want to support multimedia devices such as display,
>>            graphics, video encode/decode, camera, etc.
>>   
>> +config IPQ_APSS
>> +       tristate "IPQ APSS Clock Controller"
>> +       default N
> Drop this, it's already the default.
ok
>
>> +       help
>> +         Support for APSS clock controller on ipq platform devices. The
> Maybe say "IPQ platforms" and drop the devices part?
ok
>
>> +         APSS clock controller manages the Mux and enable block that feeds the
>> +         CPUs.
>> +         Say Y if you want to support CPU frequency scaling on
>> +         ipq based devices.
>> +
>>   config IPQ_GCC_4019
>>          tristate "IPQ4019 Global Clock Controller"
>>          help
>> diff --git a/drivers/clk/qcom/apss-ipq.c b/drivers/clk/qcom/apss-ipq.c
>> new file mode 100644
>> index 0000000..a37cd98
>> --- /dev/null
>> +++ b/drivers/clk/qcom/apss-ipq.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/regmap.h>
>> +#include <linux/module.h>
>> +
>> +#include <dt-bindings/clock/qcom,apss-ipq.h>
>> +
>> +#include "common.h"
>> +#include "clk-regmap.h"
>> +#include "clk-branch.h"
>> +#include "clk-alpha-pll.h"
>> +#include "clk-regmap-mux.h"
>> +
>> +enum {
>> +       P_XO,
>> +       P_APSS_PLL_EARLY,
>> +};
>> +
>> +static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
>> +       { .fw_name = "xo" },
>> +       { .fw_name = "pll" },
>> +};
>> +
>> +static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
>> +       { P_XO, 0 },
>> +       { P_APSS_PLL_EARLY, 5 },
>> +};
>> +
>> +static struct clk_regmap_mux apcs_alias0_clk_src = {
>> +       .reg = 0x0050,
>> +       .width = 3,
>> +       .shift = 7,
>> +       .parent_map = parents_apcs_alias0_clk_src_map,
>> +       .clkr.hw.init = &(struct clk_init_data){
>> +               .name = "apcs_alias0_clk_src",
>> +               .parent_data = parents_apcs_alias0_clk_src,
>> +               .num_parents = 2,
>> +               .ops = &clk_regmap_mux_closest_ops,
>> +               .flags = CLK_SET_RATE_PARENT,
>> +       },
>> +};
>> +
>> +/*required for cpufreq*/
> This comment doesn't help in understanding.
Just realized that it need not be critical. will remove it in next patch.
>
>> +static struct clk_branch apcs_alias0_core_clk = {
>> +       .halt_reg = 0x0058,
>> +       .clkr = {
>> +               .enable_reg = 0x0058,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "apcs_alias0_core_clk",
>> +                       .parent_hws = (const struct clk_hw *[]){
>> +                               &apcs_alias0_clk_src.clkr.hw },
>> +                       .num_parents = 1,
>> +                       .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> Please comment why the clk is critical.
>
>> +                       .ops = &clk_branch2_ops,
>> +               },
>> +       },
>> +};
>> +
>> +static const struct regmap_config apss_ipq_regmap_config = {
>> +       .reg_bits       = 32,
>> +       .reg_stride     = 4,
>> +       .val_bits       = 32,
>> +       .max_register   = 0x1000,
>> +       .fast_io        = true,
>> +};
>> +
>> +static struct clk_regmap *apss_ipq_clks[] = {
>> +       [APCS_ALIAS0_CLK_SRC] = &apcs_alias0_clk_src.clkr,
>> +       [APCS_ALIAS0_CORE_CLK] = &apcs_alias0_core_clk.clkr,
>> +};
>> +
>> +static const struct qcom_cc_desc apss_ipq_desc = {
>> +       .config = &apss_ipq_regmap_config,
>> +       .clks = apss_ipq_clks,
>> +       .num_clks = ARRAY_SIZE(apss_ipq_clks),
>> +};
>> +
>> +static int apss_ipq_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +
>> +       regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       return qcom_cc_really_probe(pdev, &apss_ipq_desc, regmap);
> What is this a child of?
this is child of qcom apcs mailbox driver. will add compilation 
dependency on next patch.
