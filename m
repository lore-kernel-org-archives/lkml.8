Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904ABC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6360820CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YPEuteTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387701AbgCDDfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:35:38 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:42328 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387644AbgCDDfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:35:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583292936; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=VPX3a9LCupJ35BN0U2GtWqoO28bTvTPURVjAj6k8B0o=; b=YPEuteTr94yDDwunrsjj46DABpcsiauZv5o4Sw0w+zKHb10WhydIMU1NmjbJxHcFgqWiOjok
 1zwS3IHP4msi/JWQA3jKpMn6vsgrPvv4QY89y6WW0BICxIuWZIvwr206e4ct/8ltpUcaXgpU
 tGQYUVj5huUID9/Q6G4jHf/9lEM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5f21ff.7fe9c0657e30-smtp-out-n02;
 Wed, 04 Mar 2020 03:35:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98BB7C4479F; Wed,  4 Mar 2020 03:35:27 +0000 (UTC)
Received: from [10.206.28.9] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF16CC43383;
        Wed,  4 Mar 2020 03:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF16CC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 2/2] clk: qcom: dispcc: Remove support of
 disp_cc_mdss_rscc_ahb_clk
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Doug Anderson <dianders@chromium.org>
References: <1581423236-21341-1-git-send-email-tdas@codeaurora.org>
 <1581423236-21341-2-git-send-email-tdas@codeaurora.org>
 <20200303201629.GP24720@google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <f0529793-c51d-4baf-5217-173c552f4cbe@codeaurora.org>
