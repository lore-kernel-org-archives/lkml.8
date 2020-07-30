Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED28C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208D9207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YTk7AnLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgG3Qp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgG3Qp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:45:27 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C5CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:45:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so22575892wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ej86RLhiH25iZDP4wdWxFB2UmXj5vFm/8QPxIezwAmw=;
        b=YTk7AnLaFlkL+C5U3ihsRpQI0XMJOdvkoUEWMS9jcSJYPJZwNBQDr6HcZ+wxr3xCaw
         AuAy4DSgV2DR6MQgxwofQT7xWRRUHdLTqDRgjutaTia7srGw7KXsio2BKdaK15EOYGL8
         HNWPYs2SUOV5KARFWNpe9q41o1boLHHtcq1GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ej86RLhiH25iZDP4wdWxFB2UmXj5vFm/8QPxIezwAmw=;
        b=OEV69DMQfzxvSp+eI/nHIBku1KBsC/a2aJ9v97nwFo8e5aazDI1CL5LoIeLiFX6Ixk
         JcAmTgUFXgNlm+JkMFT2C6yrv8fFHrEmxvxEy7vJ1jPOpLLk6rS1kW9Qd1q02irZaZ/f
         A9MbI03rpG3HFA/8YYIHhTpEcbKVJCETrVDNXSEdJ5wpImhYAa+m7CzzDYpXHTeVlt4G
         oCKvyX7bzK2KFGJEkKgpUITj/BRsJQHW8Hg7B58iGy9rvzVx7Tv+fhHz4/cP04+axqTz
         Jef4YozmTv5IFmdzvl5q0g8/OEvmRXkUmqmYLlDHK9jUp6DmX7QBw5PNa7UAtp2JMtsv
         2Shg==
X-Gm-Message-State: AOAM533z7hxSNJTannbgze2lmIAnBI7zaBe8mwquFeD2bLc5foCz5DXi
        4VZQFV5sw2Eu/J0QDNZiAGAPaP+U93GyJW36hP7QdZNVBLs0HA8tVnuOZcvBg9SJmrMlj+VAlRp
        MufvGrb5KXSTqu+j6DoyKDw8T6HoO4VChnmHqX9CQNAyw05ZMyZXutoM3/x8gPLGwOAPkMLDUDz
        IQ0kU=
X-Google-Smtp-Source: ABdhPJxQ+4Py8GSmISIKP5nUNjBHnbsK7/iDIeqxIPnglPJHKmzJTwilIeilvMYgJKN8kLcSf/V1Ng==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr36482383wro.239.1596127524535;
        Thu, 30 Jul 2020 09:45:24 -0700 (PDT)
Received: from [10.136.8.246] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id n5sm10013589wrx.22.2020.07.30.09.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 09:45:23 -0700 (PDT)
Subject: Re: [PATCH 3/3] PCI: iproc: Set affinity mask on MSI interrupts
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        bhelgaas@google.com, rjui@broadcom.com, sbranden@broadcom.com,
        f.fainelli@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730033747.18931-1-mark.tomlinson@alliedtelesis.co.nz>
 <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <ddef93f0-4f5b-f860-bc2e-96ccc84ad040@broadcom.com>
Date:   Thu, 30 Jul 2020 09:45:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730033747.18931-3-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2020 8:37 PM, Mark Tomlinson wrote:
> The core interrupt code expects the irq_set_affinity call to update the
> effective affinity for the interrupt. This was not being done, so update
> iproc_msi_irq_set_affinity() to do so.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 3176ad3ab0e5..908475d27e0e 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -209,15 +209,20 @@ static int iproc_msi_irq_set_affinity(struct irq_data *data,
>  	struct iproc_msi *msi = irq_data_get_irq_chip_data(data);
>  	int target_cpu = cpumask_first(mask);
>  	int curr_cpu;
> +	int ret;
>  
>  	curr_cpu = hwirq_to_cpu(msi, data->hwirq);
>  	if (curr_cpu == target_cpu)
> -		return IRQ_SET_MASK_OK_DONE;
> +		ret = IRQ_SET_MASK_OK_DONE;
> +	else {
> +		/* steer MSI to the target CPU */
> +		data->hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu;
> +		ret = IRQ_SET_MASK_OK;
> +	}
>  
> -	/* steer MSI to the target CPU */
> -	data->hwirq = hwirq_to_canonical_hwirq(msi, data->hwirq) + target_cpu;
> +	irq_data_update_effective_affinity(data, cpumask_of(target_cpu));
>  
> -	return IRQ_SET_MASK_OK;
> +	return ret;
>  }
>  
>  static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
> 

This change looks good to me. Thanks.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
