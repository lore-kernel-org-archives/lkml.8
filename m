Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D94C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610352071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwm6eR+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFOVyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFOVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:54:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CD6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:54:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id u17so10288672vsu.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrYyEhrRR6A5rIUcHiiWKnKi36VydppgntucqfFstLE=;
        b=bwm6eR+s1orKJ3oyZ9Evd8YxotI8L3vP/Xg/h+t06qh76qO5Lb51v1SB9upmRYjV2f
         cG2cX/p+DjUzsyOcbhFkET9YLFuu6WWZUAKAu+xZ5n/O8eWl48D258TMWnh/L1FDxiee
         Qjju8cTjw4FT0zGUpcc+hyctWFGLmL6TpQ5dnV79SQBAidhMFi9bb6B+L2yksoC0jFo/
         Ot8lzg/2tgTyb8JZuPn5BYqIdpFxwxB2Mj4MNliPscaXm0T4nnncQ2i/0q0VJ7ZgWIBI
         mNpuNpDqdhsl3XVgzxSlWXAXUaEUui5mGUSwvHV7UuyK18mFMu0c2noUSGL5vvED4t3L
         UhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrYyEhrRR6A5rIUcHiiWKnKi36VydppgntucqfFstLE=;
        b=tFJ3SwMOyZ+JXLtBJurquz5+Lr2OlH+NflQRTgZKRYt/lCTIBQufVmQpm/gsDMJZBJ
         PU28FnaU48uC6kR5U80IxHlctQciyp5IXSn3YaGh88L1H4gAyqKM/V/9fyXuiG/Jn95j
         uIdN9TlT8NVvp0T+qzU5yfQAJBHXcosc1Fme8Omh5jzYRdPuniL1TYzuqVk8MOrJiMbD
         Pp88gqFWDMrE7VLFU9ZX+F4fwJZd2aOXvTeQOmejP5CL3I6KpahnHe805tpyXG+Uq9TS
         xkM0mALyuLMZIbO7wfTwn3S6QL1GEdSSQWZVUO4N9TwP/ViHOkxndDCsO2+V6F1HK+LI
         OQiA==
X-Gm-Message-State: AOAM533B5NEps4xBp7NMRW2c8pWt5xMpywEMEAnmh/HE5zxCassOhlyG
        2fXJrW4Ik5yLJJfCmNfmqNHFONDth8dmoufcUK8=
X-Google-Smtp-Source: ABdhPJy7D3emZODXkL1/U8Y2sm3fS3ljMw96Eg6vvLxmwafjbNp6R4+BfIc0eGrhlDtmI027Mj7tNOKRixSNT5HOXcA=
X-Received: by 2002:a67:f918:: with SMTP id t24mr21149749vsq.18.1592258051538;
 Mon, 15 Jun 2020 14:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-8-jim.cromie@gmail.com> <20200615132028.GE31238@alley>
In-Reply-To: <20200615132028.GE31238@alley>
From:   jim.cromie@gmail.com
Date:   Mon, 15 Jun 2020 15:53:45 -0600
Message-ID: <CAJfuBxxdoZ1T9nLi-X2g=zk8poLX-CtRAA=0A-i1KPq2_RhX9Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/24] dyndbg: fix a BUG_ON in ddebug_describe_flags
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 7:20 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Sat 2020-06-13 09:57:21, Jim Cromie wrote:

> In all patches is missing:
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

right, I missed the -s invoking format-patch, v3 will have them


>
> > ---
> >  lib/dynamic_debug.c | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 9b2445507988..aaace13d7536 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -87,22 +87,22 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
> >       { _DPRINTK_FLAGS_NONE, '_' },
> >  };
> >
> > +struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
>
> This looks too complicated. What about?
>
>         typedef char flags_buf[ARRAY_SIZE(opt_array) + 1];
>     used as
>         flags_buf fb;
>

I used the struct to give type safety.
old code passed a pointer to a string, and hoped it was big enough.
then used a BUG_ON to insist.
passing (the address of the) struct means the contained string is
known big enough.
and the addy is also that of the string itself (member offset 0), no overhead.

>
>         #define FLAGS_BUF_SIZE (ARRAY_SIZE(opt_array) + 1)
>     used as
>         char flags_buf[FLAGS_BUF_SIZE];
>

I never needed that constant, cuz the string is filled once,
in the function just below the struct def, using the same expression (sans +1)

I would/will update the 1-line comment on ddebug_describe_flags
and add another on the struct itself, once I figure out how to say
all of this succinctly and clearly enough.
Im open to suggestions.

thanks
jimc

>
> Best Regards,
> Petr
