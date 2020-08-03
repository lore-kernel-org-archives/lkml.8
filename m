Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F311C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330D520775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6qa2e/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgHCPMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:12:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBB8C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:12:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so16704903edy.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSQjY/yDDy2IgeloS1YMeNYtwnPmouyoqnWkR/XWcuY=;
        b=C6qa2e/+DC+X1CV0iz/uz93YXTJQi4pGFe0MOHD5CuLW7MnRHvUc1DQdnZxGpnXaH/
         7tAl7JLLJibUQk8XT2ud5cYfW7e3f1iPioq5zQR97icXzdV4OXLrW3XmOnIL8gNx4y6A
         GCIJUn5ORGn2O47C7XOWcvpbfv6IF+zxBdzNnzbtLyhcURInr0rOC0G0Hu1lpKT5P/6H
         +F1FebkqqvvfOdo2URKMCcGlsIbVz8l8SbbA+EEH1BP1gHok8lSyAYzdAk61ekdIBCeb
         ea1Qt8qYGDetm0vMofn+D6hfuiSV5FPnpfZdE/xE+OymVSad8oiHa+2Fl7CUknCaGona
         pHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSQjY/yDDy2IgeloS1YMeNYtwnPmouyoqnWkR/XWcuY=;
        b=SVBH0k9E5CzsNw9qYz/FGJevCl4Z2MK3E8IrWtLl9AGKkw8qdv5nuGDR9g1xg05Cdl
         yP6fAEMjvQnvM1rtepWspko8gpY5yoV6HYPzNhotQaRThc+UQgY0RZLaxAZfRfm1pQDZ
         aVMw6KQvdGmbHpnNW52OZxa0l29xnxI/5EDqKr3NGpuNKmYS6rWUqxj2+W7AK2svDSDj
         TdXHS2A03fSTRVNuMb1+dLBlpATJTjWSRTDII+2m7DBgCvPXHaRPLD8WHdEmwMac9DXo
         8rJXG4DsfYPIX+MLsygkEa6faoSlmKwLBA6oPX8VFT80M+n3fQKnuRqOTN1QbUDjp77V
         FyCA==
X-Gm-Message-State: AOAM532DWcRJCobswZTSpA2nQNBHuVHgxh+6leLc/SGmzrinLUXB53Jf
        It+jsk4Z99vnPisvMZieaxursNJ25bzNX6qNFP3H5w==
X-Google-Smtp-Source: ABdhPJxxK6AKCEaBJAoVFuPjby0EStHHsQSneYgTa9PE9YmB06nAeo8BgJkSOV1Q2qjNe+Nir4xcLJ3pHm/6XbLd0mA=
X-Received: by 2002:aa7:c45a:: with SMTP id n26mr16449720edr.45.1596467561751;
 Mon, 03 Aug 2020 08:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <1595252430.5899.6.camel@mtkswgap22> <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
 <1595906401-11985-3-git-send-email-Frankie.Chang@mediatek.com>
 <CAHRSSEwqbbTZgaE-KLC0-AMHzRVU3O2AwUzW9i5u54tVmkFAQA@mail.gmail.com> <1596424276.5207.13.camel@mtkswgap22>
In-Reply-To: <1596424276.5207.13.camel@mtkswgap22>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 3 Aug 2020 08:12:29 -0700
Message-ID: <CAHRSSEwKa=wkp3+_cgZc3cZ+k_OEw82HTaKewLNFPovFVxsnbg@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] binder: add trace at free transaction.
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 2, 2020 at 8:11 PM Frankie Chang <Frankie.Chang@mediatek.com> wrote:
>
> On Fri, 2020-07-31 at 11:50 -0700, Todd Kjos wrote:
> > On Mon, Jul 27, 2020 at 8:28 PM Frankie Chang
> > <Frankie.Chang@mediatek.com> wrote:
> > >
> > > From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
> > >
> > > Since the original trace_binder_transaction_received cannot
> > > precisely present the real finished time of transaction, adding a
> > > trace_binder_txn_latency_free at the point of free transaction
> > > may be more close to it.
> > >
> > > Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> > > ---
> > >  drivers/android/binder.c       |    6 ++++++
> > >  drivers/android/binder_trace.h |   27 +++++++++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 2df146f..1e6fc40 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -1522,6 +1522,9 @@ static void binder_free_transaction(struct binder_transaction *t)
> > >          * If the transaction has no target_proc, then
> > >          * t->buffer->transaction has already been cleared.
> > >          */
> > > +       spin_lock(&t->lock);
> > > +       trace_binder_txn_latency_free(t);
> > > +       spin_unlock(&t->lock);
> >
> > Hmm. I don't prefer taking the lock just to call a trace. It doesn't
> > make clear why the lock has to be taken. I'd prefer something like:
> >
> > if (trace_binder_txn_latency_free_enabled()) {
> c
> > }
> >
> > And then the trace would use the passed-in values instead of accessing
> > via t->to_proc/to_thread.
> >
> Then we still add lock protection in the hook function, when trace is
> disable ?

