Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7872820767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593098372;
	bh=XzTkq1iBTTWjtegGk1NOXi3odbeSdvKRDsXmO6ADP60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yMzdyZbgTzqILzo9oN7cWWxnG7/Q1OGnhPEvVsJNzfJIKlD3rxjIXPxRPUDpRfXeP
	 WAZMkhfvF6tsU0MrXdN/22FgYVEuKPy48Jz8Ay5Z7EShM9U4eo7GTbis9qs8GE+7/U
	 WhewjDMaak91LZho8+jEM2cnsvcqtEP/vfjzzAHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405597AbgFYPTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:19:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40376 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404580AbgFYPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:19:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id t25so5278685oij.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WF4nxc4cYEV7OXqFqlLbsvgVd7feCSg2z058/yAVlQ=;
        b=Q9NExQHm0bFYYUrvYOmrPMFXvmN5u03Igmg2golkQ0ksG46tr9udITuNnGM3jLvodT
         sERM2e28wATF2wE6Ym0kvoy2PLpxsFObRJrwYyLv58a1SSLnN0/baOtyP2qggo6xqK/+
         TcxEiyv3no0xEF+nvQDU03fRMZCXG/E08Qq3AZykx/H/bPKyXXphfXsMdArPMNh0AB/i
         BLq3FR2q14UyALTjcs+q8UAvZdfR/3EHOZX1QIdFK50blPrI6P7NMct4GmRHntFsFUJq
         dGjT5MrNfJDtiKCBBdqMKLUtLAeBnIZg5vCaOR1gtpHjLqP5lHB1lc04/OIR2T8kUZzA
         LNQA==
X-Gm-Message-State: AOAM5308aruBfvqg5CD/vzr1qtCCy/x2G0FS14K6ketYe7MsUs150SmV
        EK2mM91s8BjC7od0tj23juSbHTn/YlvviC4lKVY=
X-Google-Smtp-Source: ABdhPJz+Jx0AGm/kimBB+NCnBileBZRoEZjQG4pTZTETkLzsVQYZxpwev2VFd64G1HUXfGGn8/lH5zHQol3HnVM9kwM=
X-Received: by 2002:a54:4585:: with SMTP id z5mr2713355oib.110.1593098369568;
 Thu, 25 Jun 2020 08:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com>
In-Reply-To: <20200625032430.152447-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 17:19:18 +0200
Message-ID: <CAJZ5v0h1JHLK2PA45ZfNBeQrRoH+UkEi6-vRR-=HLz7AAnC1vA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Toan Le <toanle@apm.com>,
        Feng Kan <fkan@apm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 5:24 AM Saravana Kannan <saravanak@google.com> wrote:
>
> Under the following conditions:
> - driver A is built in and can probe device-A
> - driver B is a module and can probe device-B
> - device-A is supplier of device-B
>
> Without this patch:
> 1. device-A is added.
> 2. device-B is added.
> 3. dpm_list is now [device-A, device-B].
> 4. driver-A defers probe of device-A.
> 5. deferred probe of device-A is reattempted
> 6. device-A is moved to end of dpm_list.
> 6. dpm_list is now [device-B, device-A].
> 7. driver-B is loaded and probes device-B.
> 8. dpm_list stays as [device-B, device-A].
>
> Suspend (which goes in the reverse order of dpm_list) fails because
> device-A (supplier) is suspended before device-B (consumer).
>
> With this patch:
> 1. device-A is added.
> 2. device-B is added.
> 3. dpm_list is now [device-A, device-B].
> 4. driver-A defers probe of device-A.
> 5. deferred probe of device-A is reattempted later.
> 6. dpm_list is now [device-B, device-A].
> 7. driver-B is loaded and probes device-B.
> 8. dpm_list is now [device-A, device-B].
>
> Suspend works because device-B (consumer) is suspended before device-A
> (supplier).
>
> Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
> Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/dd.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9a1d940342ac..52b2148c7983 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
>                  * probe makes that very unsafe.
>                  */
>                 device_pm_move_to_tail(dev);
> +               /* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
> +                * I'm worried if it'll have some unintended consequeneces. */

Yes, this needs to go away if you make the other change.

>
>                 dev_dbg(dev, "Retrying from deferred list\n");
>                 bus_probe_device(dev);
> @@ -557,6 +559,20 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>                 goto re_probe;
>         }
>
> +       /*
> +        * The devices are added to the dpm_list (resume/suspend (reverse
> +        * order) list) as they are registered with the driver core. But the
> +        * order the devices are added doesn't necessarily match the real
> +        * dependency order.
> +        *
> +        * The successful probe order is a much better signal. If a device just
> +        * probed successfully, then we know for sure that all the devices that
> +        * probed before it don't depend on the device. So, we can safely move
> +        * the device to the end of the dpm_list. As more devices probe,
> +        * they'll automatically get ordered correctly.
> +        */
> +       device_pm_move_to_tail(dev);

But it would be good to somehow limit this to the devices affected by
deferred probing or we'll end up reordering dpm_list unnecessarily for
many times in the actual majority of cases.

> +
>         pinctrl_init_done(dev);
>
>         if (dev->pm_domain && dev->pm_domain->sync)
> --
> 2.27.0.111.gc72c7da667-goog
>
