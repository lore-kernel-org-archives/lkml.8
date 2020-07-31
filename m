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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ADD2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1l4rgtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgGaPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaPuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:50:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:50:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so16243135pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GteyqVzcNAX2itNRoyDkmeye14Tqf18SySo0jud0Dk=;
        b=W1l4rgtz7Y4d7hXcWcRvZNxvmGqMGcC/F6rYohWSrBwmVrcoGD6h/xmyfE/mBs/7Ag
         IhIYY4aROpVRWYpSwd3OJB+m2/so9P9Gg8lHJU6+y9YovsGdRLOZrxHrqutgNXBgJ1kG
         j8+bAhyBWyP9SRlHh6RrrdNlUr3rCtYpJXc6KZpxRKcV/4Jjxy2/o8xP+ChMyzpE5c2u
         BGsK99gcYBeIzrWfXXq/fNlzOBE8ZgTSE9Mi/Yx3d36D12K8uS4SmNyh7SNZ9Krf+2v2
         71Oy5cCI2/xTabjyiqg1dhHm7NseyO9juof3nb4cVxN5nUh3gsouB1P6bidRa7nEdkAy
         eAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GteyqVzcNAX2itNRoyDkmeye14Tqf18SySo0jud0Dk=;
        b=hDeCHIv6g1+b1A/YZ589WqNHeyUDFjd64a6zq4GC9UocSUOdQJ3MSHw99khTyJ/i9T
         w0/FC6aC1LAJhSAI7EgrW0Q729gtPjm8f/iHhu+EEmdrohGnhQrGPiKxBgYxWIJohsKU
         jN1EnwGqa+uTE9gSrdb4mQtTuqGOBaEN3JIqQMk6yEgIqXqnxrDwylcRCekC640PKej+
         bEeM+XPmdCrvxd00qpJjB+u1L8dix7ZKRs0rU5jwreIKCROyyzoM1/gvVlwkJlKYBGb7
         5+PIJg4Dx8M8noOhJj+klN2Yjuvly69EdtxXOBsaO9atFS7Sb2sjJQGGwiEYiZIwyJf3
         sxdQ==
X-Gm-Message-State: AOAM5320wwJ8hhsHAGl+NAI9pzI0LnV7ok/bJJAz1TDkI8RQZddPw118
        3CYwX29bHbXsmF2yEqF0Z9oUsRhoPP7sZjagqFw=
X-Google-Smtp-Source: ABdhPJzZeiJRZyHJHMN66n+tRCcBMq0YClT1r2co6/VsMwaYYp3qDeFsAXrw2WUTf3LvlwiKvzydYM3A7ym8f1X2hYw=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr4141148pfc.130.1596210602821;
 Fri, 31 Jul 2020 08:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200731123145.22357-1-andriy.shevchenko@linux.intel.com>
 <20200731123145.22357-3-andriy.shevchenko@linux.intel.com> <20200731113450.4f31c3e6@oasis.local.home>
In-Reply-To: <20200731113450.4f31c3e6@oasis.local.home>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 18:49:46 +0300
Message-ID: <CAHp75VdSz1ny1pkTMKWMB-Ok_2csoqtaC6zZkCj2aoHew-+NgQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] lib/vsprintf: Force type of flags for gfp_t
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 6:38 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 31 Jul 2020 15:31:45 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > Sparse is not happy about restricted type being assigned:
> >   lib/vsprintf.c:1940:23: warning: incorrect type in assignment (different base types)
> >   lib/vsprintf.c:1940:23:    expected unsigned long [assigned] flags
> >   lib/vsprintf.c:1940:23:    got restricted gfp_t [usertype]
> >
> > Force type of flags to make sparse happy.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  lib/vsprintf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 90d818ef03c5..118e2727d058 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -1937,7 +1937,7 @@ char *flags_string(char *buf, char *end, void *flags_ptr,
> >               names = vmaflag_names;
> >               break;
> >       case 'g':
> > -             flags = *(gfp_t *)flags_ptr;
> > +             flags = (__force typeof(flags))(*(gfp_t *)flags_ptr);
>
> Do we really need to say "typeof(flags)" ? What about simply using
> flags' type?

Whatever you prefer. I actually came with the latter and switched to the former.
So, I'll switch back for v2.

>
>                 flags = (__force unsigned long)(*(gfp_t *)flags_ptr);
>
> ?
>
> I mean, it's not like flags is a global. It's defined a few lines above.
>
> -- Steve
>
>
> >               names = gfpflag_names;
> >               break;
> >       default:
>


-- 
With Best Regards,
Andy Shevchenko
