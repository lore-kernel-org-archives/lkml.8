Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD39D217A0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgFRJ4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:56:06 -0400
Received: from foss.arm.com ([217.140.110.172]:47154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgFRJ4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:56:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D05FC31B;
        Thu, 18 Jun 2020 02:56:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81AA13F6CF;
        Thu, 18 Jun 2020 02:56:03 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:56:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.7 229/388] usb/ohci-platform: Fix a warning
 when hibernating
Message-ID: <20200618095600.umb4gyegy2hszlep@e107158-lin.cambridge.arm.com>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-229-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618010805.600873-229-sashal@kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha/Alan

On 06/17/20 21:05, Sasha Levin wrote:

[...]

> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 7addfc2cbadc..4a8456f12a73 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -299,6 +299,11 @@ static int ohci_platform_resume(struct device *dev)
>  	}
>  
>  	ohci_resume(hcd, false);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +

I am not sure what's the protocol here, but the series was fixing similar
problems to this driver but I didn't myself directly observe a warning because
of that.

https://lore.kernel.org/lkml/20200518154931.6144-2-qais.yousef@arm.com/
https://lore.kernel.org/lkml/20200518154931.6144-3-qais.yousef@arm.com/

So just pointing it out in case they're worth backporting to stable too.

Thanks

--
Qais Yousef
