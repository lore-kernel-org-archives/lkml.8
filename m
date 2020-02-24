Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92825C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D30218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582581249;
	bh=aOO2lCKSp3VaKlzq/VAE3aJCP3FjGA4lRbfGB35tGgI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L/mIYfN64/GfQalkjNJozeVH1mauVSv9TjuNY8zOMLYWz8HjqH81ZqzHXC2DdfFrZ
	 3sgREKLn8VIlLz3hjA+IHJ2SwFh/LaGpIgK7y8kEC2KMQnMoUpY1xBQtm3bBjjIe3w
	 QToKh7JCSFhZG24MLTSAbGCjEJ+qPoEvS1auqmjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgBXVyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:54:08 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgBXVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:54:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id e18so11775295ljn.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XuyignvH4d5GLfKgfJb+g8gkqcI95RWBR4W4WVX7AA=;
        b=AtiEK30pYt+3beHkK87zyVbW+qDAYJlbkd0TiDCu6tlrTVZ0Twny1U+XoXYS9WKUX8
         BpZqBNxHSI+1oBqNYdIeDY8EcwnbNkUkPmT0bLEzVPa7lfTFcBkAqimEh73dLdvyJ4uh
         87cz/bQOr0vU6VwfEOKctFokpv/75L2FGtd3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XuyignvH4d5GLfKgfJb+g8gkqcI95RWBR4W4WVX7AA=;
        b=ZQUabXAiXVOrl8y3hg0m45e1JBax3jhiiN1y0b6QC29MdBZN/i1M/zpafDPTm40Ua/
         6EdLSGfpym7wtyMxli4WOWqGcmQBNaK9S97Crcix923YhBiVJlAwY0I/tM/9Y1PeLx+a
         PuGVnFT7ewGNa5ld4LA7lMyuAskvTAsIyDTLzxEEuLOqWbwh8hnxI2+YTqLuvVHaRLBD
         CSgX8jjEaBFc+MOgXgW3Xm0E02PJRk3DoEjTwlXvJY1lV2dCk/W48vXmICWKB3wxK3Dh
         vv1F+0jqzhMBMuwE4n5aKBCXuoTpexroHO9qQTdgExYrNPw79K8UIXm6ey8ksuYqoSD6
         /wGA==
X-Gm-Message-State: APjAAAV6vMuLCDRsgJQNZpelEYyNdQn9e+2IWHK9/D24Aw6RVqzm8Ior
        FBAlP69iRX6lKXCnNsZOTF6gb9GkpzE=
X-Google-Smtp-Source: APXvYqwrypNBNVGOUGybBC6pvos1f9DgoUhjKS9XSINzixMlgEa0rmn3zbe8Mz8DS6wusSnuMbJeVA==
X-Received: by 2002:a2e:8702:: with SMTP id m2mr32402456lji.278.1582581245033;
        Mon, 24 Feb 2020 13:54:05 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u9sm6729789ljk.33.2020.02.24.13.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 13:54:04 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id a13so11779677ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:54:04 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr30211282ljg.209.1582581243727;
 Mon, 24 Feb 2020 13:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20200224212352.8640-1-w@1wt.eu> <20200224212352.8640-2-w@1wt.eu>
In-Reply-To: <20200224212352.8640-2-w@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 13:53:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
Message-ID: <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
To:     Willy Tarreau <w@1wt.eu>
Cc:     Denis Efremov <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 1:24 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Macro FDCS silently uses identifier "fdc" which may be either the
> global one or a local one. Let's expand the macro to make this more
> obvious.

Hmm. These macro expansions feel wrong to me.

Or rather, they look right as a first step - and it's probably worth
doing this just to have that "exact same code generation" step.

But I think there should be a second step (also with "exact same code
generation") which then renames the driver-global "fdc" index as
"current_fdc".

That way you'll _really_ see when you use the global vs local ones.
The local ones would continue to be just "fdc".

Because with just this patch, I don't think you actually get any more
obvious whether it's the global or local "fdc" index that is used.

So I'd like to see that second step that does the

    -static int fdc;                 /* current fdc */
    +static int current_fdc;

change.

We already call the global 'drive' variable 'current_drive', so it
really is 'fdc' that is misnamed and ambiguous because it then has two
different cases: the global 'fdc' and then the various shadowing local
'fdc' variables (or function arguments).

Mind adding that too? Slightly less automatic, I agree, because then
you really do have to disambiguate between the "is this the shadowed
use of a local 'fdc'" case or the "this is the global 'fdc' use" case.

Can coccinelle do that?

                Linus
