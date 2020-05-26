Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5F920776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDjv/fMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbgEZH5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbgEZH5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:57:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FCFC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:57:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so11772838lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hls7pMjgRAEJPr8FkQn95q9jMKxanllQ2tD+H93l8Ao=;
        b=kDjv/fMk4zgd/uMy9GdPdkzKw0FjIFNyX/DkJ4TIntG9UIvqr1brnF9lwO3ja/jq/6
         e4PJsah91HXN5L/KlNXp8fdfOHtc8tjtjwf4r26+Wavaw/NVBpFwSmXcilVjDl+HMJD5
         bNV3kMcbws6HVRsXjDGSB752UfhZFX6DlovpnRRUzCRsSNfJdNoATpsAAZM+8LC9LCbx
         xNcEzner0LDPChpzlIY2cZzLOC7EdU/hC+GEeSsHVxEdirao42Wpxo+X0V4pqNrOnUbm
         fgc+Gc5ZvIy2whtYwMU25POFzrlACuxrRehyrXpKGz+RR0BrbBfXyHjyFKVR1xSgtqhb
         bG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hls7pMjgRAEJPr8FkQn95q9jMKxanllQ2tD+H93l8Ao=;
        b=MVtXxtqCDn2T1bLLMKE9Ij79wl4LknxkgmvOO3UrIF7K2OAUZ4cNxH6MeOEA0wJNjU
         1lENQHQH6eKi6ssrWbxv+b5bhmYNu7t4CCJBS9OqAitJn0ITRpbtmGCy3Hf/9o0Y6FX6
         KP9VTpzk8xJkjnka7VkoVLTFKxKIiaDaRyPd/9op79j6exMju5cwcyZcOq3AoVkCvViK
         SNAYfMNAqp1DFSNoFMvHekVM42tq3cBB+rTgcB7FZWMXURM79ubobOKuwBj8KQ+9ItcC
         kqIz5MJQe/6wQHevQ5x3rTa/zXLaucPhV4xMn+t6oeHGLc/xottC/7xT/O7DsTu4kebB
         hwdg==
X-Gm-Message-State: AOAM530664DiY5XRXSlq6xMJSIi+ZAOQrE0a77NtrbslE/9yzYR6fsvm
        WoP8FQb9BPrZIKP6N9iRNpC83F15A+FqF6cj6+7NFw==
X-Google-Smtp-Source: ABdhPJyComtMgmHneuXnzA8/7vKS/DZQGUDGit10QC5/2EBq1S/xYwm1LkIc+Kz2CI3lMp630d59AlDsbW0jrx4se38=
X-Received: by 2002:ac2:560f:: with SMTP id v15mr16647030lfd.160.1590479859340;
 Tue, 26 May 2020 00:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <1590158027-15254-1-git-send-email-sumit.garg@linaro.org> <20200522163508.e7476dd2vulntppc@holly.lan>
In-Reply-To: <20200522163508.e7476dd2vulntppc@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 26 May 2020 13:27:28 +0530
Message-ID: <CAFA6WYPNqN-rQmymBkEQV0Cf0QWPNEjNkvVhUFFyi68zErCiiw@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Make kdb_printf robust to run in NMI context
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 22:05, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, May 22, 2020 at 08:03:47PM +0530, Sumit Garg wrote:
> > While rounding up CPUs via NMIs, its possible that a rounded up CPU
> > maybe holding a console port lock leading to kgdb master CPU stuck in
> > a deadlock during invocation of console write operations. So in order
> > to avoid such a deadlock, invoke bust_spinlocks() prior to invocation
> > of console handlers.
> >
> > Also, add a check for console port to be enabled prior to invocation of
> > corresponding handler.
>
> Perhaps this should have been two patches.
>

Okay, will split this patch into two.

> In fact, to be honest, I'd suggest combining all the patches to improve
> kdb console handling (including a fixed version of the RFC) into a
> single patch set.

Yeah it makes sense to have a combined patch set to improve kdb
console handling. But I posted the RFC patch separately as I expected
comments and discussions to come up with an accepted approach.

So let me wait for an agreement on RFC patch after which I can include
that patch in this patch set.

>
>
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v2:
> > - Use oops_in_progress directly instead of bust_spinlocks().
> >
> >  kernel/debug/kdb/kdb_io.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index 924bc92..3a5a068 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -699,7 +699,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       }
> >               }
> >               for_each_console(c) {
> > +                     if (!(c->flags & CON_ENABLED))
> > +                             continue;
> > +                     ++oops_in_progress;
>
> Given the subtly of what is going on I think we need some comments in
> the code on what we are doing and why.

Sure, will add comments.

>
>
> >                       c->write(c, cp, retlen - (cp - kdb_buffer));
> > +                     --oops_in_progress;
> >                       touch_nmi_watchdog();
> >               }
> >       }
> > @@ -761,7 +765,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> >                       }
> >               }
> >               for_each_console(c) {
> > +                     if (!(c->flags & CON_ENABLED))
> > +                             continue;
> > +                     ++oops_in_progress;
> >                       c->write(c, moreprompt, strlen(moreprompt));
> > +                     --oops_in_progress;
> >                       touch_nmi_watchdog();
>
> As with the other patches maybe the first patch in the set should be
> factoring out the common code before making changes to it.

Sure, will factor out common code as initial patch.

-Sumit

>
>
> Daniel.
