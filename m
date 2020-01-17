Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E68AC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407E320728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l5MRmsD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgAQEEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:04:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12732 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgAQEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:04:37 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e21323f0000>; Thu, 16 Jan 2020 20:04:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Jan 2020 20:04:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 16 Jan 2020 20:04:36 -0800
Received: from [10.24.192.96] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Jan
 2020 04:04:32 +0000
Subject: Re: [PATCH -next] usb: gadget: xudc: Remove redundant
 platform_get_irq error message
To:     YueHaibing <yuehaibing@huawei.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <felipe.balbi@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200116141433.57056-1-yuehaibing@huawei.com>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <0a693269-3727-bb71-414e-856eab485353@nvidia.com>
Date:   Fri, 17 Jan 2020 09:36:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116141433.57056-1-yuehaibing@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579233855; bh=Fb1kRMcCe2hRuzZ7Zne1iDJNmB9ylql0TIEaGqeED9g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l5MRmsD3V1v2EaaSAD7R5o4KbSjpbRsoMG7yVcwRrRT4A9o8SUESim+GX+YCAiVtW
         /DMf7hUqa+H6sc0KfHs/KYHtHai+jiFPNoCHFqK+Old/fMu9iOV+PL+ohSLbGCxli7
         UMOAOWI5Eo4w4a/9QE755VDUPvYaoznEbpoS3uYULmwmKPjFb0+UwY0QCiZyOfiSaF
         fS8ZNitT2rtRyPx2cwYGSP17HH8xph9InPgN49Z5X0an2JHuVC+XV/sW+BX5zpMSPk
         EtsH4MFWGPTYLNYmn6OxA/wkZjFtfVDm94OfLqrgXSmIVuIHX9ehhaCCP5S6hrAgBu
         zYTdUMODrWKRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nagarjuna Kristam <nkristam@nvidia.com>

On 16-01-2020 19:44, YueHaibing wrote:
> External email: Use caution opening links or attachments
> 
> 
> platform_get_irq() will call dev_err() itself on failure,
> so there is no need for the driver to also do this.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/usb/gadget/udc/tegra-xudc.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
> index 634c2c1..fc1eafc 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -3492,11 +3492,8 @@ static int tegra_xudc_probe(struct platform_device *pdev)
>          }
> 
>          xudc->irq = platform_get_irq(pdev, 0);
> -       if (xudc->irq < 0) {
> -               dev_err(xudc->dev, "failed to get IRQ: %d\n",
> -                               xudc->irq);
> +       if (xudc->irq < 0)
>                  return xudc->irq;
> -       }
> 
>          err = devm_request_irq(&pdev->dev, xudc->irq, tegra_xudc_irq, 0,
>                                 dev_name(&pdev->dev), xudc);
> --
> 2.7.4
> 
> 
