Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37B4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9F920825
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVGDFFAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgEYFTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEYFTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:19:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA616C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:19:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d7so12989841ote.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NZ2Tj+nzwca+RyzhMFDoxVVlP2dsYpyHhk1WK9Ml8U=;
        b=UVGDFFAF5SSvJx2F7CnfBDBWM2K/+GBUp5sSQlOaRAj0OsFEHxDI41uqI5PQf6TVw/
         cGnO5BVnhmZgSVkhVLK8na/FDDnUH0QbcDWmsP3nJ02WZNtWzgRPEpAc5fePIZLrYvK5
         qppD1AfNVHi1ap+4hC8Nner0xrJaTZ3gMpXzoAwWsh6vnXS1d4s+Z8JiKOOL5TMNPkPH
         q9tZRBRqu/JjZc6HrJ8msEXz9WkD7CnFY8fPjUezYOjTJY5EK8iz483wTXGn65rhvx6/
         8yt/AeuHygOvcRvlOKDMhdEwhiuaSMVD+RsAEKy01aMQonr4Elq1KmSBDcB1ChD6ZIaT
         KwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NZ2Tj+nzwca+RyzhMFDoxVVlP2dsYpyHhk1WK9Ml8U=;
        b=r5l/lL9sWKNLCLuwQ9QXJCqbndOYAylprhPQ+RDO4NYXrj+aRer/2rnT2GKJb1ze3O
         FKEhm/wYVIkndmleDb+9D22HPeLffyhd/ZZdc+QffkpvaPFJe4V44CzFUvsoXAaHB3dM
         QdVmzl9k5LeKtKVf3pwblbS78Kza4BnyIrrj+jX73F7DR6ViNzQD5VVhKlvaSYdy9ZS0
         PU7Kqywv7XVjf93e6EWImhD4MurGm/WvwhdcjEbqDG9xj4EZ3rTa+TZpHkpP012nCoyJ
         MPsg7fkW0rw8scojM7kLw4ca2+nDsJ9IPa/Dld1xpEh/2Uga7sYXYMYMzJMPmUP53ml/
         lBzQ==
X-Gm-Message-State: AOAM532lh0mbcol8UouKjMCoOi/QpSuIPN4PhOLuPgYjdHClzJ44zBHl
        n00lkJj0dDAHIM5ZKvXDFlnzvZIW4hdBBYCMpDctOA==
X-Google-Smtp-Source: ABdhPJxFeMl9BbWv2YhhHmOwjGVdU0V9z79bTUaKG79wxBxye4wjN7GsN1Xw/4wsPkOEyx93BUF6Lf12RqJw9LXJT9w=
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr647688ots.143.1590383972854;
 Sun, 24 May 2020 22:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200524200659.12041-1-oshpigelman@habana.ai>
