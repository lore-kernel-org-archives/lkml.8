Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B566C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B9C2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkym1vj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgFVU7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgFVU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:59:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B08BC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:59:18 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q19so19432672eja.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ue6RX1kZyda1DPpFigD1OeuukeL7pPeF2wvAH0GA2VY=;
        b=dkym1vj9zdd7rMScujOzBH+n5zSUImzcl8fkefcL95zAazkbsX7vGYegoDlXZAiJjp
         1T8TSg4lk64NcB1aHngfYacsQqyz14guMB15lLw7Ymz9vtZszKE8X22zoeQztWLd7X19
         rOUsu2SemPtv4aD7aOOwAMG0WTqRwMRtRyCnDi9XGvKxGjSOuyCJ1jW3yAQVG6dWSwfh
         wU+MRH9J25QBZWT6xzvco/EDTSVwc4daP9mKhdCvL6LZQqmNqGnkfqgzwvsMCZMol9Gb
         z0onUgjDpzbUmHzKcM6dMfrh+Qnp5uLZRJrx0JMxnl7aXPjFgenSPK44bNJaAou2fMFl
         Du1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue6RX1kZyda1DPpFigD1OeuukeL7pPeF2wvAH0GA2VY=;
        b=I+/aDAvTiof+hejtS2I0ZHjeOhIlUTx5YormBZZiBdMZ1DQhOSMApsOy3a+d3qZ0Kf
         mv/E4pNseNswaZ9D1HqzVsGpko11U7F+XPs7v6/0E+K8W0OxzqIhu1rhk4pMdqYVFfYj
         YNlCOAiODcf8204jumWE12zI+epa/MuE+U6vnidjxHQ/Zq1YkSbWHRzJtGMqt5U1KI36
         l3u0XXr3yrxD7EY1GHo+8PehBUGe84bfj7kCVmdxDx0ZFAtOOB16+gGLVpeKMqmhwa4t
         oA6BPMM+HUiItQkgGqvAdQdF7v2ShMIApMAZq/XTrZzNQTtG2qPm0kPlxwvQ+M/XHgH/
         oeEg==
X-Gm-Message-State: AOAM5317qvjWxX6R/weEFJhOhyR3CGK9HVGcRASCPWEOjGeXTu1nGguK
        7xoqyjf1RjH97mhBkpRbcxBkBnPJFOHyHPJhGN8tuA==
X-Google-Smtp-Source: ABdhPJzse9DfN8Nz5ThbenHOI2v0XiBpuFPUioEgUupH8j5Vk0OR0LZg+RqtEegE5FEvyG1Kaw/D7BMEw+Bb38GkToA=
X-Received: by 2002:a17:906:4155:: with SMTP id l21mr10680726ejk.438.1592859556870;
 Mon, 22 Jun 2020 13:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200622200715.114382-1-tkjos@google.com> <20200622200955.unq7elx2ry2vrnfe@wittgenstein>
 <CAHRSSExVfUhkXzhuEUvUP-CTwSE7ExWwYCL8K_N+YABW9C1BzQ@mail.gmail.com>
