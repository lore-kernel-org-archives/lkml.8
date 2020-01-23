Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B02C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519F421569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBWUy2bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAWSQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:16:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAWSQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:16:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so3516798wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wA0Wlh+bd+MxRm3pbZVk/Z3ATg06ui/SAg+IeXpD4OE=;
        b=PBWUy2bhRdikggryP8vrrfs3us8jT66cGBG5UclsBcCOs55TitHn/AqOsbVMM8s+JC
         YhOdYvXE58Q6IEU7ZHXgZKpOMmV7WED4iplM/r9eq+5r+BebcB2VOxBdoENXeU01abfb
         ZkMRMxJIhNmHAY8WHyx4PWkAZaB8awa/PNMgaDtlUBogkdXz11wk2V1HG+5o+RETq5eb
         xHMRXyp+kM2yyzQ7Wmrcib0v7RW7JlkVN7aBIUfBAZvO9AzJQmVyI8Xy5fLYOO0pDdkW
         nzHJk80MGXYxaAuVDl8ABfFKdtccGsPVYVlWOaKkQqosxP26SrXZFCunZpEOxNZiAJQn
         6rAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wA0Wlh+bd+MxRm3pbZVk/Z3ATg06ui/SAg+IeXpD4OE=;
        b=o15Kr2uNR4nj8ZC5fZsQlZYwbPN8DBKOBEw53hXdaRJt9YCq51XNcDKkf5gWTzoGuN
         lFyR/RmB+Tpra7KcLaprKoS7RMxIVP9vnioWxnrs2loVhUgHNOIkJXXKveU9VkTYTEAe
         GjYY+yCk3dgAImtxMyyZUjZUsd6lhthDrFn4wAJR50/nWYP3q2ekTg3+8Y6ii5EVnwBU
         hpMIcBInlbh2xsz0tzHGtN5J+pGuW8LOp71JXigno8xiIS5oYSbDtjA0Or0KJgHVcl/F
         uoO3887gTXK3qCur+91b00AM8EtMOer264R2u1JymYN9QSf54RrIUYFJ8OeqvsbBsd+Q
         EQxg==
X-Gm-Message-State: APjAAAUKEW0HSV1q0n6Ccv7Z1cUwibXs/qdqYUeJl/9bhzZ+Xpk7aqnL
        N49nId3wES8gBNAeFd7TST+GoL2t3AYcFh5giA4=
X-Google-Smtp-Source: APXvYqxMWRfg6O8UAm4VcJ2/Kqy36PAXmSCue2SezbqRmFiaWzZoOYrtkoYatbjzAKCy47K1rRrcJZQ3n4v9DdWFepE=
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr5207959wmm.44.1579803406444;
 Thu, 23 Jan 2020 10:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20200123154706.5831-1-daniel.baluta@oss.nxp.com> <20200123175658.GB1796501@kroah.com>
In-Reply-To: <20200123175658.GB1796501@kroah.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 23 Jan 2020 20:16:35 +0200
Message-ID: <CAEnQRZAnfT0kBCmir+-cTkg+8bgO0pk+1S-rSfUVobf=Hzxz7g@mail.gmail.com>
Subject: Re: [PATCH] lib: devres: Export devm_ioremap_resource_wc
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "info@metux.net" <info@metux.net>,
        "ztuowen@gmail.com" <ztuowen@gmail.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 7:57 PM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 23, 2020 at 03:47:21PM +0000, Daniel Baluta (OSS) wrote:
> > From: Daniel Baluta <daniel.baluta@nxp.com>
> >
> > So that modules can also use it.
> >
> > Fixes: b873af620e58863b ("lib: devres: provide devm_ioremap_resource_wc()")
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  lib/devres.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/devres.c b/lib/devres.c
> > index 6ef51f159c54..7fe2bd75dfa3 100644
> > --- a/lib/devres.c
> > +++ b/lib/devres.c
> > @@ -182,6 +182,7 @@ void __iomem *devm_ioremap_resource_wc(struct device *dev,
> >  {
> >       return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_WC);
> >  }
> > +EXPORT_SYMBOL(devm_ioremap_resource_wc);
>
> EXPORT_SYMBOL_GPL() perhaps?
>
> What in-tree driver needs this?

I was experimenting with an out of tree driver and I also was using it wrong :D.
Indeed looks like there is no real potential user so far in the kernel tree.

Perhaps: drivers/net/ethernet/amazon/ena/ena_netdev.c

Also, I chose EXPORT_SYMBOL because the same way its cousin
devm_ioremap_resource.

Daniel.
