Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22532075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvHyL//F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEGJGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGJGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:06:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392CC061A10;
        Thu,  7 May 2020 02:06:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so1827229plo.7;
        Thu, 07 May 2020 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zB6KCEK7TB4Ul95mU6ErFEYo41SwJ2qtyYHsKsjS6YU=;
        b=JvHyL//FfLIb7kDd60ruAjegFZ62Ou6EcVLY2VvHTgv+1Y1G2EwVp4P5rDaMukrd7e
         wpecYEDwJRT+H9HwWNSBQ2aWk14rehYzIhJqd+66vr69pGUlXj++ArvBIQyG3tZpOUEp
         ZdbFrtj0WVPIow8SNnefGxx41TheMz789Px3xnAK5/KnhkB31GKHiS/9C3Wue/L1U4lO
         dy7nO1nZdMkEmYPvlB1VqrOi92M36KZhuzG5mq1DEHro6aMkoTAxHHQX5h2DkiYiln5b
         CLvcUGvAar/aPRmXQF1nSTEpyPTRq6Un72AbhqVPqTX7xdz6nFM7c+6uRsCK0agMZvTz
         xOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zB6KCEK7TB4Ul95mU6ErFEYo41SwJ2qtyYHsKsjS6YU=;
        b=FBRI4cRSvKkt7qzMvwA0zOk4vNbFHFIf0o0hd11c2LY34AGsnjt85VwAbWnNwMwJIC
         miIE6k/O5Y9lnG34fBsLn3rlBVU2rkm0rhEWIexZpK6FZR04hEXhh6ae0kb5VrQ9TfkO
         31t4cWz8Inx4sx/sh0gqtmMXkA4/xHP0fOzbjNjOHeqWQbMDlN6EXuUNHfVE3UQUwnD+
         x+H8/0M1fgeEQhGNp5VGso7IPVXxfb6MoKw91U8np4HhZS6kVcSlfxvL5MxFnywUG7Y4
         34gNQSzKIAstid613TAJUKJswQpoEhlIaxUCLid2vHlrPykr3jYC4nEuR+y4vTElFt98
         QbWQ==
X-Gm-Message-State: AGi0PuZnCnr94zzGj1AquSXwO2laR4LC0fmNq6zraI4U0U3AMPNAFndf
        FN4jmgJnHg09wUDU/CuE2gwVMV0f8+QxR9MRPh0=
X-Google-Smtp-Source: APiQypJ099F+kAgS2dxU3s6BO9RS4epw2m0F0/u4ORYfEPrBjeSR1KiFtYi/DQQc347lz1jbuRJd6/xf92O29ozBFoU=
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr12224937ply.262.1588842395893;
 Thu, 07 May 2020 02:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200430111258.6091-1-alcooperx@gmail.com> <20200430111258.6091-4-alcooperx@gmail.com>
 <20200505110036.GB93160@kroah.com> <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
 <CAHp75VeA8JnsJgEgkv0wivinsxvk51JTVyaPhmLhsjzkqZYR8A@mail.gmail.com> <20200507064145.GB777100@kroah.com>
In-Reply-To: <20200507064145.GB777100@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 12:06:24 +0300
Message-ID: <CAHp75Vdok4WxH9b2q1GK7W_mcmNW-OuReC0y1wLQH9YLYqupmg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] usb: ehci: Add new EHCI driver for Broadcom STB SoC's
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Cooper <alcooperx@gmail.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, May 07, 2020 at 12:01:16AM +0300, Andy Shevchenko wrote:
> > On Wed, May 6, 2020 at 11:23 PM Alan Cooper <alcooperx@gmail.com> wrote:
> > > On Tue, May 5, 2020 at 7:00 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:

> > > > > +     /* Hook the hub control routine to work around a bug */
> > > >
> > > > What bug?  This feels wrong.
> > >
> > > The bug is explained in a comment above the ehci_brcm_hub_control()
> > > routine as follows:
> > > /*
> > >  * ehci_brcm_hub_control
> > >  * Intercept echi-hcd request to complete RESUME and align it to the start
> > >  * of the next microframe.
> > >  * If RESUME is complete too late in the microframe, host controller
> > >  * detects babble on suspended port and resets the port afterwards.
> > >  * This s/w workaround allows to avoid this problem.
> > >  * See SWLINUX-1909 for more details
> > >  */
> > > I'll remove the internal bug tracking reference from the comment.
> >
> > I guess you may leave the internal bug reference. I can tell from my
> > experience that's hard to understand what was going on in the driver
> > in years perspective. It will help whoever in this company have a
> > chance to look after the driver.
>
> "internal bug references" mean nothing to the 99% of the people that can
> see this.  Document the heck out of what this is instead please.

As far as I understand the bug is being described in the same file
somewhere else, that's why internal reference *on top of explanation*
would be valid.

-- 
With Best Regards,
Andy Shevchenko
