Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682A4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A39F20772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXxLlaqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbgF3SAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbgF3SAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:00:33 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51385C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:00:33 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so3430346ilk.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7oL8VGd8A63dQhiVKi3PUjT96u+CwH07OR1iL+5qx4=;
        b=LXxLlaqy8X7luV1H2JLKSLljqApL0A04Nf577TG6L7GJB83ghE594x1YcLOVh8FDVH
         nSuQC0sjMcndgu5UByNZAeT4oyKGQoHtNjxOhZ+WmCKcVdyUbye3RqazYnnCyLmfwP/Q
         s+ksI2t5EMUOleIESpSn3+jyUTmwolmprisrKI0rniHWFpDHrL7bWtz6NR8QXz3cLOI1
         xtrkNIxMgc18pplFyCBd81sFvXGYk6f1mT3EiQgfUOotg2u+lC981oiFyWRvqNIE9sne
         2JXvfhtTQzheVn+GanB5HwVzngV7NjrR1J3tuOH95UPWfNrkyFYPJWteALL2gdG8tncY
         ziGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7oL8VGd8A63dQhiVKi3PUjT96u+CwH07OR1iL+5qx4=;
        b=kKwUOIX56Qls6qv+LLMdxtaiyN3+NS/UdST/nAc8br6ZbktpmNeBtog9e1L8w1oL0h
         zkA8Rr/5HnNwLzyLA0TJUVxjrMIMV5rUIIxyfJruAIviuJNUtr+wFfgQaGFH55oJTUjE
         T5kxpzBumHJIQ0IIK7kVEwdBLH780XOxJdZJgIEYC9r0HOYR5E2J5Jzv+zwXdF1eVQz9
         kw8n4zZ/LtNtM550qziacVCGa16Ud7h8xOVm+kvZNX0fkGeGf19i5qgRgNFjOYfzn/GN
         ADF/idJXfWvidxkGPNznLAHSg1PIO2WMKFWp985g/BPUFCMdAtXbCkwaAuZHxpVV6/At
         UXaw==
X-Gm-Message-State: AOAM5304FdTSwJMsz6wsZCtsZM/RdKVRSqub/Qv5x3iYjbxZ3nxQcEan
        L9q6Q/+uUIb86uUnIrjVwZbmcBev1ZZx1FfpUJo=
X-Google-Smtp-Source: ABdhPJx6lNSWEJoftbLz5gNw9hGNEAozoi4443nPKEgIfccHPGmzI05rQic143M7ShtfqDQkwHVgsssevtWA1CT4g78=
X-Received: by 2002:a92:9f96:: with SMTP id z22mr719638ilk.266.1593540032392;
 Tue, 30 Jun 2020 11:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200626100103.18879-1-a.hajda@samsung.com> <CGME20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e@eucas1p2.samsung.com>
 <20200626100103.18879-3-a.hajda@samsung.com> <5f159e00-44fd-515b-dd8c-4db9845dc9e6@ti.com>
 <7e3c924b-c025-a829-6868-78e2935c70eb@samsung.com> <66faa188-5ef6-d449-07fe-28c8be5e559c@ti.com>
 <21f5ec9c-2d1d-5f28-5aeb-ac0db144a55e@samsung.com>
In-Reply-To: <21f5ec9c-2d1d-5f28-5aeb-ac0db144a55e@samsung.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 30 Jun 2020 11:00:21 -0700
Message-ID: <CAKdAkRRLBLCLGH2qhEjaVnt8wNjoyGAfQimNWHZUvzx2m6Mwng@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:42 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> On 30.06.2020 10:59, Grygorii Strashko wrote:
> > Hi
> >
> > On 29/06/2020 14:28, Andrzej Hajda wrote:
> >> Hi Grygorii,
> >>
> >> (...)
> >>
> >>>>    /*
> >>>>     * deferred_devs_show() - Show the devices in the deferred probe
> >>>> pending list.
> >>>>     */
> >>>> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s,
> >>>> void *data)
> >>>>        mutex_lock(&deferred_probe_mutex);
> >>>>          list_for_each_entry(curr, &deferred_probe_pending_list,
> >>>> deferred_probe)
> >>>> -        seq_printf(s, "%s\n", dev_name(curr->device));
> >>>> +        seq_printf(s, "%s\t%s", dev_name(curr->device),
> >>>> + curr->device->p->deferred_probe_reason ?: "\n");
> >>>>          mutex_unlock(&deferred_probe_mutex);
> >>>>
> >>>
> >>> Sry, may be i missing smth, but shouldn't it be optional
> >>> (CONFIG_DEBUG_FS is probably too generic).
> >>>
> >>
> >> I am not sure what exactly are you referring to, but this patch does not
> >> add new property, it just extends functionality of existing one.
> >
> > Sry, needed to be more specific.
> >
> > You've added  device_set_deferred_probe_reson(dev, &vaf);
> > which expected to be used on every EPROBE_DEFER in dev_err_probe() in
> > combination with
> >
> > +       } else {
> > +               device_set_deferred_probe_reson(dev, &vaf);
> >                 dev_dbg(dev, "error %d: %pV", err, &vaf);
> >
> > ^^ dev_dbg() does not add any runtime overhead during boot unless enabled
> > +       }
> >
> > But:
> >
> > +void device_set_deferred_probe_reson(const struct device *dev, struct
> > va_format *vaf)
> > +{
> > +       const char *drv = dev_driver_string(dev);
> > +
> > +       mutex_lock(&deferred_probe_mutex);
> > +
> > +       kfree(dev->p->deferred_probe_reason);
> > +       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s:
> > %pV", drv, vaf);
> > +
> > +       mutex_unlock(&deferred_probe_mutex);
> > +}
> >
> > ^^ Adds locking, kfree() and kasprintf() for every deferred probe
> > during boot and can't be disabled.
> >
> > Right?
>
>
> Right, but usually the burden should be insignificant in comparison to
> probe time, so I do not think it is worth optimizing.

I do not think this is going to take. You are suggesting that we
modify pretty much every driver to supply this deferral reason, and I
doubt it will happen. Can we put this burden on providers that raise
the deferral? I.e. majority of code are using devm API now, so we most
likely know the device for which deferral is being raised. We can have
a list of deferral reasons and their devices and when in device code
once probe is done we could try reconciling it with the deferred
devicelist, and this would mean you only need to implement this in
gpiolib, regulator core, clocks core, etc.

Thanks.

-- 
Dmitry
