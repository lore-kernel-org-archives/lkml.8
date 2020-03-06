Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ADCC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3043206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="kLCqtObt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCFOTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:19:12 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46287 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCFOTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:19:12 -0500
Received: by mail-vs1-f67.google.com with SMTP id s9so786838vsi.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue2+GwbAPb84xyTjVZigWk3TSNspoTjpeZtjLHwtUDw=;
        b=kLCqtObta9BeGJh62CMUO94J6gqwExyrRmFNmMapac/A0byC0oAbnP6qYgH5Rgi6hp
         OBjS3LSWmOdiJE4IkC7FyzMSgK2tiHqwzaZS25QCD8W4ykFaMiDouTT2feE64iTOVUMt
         jzQZcAcSNe5nflmPlD/KCiW7C2wHIoUj2p+FYt6Mu/jowVcIA4bkPPZspD88Uu35Q3io
         TfK/Qhe8Cc2QTkFHhlR0C86CudQFnb+h1pesi5QkFmCbJI5uTcKV/zYtJzOJMA+X9ybq
         1U/EPMZ09snFNtU3MEeMpYzGL4p2fC+LgtaE7UvKve543AfnGtAF/tUHdIIryri1pQLv
         YTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue2+GwbAPb84xyTjVZigWk3TSNspoTjpeZtjLHwtUDw=;
        b=eWyjquQBbeSejXq6HQAcMpf6yr/FiXExfXjrYj6HoCSMtoHoXNJt1Qw4TMrgHch2Y8
         gbed3ezd1FOgIsiUtpb2uDFvByi16XLNjm4z3TlVNkKeV3GsDj098zel8cdjHkDYETAF
         OpKKydkiM3rzLlw2Bcwv7dWbEcGmYU5FdoSPPJJdJ7OK+HmRJmGNMOTb8ueBjomsI0nC
         imyK7r8m3NqpZ9QBxu/7VgNxCwW/fLc6lSCJ4k20S2BtWD1tT+cPGUIazgWE8oGlHEMK
         jIYhhL0bNxGQiupqaYsF+8jfz1e3/D2FYmLCAKZv0ZgQ9Yn7RHSy1g9sTFPqH9Ky5ZQt
         alqw==
X-Gm-Message-State: ANhLgQ3NQWxHzitMjSk8oO+bysANP4+IJw+wJsJPqvNVFB2c4sTdxld0
        qnutQ79lbY8f0FIdjPRJSc3sMIeI/dUfPfD762lmuQ==
X-Google-Smtp-Source: ADFU+vvC1TodqjsSeoIjJ1HIWOBW8NAESW1icga2msXRV5KjGlswYzQCE3pwVXXKVRA8M9W0cupPQz2xYP/PM14si54=
X-Received: by 2002:a67:f296:: with SMTP id m22mr2143928vsk.237.1583504350791;
 Fri, 06 Mar 2020 06:19:10 -0800 (PST)
MIME-Version: 1.0
References: <20200305183951.2647785-1-angelo.dureghello@timesys.com> <20200305184517.GA2141048@kroah.com>
In-Reply-To: <20200305184517.GA2141048@kroah.com>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Fri, 6 Mar 2020 15:21:23 +0100
Message-ID: <CALJHbkBcv_On-QtoQ-9kecE7f+M_UP350DXTDfNax3eVcZne7w@mail.gmail.com>
Subject: Re: [PATCH] w1: ds2430: non functional fixes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

sorry, no intention to be rude, i replied previously to greg
(email-bot message) only,
without including all, just a mistake.

Was just about asking what to do to fix the issue reported by the bot.

Regards,
Angelo

On Thu, Mar 5, 2020 at 7:45 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Mar 05, 2020 at 07:39:51PM +0100, Angelo Dureghello wrote:
> > Mainly discovered a typo in the eeprom size that may lead to
> > misunderstandings.
> >
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > ---
> >  drivers/w1/slaves/w1_ds2430.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
> > index 6fb0563fb2ae..67d168ddfb60 100644
> > --- a/drivers/w1/slaves/w1_ds2430.c
> > +++ b/drivers/w1/slaves/w1_ds2430.c
> > @@ -1,7 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * w1_ds2430.c - w1 family 14 (DS2430) driver
> > - **
> > + *
> >   * Copyright (c) 2019 Angelo Dureghello <angelo.dureghello@timesys.com>
> >   *
> >   * Cloned and modified from ds2431
> > @@ -290,6 +290,6 @@ static struct w1_family w1_family_14 = {
> >  module_w1_family(w1_family_14);
> >
> >  MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
> > -MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256kb EEPROM");
> > +MODULE_DESCRIPTION("w1 family 14 driver for DS2430, 256b EEPROM");
> >  MODULE_LICENSE("GPL");
> >  MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_DS2430));
> > --
> > 2.25.0
> >
>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.  This will make it easier to review the
>   patches to ensure that they are correct, and to help alleviate any
>   merge issues that larger patches can cause.
>
> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/SubmittingPatches for what is needed in order to
>   properly describe the change.
>
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/SubmittingPatches for what a proper Subject: line should
>   look like.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot



-- 
Angelo Dureghello
Timesys
e. angelo.dureghello@timesys.com
