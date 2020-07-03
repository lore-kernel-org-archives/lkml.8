Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD78DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B760F20826
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiGOeYGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGCKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCKqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:46:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF2C08C5C1;
        Fri,  3 Jul 2020 03:46:39 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so24369508oty.11;
        Fri, 03 Jul 2020 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0c5wHg9VNJDHK0sa3QsCKAxp+om6hYF0jilSpO9w9y4=;
        b=BiGOeYGCax7/oPiLMt4Z6w4thxBd15Pucyb6wzwm9ayylbBXjPbKcPMn3l4US3gxKl
         3a9P3ymozjwGGbmCmfJkcEWBPFCjum2ytt4KF/NMM2a+TMkIMUhOZRBvmaQSrdWe8HxO
         SRA4YAcWn4+aGzYPu5ia7biJCoQ+g6NwB+pdnRvO6KDOxZGLv4ZJfBEkege93pDsNm9m
         0YqE+A6uO1o/11+Qz7Enq7db/XzHol53RA4CjLs66Tx931mv0sYxpPecF3a8vBdKkmdr
         FxxjTK46Z4H86QU0qoCCgFxUuB9imHVi4fnVs1DbXo8twCcjvc6LU0+FKz1ErihB+eHF
         1rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0c5wHg9VNJDHK0sa3QsCKAxp+om6hYF0jilSpO9w9y4=;
        b=nva5cordZ1UAt1popQZRQSUg8Sfy8F9457zQgOqtyBhq/Apj+LU539VxnIKeRFZisd
         Md+235uYrIJ+EMCD9w7cAeOORNOKSL82jHmdTyU379aZQU4pR/lXxojBlFL8V2Ym2Fam
         OKjtDhkKf5ZWHOjqtt1TqJJDJ/7c6AUMGM2cbfRqZD0FB1g5zFeLRMkjkSMR6IbWcNIt
         caZUEbVL+W1RzNICzDZoRJVNp9c7QY7Ie8wjdZ2iYO6Ba5wY+s0MLldztFjRZGdrIXjo
         L+ETTrqmpMvE19N7+La12C23bfGN/z8imm31knkNGB4ngLrjSMmnVLW+IuqXRLrGn8zd
         8mXQ==
X-Gm-Message-State: AOAM533+KXASeDeyGOPn6KsmgCaxae02VPom6JzKY3vfIPOkbZwe11jS
        JLDKdXsvxQWqvd3jYXxXO0Fiij18BhzY+eSORIA=
X-Google-Smtp-Source: ABdhPJy21MyHS89arWOkjOjzCKkhAW8rJyKdTPBlC3SxBSlhm8uBhnJ/okQbnyg8Agy85BzoVoq1mGIP+zq0w/SMlmA=
X-Received: by 2002:a05:6830:1510:: with SMTP id k16mr10884514otp.336.1593773198367;
 Fri, 03 Jul 2020 03:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200629201845.28138-1-ruslan.bilovol@gmail.com> <20200630015843.GB12443@b29397-desktop>
In-Reply-To: <20200630015843.GB12443@b29397-desktop>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Fri, 3 Jul 2020 13:46:27 +0300
Message-ID: <CAB=otbSnP7ecO9W5osxqSHSa4JRCUU4KR-g2BjBweDBUwjWobA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: epautoconf: claim smallest endpoints first
To:     Peter Chen <peter.chen@nxp.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 4:58 AM Peter Chen <peter.chen@nxp.com> wrote:
>
> On 20-06-29 23:18:45, Ruslan Bilovol wrote:
> > UDC hardware may have endpoints with different maxpacket
> > size. Current endpoint matching code takes first matching
> > endpoint from the list.
> >
> > It's always possible that gadget allocates endpoints for
> > small transfers (maxpacket size) first, then larger ones.
> > That works fine if all matching UDC endpoints have same
> > maxpacket size or are big enough to serve that allocation.
> >
> > However, some UDCs have first endpoints in the list with
> > bigger maxpacket size, whereas last endpoints are much
> > smaller. In this case endpoint allocation will fail for
> > the gadget (which allocates smaller endpoints first) on
> > final endpoint allocations.
> >
> > To make endpoint allocation fair, pick up smallest
> > matching endpoints first, leaving bigger ones for
> > heavier applications.
> >
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> > ---
> >
> > v2: rebased onto latest balbi/next branch
> >
> >  drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> > index 1eb4fa2e623f..6c453b5d87bb 100644
> > --- a/drivers/usb/gadget/epautoconf.c
> > +++ b/drivers/usb/gadget/epautoconf.c
> > @@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
> >       struct usb_ss_ep_comp_descriptor *ep_comp
> >  )
> >  {
> > -     struct usb_ep   *ep;
> > +     struct usb_ep   *ep, *ep_min = NULL;
> >
> >       if (gadget->ops->match_ep) {
> >               ep = gadget->ops->match_ep(gadget, desc, ep_comp);
> > @@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
> >                       goto found_ep;
> >       }
> >
> > -     /* Second, look at endpoints until an unclaimed one looks usable */
> > +     /*
> > +      * Second, look at endpoints until an unclaimed one looks usable.
> > +      * Try to find one with smallest maxpacket limit, leaving larger
> > +      * endpoints for heavier applications
> > +      */
> >       list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> > -             if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
> > -                     goto found_ep;
> > +             if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
> > +                     if (desc->wMaxPacketSize == 0)
> > +                             goto found_ep;
>
> Why you do special handling for this? You still could give the smallest
> maxpacket_limit EP for it, right?

Of course it's technically possible. However in case "wMaxPacketSize == 0"
gadget driver wants to get maximum possible wMaxPacketSize from endpoint
configuration and I was thinking about avoiding regressions if we always provide
smaller endpoints.

As I can see, providing smallest endpoint that matches requested wMaxPacketSize
is OK, but if gadget driver just wants autoconf core to use it with
maximum possible
value, I'm thinking now if we can even change this part and if wMaxPacketSize
is zero, find endpoint with maximum possible wMaxPacketSize

Does it make sense?

Thanks
Ruslan

>
> Peter
>
> > +                     else if (!ep_min)
> > +                             ep_min = ep;
> > +                     else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
> > +                             ep_min = ep;
> > +             }
> >       }
> >
> >       /* Fail */
> > -     return NULL;
> > +     if (!ep_min)
> > +             return NULL;
> > +
> > +     ep = ep_min;
> >  found_ep:
> >
> >       /*
> > --
> > 2.17.1
> >
>
> --
>
> Thanks,
> Peter Chen
