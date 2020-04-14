Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38D1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7680C20768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="rUyVQqrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438022AbgDNPQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:16:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20387 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407252AbgDNPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:05:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586876755; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2sHXwJ8AdtS+pVXjlc3JcGuGpLLjSecwst28kNFXaDE=; b=rUyVQqrgk8Ms5DInHRGa59N4XnzEwiTKkrsU+zwJN6aRTddQWF71Ndfh3gLXB5oFMv7dH6X7
 FgK78pwxODIrEo7cDHCzvhGpihUrjOWKRdJwlKA3fbebnfYDxLmGB44YRVrPVrrNh0Yg/6tx
 zKWHwTP5WHwGkuqzNP14NuXGP3Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95d13b.7fadc8ad0810-smtp-out-n05;
 Tue, 14 Apr 2020 15:05:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6422BC44788; Tue, 14 Apr 2020 15:05:31 +0000 (UTC)
Received: from [10.111.193.245] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC3EAC494AA;
        Tue, 14 Apr 2020 15:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC3EAC494AA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC] opp: Fixup release of clock when using set/put clkname
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1586848508-1320-1-git-send-email-rnayak@codeaurora.org>
 <20200414071823.jdhkprtkizyeua23@vireshk-i7>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <83c523d0-e18e-0401-5456-2dbba524ee98@codeaurora.org>
Date:   Tue, 14 Apr 2020 20:35:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414071823.jdhkprtkizyeua23@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/2020 12:48 PM, Viresh Kumar wrote:
> On 14-04-20, 12:45, Rajendra Nayak wrote:
>> Fixup dev_pm_opp_put_clkname() to check for a valid clock pointer
>> before it does a clk_put, since its likely that
>> _opp_table_kref_release() has already done a clk_put. Also fixup
> 
> kref release is the last thing that happens on the table, it can't get
> called after dev_pm_opp_put_clkname().

so in cases where I do have an OPP table for a device in DT and I do
dev_pm_opp_set_clkname()
dev_pm_opp_of_add_table()

and clean it up with a
dev_pm_opp_of_remove_table()
dev_pm_opp_put_clkname()

things seem to work fine as expected.

However, given I call these unconditionally in common drivers and on
some (old) platforms we really don't have an OPP table (only scale clocks)
things get a little tricky. So looks like the ref counting in such cases
gets messed up, and we end up with dev_pm_opp_of_remove_table() calling
_opp_table_kref_release() and releasing the clock, and then the subsequent
call to dev_pm_opp_put_clkname() crashes.

>> _opp_table_kref_release() to set the clock pointer to ERR_PTR(-EINVAL)
>> after its done doing a clk_put so dev_pm_opp_put_clkname() can then
>> catch it.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/opp/core.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index e4f01e7..6d064a8 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -1061,8 +1061,10 @@ static void _opp_table_kref_release(struct kref *kref)
>>   	_of_clear_opp_table(opp_table);
>>   
>>   	/* Release clk */
>> -	if (!IS_ERR(opp_table->clk))
>> +	if (!IS_ERR(opp_table->clk)) {
>>   		clk_put(opp_table->clk);
>> +		opp_table->clk = ERR_PTR(-EINVAL);
>> +	}
>>   
>>   	WARN_ON(!list_empty(&opp_table->opp_list));
>>   
>> @@ -1744,8 +1746,10 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
>>   	/* Make sure there are no concurrent readers while updating opp_table */
>>   	WARN_ON(!list_empty(&opp_table->opp_list));
>>   
>> -	clk_put(opp_table->clk);
>> -	opp_table->clk = ERR_PTR(-EINVAL);
>> +	if (!IS_ERR(opp_table->clk)) {
>> +		clk_put(opp_table->clk);
>> +		opp_table->clk = ERR_PTR(-EINVAL);
>> +	}
>>   
>>   	dev_pm_opp_put_opp_table(opp_table);
>>   }
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
