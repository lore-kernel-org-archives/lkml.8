Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34771C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02662206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 00:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BirI9o13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgEAA4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEAA4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 20:56:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FFBC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:56:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so1698874pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37JzE6dO7W63uNk97bdpwnKTw03BVNHUQMku3iX92TE=;
        b=BirI9o13LaYlRDUQQps/Dm4/3J8cQB3/DWHqJ6staa7enYULUwkOjG6eGuPtfYsmzK
         T1tBwiM2AXjVsNj9oV7GxwnT/lBhAvGz664C99GR7nFS54EQfVjJs0ZmK3dHgLD0GEy8
         fgZ2tNyglhz05NBmCXBRhyOJAZP/HmC+esSPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37JzE6dO7W63uNk97bdpwnKTw03BVNHUQMku3iX92TE=;
        b=m3UjOxHkxgMVvaHmyA1hhqqruvzXSVFbMPlM8rP2khxGFVcsri9O9uHBx1SGEdutC5
         sj3vZPeA9EWvS9MxAsJUfKYDKUpZSiZz8JxV5bmz0jQw86CBqsF7KANrU0Cd5F0yTTj4
         4SLPytdNBO/p3iNqtEcnEP2lpqXf/jmYsFYQ8jF7+j3sZlGpOxYWoTOb2u+V9SpCvuSu
         Bg5/HNAQBonf4JJN/H63ZUzMXfIFc5/dlOlBRIj5P8E9GdiZ8Y/Pvkc2dt7aT8bpO4qP
         vIx5F6uztBma9liOHFg07YD3pzmV9yU1vS/tAofT3Zb92H/QCZ2BVce1UIJUF0lmfCgo
         cBBQ==
X-Gm-Message-State: AGi0PuYTZFgaxL8VkiB4gA3ugwg8ATgYun4wHfGyXtF4tKIA6RLCC69K
        Jey68Tu5y61o1BhGeEIIQgC9SQ==
X-Google-Smtp-Source: APiQypL2EjMoePzDlS7L05+cQm5XN7B9LvgzzFOvwppc9pwXj6C1pVPWOfwR9P4JNsn2pSr2MIgHXg==
X-Received: by 2002:a17:902:7592:: with SMTP id j18mr1878591pll.43.1588294570951;
        Thu, 30 Apr 2020 17:56:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id i18sm752183pjx.33.2020.04.30.17.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 17:56:10 -0700 (PDT)
Date:   Thu, 30 Apr 2020 17:56:09 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
Message-ID: <20200501005609.GA131713@google.com>
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
 <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com>
 <CAONX=-dLVBpz+p1si4cWGHEmQ_toO8kW=fCPcdUuX2KLc-o=2A@mail.gmail.com>
 <CAONX=-dDWjMQDGncSgXNf86Bt3C5OUtFqh=Pe2HToGPSv5qa4A@mail.gmail.com>
 <CACeCKacoEjQm0_VfZGYNEZVhKubPyqspNZupQk+7piJOsVzH+Q@mail.gmail.com>
 <fc7901ff-9e67-d6d5-f084-70233fd8344c@collabora.com>
 <CACeCKafnrMk_=Udg-roEbrkDzZe6m3mUk14OOVVROmn-agfpDA@mail.gmail.com>
 <CAONX=-cR0H2zrGEunwq2k3g+d=9asmeu39ssFN31yFs6i-wktQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-cR0H2zrGEunwq2k3g+d=9asmeu39ssFN31yFs6i-wktQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

On Fri, May 01, 2020 at 10:15:18AM +1000, Daniil Lunev wrote:
> On the official revision of coreboot for hatch it doesn't even try to
> load Type C. However it gives some warning messages from
> cros-usbpd-notify-acpi about EC, So I wonder why the check of the same
> type is not appropriate in the typec driver?

I think the difference is that GOOG0003 is already present on shipped /
official versions of coreboot (so not having that check can cause
existing release images/devices to crash), whereas for GOOG0014 that is / isn't the case.

Is GOOG0014 present on the official release coreboot image for this
device? If so, what's its path (/sys/bus/acpi/devices/<HID>/path) ?

Best regards,