Date:   Wed, 4 Mar 2020 09:05:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303201629.GP24720@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2020 1:46 AM, Matthias Kaehlcke wrote:
> On Tue, Feb 11, 2020 at 05:43:56PM +0530, Taniya Das wrote:
>> The disp_cc_mdss_rscc_ahb_clk is default enabled from hardware and thus
>> does not require to be marked CRITICAL. This which would allow the RCG to
>> be turned OFF when the display turns OFF and not blocking XO.
>>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/clk/qcom/dispcc-sc7180.c | 19 -------------------
>>   1 file changed, 19 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/dispcc-sc7180.c b/drivers/clk/qcom/dispcc-sc7180.c
>> index dd7af41..0a5d395 100644
>> --- a/drivers/clk/qcom/dispcc-sc7180.c
>> +++ b/drivers/clk/qcom/dispcc-sc7180.c
>> @@ -592,24 +592,6 @@ static struct clk_branch disp_cc_mdss_rot_clk = {
>>   	},
>>   };
>>
>> -static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
>> -	.halt_reg = 0x400c,
>> -	.halt_check = BRANCH_HALT,
>> -	.clkr = {
>> -		.enable_reg = 0x400c,
>> -		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data){
>> -			.name = "disp_cc_mdss_rscc_ahb_clk",
>> -			.parent_data = &(const struct clk_parent_data){
>> -				.hw = &disp_cc_mdss_ahb_clk_src.clkr.hw,
>> -			},
>> -			.num_parents = 1,
>> -			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
>> -			.ops = &clk_branch2_ops,
>> -		},
>> -	},
>> -};
>> -
>>   static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
>>   	.halt_reg = 0x4008,
>>   	.halt_check = BRANCH_HALT,
>> @@ -687,7 +669,6 @@ static struct clk_regmap *disp_cc_sc7180_clocks[] = {
>>   	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
>>   	[DISP_CC_MDSS_ROT_CLK] = &disp_cc_mdss_rot_clk.clkr,
>>   	[DISP_CC_MDSS_ROT_CLK_SRC] = &disp_cc_mdss_rot_clk_src.clkr,
>> -	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
>>   	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
>>   	[DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
>>   	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
> 
> We found that this change leads to a panic at boot time on SC7180 devices
> without display configuration (e.g. the SC7180 IDP with the current DT):
> 
> [    2.412820] SError Interrupt on CPU6, code 0xbe000411 -- SError
> [    2.412822] CPU: 6 PID: 1 Comm: swapper/0 Tainted: G S                5.4.22 #103
> [    2.412822] Hardware name: Qualcomm Technologies, Inc. SC7180 IDP (DT)
> [    2.412823] pstate: 20c00089 (nzCv daIf +PAN +UAO)
> [    2.412823] pc : regmap_mmio_read32le+0x28/0x40
> [    2.412823] lr : regmap_mmio_read+0x44/0x6c
> [    2.412824] sp : ffffffc01005ba90
> [    2.412824] x29: ffffffc01005ba90 x28: 0000000000000000
> [    2.412825] x27: 0000000000000000 x26: 0000000000000000
> [    2.412826] x25: 0000000000000000 x24: ffffffd1f4aed018
> [    2.412827] x23: ffffffd1f4c12148 x22: ffffff8177a6c800
> [    2.412827] x21: 0000000000002048 x20: ffffff8177489e00
> [    2.412828] x19: 0000000000002048 x18: 000000004a746f4b
> [    2.412829] x17: 00000000d0e09034 x16: 000000005079b450
> [    2.412830] x15: 000000003e3bf7ed x14: 0000000000007fff
> [    2.412830] x13: ffffff8177309b40 x12: 0000000000000000
> [    2.412831] x11: 0000000000000000 x10: 0000000000000000
> [    2.412831] x9 : 0000000000000001 x8 : ffffffc011c02048
> [    2.412832] x7 : aaaaaaaaaaaaaaaa x6 : 0000000000000000
> [    2.412833] x5 : 0000000000000000 x4 : 0000000000000000
> [    2.412834] x3 : 0000000000000000 x2 : ffffffc01005bb84
> [    2.412834] x1 : 0000000000002048 x0 : 0000000080000000
> [    2.412835] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    2.412836] CPU: 6 PID: 1 Comm: swapper/0 Tainted: G S                5.4.22 #103
> [    2.412836] Hardware name: Qualcomm Technologies, Inc. SC7180 IDP (DT)
> [    2.412836] Call trace:
> [    2.412837]  dump_backtrace+0x0/0x150
> [    2.412837]  show_stack+0x20/0x2c
> [    2.412837]  dump_stack+0xa0/0xd8
> [    2.412838]  panic+0x158/0x360
> [    2.412838]  panic+0x0/0x360
> [    2.412838]  arm64_serror_panic+0x78/0x84
> [    2.412839]  do_serror+0x110/0x118
> [    2.412839]  el1_error+0x84/0xf8
> [    2.412839]  regmap_mmio_read32le+0x28/0x40
> [    2.412840]  regmap_mmio_read+0x44/0x6c
> [    2.412840]  _regmap_bus_reg_read+0x34/0x44
> [    2.412841]  _regmap_read+0x88/0x164
> [    2.412841]  regmap_read+0x54/0x78
> [    2.412841]  clk_is_enabled_regmap+0x3c/0x8c
> [    2.412842]  clk_core_is_enabled+0x68/0xac
> [    2.412842]  clk_disable_unused_subtree+0x90/0x22c
> [    2.412843]  clk_disable_unused_subtree+0x34/0x22c
> [    2.412843]  clk_disable_unused+0x74/0x108
> [    2.412843]  do_one_initcall+0x13c/0x2c8
> [    2.412844]  do_initcall_level+0x144/0x16c
> [    2.412844]  do_basic_setup+0x30/0x48
> [    2.412844]  kernel_init_freeable+0xc4/0x140
> [    2.412845]  kernel_init+0x14/0x100
> [    2.412845]  ret_from_fork+0x10/0x18
> [    2.412858] SMP: stopping secondary CPUs
> [    2.412859] Kernel Offset: 0x11e3a00000 from 0xffffffc010000000
> [    2.412859] PHYS_OFFSET: 0xffffffe780000000
> [    2.412860] CPU features: 0x0006,2a80aa18
> [    2.412860] Memory Limit: none
> 

Hi Matthias,

The display device node is not present and we encounter this crash, 
would it be possible to add ALWAYS_ON for the MDSS GDSC and give it a try.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