In-Reply-To: <CAHRSSExVfUhkXzhuEUvUP-CTwSE7ExWwYCL8K_N+YABW9C1BzQ@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 22 Jun 2020 13:59:04 -0700
Message-ID: <CAHRSSEzms6-4zvTXDG6PTcgHx1vev343DRWXxV2kZDqpop1=GQ@mail.gmail.com>
Subject: Re: [PATCH] binder: fix null deref of proc->context
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Android Kernel Team <kernel-team@android.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 1:18 PM Todd Kjos <tkjos@google.com> wrote:
>
> On Mon, Jun 22, 2020 at 1:09 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Mon, Jun 22, 2020 at 01:07:15PM -0700, Todd Kjos wrote:
> > > The binder driver makes the assumption proc->context pointer is invariant after
> > > initialization (as documented in the kerneldoc header for struct proc).
> > > However, in commit f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> > > proc->context is set to NULL during binder_deferred_release().
> > >
> > > Another proc was in the middle of setting up a transaction to the dying
> > > process and crashed on a NULL pointer deref on "context" which is a local
> > > set to &proc->context:
> > >
> > >     new_ref->data.desc = (node == context->binder_context_mgr_node) ? 0 : 1;
> > >
> > > Here's the stack:
> > >
> > > [ 5237.855435] Call trace:
> > > [ 5237.855441] binder_get_ref_for_node_olocked+0x100/0x2ec
> > > [ 5237.855446] binder_inc_ref_for_node+0x140/0x280
> > > [ 5237.855451] binder_translate_binder+0x1d0/0x388
> > > [ 5237.855456] binder_transaction+0x2228/0x3730
> > > [ 5237.855461] binder_thread_write+0x640/0x25bc
> > > [ 5237.855466] binder_ioctl_write_read+0xb0/0x464
> > > [ 5237.855471] binder_ioctl+0x30c/0x96c
> > > [ 5237.855477] do_vfs_ioctl+0x3e0/0x700
> > > [ 5237.855482] __arm64_sys_ioctl+0x78/0xa4
> > > [ 5237.855488] el0_svc_common+0xb4/0x194
> > > [ 5237.855493] el0_svc_handler+0x74/0x98
> > > [ 5237.855497] el0_svc+0x8/0xc
> > >
> > > The fix is to move the kfree of the binder_device to binder_free_proc()
> > > so the binder_device is freed when we know there are no references
> > > remaining on the binder_proc.
> > >
> > > Fixes: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> > > Signed-off-by: Todd Kjos <tkjos@google.com>
>
> Forgot to include stable. The issue was introduced in 5.6, so fix needed in 5.7.
> Cc: stable@vger.kernel.org # 5.7

Turns out the patch with the issue was also backported to 5.4.y, so
the fix is needed there too.

>
>
> >
> >
> > Thanks, looks good to me!
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> > Christian
> >
> > > ---
> > >  drivers/android/binder.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index e47c8a4c83db..f50c5f182bb5 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -4686,8 +4686,15 @@ static struct binder_thread *binder_get_thread(struct binder_proc *proc)
> > >
> > >  static void binder_free_proc(struct binder_proc *proc)
> > >  {
> > > +     struct binder_device *device;
> > > +
> > >       BUG_ON(!list_empty(&proc->todo));
> > >       BUG_ON(!list_empty(&proc->delivered_death));
> > > +     device = container_of(proc->context, struct binder_device, context);
> > > +     if (refcount_dec_and_test(&device->ref)) {
> > > +             kfree(proc->context->name);
> > > +             kfree(device);
> > > +     }
> > >       binder_alloc_deferred_release(&proc->alloc);
> > >       put_task_struct(proc->tsk);
> > >       binder_stats_deleted(BINDER_STAT_PROC);
> > > @@ -5406,7 +5413,6 @@ static int binder_node_release(struct binder_node *node, int refs)
> > >  static void binder_deferred_release(struct binder_proc *proc)
> > >  {
> > >       struct binder_context *context = proc->context;
> > > -     struct binder_device *device;
> > >       struct rb_node *n;
> > >       int threads, nodes, incoming_refs, outgoing_refs, active_transactions;
> > >
> > > @@ -5423,12 +5429,6 @@ static void binder_deferred_release(struct binder_proc *proc)
> > >               context->binder_context_mgr_node = NULL;
> > >       }
> > >       mutex_unlock(&context->context_mgr_node_lock);
> > > -     device = container_of(proc->context, struct binder_device, context);
> > > -     if (refcount_dec_and_test(&device->ref)) {
> > > -             kfree(context->name);
> > > -             kfree(device);
> > > -     }
> > > -     proc->context = NULL;
> > >       binder_inner_proc_lock(proc);
> > >       /*
> > >        * Make sure proc stays alive after we
> > > --
> > > 2.27.0.111.gc72c7da667-goog
> > >
