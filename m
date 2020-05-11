Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2696EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B5520720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W8GsoKBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgEKJSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:18:33 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36113C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:18:32 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x13so2251182qvr.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbfgjCIJCT731lsX+VnBCmkJyCHAocQc+0O+jnIBrdA=;
        b=W8GsoKBTh3eU7gK0hFlJ0SlnR4/zsOEdiEu38ZroK0AD/j0RkfeKchZBEqi62uiRc6
         URDF81n5X0ocDhATQJCsPzqQmANVVyixmbQnVl+EVmPhoxZnMzKIIdJLifoKd6qDSW7R
         g3/nx11QoXUNQSXk3ZbTaRZs5bDYZlnQKGcgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbfgjCIJCT731lsX+VnBCmkJyCHAocQc+0O+jnIBrdA=;
        b=jQfOZYYhXJ8mnDqW8dLz7dqloXwM0TuN7s8DZX441nQicm7yDUbJJeLyZ/WfAuEM8d
         wFpJxoSs6/Zc1DSgW2DguWhtT6U+l5x0pFN9XcBeVvnsQFS3B/W+41wOjKBG60wO5tPe
         iqNqD1rt8diwa4FWb8/p2j1Z9XSPNuQ9GWU49aGx0wGkp1+fS8+Y5HVy6BI4Joas/oDC
         vvdn5mhpRYW6WX6Ycf2nVlOHswxZfGKNfx81aCBTJwsvhNZKX2lgDNqrwLGFbq55qrQ3
         Bs4cIiDlgMf6m3bwvxCp67V0eOR2IUEp1JQhAs7BBnPDamYjcElSFPdhX1Ltr1pelZOB
         TtCw==
X-Gm-Message-State: AGi0PuaQ82PWyZKonICtOUaPiVWuqg0fVJ7KXKkBTAvvNlPGIj54kqAv
        Xdjau1cr7OFzjEjm8mwcGKbnnYt1gHPjDueZddT6Kw==
X-Google-Smtp-Source: APiQypKT98jJ+xFT05/I6LmJQeISERtWb2r4N0celT3NHNTNMdSnrXvpVHkM+TeXsrBCRZ3aCItbNo4jo662cXs8B6E=
X-Received: by 2002:a0c:90e7:: with SMTP id p94mr14956340qvp.219.1589188710998;
 Mon, 11 May 2020 02:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200510213934.146631-1-pmalani@chromium.org> <6921cb24-091b-1de3-5348-a1dd8a6803f5@gmail.com>
In-Reply-To: <6921cb24-091b-1de3-5348-a1dd8a6803f5@gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 11 May 2020 02:18:19 -0700
Message-ID: <CACeCKaeohcaOt7sfWR0FWaSp8CLEa5_6afAZUdYYTn2S_wXOew@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: mux: intel: Fix DP_HPD_LVL bit field
To:     Lars Melin <larsm17@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:USB TYPEC CLASS" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

Thanks for reviewing the patch.

On Mon, May 11, 2020 at 1:49 AM Lars Melin <larsm17@gmail.com> wrote:
>
> On 5/11/2020 04:39, Prashant Malani wrote:
> > According to the PMC Type C Subsystem (TCSS) Mux programming guide rev
> > 0.6, the PMC HPD request LVL bit field is bit 4.
> > Fix the definition here to match the programming guide.
> >
> > Since this bit field is changing, explicitly define a field for the
> > HPD_HIGH mode data bit.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > Fixes: 6701adfa9693 ("usb: typec: driver for Intel PMC mux control")
> > Reviewed-by: Benson Leung <bleung@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Fixed bit error in commit message.
> >
> >   drivers/usb/typec/mux/intel_pmc_mux.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
> > index 67c5139cfa0d..15074aec94eb 100644
> > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > @@ -63,6 +63,7 @@ enum {
> >   #define PMC_USB_ALTMODE_DP_MODE_SHIFT       8
> >
> >   /* TBT specific Mode Data bits */
> > +#define PMC_USB_ALTMODE_HPD_HIGH     BIT(14)
> >   #define PMC_USB_ALTMODE_TBT_TYPE    BIT(17)
> >   #define PMC_USB_ALTMODE_CABLE_TYPE  BIT(18)
> >   #define PMC_USB_ALTMODE_ACTIVE_LINK BIT(20)
> > @@ -75,7 +76,7 @@ enum {
> >
> >   /* Display HPD Request bits */
> >   #define PMC_USB_DP_HPD_IRQ          BIT(5)
> > -#define PMC_USB_DP_HPD_LVL           BIT(6)
> > +#define PMC_USB_DP_HPD_LVL           BIT(4)
> >
> Please keep the bits sorted
Sure. Will send a new version of the patch with this change.

Best regards,
>
> >   struct pmc_usb;
> >
> > @@ -158,8 +159,7 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
> >                        PMC_USB_ALTMODE_DP_MODE_SHIFT;
> >
> >       if (data->status & DP_STATUS_HPD_STATE)
> > -             req.mode_data |= PMC_USB_DP_HPD_LVL <<
> > -                              PMC_USB_ALTMODE_DP_MODE_SHIFT;
> > +             req.mode_data |= PMC_USB_ALTMODE_HPD_HIGH;
> >
> >       return pmc_usb_command(port, (void *)&req, sizeof(req));
> >   }
> >
>
> Thanks
> Lars
