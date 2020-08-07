Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E46C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2C522C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axN4FL/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGNJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHGNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:09:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F74C061575
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 06:09:32 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id m19so2006992ejd.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2XCXsmJyA7W5usz6rBfTizoWqy9Uyp5cHVW9IvGA2c=;
        b=axN4FL/COED5Z5yRiWtsARF1hdhL5JgTJpfZqkBRCXe4tFeCxtQCgehSz7hPjibXzw
         jwYp+AotTyirGdBNg0299qV5KbQxVHSXao/FMMViaFCst/9JCu9xJSDK31A3nNMqhJvE
         RoyggGI4FWc+l3ItIb1XuejWp3OM4WSzgaWNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2XCXsmJyA7W5usz6rBfTizoWqy9Uyp5cHVW9IvGA2c=;
        b=NaLuRefJ0MdNWFgPzUAp8Np9y6fL/4RIiZxR+a1YbvRAL0tD4SW8T0HASU//vzi7LD
         TY8+XmADUGDNX9GnZTI5993fnBaz/YdtG3nZ+ER4cXgUk/QNQtrszlMfY5Y+2RHe1I1X
         joUgYa3UfdtNPiu5ygDVbKvapQ7WhGzEKntNfm2ITkRnFGwu3n0YnJ7xdhOpTT57OTrC
         OZSgXErPkabVn2xKDEZ6h6tUA408KlbozHgJTD467PUnamslILjuRo0OfXd1ULp/2XBv
         pzioZ24guftZ3jTIIMNzv+GDzBWRUaX7priGUmK9MN67zU8dhXi6VG1VcZE1k02TOW15
         gYKA==
X-Gm-Message-State: AOAM530EhOh799OTmirjki6LXxxiGJH9UCm9ADIE8rzQFUDDaOrF8usq
        ldaVQkURX/s0EbxQ03hLy2EE7soZKUX2ldAwiP3ZEdSl
X-Google-Smtp-Source: ABdhPJxrEzTPKTvRkUAnTnQZpqhKI9YTMaeAolXGnU7xz6Imi4rKSsQrGfHqItdJEg+dDbPYVlolH1F5VhxwHH1WaNw=
X-Received: by 2002:a17:906:3850:: with SMTP id w16mr9706026ejc.205.1596805770763;
 Fri, 07 Aug 2020 06:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
 <20200710070332.GA1175842@kroah.com> <CANMq1KDcKWgyYYP_m0-WV7602g7zUbU0PPkvwXxbSTF5vFfKGQ@mail.gmail.com>
 <CANMq1KC7CgUT+neoOUZbnr8MbDgqEikqt2vn8dxAS1rpX=C2aA@mail.gmail.com>
 <20200807062809.GB979264@kroah.com> <CANMq1KD_hJ_ST3du7dcSd8GBtdL4d-C1pWbxXz8Wu8w79-2fUg@mail.gmail.com>
 <20200807100444.0f2d3c94@coco.lan>
In-Reply-To: <20200807100444.0f2d3c94@coco.lan>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Aug 2020 21:09:20 +0800
Message-ID: <CANMq1KD1HDT75YqwyqW-wdGZGSjuq_GvGdwYNF2ZU8Cgx6HHEg@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 4:04 PM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Em Fri, 7 Aug 2020 14:51:12 +0800
> Nicolas Boichat <drinkcat@chromium.org> escreveu:
>
> > On Fri, Aug 7, 2020 at 2:28 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Aug 07, 2020 at 09:50:23AM +0800, Nicolas Boichat wrote:
> > > > On Fri, Jul 24, 2020 at 8:41 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > > > >
> > > > > On Fri, Jul 10, 2020 at 3:03 PM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Fri, Jul 10, 2020 at 02:45:29PM +0800, Nicolas Boichat wrote:
> > > > > > > trace_printk should not be used in production code, replace it
> > > > > > > call with pr_info.
> > > > > > >
> > > > > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > > > ---
> > > > > > > Sent this before as part of a series (whose 4th patch was a
> > > > > > > change that allows to detect such trace_printk), but maybe it's
> > > > > > > easier to get individual maintainer attention by splitting it.
> > > > > >
> > > > > > Mauro should take this soon:
> > > > > >
> > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > > > Mauro: did you get a chance to look at this? (and the other similar
> > > > > patch "media: camss: vfe: Use trace_printk for debugging only")
> > > >
> > > > Mauro: Another gentle ping. Thanks.
> > >
> > > It's the middle of the merge window, maintainers can't do anything until
> > > after 5.9-rc1 is out, sorry.
> >
> > Huh, wait, looks like Mauro _did_ pick it (found it in this email
> > "[GIT PULL for v5.8-rc7] media fixes").
> >
> > My bad then, I was expecting an ack ,-)
>
> Never expect acks. Kernel maintainers usually don't send them.

For some reasons I'm working mainly with maintainers who do ,-) I'll
adjust my expectations, thanks.

> Yet, in the case of media, you should probably have received
> an automatic e-mail from our patchwork instance.

Nope, didn't receive anything. But I'm happy to blame gmail for that...

Anyway, I'll ping you again after the merge window closes about
"media: camss: vfe: Use trace_printk for debugging only" (I _think_
that one didn't get merged). Hopefully not too many other
trace_printks made it through the cracks in the meantime ,-)

Thanks, have a good weekend,

>
> Thanks,
> Mauro
