Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F2C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE372070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 03:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F3aIch1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgA2DVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 22:21:31 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:27083 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbgA2DVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:21:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580268090; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HrSDgQIqdWgPV8GnbJ6bzIKE7KqkErsk59LR031H5P4=; b=F3aIch1X1x3E+H1yuWvHE74M3+EXK1LpRass3KvmACutByOFjVLIxWsXtt1KE8F4PonsJLBI
 H7X50PWJNLwbyMVj0on6z97E5lT6GF3rSiyXQbQGyOcTPmUlYLv0e7k57Q0zpqZJClRMu64v
 Q2xOcMBiJfLZa2J2Pak5RTgOq28=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30fa34.7f63b3dcc538-smtp-out-n03;
 Wed, 29 Jan 2020 03:21:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFC87C4479C; Wed, 29 Jan 2020 03:21:23 +0000 (UTC)
Received: from [10.131.117.127] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAE6AC43383;
        Wed, 29 Jan 2020 03:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAE6AC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH] clk: qcom: Don't overwrite 'cfg' in
 clk_rcg2_dfs_populate_freq()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20200128193329.45635-1-sboyd@kernel.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <3b8acaa8-8bc4-cc7f-51d1-2a1b4ff5374a@codeaurora.org>
Date:   Wed, 29 Jan 2020 08:51:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128193329.45635-1-sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/2020 1:03 AM, Stephen Boyd wrote:
> The DFS frequency table logic overwrites 'cfg' while detecting the
> parent clk and then later on in clk_rcg2_dfs_populate_freq() we use that
> same variable to figure out the mode of the clk, either MND or not. Add
> a new variable to hold the parent clk bit so that 'cfg' is left
> untouched for use later.
> 
> This fixes problems in detecting the supported frequencies for any clks
> in DFS mode.
> 
> Fixes: cc4f6944d0e3 ("clk: qcom: Add support for RCG to register for DFS")
> Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>

>   drivers/clk/qcom/clk-rcg2.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index da045b200def..973ecf4f6bc5 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -953,7 +953,7 @@ static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>   	struct clk_hw *p;
>   	unsigned long prate = 0;
> -	u32 val, mask, cfg, mode;
> +	u32 val, mask, cfg, mode, src;
>   	int i, num_parents;
>   
>   	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(l), &cfg);
> @@ -963,12 +963,12 @@ static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
>   	if (cfg & mask)
>   		f->pre_div = cfg & mask;
>   
> -	cfg &= CFG_SRC_SEL_MASK;
> -	cfg >>= CFG_SRC_SEL_SHIFT;
> +	src = cfg & CFG_SRC_SEL_MASK;
> +	src >>= CFG_SRC_SEL_SHIFT;
>   
>   	num_parents = clk_hw_get_num_parents(hw);
>   	for (i = 0; i < num_parents; i++) {
> -		if (cfg == rcg->parent_map[i].cfg) {
> +		if (src == rcg->parent_map[i].cfg) {
>   			f->src = rcg->parent_map[i].src;
>   			p = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
>   			prate = clk_hw_get_rate(p);
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
