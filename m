Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09DC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C28206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqSLWEU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgG1Oub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbgG1Ou1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:50:27 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DEEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:50:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 140so11167309lfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uz2mVijTdc9hWEqHj4Oi6aqXh1WA5+MI9lYrpxVpIkY=;
        b=TqSLWEU5EvLtNxbQEQ3Gu27y/A9HJjH8OJhyzazll6sKSxnWk+Vo+16/N4a9JCJ0EU
         aooWwgS3xZYVAy3rNzb7KF8+GLCoeTo0VntwT4lo2DyGE4bEfAGar0X/wHGOLWuhIVMg
         lmJobZcOdQr+98w5nG/XMS4EZnqTpj59l+WoR5Ud9gQ5D19jAMFWFOL2yvexmIlOJFl+
         ybMSEgJZT1fhWWprT2m8h+tX0scfW6SLYibBycci08t2Z6hHrpk65b2iPTRk0BX3srQp
         jyRZoqnnfXlZrEk0XwhRxg2RlICbYYlAzGEwaTJmG+iQysg5C0Jnmm7tpum0Emfbp34N
         ORRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uz2mVijTdc9hWEqHj4Oi6aqXh1WA5+MI9lYrpxVpIkY=;
        b=mkTsRfUCaTqWKTYZUj50kULXcXC7DauH5khxTeOgGm4GGPhqbXUZMgQHkFPC3wz1Ti
         wLThZtvC9b93onocz3la/u04XyALWpc5F0HhhUxBUMB07eL6MDRVY6DS9GxV4Pd53Keg
         JzuAoM+yWd0bJkBxQKD/IrSCtudLWpyfrrQ7HCbWs6iu+mYUB+eoMX/lD1VcStkJ8cAm
         xIgNwJaGWjyi8IH6WZo2vRX48uDQiIXx4MQ1SyF4Q8+FPTzUJdfLYjA20f4AxP5LI1TP
         k3FxPuemVzXKK/r2j0JHlzfxybvrVwPWiT9TH5Ngh3t1QtOsfLx0g1Rm7SgtD/zetUMI
         nJrQ==
X-Gm-Message-State: AOAM531ap7PfjsSm4XnxKQCNQjOipqNEMnV2bEB0cTjlWwxxFuEXPeSl
        O/Y65h4abKKl1HlVPUnWM7DtvyuKoG4oXm6+oAovpw==
X-Google-Smtp-Source: ABdhPJwCqKrTeHtvdsqwVeOMyiD1xS/7jIZTgktpD+HlGEQMNe53y3cm+ryPXlNjn2ulN7GgFDYZJDqvkBrczXp0/NA=
X-Received: by 2002:a19:ac03:: with SMTP id g3mr14429055lfc.164.1595947825106;
 Tue, 28 Jul 2020 07:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200727120424.1627555-1-jannh@google.com> <CAB0TPYHx-SkaWR6i0LwLYRJv13_0V3Ak63H0=parZNvS5XdqgA@mail.gmail.com>
In-Reply-To: <CAB0TPYHx-SkaWR6i0LwLYRJv13_0V3Ak63H0=parZNvS5XdqgA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Jul 2020 16:49:58 +0200
Message-ID: <CAG48ez23-oOGjeNhFCzrWxJuuJUsdgbpiSiPvM0ov1n+FcLPhw@mail.gmail.com>
Subject: Re: [PATCH v2] binder: Prevent context manager from incrementing ref 0
To:     Martijn Coenen <maco@android.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Mattias Nissler <mnissler@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 3:50 PM Martijn Coenen <maco@android.com> wrote:
> On Mon, Jul 27, 2020 at 2:04 PM Jann Horn <jannh@google.com> wrote:
> >  - task B opens /dev/binder once, creating binder_proc instance P3
> >  - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
> >    transaction)
> >  - P2 receives the handle and uses it to call P3 (two-way transaction)
> >  - P3 calls P2 (via magic handle 0) (two-way transaction)
> >  - P2 calls P2 (via handle 1) (two-way transaction)
>
> Why do you need P3 involved at all? Could P2 just straight away make a
> call on handle 1?

Yes, it could, I think. IIRC these steps are necessary if you want to
actually get a KASAN splat, instead of just a transaction-to-self with
no further consequences. It has been a while since I looked at this,
but I'll try to figure out again what was going on...


A UAF occurs in the following code due to the transaction-to-self,
because the "if (t->to_thread == thread)" is tricked into believing
that the transaction has already been accepted.

static int binder_thread_release(struct binder_proc *proc,
                                 struct binder_thread *thread)
{
        struct binder_transaction *t;
        struct binder_transaction *send_reply = NULL;
        [...]
        t = thread->transaction_stack;
        if (t) {
                [...]
                if (t->to_thread == thread)
                        send_reply = t;
        } else {
                [...]
        }
        [...]
        //NOTE: transaction is freed here because top-of-stack is
        //      wrongly treated as already-accepted incoming transaction)
        if (send_reply)
                binder_send_failed_reply(send_reply, BR_DEAD_REPLY);
        //NOTE pending transaction work is processed here (transaction has not
        //     yet been accepted)
        binder_release_work(proc, &thread->todo);
        [...]
}

An unaccepted transaction will only have a non-NULL ->to_thread if the
transaction has a specific target thread; for a non-reply transaction,
that is only the case if it is a two-way transaction that was sent
while the binder call stack already contained the target task (iow,
the transaction looks like a synchronous callback invocation).

With the steps:

 - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
   transaction)
 - P2 receives the handle and uses it to call P3 (two-way transaction)
 - P3 calls P2 (via magic handle 0) (two-way transaction)
 - P2 calls P2 (via handle 1) (two-way transaction)

the call stack will look like this:

    P3 -> P2 -> P3 -> P2 -> P2

The initial call from P3 to P2 was IIRC just to give P2 a handle to
P3; IIRC the relevant part of the call stack was:

    P2 -> P3 -> P2 -> P2

Because P2 already occurs down in the call stack, the final
transaction "P2 -> P2" is considered to be a callback and is
thread-directed.


The reason why P3 has to be created from task B is the "if
(target_node && target_proc->pid == proc->pid)" check for transactions
to reference 0.
