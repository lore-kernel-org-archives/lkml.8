Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A49C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7E1206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZNa14DFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgD2OQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:16:54 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47415 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726558AbgD2OQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:16:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588169813; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=nnaIfrV4qLeRSIGOFX1I6F/ufbM8nw9ujY7Wju+a3ug=; b=ZNa14DFi5HHxe91l23kfhXYiG1fknxvXarBdL9sf4F7BHAa2RaQR+R/qysMhJhluPqhCEd/U
 WitswyZp8/ol4CddLR6PDsrqza4iNfPhWy73qQQAcfE45MD8gLxzK+FeovtMUhT3ywv4dS4f
 LA3NGm2VjokOYeEQScAXghjS6h8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea98c4c.7f2982237650-smtp-out-n04;
 Wed, 29 Apr 2020 14:16:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F64BC433D2; Wed, 29 Apr 2020 14:16:43 +0000 (UTC)
Received: from [10.131.182.194] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3419C433CB;
        Wed, 29 Apr 2020 14:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3419C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 05/17] drm/msm/dpu: Use OPP API to set clk/perf state
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org
References: <1588080785-6812-1-git-send-email-rnayak@codeaurora.org>
 <1588080785-6812-6-git-send-email-rnayak@codeaurora.org>
 <20200429001425.GL4525@google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <92892448-c10c-4440-4933-17706d46ef93@codeaurora.org>
Date:   Wed, 29 Apr 2020 19:46:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429001425.GL4525@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/29/2020 5:44 AM, Matthias Kaehlcke wrote:
> On Tue, Apr 28, 2020 at 07:02:53PM +0530, Rajendra Nayak wrote:
>> On some qualcomm platforms DPU needs to express a perforamnce state
>> requirement on a power domain depennding on the clock rates.
>> Use OPP table from DT to register with OPP framework and use
>> dev_pm_opp_set_rate() to set the clk/perf state.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Cc: Sean Paul <sean@poorly.run>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  3 ++-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 25 ++++++++++++++++++++++++-
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h       |  4 ++++
>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> index 11f2beb..fe5717df 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/errno.h>
>>   #include <linux/mutex.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/sort.h>
>>   #include <linux/clk.h>
>>   #include <linux/bitmap.h>
>> @@ -239,7 +240,7 @@ static int _dpu_core_perf_set_core_clk_rate(struct dpu_kms *kms, u64 rate)
>>   		rate = core_clk->max_rate;
>>   
>>   	core_clk->rate = rate;
>> -	return msm_dss_clk_set_rate(core_clk, 1);
>> +	return dev_pm_opp_set_rate(&kms->pdev->dev, core_clk->rate);
>>   }
>>   
>>   static u64 _dpu_core_perf_get_core_clk_rate(struct dpu_kms *kms)
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index ce19f1d..2f53bbf 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/dma-buf.h>
>>   #include <linux/of_irq.h>
>> +#include <linux/pm_opp.h>
>>   
>>   #include <drm/drm_crtc.h>
>>   #include <drm/drm_file.h>
>> @@ -1033,11 +1034,23 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>>   	if (!dpu_kms)
>>   		return -ENOMEM;
>>   
>> +	dpu_kms->opp_table = dev_pm_opp_set_clkname(dev, "core");
>> +	if (IS_ERR(dpu_kms->opp_table))
>> +		return PTR_ERR(dpu_kms->opp_table);
>> +	/* OPP table is optional */
>> +	ret = dev_pm_opp_of_add_table(dev);
>> +	if (!ret) {
>> +		dpu_kms->has_opp_table = true;
>> +	} else if (ret != -ENODEV) {
>> +		dev_err(dev, "Invalid OPP table in Device tree\n");
> 
> nit: s/Device/device/ ?
> 
> uber-nit: s/Invalid/invalid/
> 
>    most log messages in this file start with a lower case letter, except
>    for acronyms/register names
> 
> please also change it in the other drivers unless you disagree.

Sure, will do. Thanks.

> 
>> +		return ret;
>> +	}
>> +
>>   	mp = &dpu_kms->mp;
>>   	ret = msm_dss_parse_clock(pdev, mp);
>>   	if (ret) {
>>   		DPU_ERROR("failed to parse clocks, ret=%d\n", ret);
>> -		return ret;
>> +		goto err;
>>   	}
>>   
>>   	platform_set_drvdata(pdev, dpu_kms);
>> @@ -1051,6 +1064,11 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
>>   
>>   	priv->kms = &dpu_kms->base;
>>   	return ret;
>> +err:
>> +	if (dpu_kms->has_opp_table)
>> +		dev_pm_opp_of_remove_table(dev);
>> +	dev_pm_opp_put_clkname(dpu_kms->opp_table);
>> +	return ret;
>>   }
>>   
>>   static void dpu_unbind(struct device *dev, struct device *master, void *data)
>> @@ -1059,6 +1077,9 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
>>   	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
>>   	struct dss_module_power *mp = &dpu_kms->mp;
>>   
>> +	if (dpu_kms->has_opp_table)
>> +		dev_pm_opp_of_remove_table(dev);
>> +	dev_pm_opp_put_clkname(dpu_kms->opp_table);
>>   	msm_dss_put_clk(mp->clk_config, mp->num_clk);
>>   	devm_kfree(&pdev->dev, mp->clk_config);
>>   	mp->num_clk = 0;
>> @@ -1090,6 +1111,8 @@ static int __maybe_unused dpu_runtime_suspend(struct device *dev)
>>   	struct dpu_kms *dpu_kms = platform_get_drvdata(pdev);
>>   	struct dss_module_power *mp = &dpu_kms->mp;
>>   
>> +	/* Drop the performance state vote */
>> +	dev_pm_opp_set_rate(dev, 0);
>>   	rc = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
>>   	if (rc)
>>   		DPU_ERROR("clock disable failed rc:%d\n", rc);
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
>> index 211f5de9..2a52e4e 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
>> @@ -128,6 +128,10 @@ struct dpu_kms {
>>   
>>   	struct platform_device *pdev;
>>   	bool rpm_enabled;
>> +
>> +	struct opp_table *opp_table;
>> +	bool has_opp_table;
>> +
>>   	struct dss_module_power mp;
>>   
>>   	/* reference count bandwidth requests, so we know when we can
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
