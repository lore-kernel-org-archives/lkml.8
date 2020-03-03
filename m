Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29DDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65A9214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTON33Ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgCCJOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:14:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34071 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgCCJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:14:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so3381316wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZ/tuB8qgRACZZ2pio9zWrvoh8e8w7qHr+14A9Ldgeg=;
        b=NTON33Jifl+R6NAyY2Scr0HzJ73gC6UjKe7pb9fRUiOuUCNfpGVcqaZ4Nz3m9sn4R+
         BfhXriuuW3scO9sn8U37bzh39fb2kN54HjDR/oZgJc13WiTqBKD7YpJxzKkuRXLqEOqQ
         Z4Zsh1x9xW+bPeCoG2oNSE6W8Ykso+j9FFkFWrQXIbAHIqljoYmDK/lMXVTUL1YSczDy
         rWVZqmtf1i/Z5Ke0Loc+4ZTsAykJ4kTmnplOd1tVS4ppVf2GE2+OSo2FtlDLZtfOigmB
         o6rXrMk/8iSuTCCXyeMhNgnnSkRVKgGUDo5tn84axApQvKU7HPD77LYxqDynM9jjOfiR
         CbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZ/tuB8qgRACZZ2pio9zWrvoh8e8w7qHr+14A9Ldgeg=;
        b=HmqOEG6cqXa8RFcBS5idEl4RKAmGYwxKVhlhzXcJNS+LIFkqZK6RqaZKEPjCwhdXhe
         5WBjsypblcETdGAhf9mqSVxOM+Ipe9tD/vQWDviVdfdXoKp80vmpBaeKIlfx80cNjOLH
         4nqW8ZJLu4hCmsKpmJkAb0VTpEr7v+1/EJvPeTyYQf2pX9/ouT1QOKd/rsenAH1WL1Ac
         62QsjUiGuiVq4mNWdHXRwEEr0N5jFenNwW+Ec4mYucmaM6bxZuEthJXr9zAZPnNHL0Ko
         NTJbl6c/pgRhTnRnN91PoiZrz1+g1QfK8F6f2Teh8rWJup2yLjr+lvVKMzpvgYEA7NTD
         v5jg==
X-Gm-Message-State: ANhLgQ2MzcZZpE9JIPlZZ1CY2hUlpv5ksjZfsOd0/TmlYLaM1FkvLfEa
        j00TQ+Z2Ttnwo5g7dVny/dt+AIwmQW2I6fcjUgeJig==
X-Google-Smtp-Source: ADFU+vuTYVcZD5+Vjn2bW93fBu9dCOBHeqiEkje9CEeHzEU8OeCP41MxKYVeFdUUR9XGd+uhTKDLq6ynerMLwMyvZgw=
X-Received: by 2002:adf:b60f:: with SMTP id f15mr4744555wre.372.1583226869357;
 Tue, 03 Mar 2020 01:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
 <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
 <4cac10d3e2c03e4f21f1104405a0a62a853efb4e.camel@perches.com>
 <CAG_fn=XOyPGau9m7x8eCLJHy3m-H=nbMODewWVJ1xb2e+BPdFw@mail.gmail.com> <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
In-Reply-To: <18b0d6ea5619c34ca4120a6151103dbe9bfa0cbe.camel@perches.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 3 Mar 2020 10:14:18 +0100
Message-ID: <CAG_fn=U2T--j_uhyppqzFvMO3w3yUA529pQrCpbhYvqcfh9Z1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binder: do not initialize locals passed to copy_from_user()
To:     Joe Perches <joe@perches.com>
Cc:     Todd Kjos <tkjos@google.com>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 7:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-03-02 at 19:17 +0100, Alexander Potapenko wrote:
> > On Mon, Mar 2, 2020 at 3:00 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2020-03-02 at 14:25 +0100, Alexander Potapenko wrote:
> > > > On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > > > > > Certain copy_from_user() invocations in binder.c are known to
> > > > > > unconditionally initialize locals before their first use, like e.g. in
> > > > > > the following case:
> > > > > []
> > > > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > > []
> > > > > > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> > > > > >
> > > > > >               case BC_TRANSACTION_SG:
> > > > > >               case BC_REPLY_SG: {
> > > > > > -                     struct binder_transaction_data_sg tr;
> > > > > > +                     struct binder_transaction_data_sg tr __no_initialize;
> > > > > >
> > > > > >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
> > > > >
> > > > > I fail to see any value in marking tr with __no_initialize
> > > > > when it's immediately written to by copy_from_user.
> > > >
> > > > This is being done exactly because it's immediately written to by copy_to_user()
> > > > Clang is currently unable to figure out that copy_to_user() initializes memory.
> > > > So building the kernel with CONFIG_INIT_STACK_ALL=y basically leads to
> > > > the following code:
> > > >
> > > >   struct binder_transaction_data_sg tr;
> > > >   memset(&tr, 0xAA, sizeof(tr));
> > > >   if (copy_from_user(&tr, ptr, sizeof(tr))) {...}
> > > >
> > > > This unnecessarily slows the code down, so we add __no_initialize to
> > > > prevent the compiler from emitting the redundant initialization.
> > >
> > > So?  CONFIG_INIT_STACK_ALL by design slows down code.
> > Correct.
> >
> > > This marking would likely need to be done for nearly all
> > > 3000+ copy_from_user entries.
> > Unfortunately, yes. I was just hoping to do so for a handful of hot
> > cases that we encounter, but in the long-term a compiler solution must
> > supersede them.
> >
> > > Why not try to get something done on the compiler side
> > > to mark the function itself rather than the uses?
> > This is being worked on in the meantime as well (see
> > http://lists.llvm.org/pipermail/cfe-dev/2020-February/064633.html)
> > Do you have any particular requisitions about how this should look on
> > the source level?
>
> I presume something like the below when appropriate for
> automatic variables when not already initialized or modified.
> ---
>  include/linux/uaccess.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 8a215c..3e034b5 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -138,7 +138,8 @@ _copy_to_user(void __user *, const void *, unsigned long);
>  #endif
>
>  static __always_inline unsigned long __must_check
> -copy_from_user(void *to, const void __user *from, unsigned long n)
> +copy_from_user(void __no_initialize *to, const void __user *from,
> +              unsigned long n)

Shall this __no_initialize attribute denote that the whole object
passed to it is initialized?
Or do we need to encode the length as well, as Jann suggests?
It's also interesting what should happen if *to is pointing _inside_ a
local object - presumably it's unsafe to disable initialization for
the whole object.
