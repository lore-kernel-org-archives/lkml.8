Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1838FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E480520675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXxJ7jHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgF3KAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgF3KAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:00:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:00:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bj10so3052480plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bS0b9bomKbWXIqGH1Zn1LUVsA5coUEY5p6IxbrWuUK8=;
        b=hXxJ7jHSRR9RC7jPAR8UazOI0+y6V4kRxr3Yvm4SgETLWpYx9ONMzLlV7qJpbOY/6W
         HbRjoYS5yrixrD/eNc8NQG2gTvYVyprGeojRsBzDeKUhoo30xVrDvD1u524X4jOv0Efs
         KjZd5woAIewUlg1ZLitc8ogpLw357Y0Vzt57JHhlidrx/k2XW/hSRDYLDEftzxHsh3Gf
         YBxloTbDS1Cmxfi2ObHtLSy/2qn1Sz50FOZR4kAmnVxSBJ9RB6LKcOtYFXAVfp5rdkco
         KcKNemTAxhE1vGcyMgR64hSpgTDd6pCnXQAUo1aYC75E24oob1cMcspCRkY1DWHeBByM
         64uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bS0b9bomKbWXIqGH1Zn1LUVsA5coUEY5p6IxbrWuUK8=;
        b=aSo7xRROn43OiWllOQJUn/KoNGzaEAWTJd6xrTk9Gegcu1+Nr3YItn5GEsjegk1/Sd
         bBOLZkKnKu0/R6k+AzRwNq98fMB73eLVhn5IoBtQ/fV5x93h4AjENskner8eqCJ7XyWn
         kwTIw3xF+9K4gYGQCSuU9TPatx03UkN8hZ5/7HC6rTInZLxekvHpC80vHv17bUkt9Q/w
         KGNFTvxSU210oWFQBUlhTXxPvItOEvLTXxdUvnO9vQ/BboRH5lFANrBxXRIbL6bbkcBm
         HGFq3TrbDc5XveFXtJhCXXEvxRM01gF/s8tblidhu9mZhOte4CoZ9M+Re4Zk2iPH9seM
         ybvg==
X-Gm-Message-State: AOAM530Dmgmhl23QBVJBSY1UVzzacs+Z4/e1sucWjhWR9FozJeZdxH6V
        PKNAucs4dCmYftpRRrpves3enI0lDa1PsT9bA08=
X-Google-Smtp-Source: ABdhPJyDAWVlXnklUfmuNIokLXtYElqabkjA8Cr1sJHfddgAENO5LBwoK9RGkW420nWl8wlBjw/H2sVLKtawRm0W9Mg=
X-Received: by 2002:a17:90a:d712:: with SMTP id y18mr760791pju.228.1593511214814;
 Tue, 30 Jun 2020 03:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200629112249eucas1p160b845444f8fbad96bdec41e9d3938da@eucas1p1.samsung.com>
 <20200629112242.18380-1-a.hajda@samsung.com> <20200629112242.18380-3-a.hajda@samsung.com>
 <CAHp75VdS_u8h4qfBxsQRUp1-2SL_hq20=dQkpteXH7Xg7epArQ@mail.gmail.com> <a48ab93c-0d9c-ed8b-76dd-62007826bf6f@samsung.com>
In-Reply-To: <a48ab93c-0d9c-ed8b-76dd-62007826bf6f@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Jun 2020 13:00:01 +0300
Message-ID: <CAHp75VdgCJXEkLuUQ7Z+5J499TNtgvsXG=4cncuQuKqAgHm4hw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 11:32 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 29.06.2020 18:36, Andy Shevchenko wrote:
> > On Mon, Jun 29, 2020 at 2:22 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> >> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
> >> This list does not contain reason why the driver deferred probe, the patch
> >> improves it.
> >> The natural place to set the reason is dev_err_probe function introduced recently,
> >> ie. if dev_err_probe will be called with -EPROBE_DEFER instead of printk the message
> >> will be attached to deferred device and printed when user read devices_deferred
> > to a deferred
> >
> > reads
> OK, thx.
> >
> >> property.

...

> >>          list_for_each_entry(curr, &deferred_probe_pending_list, deferred_probe)
> >> -               seq_printf(s, "%s\n", dev_name(curr->device));
> >> +               seq_printf(s, "%s\t%s", dev_name(curr->device),
> >> +                          curr->device->p->deferred_probe_reason ?: "\n");
> > Hmm... "\t" will be dangling in the latter case
>
>
> Hmm, I followed your advice [1] :)
>
> [1]:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1787370.html

Ah, indeed :-)
Okay, as I  said I'm fine with the code. Since it's debugfs, we are fine.

-- 
With Best Regards,
Andy Shevchenko