I don't understand... in the example I gave, the trace doesn't get
called if disabled. What do you mean to "add lock protection when the
trace is disabled()"?

>
> Or we also pass these to hook function, no matter the trace is enable or

What do you mean by "hook" function? If something has attached to the
trace, then xxx_enabled() will return true.

> not.I think this way is more clear that the lock protects @from,
> @to_proc and @to_thread.Then, there is no need to add the lock in hook
> function.

Why is it clearer (other than the fact that I missed including t->from
under the lock)?

>
> int from_proc, from_thread, to_proc, to_thread;
>
> spin_lock(&t->lock);
> from_proc = t->from ? t->from->proc->pid : 0;
> from_thread = t->from ? t->from->pid :0;
> to_proc = t->to_proc ? t->to_proc->pid : 0;
> to_thread = t->to_thread ? t->to_thread->pid : 0;
> spin_unlock(&t->lock);
> trace_binder_txn_latency_free(t, from_proc, from_thread, to_proc,
> to_pid);

The main feedback is I'd like to see the fields dereferenced in the
same context as the lock acquisition instead of acquiring the lock and
calling the trace function, so this code would be fine. There will be
very little contention for t->lock so using xxx_enabled() is optional.

Since trace_binder_txn_latency_free() is called twice,  it would make
sense to have a helper function to do the above.

>
> > >         binder_free_txn_fixups(t);
> > >         kfree(t);
> > >         binder_stats_deleted(BINDER_STAT_TRANSACTION);
> > > @@ -3093,6 +3096,9 @@ static void binder_transaction(struct binder_proc *proc,
> > >         kfree(tcomplete);
> > >         binder_stats_deleted(BINDER_STAT_TRANSACTION_COMPLETE);
> > >  err_alloc_tcomplete_failed:
> > > +       spin_lock(&t->lock);
> > > +       trace_binder_txn_latency_free(t);
> > > +       spin_unlock(&t->lock);
> > >         kfree(t);
> > >         binder_stats_deleted(BINDER_STAT_TRANSACTION);
> > >  err_alloc_t_failed:
> > > diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> > > index 6731c3c..8ac87d1 100644
> > > --- a/drivers/android/binder_trace.h
> > > +++ b/drivers/android/binder_trace.h
> > > @@ -95,6 +95,33 @@
> > >                   __entry->thread_todo)
> > >  );
> > >
> > > +TRACE_EVENT(binder_txn_latency_free,
> > > +       TP_PROTO(struct binder_transaction *t),
> > > +       TP_ARGS(t),
> > > +       TP_STRUCT__entry(
> > > +               __field(int, debug_id)
> > > +               __field(int, from_proc)
> > > +               __field(int, from_thread)
> > > +               __field(int, to_proc)
> > > +               __field(int, to_thread)
> > > +               __field(unsigned int, code)
> > > +               __field(unsigned int, flags)
> > > +       ),
> > > +       TP_fast_assign(
> > > +               __entry->debug_id = t->debug_id;
> > > +               __entry->from_proc = t->from ? t->from->proc->pid : 0;
> > > +               __entry->from_thread = t->from ? t->from->pid : 0;
> > > +               __entry->to_proc = t->to_proc ? t->to_proc->pid : 0;
> > > +               __entry->to_thread = t->to_thread ? t->to_thread->pid : 0;
> > > +               __entry->code = t->code;
> > > +               __entry->flags = t->flags;
> > > +       ),
> > > +       TP_printk("transaction=%d from %d:%d to %d:%d flags=0x%x code=0x%x",
> > > +                 __entry->debug_id, __entry->from_proc, __entry->from_thread,
> > > +                 __entry->to_proc, __entry->to_thread, __entry->code,
> > > +                 __entry->flags)
> > > +);
> > > +
> > >  TRACE_EVENT(binder_transaction,
> > >         TP_PROTO(bool reply, struct binder_transaction *t,
> > >                  struct binder_node *target_node),
> > > --
> > > 1.7.9.5
>
