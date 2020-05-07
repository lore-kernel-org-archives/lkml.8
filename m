Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AA5C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588851922;
	bh=SBh6/SXccjf0Rc9czYTuq+JdW1OUZENjqIfTY2GjdZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=niqynvEfc2ZQtbkO9OAx8BYXeXOYfeZx0OSG/mDCm58SXeszwdYjKIwkgPAM4MukF
	 ywMs6LX98seGMD+g/ZcHLmpyX1p3sqIsmazLRGq9G27mPTtlZoCRtlzePZagpZqfGq
	 5sAprrnGNHBZFbRGnJ/inONDvBkPjOcq4dYNOhR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEGLpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGLpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:45:20 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE18320A8B;
        Thu,  7 May 2020 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588851920;
        bh=SBh6/SXccjf0Rc9czYTuq+JdW1OUZENjqIfTY2GjdZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCJRtJi3qexOPDYQdj2fKINE8LTBEnOnKdvLZ5pEu6Gpuut/bGZJQc2OCrwf7z7y4
         olSRzcLwF4os2cUduO4PGB1uXY1gArDmHcy+BEoxej+/yCcPIoRcjFUboLebKCmbhR
         HRohX1jCL4rP7xbXVDns9/MI3fCo3orIitul8kMQ=
Received: by pali.im (Postfix)
        id 01D5760D; Thu,  7 May 2020 13:45:17 +0200 (CEST)
Date:   Thu, 7 May 2020 13:45:17 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Koba Ko <koba.ko@canonical.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Message-ID: <20200507114517.tslux7m7aysuwaok@pali>
References: <20200507094242.7523-1-koba.ko@canonical.com>
 <20200507111331.dzge7htw5toejh72@pali>
 <CAJB-X+WKqrWuKK0=BWtj7f8AovsMzbCO-QaLi2ZaP0_Q6321WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJB-X+WKqrWuKK0=BWtj7f8AovsMzbCO-QaLi2ZaP0_Q6321WQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 May 2020 19:27:47 Koba Ko wrote:
> Hi Pali,
> don't understand "registration and deregistration would be optional',
> could you explain more!?

After your patch led_classdev_register() function is not always called.
And led_classdev_unregister() should not be called when there is no
device registered.

> I will modify the comment of patch.
> 
> On Thu, May 7, 2020 at 7:13 PM Pali Rohár <pali@kernel.org> wrote:
> 
> > On Thursday 07 May 2020 17:42:42 koba.ko@canonical.com wrote:
> > > From: Koba Ko <koba.ko@canonical.com>
> > >
> > > Error messge is issued,
> > > "platform::micmute: Setting an LED's brightness failed (-19)",
> > > Even the device isn't presented.
> > >
> > > Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> > > If one of two tokens doesn't exist, don't register platform::micmute.
> > >
> > > Signed-off-by: Koba Ko <koba.ko@canonical.com>
> > > ---
> > >  drivers/platform/x86/dell-laptop.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/dell-laptop.c
> > b/drivers/platform/x86/dell-laptop.c
> > > index 1e46022fb2c5..afc1ded83e56 100644
> > > --- a/drivers/platform/x86/dell-laptop.c
> > > +++ b/drivers/platform/x86/dell-laptop.c
> > > @@ -2208,10 +2208,13 @@ static int __init dell_init(void)
> > >
> > >       dell_laptop_register_notifier(&dell_laptop_notifier);
> > >
> > > -     micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > > -     ret = led_classdev_register(&platform_device->dev,
> > &micmute_led_cdev);
> > > -     if (ret < 0)
> > > -             goto fail_led;
> > > +     if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> > > +         dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> > > +             micmute_led_cdev.brightness =
> > ledtrig_audio_get(LED_AUDIO_MICMUTE);
> > > +             ret = led_classdev_register(&platform_device->dev,
> > &micmute_led_cdev);
> > > +             if (ret < 0)
> > > +                     goto fail_led;
> > > +     }
> >
> > Hello! I think that this is correct approach. Changing micmute LED is
> > done via those GLOBAL_MIC_MUTE_DISABLE and GLOBAL_MIC_MUTE_ENABLE
> > tokens. And if these tokens are not supported by hardware then linux
> > kernel should not register micmute LED device. There are lot of Dell
> > machines without led diode for microphone and these machines obviously
> > would not support those tokens.
> >
> > But this change is incomplete as registration of led class dev would be
> > optional. So deregistration also needs to be optional.
> >
> > And I think there is missing better description / explanation of this
> > change to make it clear what really happens.
> >
> > >
> > >       if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
> > >               return 0;
> > > --
> > > 2.17.1
> > >
> >
