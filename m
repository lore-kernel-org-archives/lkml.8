Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9FAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797FE207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vmLwAIE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE2Ks0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:48:26 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:36040 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgE2KsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:48:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590749304; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=B8L7vHtKkHs16625TWlJ0o9ar7jOJ9s+CGFbVBkgeRU=; b=vmLwAIE9q1Q3wP4Q5DrHzGlPNHFHJUWiVdnMcTGFYtMwwq5P28sP2vDm/gpuUNvRU5daCGpM
 uWJGfnREQ2qRiYISbp8rKMp4yBjNBT/e9h+AH6tA7dEF7iEU21dCwbxeUNVd9hkKR6meQDfP
 VsKtlbxF4oyYgqN+Jv2J7TEb1rY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ed0e87242288e951fad69fa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 10:48:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 08E1AC433CA; Fri, 29 May 2020 10:48:18 +0000 (UTC)
Received: from [10.50.50.126] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rbokka)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDD1AC433C6;
        Fri, 29 May 2020 10:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDD1AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rbokka@codeaurora.org
Subject: Re: [PATCH] nvmem: Enforce nvmem stride in the sysfs interface
To:     Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     evgreen@chromium.org, dhavalp@codeaurora.org,
        mturney@codeaurora.org, sparate@codeaurora.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        linux-kernel@vger.kernel.org
References: <20200528165250.1.Iad7dec5afecba175c816773a0088be805476453f@changeid>
From:   "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>
Message-ID: <ee900df1-0df7-7e73-1916-531dbc5e243b@codeaurora.org>
Date:   Fri, 29 May 2020 16:18:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528165250.1.Iad7dec5afecba175c816773a0088be805476453f@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/29/2020 5:23 AM, Douglas Anderson wrote:
> The 'struct nvmem_config' has a stride attribute that specifies the
> needed alignment for accesses into the nvmem.  This is used in
> nvmem_cell_info_to_nvmem_cell() but not in the sysfs read/write
> functions.  If the alignment is important in one place it's important
> everywhere, so let's add enforcement.
> 
> For now we'll consider it totally invalid to access with the wrong
> alignment.  We could relax this in the read case where we could just
> read some extra bytes and throw them away.  Relaxing it in the write
> case seems harder (and less safe?) since we'd have to read some data
> first and then write it back.  To keep it symmetric we'll just
> disallow it in both cases.
> 
> Reported-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/nvmem/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

I have reviewed and tested this patch.
Result: kernel crash resolved with unaligned offset.

Reviewed-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Tested-by: Ravi Kumar Bokka <rbokka@codeaurora.org>

> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 05c6ae4b0b97..1c0e7953f90d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -111,6 +111,9 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
>   	if (pos >= nvmem->size)
>   		return 0;
>   
> +	if (!IS_ALIGNED(pos, nvmem->stride))
> +		return -EINVAL;
> +
>   	if (count < nvmem->word_size)
>   		return -EINVAL;
>   
> @@ -148,6 +151,9 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
>   	if (pos >= nvmem->size)
>   		return -EFBIG;
>   
> +	if (!IS_ALIGNED(pos, nvmem->stride))
> +		return -EINVAL;
> +
>   	if (count < nvmem->word_size)
>   		return -EINVAL;
>   
> 

Regards,
Ravi Kumar.B
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by the Linux Foundation.
