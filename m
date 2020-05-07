Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F12C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E450520A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588850016;
	bh=pV3ronhkIEWAJcNoKw7OVs+fbJV2F891DPKci/Ts4nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wR2udFr2X8iLMIgVjIusiu3NnXWvsuL48zN72nAueUng2oYBybFZvSkh0vKx2QrZe
	 aJ/j4rAAloA+j+dpvxXXMqSUXHaPHnNf0mnIg13eFYIOnZz3VBkk/MDikDsJICG74f
	 qP76I60nrqck2YO/agyFiXXiZ+LJRwS2ITKPYhrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEGLNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgEGLNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:13:34 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9DF208E4;
        Thu,  7 May 2020 11:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588850014;
        bh=pV3ronhkIEWAJcNoKw7OVs+fbJV2F891DPKci/Ts4nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AH17zeETL9jLSPxgFlT3ARPqHgyVWNrm++uyvd9Mblf60Ivx7Wp8Vyv54i6EL5LBE
         6QufC0K9RKSWGCDasaW+zwIU0ub6XyEtDxMeYKSt6avPt31Uf3cZHuy9qU7B+208+O
         v+esGjl+Ical9l9+6EzENSTGdPW44TqauGY342/g=
Received: by pali.im (Postfix)
        id 768AB60D; Thu,  7 May 2020 13:13:31 +0200 (CEST)
Date:   Thu, 7 May 2020 13:13:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     koba.ko@canonical.com
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Message-ID: <20200507111331.dzge7htw5toejh72@pali>
References: <20200507094242.7523-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507094242.7523-1-koba.ko@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 May 2020 17:42:42 koba.ko@canonical.com wrote:
> From: Koba Ko <koba.ko@canonical.com>
> 
> Error messge is issued,
> "platform::micmute: Setting an LED's brightness failed (-19)",
> Even the device isn't presented.
> 
> Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> If one of two tokens doesn't exist, don't register platform::micmute.
> 
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
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

Hello! I think that this is correct approach. Changing micmute LED is
done via those GLOBAL_MIC_MUTE_DISABLE and GLOBAL_MIC_MUTE_ENABLE
tokens. And if these tokens are not supported by hardware then linux
kernel should not register micmute LED device. There are lot of Dell
machines without led diode for microphone and these machines obviously
would not support those tokens.

But this change is incomplete as registration of led class dev would be
optional. So deregistration also needs to be optional.

And I think there is missing better description / explanation of this
change to make it clear what really happens.

>  
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return 0;
> -- 
> 2.17.1
> 
