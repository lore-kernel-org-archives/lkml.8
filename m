Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7565C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BAB20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ovvm6lj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgG3UoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgG3UoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:44:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E33EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:44:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id l27so13957097oti.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bV8Y2eAvGs+8fskxCg1gAHaMb+xmkqcepkokYWGtvSk=;
        b=Ovvm6lj79ORfUOd9dR9HBkdWt2tPFQFP4AXI+5Gl+H+BFJ2TGbP1iD9siWzVxgOkVu
         oFzIR80vI9k2IH2pkKDIZ6qdDDmX+duIBUzCp+4WLwax4ZAfkREN0n6np9BBLODL0ttO
         esyiWAZm+LUIrWimZa5raDSPChNShTsl9t9HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV8Y2eAvGs+8fskxCg1gAHaMb+xmkqcepkokYWGtvSk=;
        b=ThvtzDJsSPcsEvH5UBYGxiCwAqr2k922hClCefLaOu7feZATYtBnTgIQX5F//wVEC8
         GvWS4jVWBmw0/UvhhDFsvVUs83FMRIu86JTEdlzSHvRdPFLvPpno7Z1MDK6Ealdxvebw
         rrdSqPnxEeJUG26rAmw88gkRpQJVoE/Hhylxys0lQWM8c7HApKskf3aaXCEbgJOhRu+b
         x9bmHoi87FOYgUFDujKrYD46bs3gd6nLBDzSZAKxsKT3rItYGFn4sdIfBUhYENdK9L3y
         OboEk51w6usFFXkGHO9JQQbnq+D0zG6fKCTbsYdWWPMhATPq0X4MjEMo/jkERoWkCrfe
         FMQA==
X-Gm-Message-State: AOAM533eJXF+l7WEfx9oeJDxN/xVH9Z0HbBmF+UQT8X1kCEvE731OHWh
        1uFBZ3ptKVig2l3u0LOe1V/nF27+H5fPo6D/gu8Jng==
X-Google-Smtp-Source: ABdhPJyrfRTcHpHED2ZKFe4x3Z98xCk4l2c3gmg3HDvRuRiuq0OHYnWVQ+VpfO7X73uwLPTPKzZrEL5lGnmTraActyk=
X-Received: by 2002:a9d:f29:: with SMTP id 38mr392177ott.281.1596141850104;
 Thu, 30 Jul 2020 13:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200730131347.30261-1-oded.gabbay@gmail.com>
In-Reply-To: <20200730131347.30261-1-oded.gabbay@gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 30 Jul 2020 22:43:58 +0200
Message-ID: <CAKMK7uEsmLMK2CJLk1kyN-BkG9+Ykv56K+BNr3832eG+idX2Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs: Replace dma-fence mechanism with completions
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 3:13 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> From: Ofir Bitton <obitton@habana.ai>
>
> habanalabs driver uses dma-fence mechanism for synchronization.
> dma-fence mechanism was designed solely for GPUs, hence we purpose
> a simpler mechanism based on completions to replace current
> dma-fence objects.
>
> Signed-off-by: Ofir Bitton <obitton@habana.ai>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Are you sure you need kfree_rcu for hl_fence? That was a requirement
from dma_fence, because we do _tons_ of rcu protected lockups of those
in gpu drivers (e.g. struct dma_resv). But a quick git grep says
habanalabs driver doesn't use any rcu, so a simple kfree() should be
fine, and allows you to further simplify hl_fence. With that change
this is:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Cheers, Daniel

