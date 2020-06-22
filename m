Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113CEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FE620767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgFVUKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:10:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50112 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbgFVUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:10:01 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnSlP-0005N4-Mn; Mon, 22 Jun 2020 20:09:55 +0000
Date:   Mon, 22 Jun 2020 22:09:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix null deref of proc->context
Message-ID: <20200622200955.unq7elx2ry2vrnfe@wittgenstein>
References: <20200622200715.114382-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622200715.114382-1-tkjos@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 01:07:15PM -0700, Todd Kjos wrote:
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

Thanks, looks good to me!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Christian

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
> +	struct binder_device *device;
> +
>  	BUG_ON(!list_empty(&proc->todo));
>  	BUG_ON(!list_empty(&proc->delivered_death));
> +	device = container_of(proc->context, struct binder_device, context);
> +	if (refcount_dec_and_test(&device->ref)) {
> +		kfree(proc->context->name);
> +		kfree(device);
> +	}
>  	binder_alloc_deferred_release(&proc->alloc);
>  	put_task_struct(proc->tsk);
>  	binder_stats_deleted(BINDER_STAT_PROC);
> @@ -5406,7 +5413,6 @@ static int binder_node_release(struct binder_node *node, int refs)
>  static void binder_deferred_release(struct binder_proc *proc)
>  {
>  	struct binder_context *context = proc->context;
> -	struct binder_device *device;
>  	struct rb_node *n;
>  	int threads, nodes, incoming_refs, outgoing_refs, active_transactions;
>  
> @@ -5423,12 +5429,6 @@ static void binder_deferred_release(struct binder_proc *proc)
>  		context->binder_context_mgr_node = NULL;
>  	}
>  	mutex_unlock(&context->context_mgr_node_lock);
> -	device = container_of(proc->context, struct binder_device, context);
> -	if (refcount_dec_and_test(&device->ref)) {
> -		kfree(context->name);
> -		kfree(device);
> -	}
> -	proc->context = NULL;
>  	binder_inner_proc_lock(proc);
>  	/*
>  	 * Make sure proc stays alive after we
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
