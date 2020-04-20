Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4132EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E2A20735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QCL2VPUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgDTOcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:32:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7438 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgDTOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:32:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9db2510000>; Mon, 20 Apr 2020 07:31:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 07:32:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 20 Apr 2020 07:32:46 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 14:32:46 +0000
Received: from [10.26.73.5] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 14:32:44 +0000
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Fix idle suspend/resume
To:     Thierry Reding <thierry.reding@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Nagarjuna Kristam <nkristam@nvidia.com>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200417170537.2540914-1-thierry.reding@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <60250b1f-f721-0631-59bf-513576473f44@nvidia.com>
Date:   Mon, 20 Apr 2020 15:32:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417170537.2540914-1-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587393105; bh=toH/pecuB89VX7SWlMWownm60l5bU9nUI52RJVrzz8o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QCL2VPUYrf4DBc6ejLE/f7QMmkZQSfsfbEkaSTvYZ41SuzRdyCEQq3wlwHQh98aF3
         hPFCSGoZyz9Ox0myXXzupPMwVW1YbBMuY0kEY1sI46nQO+ILA+wrqjfI3/u/VdKxHN
         weE1jP9LFeohRVRBwPFer9wNIGxbpUscAz2pJEb6spnJWEu9ob9SMdRudnHLx0ureW
         bRJaBIGFbw0ArpEhYnOtIUPI/Li09my72cA9pTpYQliiItN1XBnudPEX48v2lZn5SJ
         v71u5FMDgjb+8d69HuCBpIlTE4faHZ685krfc4Q0RGhZNX5bB5tKKHhpMsuZb6j94w
         /1Sl1UmFhT82w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/04/2020 18:05, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> When the XUDC device is idle (i.e. powergated), care must be taken not
> to access any registers because that would lead to a crash.
> 
> Move the call to tegra_xudc_device_mode_off() into the same conditional
> as the tegra_xudc_powergate() call to make sure we only force device
> mode off if the XUDC is actually powered up.
> 
> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
> index 52a6add961f4..dfabc54cdc27 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -3840,11 +3840,11 @@ static int __maybe_unused tegra_xudc_suspend(struct device *dev)
>  
>  	flush_work(&xudc->usb_role_sw_work);
>  
> -	/* Forcibly disconnect before powergating. */
> -	tegra_xudc_device_mode_off(xudc);
> -
> -	if (!pm_runtime_status_suspended(dev))
> +	if (!pm_runtime_status_suspended(dev)) {
> +		/* Forcibly disconnect before powergating. */
> +		tegra_xudc_device_mode_off(xudc);
>  		tegra_xudc_powergate(xudc);
> +	}
>  
>  	pm_runtime_disable(dev);


Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
