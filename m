Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B207EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8E4207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwmwR8pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgFIJTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFIJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:19:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25FBC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 02:19:11 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so2345420wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ko4rWFPKDMe9rc0tjCCVIFJ0/oRc6Xoz+JGznJVz9As=;
        b=cwmwR8pFJNPO/s+xuUdBe3R/cGlqjbjbVX2WTV/qQlgEReaIgTg74bGHiy4T3GDO0O
         g6AKozrOCJ897X9T0hgvE3ePWOzC1oYtXUYKp5lKYAOK9tGBSl4OQUtsDBNzSwgRE/K1
         1v0KpqayuRzIeCoRWUn2jfJi1FvqYuDoKaTMzxwZIsJZUKyr1mXLsPpAOi0oj/HOXBTK
         AFm5B6nDhWfj+b/tg/JgXHse3ELfMRlcICQQekcyPmdwsYF4hj8UOCjceJqdoZy1rczy
         GiKwAqd4q1wcGuC59KWqkjqwFW95/+XLSi7uH8KkyJ69F2otS77ZRz4p9isDOFNo+887
         p8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ko4rWFPKDMe9rc0tjCCVIFJ0/oRc6Xoz+JGznJVz9As=;
        b=eJ0e/RCgIBehxBmNSGrk3bTxZgeZ4bLIhTIL1FnB1n92ToTNcdjHNx9N8yucIivLjY
         1DXBR87nJ7WPZKg3/GAeuptUIWEYyVdxFWGF+ephAAiFr0dcCvZWcuMY6kl/CwzM3fR1
         vFC6MugHEWpgg8fUYZeDzxM4UHAX9YnrJo/Iynergg562WzqDMKAwKCTgJ5AzLa1LlE/
         rlnOfGwRZKoAYHX9vv3hrqbBWP8FQhwtPtlEC0Ht4E3hD0P23//I1o6Xpxvn0f9pbiW9
         cj1QhMo/JO+5dbFE2KypynVhVnmj2yeEyLPKP2/LpyFmgcxWnJHZVSZROZr+TBBjJdKE
         /1kQ==
X-Gm-Message-State: AOAM533z7H0Lw53C+qlWRfuCziYN9GKrStZV/CIOPuusrY9wN+7PvI60
        5adopRGil4vBqc+rlqzOj2RfViu7P0g=
X-Google-Smtp-Source: ABdhPJz3Xhm/8ebZUCwc0O/JZNLdi/Hf9aVcvXm4x0C3TkYb3KVcUyQvrnW9jyXT9rNVuhTdML0k9w==
X-Received: by 2002:a1c:60d6:: with SMTP id u205mr3180926wmb.163.1591694349961;
        Tue, 09 Jun 2020 02:19:09 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r5sm2786439wrq.0.2020.06.09.02.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 02:19:09 -0700 (PDT)
Subject: Re: [PATCH 2/5] soundwire: qcom: add support for mmio soundwire
 devices
To:     Jonathan Marek <jonathan@marek.ca>, alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-3-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1b29db61-2394-8f88-9ebb-219568fb9306@linaro.org>
Date:   Tue, 9 Jun 2020 10:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200608204347.19685-3-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2020 21:43, Jonathan Marek wrote:
> Adds support for qcom soundwire devices with memory mapped IO registers.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

In general patch itself looks pretty trivial, but I would like to see 
what 1.5.1 controller provides in terms of error reporting of SoundWire 
slave register reads/writes. On WCD based controller we did not have a 
mechanism to report things like if the read is ignored or not. I was 
hoping that this version of controller would be able to report that.

I will be nice to those patches if that is something which is supported 
in this version.

--srini

>   drivers/soundwire/qcom.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index f38d1fd3679f..628747df1c75 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -90,6 +90,7 @@ struct qcom_swrm_ctrl {
>   	struct sdw_bus bus;
>   	struct device *dev;
>   	struct regmap *regmap;
> +	void __iomem *mmio;
>   	struct completion *comp;
>   	struct work_struct slave_work;
>   	/* read/write lock */
> @@ -154,6 +155,20 @@ static int qcom_swrm_ahb_reg_write(struct qcom_swrm_ctrl *ctrl,
>   	return SDW_CMD_OK;
>   }
>   
> +static int qcom_swrm_cpu_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
> +				  u32 *val)
> +{
> +	*val = readl(ctrl->mmio + reg);
> +	return SDW_CMD_OK;
> +}
> +
> +static int qcom_swrm_cpu_reg_write(struct qcom_swrm_ctrl *ctrl, int reg,
> +				   int val)
> +{
> +	writel(val, ctrl->mmio + reg);
> +	return SDW_CMD_OK;
> +}
> +
>   static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
>   				     u8 dev_addr, u16 reg_addr)
>   {
> @@ -746,6 +761,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	struct sdw_master_prop *prop;
>   	struct sdw_bus_params *params;
>   	struct qcom_swrm_ctrl *ctrl;
> +	struct resource *res;
>   	int ret;
>   	u32 val;
>   
> @@ -760,8 +776,13 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   		if (!ctrl->regmap)
>   			return -EINVAL;
>   	} else {
> -		/* Only WCD based SoundWire controller is supported */
> -		return -ENOTSUPP;
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +		ctrl->reg_read = qcom_swrm_cpu_reg_read;
> +		ctrl->reg_write = qcom_swrm_cpu_reg_write;
> +		ctrl->mmio = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(ctrl->mmio))
> +			return PTR_ERR(ctrl->mmio);
>   	}
>   
>   	ctrl->irq = of_irq_get(dev->of_node, 0);
> 
