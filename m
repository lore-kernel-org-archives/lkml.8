Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C1AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FB620885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AktzP1qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgGDUyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgGDUyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:54:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24989C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 13:54:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so10475271pfq.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6PmxtU26J104QjdAPS4bilmwtEeT3TLjN53LBeepDs=;
        b=AktzP1qpR1WTXWaM4qWySrlhq4kJmUcLMYC1PLSqylxGEGiNY1E94Y0AAvWsRRtxdu
         jiF5ZkmWl+zCb/jYZdjSa0RfdHLGlat+epiUvLWYpype4rDZNhCT6DNeFJ1FxpXpiARR
         JC/zRNwICw2Gcv/8eF7IEkDBizaiAOt7GllHNEGzZXl4WE7eeuwKMwvqkSMqxcnFZ+3O
         oiHnP8xaRyRVWdkojMZRGsp4seXiqYdnmxwsgxYMtcwL/BjzOrIKGoLJgpe8It7sI66e
         8ESbtoE29KhxPrLH334rsRjYj9ig22aUvxDY7mZ9FCwcnfIOnSh2eBq1w7ffSBezfuLf
         XztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6PmxtU26J104QjdAPS4bilmwtEeT3TLjN53LBeepDs=;
        b=mrfmCcxZmAbBNbbfSWWmbym3W8C5i/vQvRlVhSp4/8mAQOB6jaRBGFiuNmjJmaGOuW
         rmYLVrJxRUrhptgV3LTV0poLt7tu5l0Wx6vvEghubCjzvlZbCTZN7Qx+02wJjjrf5RbY
         Iqvdh0w2bDCEpQmYoZ97PpRvmCmNOVjnssrloNnyUoAgXu08mHAEjEPKjXD0kd0S9Ywe
         3c9KUTPs+YNw+idw6WI3KaCswJQ/WDrefsTeIzVdDMINb8wKt3lST8pyZdSiU2PzJGQA
         lrnEGMVt2aEEpOeG4UWahEDv8yy9xN4mOdK7xSbPrIu7laccsQo2w9Dtb4Zo8RtiW+UM
         KCAA==
X-Gm-Message-State: AOAM530vkOggfO9NOfrk/+VvmQ/Y1dE4uB09TehDQ69sJlFofRFHZe+q
        rl17iblxKMw3uYN9pSuAUUtJjz6yB+XnqwyRAPFIvY68
X-Google-Smtp-Source: ABdhPJypceqcB51zvTmovBbJigCVusomdHRfDBdDi8tBLMpZ58trq+8Lt/EYeqIcNZa4igFnzXGABuIH1VEBixCWmos=
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr2359035pfu.36.1593896078764;
 Sat, 04 Jul 2020 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ve4O+OmVttjhtKepFWwZLU6tFMx5vNpPVJdB58mcLFm3w@mail.gmail.com>
 <613b-5f00e780-a9-10028e00@255553491>
In-Reply-To: <613b-5f00e780-a9-10028e00@255553491>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 23:54:22 +0300
Message-ID: <CAHp75Ve7JO0xJzwODoNS6f_UcvNtWTTu9mJxWAE0xEyBpHqQSg@mail.gmail.com>
Subject: Re: Writing to a const pointer: is this supposed to happen?
To:     Kars Mulder <kerneldev@karsmulder.nl>
Cc:     David Laight <David.Laight@aculab.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 11:32 PM Kars Mulder <kerneldev@karsmulder.nl> wrote:
> On Saturday, July 04, 2020 16:39 CEST, Andy Shevchenko wrote:
> > > I've searched for a function that parses an int from a string and
> > > stores a pointer to the end; I can find some function simple_strtoul
> > > that matches this criterion, but it's documented as
> > >
> > >     "This function has caveats. Please use kstrtoul instead."
> > >
> > > ... and kstrtoul does not store a pointer to the end. The documentation
> > > of kstrtoul describes simple_strtoul as obsolete as well.
> >
> >
> >  Where? We need to fix that, because using simple_strto*() is fairly legal
> > in cases like this, but "has caveats".
>
> In lib/vsprintf.c, the comments before the function's implementation say:
>
>     /**
>      * simple_strtoul - convert a string to an unsigned long
>      * @cp: The start of the string
>      * @endp: A pointer to the end of the parsed string will be placed here
>      * @base: The number base to use
>      *
>      * This function has caveats. Please use kstrtoul instead.
>      */

This is correct.

> Many variants upon kstrtoul, such as kstrtoull, defined in lib/kstrtox.c,
> describe the simple_strtoull function as obsolete:
>
>     /**
>      * kstrtoull - convert a string to an unsigned long long
>      * [...]
>      *
>      * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.

>      * Used as a replacement for the obsolete simple_strtoull. Return code must
>      * be checked.
>      */

This and similar are not correct. 1/ They are not replacement per se
(because of different behaviour). 2/ They simple_strto*() are not
obsoleted.

Can you correct all places you found and make it consistent?

> I seem to have been slightly inaccurate about my claim that "kstrtoul"
> describes simple_strtoul as "obsolete" though, because in the specific
> case of kstrtoul, include/linux/kernel.h only says:
>
>     /**
>      * kstrtoul - convert a string to an unsigned long
>      * [...]
>      *
>      * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
>      * Used as a replacement for the simple_strtoull. Return code must be checked.
>     */

> (Also, there may be a documentation error here: all kstrto* functions in
> kstrtox.c and kernel.h describe themselves as replacements of simple_strtoull.
> E.g. kstrtol and kstrtoul also describe themselves as replacements of
> simple_strtoull rather than as a replacements of simple_strtol and
> simple_strtoul respectively.)
>
> By the way, I found the documentation of the caveat somewhere in
> include/linux/kernel.h:

Yes, that's what has been added lately to clarify the usage of
simple_strto*() vs. kstrto*().

>     /*
>      * Use kstrto<foo> instead.
>      *
>      * NOTE: simple_strto<foo> does not check for the range overflow and,
>      *   depending on the input, may give interesting results.
>      *
>      * Use these functions if and only if you cannot use kstrto<foo>, because
>      * the conversion ends on the first non-digit character, which may be far
>      * beyond the supported range. It might be useful to parse the strings like
>      * 10x50 or 12:21 without altering original string or temporary buffer in use.
>      * Keep in mind above caveat.
>      */


-- 
With Best Regards,
Andy Shevchenko
