Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E032BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B986120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5EC2Oaf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgF2TCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgF2TCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF3C030F24
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:36:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h4so1216127plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cP6iQsVZnZL9cfv3sLl/5r6hzqX0rVayprzDZmD8fls=;
        b=q5EC2OafxVTf2u/iQVD0g8yJF3Y1bDOuicqD7IHdDsvf5/fGCEdbx9n3vhiYTT2qiC
         fXBtNHHkfMBVzxvHYFkKG4rc+UqQ1k+C6Zc1++iOwPtLEWdKwxKR0b4Hexnp5badz2e9
         Emob2Nui7WvtyIQWV2bepfCdG5Z+H4LQOzS6+qE7Mk/UpmWlaayYsRadT8JfLDeJuF7b
         ekEIDf7quMaUYxhU8LTapw6ta8ft2Dnmm1EFyyS+Va4/NSNILgilR0dN32QjzYEyHoPS
         cVvD1LHMsN1bihCtlFjyMsdBqea389T0XZ7BeI/GjaXKXlZmPjNU8WYzYSUbXsvl1n2F
         1iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cP6iQsVZnZL9cfv3sLl/5r6hzqX0rVayprzDZmD8fls=;
        b=F2C4riixD9Z5TSuzIybSFFwZRMlZWYkfnbkM/fplv9AMTUYrdRGsDFhUf/t8NcZ6E5
         sP7xxFqDbjilSQvXQcZfbT3OYdWFYdBKP1pTYk9hvEjdIEEob2lLuqRyegottENC8i/N
         D8GLb8AJTI+9M8xrPvwkEnWG8p6CWykqSvX0X+AJW8Z2i8RBgkF85GidGgzzjbgwSo7/
         d2kVZuVYG9Kpjas0gL7UuSLWlu/wpPqPoQtCb2YtCaL5MJ/Tr4asLwRsGF9t9ehUZRF5
         NQgseuPuCxsDXF6Gfh5pX1y2HjhNc+8avM2Usj/04imC2NsIJ7JrGMyf4VcUuTRGIzv4
         slaQ==
X-Gm-Message-State: AOAM530epQgLGYyxnzxGTovaUmj6dTdx3T9kTUfW9Gxfzlns3b0ZFBWy
        dkx8QkRzCdlnr5A2AfvJXdsp5jUjuKf7ZxwKhy8=
X-Google-Smtp-Source: ABdhPJxY0TieHGnK37IC/NZ8PHvS+nU0xr2yP6SeSbn2otyH5MinztJSPrmwBVJET9OWG4mysZKu95H1GtfccfKlpyw=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr18146343pjr.181.1593448616001;
 Mon, 29 Jun 2020 09:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da@eucas1p1.samsung.com>
 <20200629112242.18380-1-a.hajda@samsung.com> <20200629112242.18380-3-a.hajda@samsung.com>
In-Reply-To: <20200629112242.18380-3-a.hajda@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Jun 2020 19:36:42 +0300
Message-ID: <CAHp75VdS_u8h4qfBxsQRUp1-2SL_hq20=dQkpteXH7Xg7epArQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:22 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> This list does not contain reason why the driver deferred probe, the patch
> improves it.
> The natural place to set the reason is dev_err_probe function introduced recently,
> ie. if dev_err_probe will be called with -EPROBE_DEFER instead of printk the message
> will be attached to deferred device and printed when user read devices_deferred

to a deferred

reads

> property.

...

> @@ -3984,10 +3986,12 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
>         vaf.fmt = fmt;
>         vaf.va = &args;
>
> -       if (err != -EPROBE_DEFER)

> +       if (err != -EPROBE_DEFER) {

Why not positive conditional? (Okay, I'm fine with either in this case)

>                 dev_err(dev, "error %d: %pV", err, &vaf);
> -       else
> +       } else {
> +               device_set_deferred_probe_reson(dev, &vaf);
>                 dev_dbg(dev, "error %d: %pV", err, &vaf);
> +       }

To reduce churn, you may move {} addition to the first patch.

...

>         list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> -               seq_printf(s, "%s\n", dev_name(curr->device));
> +               seq_printf(s, "%s\t%s", dev_name(curr->device),
> +                          curr->device->p->deferred_probe_reason ?: "\n");

Hmm... "\t" will be dangling in the latter case.

-- 
With Best Regards,
Andy Shevchenko
