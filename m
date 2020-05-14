Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91022C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653E420709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589495735;
	bh=PzRII4/RfN31cWmlbYBqI5etPc9zdw9KR1iB+zAlMNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BnyL0ihkHXkrJIbVW82LzGlbLxO1rlRp2sjdElZwN3HSjj5Jv/PwdfASi7OqVhdq+
	 WvsGOziMCGhKR5bYNVpzIFtlacVOq+yYgnJPoboXCoRcfewCuyrlty2xe38SHsrxSL
	 LWfIHrfhHg8wVLbGfz2UtF6Pyvaf6aVFwXhV9ErE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgENWfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgENWfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:35:34 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA932065C;
        Thu, 14 May 2020 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589495733;
        bh=PzRII4/RfN31cWmlbYBqI5etPc9zdw9KR1iB+zAlMNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhb9MbKX9DzBEN+QS/Qp8tagSDXmw6j+EI1XBKpliU9NuJ4BZMqzSYxtsia+YzvOZ
         xuhyQ1U6K9I3RG6GMpaTPH69YrsZatjYiBEJx2CuKtYrxuZ4ZmU6QmNYBhO/foyyEN
         F3SVey4ul1KTyP9TcLb14dADf1zj+Ry83IWULWh8=
Received: by pali.im (Postfix)
        id 05D177B2; Fri, 15 May 2020 00:35:30 +0200 (CEST)
Date:   Fri, 15 May 2020 00:35:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     koba.ko@canonical.com
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario.Limonciello@dell.com
Subject: Re: [PATCH] V2: platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Message-ID: <20200514223530.24r7c42bvwxvyyv5@pali>
References: <20200511014456.5149-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200511014456.5149-1-koba.ko@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 May 2020 09:44:56 koba.ko@canonical.com wrote:
> From: Koba Ko <koba.ko@canonical.com>
> 
> On dell G3-3590, error message is issued during boot up,
> "platform::micmute: Setting an LED's brightness failed (-19)",
> but there's no micmute led on the machine.
> 
> Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> If one of two tokens doesn't exist,
> don't call led_classdev_register() for platform::micmute.
> After that, you wouldn't see the platform::micmute in /sys/class/leds/,
> and the error message wouldn't see in dmesg.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>

Fine for me, you can add:

Reviewed-by: Pali Rohár <pali@kernel.org>

Darren / Andy, when applying this patch, please add Fixes line so this
change would be propagated to stable kernels:

Fixes: d00fa46e0a2c6 ("platform/x86: dell-laptop: Add micmute LED trigger support")

> ---
> Changelog:
> 1. Refine the typo of comment.
> ---
>  drivers/platform/x86/dell-laptop.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index 1e46022fb2c5..afc1ded83e56 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2208,10 +2208,13 @@ static int __init dell_init(void)
>  
>  	dell_laptop_register_notifier(&dell_laptop_notifier);
>  
> -	micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> -	ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> -	if (ret < 0)
> -		goto fail_led;
> +	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> +	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> +		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +		ret = led_classdev_register(&platform_device->dev, &micmute_led_cdev);
> +		if (ret < 0)
> +			goto fail_led;
> +	}
>  
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return 0;
> -- 
> 2.17.1
> 