> ---
>  .../habanalabs/common/command_submission.c    | 93 +++++++++----------
>  drivers/misc/habanalabs/common/context.c      | 13 +--
>  drivers/misc/habanalabs/common/habanalabs.h   | 32 +++++--
>  drivers/misc/habanalabs/common/hw_queue.c     |  2 +-
>  4 files changed, 78 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
> index b9840e368eb5..d19ac641b171 100644
> --- a/drivers/misc/habanalabs/common/command_submission.c
> +++ b/drivers/misc/habanalabs/common/command_submission.c
> @@ -38,26 +38,10 @@ void hl_sob_reset_error(struct kref *ref)
>                         hw_sob->q_idx, hw_sob->sob_id);
>  }
>
> -static const char *hl_fence_get_driver_name(struct dma_fence *fence)
> -{
> -       return "HabanaLabs";
> -}
> -
> -static const char *hl_fence_get_timeline_name(struct dma_fence *fence)
> -{
> -       struct hl_cs_compl *hl_cs_compl =
> -               container_of(fence, struct hl_cs_compl, base_fence);
> -
> -       return dev_name(hl_cs_compl->hdev->dev);
> -}
> -
> -static bool hl_fence_enable_signaling(struct dma_fence *fence)
> -{
> -       return true;
> -}
> -
> -static void hl_fence_release(struct dma_fence *fence)
> +void hl_fence_release(struct kref *kref)
>  {
> +       struct hl_fence *fence =
> +               container_of(kref, struct hl_fence, refcount);
>         struct hl_cs_compl *hl_cs_cmpl =
>                 container_of(fence, struct hl_cs_compl, base_fence);
>         struct hl_device *hdev = hl_cs_cmpl->hdev;
> @@ -102,12 +86,24 @@ static void hl_fence_release(struct dma_fence *fence)
>         kfree_rcu(hl_cs_cmpl, base_fence.rcu);
>  }
>
> -static const struct dma_fence_ops hl_fence_ops = {
> -       .get_driver_name = hl_fence_get_driver_name,
> -       .get_timeline_name = hl_fence_get_timeline_name,
> -       .enable_signaling = hl_fence_enable_signaling,
> -       .release = hl_fence_release
> -};
> +void hl_fence_put(struct hl_fence *fence)
> +{
> +       if (fence)
> +               kref_put(&fence->refcount, hl_fence_release);
> +}
> +
> +void hl_fence_get(struct hl_fence *fence)
> +{
> +       if (fence)
> +               kref_get(&fence->refcount);
> +}
> +
> +void hl_fence_init(struct hl_fence *fence)
> +{
> +       kref_init(&fence->refcount);
> +       fence->error = 0;
> +       init_completion(&fence->completion);
> +}
>
>  static void cs_get(struct hl_cs *cs)
>  {
> @@ -336,7 +332,7 @@ static void cs_do_release(struct kref *ref)
>                  * In case the wait for signal CS was submitted, the put occurs
>                  * in init_signal_wait_cs() right before hanging on the PQ.
>                  */
> -               dma_fence_put(cs->signal_fence);
> +               hl_fence_put(cs->signal_fence);
>         }
>
>         /*
> @@ -348,19 +344,18 @@ static void cs_do_release(struct kref *ref)
>         hl_ctx_put(cs->ctx);
>
>         /* We need to mark an error for not submitted because in that case
> -        * the dma fence release flow is different. Mainly, we don't need
> +        * the hl fence release flow is different. Mainly, we don't need
>          * to handle hw_sob for signal/wait
>          */
>         if (cs->timedout)
> -               dma_fence_set_error(cs->fence, -ETIMEDOUT);
> +               cs->fence->error = -ETIMEDOUT;
>         else if (cs->aborted)
> -               dma_fence_set_error(cs->fence, -EIO);
> +               cs->fence->error = -EIO;
>         else if (!cs->submitted)
> -               dma_fence_set_error(cs->fence, -EBUSY);
> -
> -       dma_fence_signal(cs->fence);
> -       dma_fence_put(cs->fence);
> +               cs->fence->error = -EBUSY;
>
> +       complete_all(&cs->fence->completion);
> +       hl_fence_put(cs->fence);
>         cs_counters_aggregate(hdev, cs->ctx);
>
>         kfree(cs->jobs_in_queue_cnt);
> @@ -401,7 +396,7 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
>                         enum hl_cs_type cs_type, struct hl_cs **cs_new)
>  {
>         struct hl_cs_compl *cs_cmpl;
> -       struct dma_fence *other = NULL;
> +       struct hl_fence *other = NULL;
>         struct hl_cs *cs;
>         int rc;
>
> @@ -434,7 +429,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
>         cs_cmpl->cs_seq = ctx->cs_sequence;
>         other = ctx->cs_pending[cs_cmpl->cs_seq &
>                                 (hdev->asic_prop.max_pending_cs - 1)];
> -       if ((other) && (!dma_fence_is_signaled(other))) {
> +
> +       if (other && !completion_done(&other->completion)) {
>                 dev_dbg(hdev->dev,
>                         "Rejecting CS because of too many in-flights CS\n");
>                 rc = -EAGAIN;
> @@ -448,8 +444,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
>                 goto free_fence;
>         }
>
> -       dma_fence_init(&cs_cmpl->base_fence, &hl_fence_ops, &cs_cmpl->lock,
> -                       ctx->asid, ctx->cs_sequence);
> +       /* init hl_fence */
> +       hl_fence_init(&cs_cmpl->base_fence);
>
>         cs->sequence = cs_cmpl->cs_seq;
>
> @@ -458,9 +454,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
>                                                         &cs_cmpl->base_fence;
>         ctx->cs_sequence++;
>
> -       dma_fence_get(&cs_cmpl->base_fence);
> +       hl_fence_get(&cs_cmpl->base_fence);
>
> -       dma_fence_put(other);
> +       hl_fence_put(other);
>
>         spin_unlock(&ctx->cs_lock);
>
> @@ -773,7 +769,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
>         struct hl_ctx *ctx = hpriv->ctx;
>         struct hl_cs_chunk *cs_chunk_array, *chunk;
>         struct hw_queue_properties *hw_queue_prop;
> -       struct dma_fence *sig_fence = NULL;
> +       struct hl_fence *sig_fence = NULL;
>         struct hl_cs_job *job;
>         struct hl_cs *cs;
>         struct hl_cb *cb;
> @@ -875,14 +871,14 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
>                         dev_err(hdev->dev,
>                                 "CS seq 0x%llx is not of a signal CS\n",
>                                 signal_seq);
> -                       dma_fence_put(sig_fence);
> +                       hl_fence_put(sig_fence);
>                         rc = -EINVAL;
>                         goto free_signal_seq_array;
>                 }
>
> -               if (dma_fence_is_signaled(sig_fence)) {
> +               if (completion_done(&sig_fence->completion)) {
>                         /* signal CS already finished */
> -                       dma_fence_put(sig_fence);
> +                       hl_fence_put(sig_fence);
>                         rc = 0;
>                         goto free_signal_seq_array;
>                 }
> @@ -894,7 +890,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
>         rc = allocate_cs(hdev, ctx, cs_type, &cs);
>         if (rc) {
>                 if (cs_type == CS_TYPE_WAIT)
> -                       dma_fence_put(sig_fence);
> +                       hl_fence_put(sig_fence);
>                 hl_ctx_put(ctx);
>                 goto free_signal_seq_array;
>         }
> @@ -1154,7 +1150,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
>  static long _hl_cs_wait_ioctl(struct hl_device *hdev,
>                 struct hl_ctx *ctx, u64 timeout_us, u64 seq)
>  {
> -       struct dma_fence *fence;
> +       struct hl_fence *fence;
>         unsigned long timeout;
>         long rc;
>
> @@ -1173,12 +1169,15 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
>                                 "Can't wait on CS %llu because current CS is at seq %llu\n",
>                                 seq, ctx->cs_sequence);
>         } else if (fence) {
> -               rc = dma_fence_wait_timeout(fence, true, timeout);
> +               rc = wait_for_completion_interruptible_timeout(
> +                               &fence->completion, timeout);
> +
>                 if (fence->error == -ETIMEDOUT)
>                         rc = -ETIMEDOUT;
>                 else if (fence->error == -EIO)
>                         rc = -EIO;
> -               dma_fence_put(fence);
> +
> +               hl_fence_put(fence);
>         } else {
>                 dev_dbg(hdev->dev,
>                         "Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
> diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
> index 3e375958e73b..b168a9fce817 100644
> --- a/drivers/misc/habanalabs/common/context.c
> +++ b/drivers/misc/habanalabs/common/context.c
> @@ -23,7 +23,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
>          */
>
>         for (i = 0 ; i < hdev->asic_prop.max_pending_cs ; i++)
> -               dma_fence_put(ctx->cs_pending[i]);
> +               hl_fence_put(ctx->cs_pending[i]);
>
>         kfree(ctx->cs_pending);
>
> @@ -128,7 +128,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
>         atomic_set(&ctx->thread_ctx_switch_token, 1);
>         ctx->thread_ctx_switch_wait_token = 0;
>         ctx->cs_pending = kcalloc(hdev->asic_prop.max_pending_cs,
> -                               sizeof(struct dma_fence *),
> +                               sizeof(struct hl_fence *),
>                                 GFP_KERNEL);
>         if (!ctx->cs_pending)
>                 return -ENOMEM;
> @@ -184,10 +184,10 @@ int hl_ctx_put(struct hl_ctx *ctx)
>         return kref_put(&ctx->refcount, hl_ctx_do_release);
>  }
>
> -struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
> +struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
>  {
>         struct asic_fixed_properties *asic_prop = &ctx->hdev->asic_prop;
> -       struct dma_fence *fence;
> +       struct hl_fence *fence;
>
>         spin_lock(&ctx->cs_lock);
>
> @@ -201,8 +201,9 @@ struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
>                 return NULL;
>         }
>
> -       fence = dma_fence_get(
> -                       ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)]);
> +       fence = ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)];
> +       hl_fence_get(fence);
> +
>         spin_unlock(&ctx->cs_lock);
>
>         return fence;
> diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
> index 018d9d67e8e6..30a399337675 100644
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -15,7 +15,6 @@
>  #include <linux/cdev.h>
>  #include <linux/iopoll.h>
>  #include <linux/irqreturn.h>
> -#include <linux/dma-fence.h>
>  #include <linux/dma-direction.h>
>  #include <linux/scatterlist.h>
>  #include <linux/hashtable.h>
> @@ -342,9 +341,24 @@ struct asic_fixed_properties {
>         u8                              completion_queues_count;
>  };
>
> +/**
> + * struct hl_fence - software synchronization primitive
> + * @completion: fence is implemented using completion
> + * @refcount: refcount for this fence
> + * @rcu: used for releasing fence with kfree_rcu
> + * @error: mark this fence with error
> + *
> + */
> +struct hl_fence {
> +       struct completion       completion;
> +       struct kref             refcount;
> +       struct rcu_head         rcu;
> +       int                     error;
> +};
> +
>  /**
>   * struct hl_cs_compl - command submission completion object.
> - * @base_fence: kernel fence object.
> + * @base_fence: hl fence object.
>   * @lock: spinlock to protect fence.
>   * @hdev: habanalabs device structure.
>   * @hw_sob: the H/W SOB used in this signal/wait CS.
> @@ -353,7 +367,7 @@ struct asic_fixed_properties {
>   * @sob_val: the SOB value that is used in this signal/wait CS.
>   */
>  struct hl_cs_compl {
> -       struct dma_fence        base_fence;
> +       struct hl_fence         base_fence;
>         spinlock_t              lock;
>         struct hl_device        *hdev;
>         struct hl_hw_sob        *hw_sob;
> @@ -800,7 +814,7 @@ struct hl_va_range {
>   * @hdev: pointer to the device structure.
>   * @refcount: reference counter for the context. Context is released only when
>   *             this hits 0l. It is incremented on CS and CS_WAIT.
> - * @cs_pending: array of DMA fence objects representing pending CS.
> + * @cs_pending: array of hl fence objects representing pending CS.
>   * @host_va_range: holds available virtual addresses for host mappings.
>   * @host_huge_va_range: holds available virtual addresses for host mappings
>   *                      with huge pages.
> @@ -832,7 +846,7 @@ struct hl_ctx {
>         struct hl_fpriv         *hpriv;
>         struct hl_device        *hdev;
>         struct kref             refcount;
> -       struct dma_fence        **cs_pending;
> +       struct hl_fence         **cs_pending;
>         struct hl_va_range      *host_va_range;
>         struct hl_va_range      *host_huge_va_range;
>         struct hl_va_range      *dram_va_range;
> @@ -919,8 +933,8 @@ struct hl_cs {
>         struct list_head        job_list;
>         spinlock_t              job_lock;
>         struct kref             refcount;
> -       struct dma_fence        *fence;
> -       struct dma_fence        *signal_fence;
> +       struct hl_fence         *fence;
> +       struct hl_fence         *signal_fence;
>         struct work_struct      finish_work;
>         struct delayed_work     work_tdr;
>         struct list_head        mirror_node;
> @@ -1736,7 +1750,7 @@ int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx);
>  void hl_ctx_do_release(struct kref *ref);
>  void hl_ctx_get(struct hl_device *hdev,        struct hl_ctx *ctx);
>  int hl_ctx_put(struct hl_ctx *ctx);
> -struct dma_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
> +struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
>  void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
>  void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
>
> @@ -1778,6 +1792,8 @@ void hl_cs_rollback_all(struct hl_device *hdev);
>  struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
>                 enum hl_queue_type queue_type, bool is_kernel_allocated_cb);
>  void hl_sob_reset_error(struct kref *ref);
> +void hl_fence_put(struct hl_fence *fence);
> +void hl_fence_get(struct hl_fence *fence);
>
>  void goya_set_asic_funcs(struct hl_device *hdev);
>  void gaudi_set_asic_funcs(struct hl_device *hdev);
> diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
> index 287681646071..65b9aa69a83e 100644
> --- a/drivers/misc/habanalabs/common/hw_queue.c
> +++ b/drivers/misc/habanalabs/common/hw_queue.c
> @@ -474,7 +474,7 @@ static void init_signal_wait_cs(struct hl_cs *cs)
>                  * wait CS was submitted.
>                  */
>                 mb();
> -               dma_fence_put(cs->signal_fence);
> +               hl_fence_put(cs->signal_fence);
>                 cs->signal_fence = NULL;
>         }
>  }
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