In-Reply-To: <20200524200659.12041-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 25 May 2020 08:19:05 +0300
Message-ID: <CAFCwf11T=xe3qqYFCC3Ma3ukff2OizDoUWR03Lhs7Wpp6zdN6A@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: handle MMU cache invalidation timeout
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:07 PM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> MMU cache invalidation timeout indicates that the device is unstable and
> therefore unusable.
> Hence in such case do hard reset and return an error to the user if was
> called from ioctl.
> In addition, change the print to error level and rephrase its text.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 36 ++++++++++++++++-----------
>  drivers/misc/habanalabs/goya/goya.c   | 34 +++++++++++++++----------
>  drivers/misc/habanalabs/habanalabs.h  |  8 +++---
>  drivers/misc/habanalabs/memory.c      | 35 ++++++++++++++++++++------
>  4 files changed, 75 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 92a5130f06fb..61f88e9884ce 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -5975,7 +5975,7 @@ static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate,
>         return gaudi->events_stat;
>  }
>
> -static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
> +static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
>                                         u32 flags)
>  {
>         struct gaudi_device *gaudi = hdev->asic_specific;
> @@ -5984,15 +5984,15 @@ static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
>
>         if (!(gaudi->hw_cap_initialized & HW_CAP_MMU) ||
>                 hdev->hard_reset_pending)
> -               return;
> -
> -       mutex_lock(&hdev->mmu_cache_lock);
> +               return 0;
>
>         if (hdev->pldm)
>                 timeout_usec = GAUDI_PLDM_MMU_TIMEOUT_USEC;
>         else
>                 timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
>
> +       mutex_lock(&hdev->mmu_cache_lock);
> +
>         /* L0 & L1 invalidation */
>         WREG32(mmSTLB_INV_PS, 2);
>
> @@ -6006,14 +6006,18 @@ static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
>
>         WREG32(mmSTLB_INV_SET, 0);
>
> -       if (rc)
> -               dev_notice_ratelimited(hdev->dev,
> -                       "Timeout when waiting for MMU cache invalidation\n");
> -
>         mutex_unlock(&hdev->mmu_cache_lock);
> +
> +       if (rc) {
> +               dev_err_ratelimited(hdev->dev,
> +                                       "MMU cache invalidation timeout\n");
> +               hl_device_reset(hdev, true, false);
> +       }
> +
> +       return rc;
>  }
>
> -static void gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
> +static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
>                                 bool is_hard, u32 asid, u64 va, u64 size)
>  {
>         struct gaudi_device *gaudi = hdev->asic_specific;
> @@ -6024,7 +6028,7 @@ static void gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
>
>         if (!(gaudi->hw_cap_initialized & HW_CAP_MMU) ||
>                 hdev->hard_reset_pending)
> -               return;
> +               return 0;
>
>         mutex_lock(&hdev->mmu_cache_lock);
>
> @@ -6055,11 +6059,15 @@ static void gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
>                 1000,
>                 timeout_usec);
>
> -       if (rc)
> -               dev_notice_ratelimited(hdev->dev,
> -                       "Timeout when waiting for MMU cache invalidation\n");
> -
>         mutex_unlock(&hdev->mmu_cache_lock);
> +
> +       if (rc) {
> +               dev_err_ratelimited(hdev->dev,
> +                                       "MMU cache invalidation timeout\n");
> +               hl_device_reset(hdev, true, false);
> +       }
> +
> +       return rc;
>  }
>
>  static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev,
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 152418dfe20c..0d2952bb58df 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -4884,7 +4884,7 @@ static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
>                 goya_mmu_prepare_reg(hdev, goya_mmu_regs[i], asid);
>  }
>
> -static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
> +static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
>                                         u32 flags)
>  {
>         struct goya_device *goya = hdev->asic_specific;
> @@ -4893,11 +4893,11 @@ static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
>
>         if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
>                 hdev->hard_reset_pending)
> -               return;
> +               return 0;
>
>         /* no need in L1 only invalidation in Goya */
>         if (!is_hard)
> -               return;
> +               return 0;
>
>         if (hdev->pldm)
>                 timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
> @@ -4919,13 +4919,17 @@ static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
>
>         mutex_unlock(&hdev->mmu_cache_lock);
>
> -       if (rc)
> -               dev_notice_ratelimited(hdev->dev,
> -                       "Timeout when waiting for MMU cache invalidation\n");
> +       if (rc) {
> +               dev_err_ratelimited(hdev->dev,
> +                                       "MMU cache invalidation timeout\n");
> +               hl_device_reset(hdev, true, false);
> +       }
> +
> +       return rc;
>  }
>
> -static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
> -               bool is_hard, u32 asid, u64 va, u64 size)
> +static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
> +                               bool is_hard, u32 asid, u64 va, u64 size)
>  {
>         struct goya_device *goya = hdev->asic_specific;
>         u32 status, timeout_usec, inv_data, pi;
> @@ -4933,11 +4937,11 @@ static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
>
>         if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
>                 hdev->hard_reset_pending)
> -               return;
> +               return 0;
>
>         /* no need in L1 only invalidation in Goya */
>         if (!is_hard)
> -               return;
> +               return 0;
>
>         if (hdev->pldm)
>                 timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
> @@ -4970,9 +4974,13 @@ static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
>
>         mutex_unlock(&hdev->mmu_cache_lock);
>
> -       if (rc)
> -               dev_notice_ratelimited(hdev->dev,
> -                       "Timeout when waiting for MMU cache invalidation\n");
> +       if (rc) {
> +               dev_err_ratelimited(hdev->dev,
> +                                       "MMU cache invalidation timeout\n");
> +               hl_device_reset(hdev, true, false);
> +       }
> +
> +       return rc;
>  }
>
>  int goya_send_heartbeat(struct hl_device *hdev)
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index 0f0691875298..1ecdcf8b763a 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -675,9 +675,9 @@ struct hl_asic_funcs {
>                                 u32 *size);
>         u64 (*read_pte)(struct hl_device *hdev, u64 addr);
>         void (*write_pte)(struct hl_device *hdev, u64 addr, u64 val);
> -       void (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard,
> +       int (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard,
>                                         u32 flags);
> -       void (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
> +       int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
>                         u32 asid, u64 va, u64 size);
>         int (*send_heartbeat)(struct hl_device *hdev);
>         void (*enable_clock_gating)(struct hl_device *hdev);
> @@ -755,8 +755,8 @@ struct hl_va_range {
>   *                      with huge pages.
>   * @dram_va_range: holds available virtual addresses for DRAM mappings.
>   * @mem_hash_lock: protects the mem_hash.
> - * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifing the
> - *            MMU hash or walking the PGT requires talking this lock
> + * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
> + *            MMU hash or walking the PGT requires talking this lock.
>   * @debugfs_list: node in debugfs list of contexts.
>   * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
>   *                     to user so user could inquire about CS. It is used as
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index a72f766ca470..4b8eed1ca513 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -886,6 +886,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
>
>                 vm_type = (enum vm_type_t *) userptr;
>                 hint_addr = args->map_host.hint_addr;
> +               handle = phys_pg_pack->handle;
>         } else {
>                 handle = lower_32_bits(args->map_device.handle);
>
> @@ -954,10 +955,17 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
>                 goto map_err;
>         }
>
> -       hdev->asic_funcs->mmu_invalidate_cache(hdev, false, *vm_type);
> +       rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, false, *vm_type);
>
>         mutex_unlock(&ctx->mmu_lock);
>
> +       if (rc) {
> +               dev_err(hdev->dev,
> +                       "mapping handle %u failed due to MMU cache invalidation\n",
> +                       handle);
> +               goto map_err;
> +       }
> +
>         ret_vaddr += phys_pg_pack->offset;
>
>         hnode->ptr = vm_type;
> @@ -1083,21 +1091,34 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
>          * at the loop end rather than for each iteration
>          */
>         if (!ctx_free)
> -               hdev->asic_funcs->mmu_invalidate_cache(hdev, true, *vm_type);
> +               rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
> +                                                               *vm_type);
>
>         mutex_unlock(&ctx->mmu_lock);
>
>         /*
> -        * No point in maintaining the free VA block list if the context is
> -        * closing as the list will be freed anyway
> +        * If the context is closing we don't need to check for the MMU cache
> +        * invalidation return code and update the VA free list as in this flow
> +        * we invalidate the MMU cache outside of this unmap function and the VA
> +        * free list will be freed anyway.
>          */
>         if (!ctx_free) {
> -               rc = add_va_block(hdev, va_range, vaddr,
> -                                       vaddr + phys_pg_pack->total_size - 1);
> +               int tmp_rc;
> +
>                 if (rc)
> +                       dev_err(hdev->dev,
> +                               "unmapping vaddr 0x%llx failed due to MMU cache invalidation\n",
> +                               vaddr);
> +
> +               tmp_rc = add_va_block(hdev, va_range, vaddr,
> +                                       vaddr + phys_pg_pack->total_size - 1);
> +               if (tmp_rc) {
>                         dev_warn(hdev->dev,
>                                         "add va block failed for vaddr: 0x%llx\n",
>                                         vaddr);
> +                       if (!rc)
> +                               rc = tmp_rc;
> +               }
>         }
>
>         atomic_dec(&phys_pg_pack->mapping_cnt);
> @@ -1108,7 +1129,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
>                 dma_unmap_host_va(hdev, userptr);
>         }
>
> -       return 0;
> +       return rc;
>
>  mapping_cnt_err:
>         if (is_userptr)
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
