Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A65C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D947E2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kg/Ix5ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgCBN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:26:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37893 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgCBN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:26:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id t11so6168468wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ksuLQhQaVfn70PglWjMPhyebhvTDpJOHYR+Eolo3CI=;
        b=kg/Ix5ng9Mz+UXqDYAMU89aLZdgeaLpX4W30gQT8rcTasW1GpdIE8NKWxAtUZyRzTG
         ALq6z0sTmxSMYl6IPPgzZPA8iar3y6hmHb/eZ0uffkyfINUKungQFokafBTWdikN5RBR
         dI35lgDn6AnQsX1VziRKtNj/mzkywL7xshBxa62FvMo2cbFZ8Dc1skpvOnG6RE3XitM2
         xI/BXIomb0qKYEWrQQ69B6m7ehaiVzDwt6QHXwfXdtyRn0luJY5dXeDlsSDtFBYDP2yF
         dyCd8vO5HwgOYRwEzyqINWoi9hKBGFcpC4mjibqy+WM2gqk8DvJaXdsojuzVUBX3vtRJ
         hTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ksuLQhQaVfn70PglWjMPhyebhvTDpJOHYR+Eolo3CI=;
        b=f3JfHUkgUsJaKP9jfEMBa4zPndEDwwqC7pxr1sRw0fjx8MKQYjKyE5BhriYY0rYqDB
         F9PsvRD4FFz1y+iMWY+2FzSX4XH80H/SGIVIPHL6/baBa9NlRV1K/pvDbUaFMqpeQ/yA
         G8kRPDKASwQhsmQpGBRpL0KdbG8WTe9yYDKUcdBQCwk0J7Qiw7rbpRPXjgeTXghvLWQN
         K+L5qUt3qLiBjzOxHpvvHhPQGEfLVMc/L0uPde7yy+7N3VFtsjhHXZTTL4rGd6xqpGWT
         6HiA7ikPepY8OB+Sy1DppaDA6UHNrFlK2b2XKRA6PtbUyB3FnTdsMoOBsspNfinIu7Ci
         z0Tg==
X-Gm-Message-State: APjAAAVCMBinrpB+r2Q/404ecLcrQwK+AwvZbYRp1n2Z6sy8lpyORHdv
        NxxnOhdxFRTuNlZ8J1PNpSgssYF8K749cnJOQ9eEug==
X-Google-Smtp-Source: APXvYqxD5EpTi7d4N+T4r3tOiFmCqFlQ0Fdz+H/VD/mUoHhAtlYzTInQmsWXuPJY1uT7rZdF7WXI4Zib325auuyMoro=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr22486054wrp.200.1583155562342;
 Mon, 02 Mar 2020 05:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20200302130430.201037-1-glider@google.com> <20200302130430.201037-2-glider@google.com>
 <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
In-Reply-To: <0eaac427354844a4fcfb0d9843cf3024c6af21df.camel@perches.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 2 Mar 2020 14:25:51 +0100
Message-ID: <CAG_fn=VNnxjD6qdkAW_E0v3faBQPpSsO=c+h8O=yvNxTZowuBQ@mail.gmail.com>
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

On Mon, Mar 2, 2020 at 2:11 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-03-02 at 14:04 +0100, glider@google.com wrote:
> > Certain copy_from_user() invocations in binder.c are known to
> > unconditionally initialize locals before their first use, like e.g. in
> > the following case:
> []
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> []
> > @@ -3788,7 +3788,7 @@ static int binder_thread_write(struct binder_proc *proc,
> >
> >               case BC_TRANSACTION_SG:
> >               case BC_REPLY_SG: {
> > -                     struct binder_transaction_data_sg tr;
> > +                     struct binder_transaction_data_sg tr __no_initialize;
> >
> >                       if (copy_from_user(&tr, ptr, sizeof(tr)))
>
> I fail to see any value in marking tr with __no_initialize
> when it's immediately written to by copy_from_user.

This is being done exactly because it's immediately written to by copy_to_user()
Clang is currently unable to figure out that copy_to_user() initializes memory.
So building the kernel with CONFIG_INIT_STACK_ALL=y basically leads to
the following code:

  struct binder_transaction_data_sg tr;
  memset(&tr, 0xAA, sizeof(tr));
  if (copy_from_user(&tr, ptr, sizeof(tr))) {...}

This unnecessarily slows the code down, so we add __no_initialize to
prevent the compiler from emitting the redundant initialization.
