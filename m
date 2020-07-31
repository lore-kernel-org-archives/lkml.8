Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6114C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06822083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzZfQVVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbgGaPse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:48:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB023C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:48:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so7621681pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FlYZ0BGAoZaUHrTCOzNPZQBwvno0FHswWnWRF+VZvM=;
        b=ZzZfQVVHdmhfwtnsSjLGIUeKQWORu/xcNeQxctRTzPXmnklAFEZRVjdAeV4MKuQDAf
         9hriTNlrcaPsivHIljrbOU5XCT7KvjCQ0zlDRyB1XoQ9tIwUjxINQ/gIaBZr87Y5cgBr
         rH2ptUAkBwc/jh87T7rJca7Jkor4+KyUNm8csGwbe6fmG1s94Ja/pCB0px3xYOoNzawD
         o2h2tQ7JonhEN26vNK6dUgqnXAeIwjBn0aIyYkcTpYYPbiDdQ6suEEEgzEPWTmZV3pst
         35w4yzVkxB4wFRjYH219GCUutI3tx7eC5qM7BhtREyiOq8R10IaSk/B+jxGlaIJV2jE4
         E99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FlYZ0BGAoZaUHrTCOzNPZQBwvno0FHswWnWRF+VZvM=;
        b=oSYHB26Ad/+IkuqrfObXSjMXe+4w8sjYJZqliiKFYy8eJuHwxbQptBcUxqswP8U98j
         qRPmOWPulKlevD+QWhjQhJbcFastjB38bJhSY4m8VCgFGJeoWtejUmaISJW2kA/JQIxq
         7gM91j7S50zE+Il36cLvFA1JsS7y9GS/YveoXAkYZG8R2LavBfjIY9h9Q66B4u09JiCf
         /JIrdBcf55VTc6zAYTKEXvQs/PzvBAjbynTAuZ0qSLXho43qqe3VHhUFsARFhFU+h4B8
         IzRqmm1czXQcgHQ28/ydiuH9P9/B4estSRnxT90zDx4WsM0jJkhXQ4m1cRR5zfnc9SKN
         5Njg==
X-Gm-Message-State: AOAM5321Tcrf+0b4Uyf57Kg0UFHYKOR6cnn+vreF5+WX3oVpc/0ic69C
        zN6spzohWYeobGPZVpmDM0jRa7BjvtMZmGzZyF8=
X-Google-Smtp-Source: ABdhPJxgoJzyNN1CY3Hsgnqt2iHEgQWTpoYxwVy43kCCT0nMoMPktNR0ZwAF6AzZLMw4Xut5WWNrA5v8pNUlIUe+kNE=
X-Received: by 2002:a17:90a:390f:: with SMTP id y15mr4564999pjb.181.1596210513294;
 Fri, 31 Jul 2020 08:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
 <20200731123145.22357-2-andriy.shevchenko@linux.intel.com> <20200731111510.27c2ef73@oasis.local.home>
In-Reply-To: <20200731111510.27c2ef73@oasis.local.home>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 18:48:16 +0300
Message-ID: <CAHp75VfBS5k+-QU6NiPwgGjLUmGNuXPGNFjX9JyEd60BrcWEqQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 6:17 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 31 Jul 2020 15:31:44 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > When printing phandle in %pOF the custom spec is used. First of all,
> > it has SMALL flag which makes no sense for decimal numbers. Second,
> > we have already default spec for decimal numbers. Use the latter in
> > %pOF case as well.
>
> The change log threw me off, as this is specifically for %pOFp. This
> only affects the phandle ('p') portion. Please update the change log to
> reflect that.

I think phandle implies this, but I update for sake of clarification.

> Also, I would add in Cc those that added this code and looked it over:
>
> Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Rob Herring <robh@kernel.org>
>
> And mentioned in that code's change log:
>
> Cc: Grant Likely <grant.likely@arm.com>

Okay, will do.
Also I have to mention that this (actually entire series) has been
tested against test_printf and OF unittest modules.

> Otherwise,
>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> -- Steve
>
>
>
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 8a8ac7ce0289..90d818ef03c5 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1979,12 +1979,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >       char *buf_start = buf;
> >       struct property *prop;
> >       bool has_mult, pass;
> > -     static const struct printf_spec num_spec = {
> > -             .flags = SMALL,
> > -             .field_width = -1,
> > -             .precision = -1,
> > -             .base = 10,
> > -     };
> >
> >       struct printf_spec str_spec = spec;
> >       str_spec.field_width = -1;
> > @@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
> >                       str_spec.precision = precision;
> >                       break;
> >               case 'p':       /* phandle */
> > -                     buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
> > +                     buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);
> >                       break;
> >               case 'P':       /* path-spec */
> >                       p = fwnode_get_name(of_fwnode_handle(dn));
>


-- 
With Best Regards,
Andy Shevchenko
