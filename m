Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A965C433ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0501820674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 16:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OODIOowY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGXQHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:07:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30488 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgGXQHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:07:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595606841; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=BDjCdzox03R+E0WebnMzaH3e+8GkUl2oaYOMtWhsAZY=; b=OODIOowYR0/ko6NfJy/QnHruF3jkDxnwl0WRh3B8bkx/VqkdwFrpSkZ5qVDlIL6TnYZhH+sb
 VtdjCJzfcIbClmohdbDNB/EtD+sATJfczumPXF9NbmhqZatlNBJW6Se40i3WWicbrr0vRIxy
 +4CuIsxShUtsvRzoMuJIPPz0AI0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f1b07268db7256a955ba010 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 16:07:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03AB9C433C9; Fri, 24 Jul 2020 16:07:01 +0000 (UTC)
Received: from [192.168.0.105] (unknown [183.82.136.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4CD91C43391;
        Fri, 24 Jul 2020 16:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4CD91C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v4 4/4] clk: qcom: lpass: Add support for LPASS clock
 controller for SC7180
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org
References: <1594795010-9074-1-git-send-email-tdas@codeaurora.org>
 <1594795010-9074-5-git-send-email-tdas@codeaurora.org>
 <159531768310.3847286.13203525525881212775@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <893b1221-6e35-a903-77d4-a60a3ce0cbdc@codeaurora.org>
Date:   Fri, 24 Jul 2020 21:36:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159531768310.3847286.13203525525881212775@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the review.

On 7/21/2020 1:18 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2020-07-14 23:36:50)
>> diff --git a/drivers/clk/qcom/lpasscorecc-sc7180.c b/drivers/clk/qcom/lpasscorecc-sc7180.c

>> +static struct clk_alpha_pll lpass_lpaaudio_dig_pll = {
>> +       .offset = 0x1000,
>> +       .vco_table = fabia_vco,
>> +       .num_vco = ARRAY_SIZE(fabia_vco),
>> +       .regs = clk_alpha_pll_regs_offset[CLK_ALPHA_PLL_TYPE_FABIA],
>> +       .clkr = {
>> +               .hw.init = &(struct clk_init_data){
>> +                       .name = "lpass_lpaaudio_dig_pll",
>> +                       .parent_data = &(const struct clk_parent_data){
>> +                               .fw_name = "bi_tcxo",
>> +                               .name = "bi_tcxo",
> 
> We don't need .name if we have .fw_name and this is a new binding/device.
> 

My bad, will cleanup in the next patch.

>> +                       },
>> +                       .num_parents = 1,
>> +                       .ops = &clk_alpha_pll_fabia_ops,
>> +               },
>> +       },
>> +};
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
