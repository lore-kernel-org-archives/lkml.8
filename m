Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B9B20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ma7PaJpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgFWNyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732750AbgFWNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:54:42 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:54:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 80so6982368qko.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+8tjxg/XAgFHHjPbGONl8+4MlNkySWi6n8PM8+S96E=;
        b=ma7PaJpr9bD/R9bhlQN3uOTonu3w49h3OtLdL8xV5cfvFquFqsmzxpG6Ej5FJlh7GC
         NawMQbsGI8RDDPWyUozgGAcVxMaOoDNq35DZaImK62kEdoD2pTuupBm/7jJVWx8lpp05
         Gqt5EoJi8klLM+eeS3vo/hlektTBikugHYSdeefT3gy7bo7UW6ozVk0QBoM7L8/DCnv5
         IrMsa19HT6g9iLFNlJuY98a5dVzJmI+OAJGcEF1lK4mpM0FHOkrquTuBrt3PNLkZq6+z
         WbIGHXjmk4+zCuZpMPA6EYHwsOduQGz/sSroRTuFRwcCfW8bmRIT97CEgfM2vQIfUGvx
         5G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+8tjxg/XAgFHHjPbGONl8+4MlNkySWi6n8PM8+S96E=;
        b=pz6w/WUh2xtAyiEjgoBwxpge9IrRbNBePaML5xiy7kZa4p7XF+fIldaiM2OYV9pHKa
         VlqdnZsbANJf2v+1iOyBKPC30Ee6/lBiUZJ137gcPvde1zyygfQYfMpd3FlG/SdWG9l5
         26Lew4pEd+Q4JJKmHRNUC+vlRqwNQA4xz8mEvu+SOmzm3n6FB2tYa33911w1zsUQH/Vc
         R5ybR8+DxItHs6kRLG0Dpj2zzvpE8eVKp1c4ICFc0YcIJmf1B5VHGdqHS+zJSQFXdlh9
         WPuVlQ2pLufE3HJ6qhGDrruEBToG9X4BCG0W9PNgpDk31pKS0l7tjo9Bi6VOLXHvHfir
         Tb6w==
X-Gm-Message-State: AOAM5305+yE+aP9Dd8lbMU7vSbISMQ9mH6nOCPT/1rXsk8NyBDBQiiTh
        1JSQDWeqziRLHksEqC858urYdbVnk68/aCBEClWQMg==
X-Google-Smtp-Source: ABdhPJz+Q5So6wi+cyHnF+6gysPTIqV+FME7GlRwzYgNSrvjjNNYJcsZz4ljnJaBwhK7szb6BmDGXbDioduaNm+sXLI=
X-Received: by 2002:a05:620a:958:: with SMTP id w24mr6760648qkw.20.1592920479763;
 Tue, 23 Jun 2020 06:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200622200715.114382-1-tkjos@google.com>
In-Reply-To: <20200622200715.114382-1-tkjos@google.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 23 Jun 2020 09:54:27 -0400
Message-ID: <CAJWu+op-5EjRiaL7b-TcXCruqheET9aB_ZJK8CGsfmuxSNQWqA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix null deref of proc->context
To:     Todd Kjos <tkjos@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Arve Hjonnevag <arve@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 4:07 PM 'Todd Kjos' via kernel-team
<kernel-team@android.com> wrote:
>
> The binder driver makes the assumption proc->context pointer is invariant after
> initialization (as documented in the kerneldoc header for struct proc).
> However, in commit f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> proc->context is set to NULL during binder_deferred_release().
>
> Another proc was in the middle of setting up a transaction to the dying
> process and crashed on a NULL pointer deref on "context" which is a local
> set to &proc->context:
>
>     new_ref->data.desc = (node == context->binder_context_mgr_node) ? 0 : 1;
>
> Here's the stack:
>
> [ 5237.855435] Call trace:
> [ 5237.855441] binder_get_ref_for_node_olocked+0x100/0x2ec
> [ 5237.855446] binder_inc_ref_for_node+0x140/0x280
> [ 5237.855451] binder_translate_binder+0x1d0/0x388
> [ 5237.855456] binder_transaction+0x2228/0x3730
> [ 5237.855461] binder_thread_write+0x640/0x25bc
> [ 5237.855466] binder_ioctl_write_read+0xb0/0x464
> [ 5237.855471] binder_ioctl+0x30c/0x96c
> [ 5237.855477] do_vfs_ioctl+0x3e0/0x700
> [ 5237.855482] __arm64_sys_ioctl+0x78/0xa4
> [ 5237.855488] el0_svc_common+0xb4/0x194
> [ 5237.855493] el0_svc_handler+0x74/0x98
> [ 5237.855497] el0_svc+0x8/0xc
>
> The fix is to move the kfree of the binder_device to binder_free_proc()
> so the binder_device is freed when we know there are no references
> remaining on the binder_proc.
>
> Fixes: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
> Signed-off-by: Todd Kjos <tkjos@google.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thanks,

 - Joel



> ---
>  drivers/android/binder.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index e47c8a4c83db..f50c5f182bb5 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4686,8 +4686,15 @@ static struct binder_thread *binder_get_thread(struct binder_proc *proc)
>
>  static void binder_free_proc(struct binder_proc *proc)
>  {
> +       struct binder_device *device;
> +
>         BUG_ON(!list_empty(&proc->todo));
>         BUG_ON(!list_empty(&proc->delivered_death));
> +       device = container_of(proc->context, struct binder_device, context);
> +       if (refcount_dec_and_test(&device->ref)) {
> +               kfree(proc->context->name);
> +               kfree(device);
> +       }
>         binder_alloc_deferred_release(&proc->alloc);
>         put_task_struct(proc->tsk);
>         binder_stats_deleted(BINDER_STAT_PROC);
> @@ -5406,7 +5413,6 @@ static int binder_node_release(struct binder_node *node, int refs)
>  static void binder_deferred_release(struct binder_proc *proc)
>  {
>         struct binder_context *context = proc->context;
> -       struct binder_device *device;
>         struct rb_node *n;
>         int threads, nodes, incoming_refs, outgoing_refs, active_transactions;
>
> @@ -5423,12 +5429,6 @@ static void binder_deferred_release(struct binder_proc *proc)
>                 context->binder_context_mgr_node = NULL;
>         }
>         mutex_unlock(&context->context_mgr_node_lock);
> -       device = container_of(proc->context, struct binder_device, context);
> -       if (refcount_dec_and_test(&device->ref)) {
> -               kfree(context->name);
> -               kfree(device);
> -       }
> -       proc->context = NULL;
>         binder_inner_proc_lock(proc);
>         /*
>          * Make sure proc stays alive after we
> --
> 2.27.0.111.gc72c7da667-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