-Prashant
> 
> ../chrome/cros_usbpd_notify.c
> 
> /* Get the EC device pointer needed to talk to the EC. */
> ec_dev = dev_get_drvdata(dev->parent);
> if (!ec_dev) {
> /*
> * We continue even for older devices which don't have the
> * correct device heirarchy, namely, GOOG0003 is a child
> * of GOOG0004.
> */
> dev_warn(dev, "Couldn't get Chrome EC device pointer.\n");
> }
> 
> 
> # dmesg
> ...
> [    8.513351] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
> [    8.722072] cros-ec-spi spi-PRP0001:02: EC failed to respond in time
> [    8.729271] cros-ec-spi spi-PRP0001:02: Cannot identify the EC: error -110
> [    8.736966] cros-ec-spi spi-PRP0001:02: cannot register EC,
> fallback to spidev
> [    8.767017] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
> [    8.807537] cros-usbpd-notify-acpi GOOG0003:00: Couldn't get Chrome
> EC device pointer.
> ...
> 
> On Fri, May 1, 2020 at 2:17 AM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Enric,
> >
> > On Thu, Apr 30, 2020 at 8:26 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > >
> > > Hi Prashant,
> > >
> > > On 30/4/20 2:43, Prashant Malani wrote:
> > > > On Wed, Apr 29, 2020 at 5:38 PM Daniil Lunev <dlunev@chromium.org> wrote:
> > > >>
> > > >> [to make it appear on the mailing list as I didn't realize I was in
> > > >> hypertext sending mode]
> > > >>
> > > >> On Thu, Apr 30, 2020 at 10:11 AM Daniil Lunev <dlunev@chromium.org> wrote:
> > > >>>
> > > >>> Hi Enric.
> > > >>> I encountered the issue on a Hatch device when trying running 5.4 kernel on that. After talking to Prashant it seems that any device with coreboot built before a certain point (a particular fix for device hierarchy in ACPI tables of Chrome devices which happened in mid-April) will not be able to correctly initialize the driver and will get a kernel panic trying to do so.
> > > >
> > > > A clarifying detail here: This should not be seen in any current
> > > > *production* device. No prod device firmware will carry the erroneous
> > > > ACPI device entry.
> > > >
> > >
> > > Thanks for the clarification. Then, I don't think we need to upstream this. This
> > > kind of "defensive-programming" it's not something that should matter to upstream.
> >
> > Actually, on second thought, I am not 100% sure about this:
> > Daniil, is the erroneous ACPI device on a *production* firmware for
> > this device (I'm not sure about the vintage of that device's BIOS)?
> >
> > My apologies for the confusion, Enric and Daniil; but would be good to
> > get clarification from Daniil.
> >
> > Best regards,
> > >
> > > Thanks,
> > >  Enric
> > >
> > >
> > > >>> Thanks,
> > > >>> Daniil
> > > >>>
> > > >>> On Thu, Apr 30, 2020 at 7:58 AM Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> > > >>>>
> > > >>>> Hi Daniil,
> > > >>>>
> > > >>>> Thank you for the patch.
> > > >>>>
> > > >>>> On 28/4/20 3:02, Daniil Lunev wrote:
> > > >>>>> Missing EC in device hierarchy causes NULL pointer to be returned to the
> > > >>>>> probe function which leads to NULL pointer dereference when trying to
> > > >>>>> send a command to the EC. This can be the case if the device is missing
> > > >>>>> or incorrectly configured in the firmware blob. Even if the situation
> > > >>>>
> > > >>>> There is any production device with a buggy firmware outside? Or this is just
> > > >>>> for defensive programming while developing the firmware? Which device is
> > > >>>> affected for this issue?
> > > >>>>
> > > >>>> Thanks,
> > > >>>>  Enric
> > > >>>>
> > > >>>>> occures, the driver shall not cause a kernel panic as the condition is
> > > >>>>> not critical for the system functions.
> > > >>>>>
> > > >>>>> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> > > >>>>> ---
> > > >>>>>
> > > >>>>>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
> > > >>>>>  1 file changed, 5 insertions(+)
> > > >>>>>
> > > >>>>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > > >>>>> index 874269c07073..30d99c930445 100644
> > > >>>>> --- a/drivers/platform/chrome/cros_ec_typec.c
> > > >>>>> +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > >>>>> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_device *pdev)
> > > >>>>>
> > > >>>>>       typec->dev = dev;
> > > >>>>>       typec->ec = dev_get_drvdata(pdev->dev.parent);
> > > >>>>> +     if (!typec->ec) {
> > > >>>>> +             dev_err(dev, "Failed to get Cros EC data\n");
> > > >>>>> +             return -EINVAL;
> > > >>>>> +     }
> > > >>>>> +
> > > >>>>>       platform_set_drvdata(pdev, typec);
> > > >>>>>
> > > >>>>>       ret = cros_typec_get_cmd_version(typec);
> > > >>>>>
