Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB6C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982F7206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmASnIuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgDPU5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbgDPU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:57:33 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBAAC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:57:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m2so4320374otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GzOuJ3S/DFvn5UM5AKP4FQW2r3C3chBE+8H/zimqdDA=;
        b=nmASnIuWH0Ut4kVXuBo12o5JhsMDz9RPCCDVOq5XYPySFXiRzhlJwopONlCYVaBf5+
         JeD5hL4WCOYygaeJo0AiHGN4z9eTlaOkWeDkF5lNnULrYDqvA93tef+PnECkZh5BGnOx
         6hPaqjkc8znx+dLXtWTUjFE2d7zMiJ3yWjGSifCUB4CZjPXiHWRXMcjLe8lwXaRR8XyD
         4Vq+DN3WOKWMS1kO1fCj+wPZWzF/dMp8DKkw7HU5gQp0Vu6jrDXj0W7b6qzJcW6TMfrd
         Lku3CFCaEjRghzI3B0LehTsRr1BBQWYDLgqwOIPFnBpE/AMd1KLYfup409V9EROqPgpF
         CU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzOuJ3S/DFvn5UM5AKP4FQW2r3C3chBE+8H/zimqdDA=;
        b=uRqommbp4wcB9qY9M2qio/cFQlU66BefIie8uTQ8NoP+AGkvh/9TneLW0ZMupkIX58
         fqPygwmNn8hRpmgAYARZ/l0L0NBewsm5Npm3ZFbb9y6rD0z3lZeLJleX5aVPDV15Vop5
         R7YzPjnOTw42QxpNBklJqa8ZP0wz800N/hpvrR8S0bGtwO+DhwHO65DQyUhROMQ1AFx1
         32EevS8YBPI5c0wtgfvKBUUQ2hrjNAfZyZyAK5f44Rfq/qcZYgmSZ/I6F4GH8ABenq6A
         KsdVsbyjpGLf2+NVyWLbavl1C0wVtP07mqceGDvATBNO1kqBh2GnF2yGm5ucdOEXM143
         cEDQ==
X-Gm-Message-State: AGi0PuY1+suVS9lz4w6/rc3U8CTAhy787wOLigFuSVVw6S24qWYOaHgV
        8MvRUKL0EeGsUDYbhp8IkpMnUfEiEv4i58W+unex0i4c
X-Google-Smtp-Source: APiQypJFplIwtmaFuGeE8IUbW3EaiUwiZSL5xbJKCJMGJF9i9axClRWNQn/5/wiu0qIGvLfGpxXEGkxKzBKBqeYmId8=
X-Received: by 2002:a9d:4c91:: with SMTP id m17mr11151otf.139.1587070651803;
 Thu, 16 Apr 2020 13:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200415150550.28156-1-nsaenzjulienne@suse.de>
 <20200415150550.28156-3-nsaenzjulienne@suse.de> <CAGETcx_7cTp0zx2hfGX0X=NpudkAjER8YeLMmRxTEtoqxc0pFw@mail.gmail.com>
 <55611d3e028b6ea418cba1ef9d94fe7bf1e1b1fd.camel@suse.de>
In-Reply-To: <55611d3e028b6ea418cba1ef9d94fe7bf1e1b1fd.camel@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 16 Apr 2020 13:56:55 -0700
Message-ID: <CAGETcx8_BUirqE4Nzj-U4hxVozFdX4n4dryF=D1OX_+EYQo=jA@mail.gmail.com>
Subject: Re: [PATCH 2/4] of: property: Do not link to disabled devices
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 4:37 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Wed, 2020-04-15 at 11:30 -0700, Saravana Kannan wrote:
> > On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > When creating a consumer/supplier relationship between two devices, make
> > > sure the supplier node is actually active. Otherwise this will create a
> > > device link that will never be fulfilled. This, in the worst case
> > > scenario, will hang the system during boot.
> > >
> > > Note that, in practice, the fact that a device-tree represented
> > > consumer/supplier relationship isn't fulfilled will not prevent devices
> > > from successfully probing.
> > >
> > > Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT
> > > bindings")
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > ---
> > >  drivers/of/property.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index a8c2b13521b27..487685ff8bb19 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1052,6 +1052,13 @@ static int of_link_to_phandle(struct device *dev,
> > > struct device_node *sup_np,
> > >                 return -ENODEV;
> > >         }
> > >
> > > +       /* Don't allow linking a device node as consumer of a disabled node
> > > */
> > > +       if (!of_device_is_available(sup_np)) {
> > > +               dev_dbg(dev, "Not linking to %pOFP - Not available\n",
> > > sup_np);
> > > +               of_node_put(sup_np);
> > > +               return -ENODEV;
> > > +       }
> > > +
> >
> > Again, surprised I haven't hit this situation with the number of
> > disabled devices I have.
>
> I'll point out to the example that triggered this issue on my reply to patch
> #4.
>
> > The idea is right, but the implementation can be better. I think this
> > check needs to be the first check after the of_node_get(sup_np) --
> > before we do any of the "walk up to find the device" part.
> >
> > Otherwise, you could have a supplier device (the one with compatible
> > prop) that's available with a child node that's disabled. And the
> > phandle could be pointing to that disabled child node. If you don't do
> > this as the first check, you might still try to form a pointless
> > device link. It won't affect probing (because the actual struct device
> > will probe) but it's still a pointless device link and a pointless
> > delay in probing, etc.
>
> Agree, I'll update the patch.

I thought about it more. I think you should do this check in the loop
that's walking up to the "compatible" node because any node in that
path having status=disabled would/should disable this supplier if I
understand DT correctly. Technically we need to do this all the way up
to the root, but we'll do that if we have actual reports of that
causing problems. Otherwise, it's just wasteful.

-Saravana
