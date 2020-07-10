Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8BC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5B720657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ8f2Sru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGJRFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:05:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC1C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:05:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a21so4675530otq.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reStBEWqwPKkJ8MQVsMGy0nARiSpxbLhmkT/7W1Ki/k=;
        b=aZ8f2SruCJLgagSV3Mv/cGvnmnhYag0B/CdIkS7qizWXboxInycnGm29Kzbq37la9R
         1BOpwVDk5qIQG3UKrJgJX7QpEV+YC+JxZPaQB6xfCZodTUrKlPuBEnkAFlHevQu7C88m
         9nzBW1ajSo/2+2VuXswqCJcOGFkm/Y2KXZs6ek08nfEdBpTJYNt4EtQ7DCXtvoAWw0OE
         nSbNtN+LTdKWG1I/XXkfR7M+80yJiCeZSK9zsjwUd2Mbsw1/TjV3pgj6cwjjW5kcxF0H
         uV4gcmVIBHftyFITzvBQP3uBVVqhO45TYG+KJEo0CMcTswYLYsoIZEhjWW7gzcXxMmTE
         BpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reStBEWqwPKkJ8MQVsMGy0nARiSpxbLhmkT/7W1Ki/k=;
        b=onk3vxCaxgF4ri7sPME312QtcAE04UFt9wfsRYw/dx5tmwj4HPIZx60hrkYE3gZNZL
         LMotO5nyh6+ga9t9GWmHZqokoMqleT9F9Onai/6N+sG82fCjfYxApgmtLj9l7bcZ741T
         IUcftajlf1eaDJi1p+AQdwnGeVolsQd4i92XoRKg0Nc3IGNCP/bpkZ8Vh/6zH1EWH70N
         d9EEWrzy9LojuXSs4PreX0lh7Ym6ElAksQn+d4OxraUX1LaAvo+/467HyK2pvQYNzRlp
         5MPmxLbCnyqiOohDnM4/jowZfL+eJ6mJq+QzFc/rmsP++eaWHHA1Mt0kqLgO0uQfgQbw
         bm9Q==
X-Gm-Message-State: AOAM532fwLg4jxy4mfH2fzHWtvwwFJpm3n/8gMb6/fFELeqpUavX8xtL
        JnLIcQr5FVB7IpQZcdteFViUL4uRwo9AGMsD1yecGBDM
X-Google-Smtp-Source: ABdhPJytNAJy49P1E9ZZoJcH5+aW1H2PfnySPVud82jHMqpLASxMAyvEv/o6WigKHL6FrCerpxomyH8VE2MbmSciL9U=
X-Received: by 2002:a05:6830:42:: with SMTP id d2mr15899633otp.339.1594400733581;
 Fri, 10 Jul 2020 10:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200707212954.26487-1-oshpigelman@habana.ai>
In-Reply-To: <20200707212954.26487-1-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 10 Jul 2020 20:05:08 +0300
Message-ID: <CAFCwf13EAWa3hYQzw1oBT9sHLcZGfimhiuPGBzrjnuUvNWi4OA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: remove unused hash
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:30 AM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> Remove an old hash that is not in use anymore.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/habanalabs.h | 2 --
>  drivers/misc/habanalabs/mmu.c        | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
> index a61aab09778c..ea0fd178accb 100644
> --- a/drivers/misc/habanalabs/habanalabs.h
> +++ b/drivers/misc/habanalabs/habanalabs.h
> @@ -780,7 +780,6 @@ struct hl_va_range {
>   * struct hl_ctx - user/kernel context.
>   * @mem_hash: holds mapping from virtual address to virtual memory area
>   *             descriptor (hl_vm_phys_pg_list or hl_userptr).
> - * @mmu_phys_hash: holds a mapping from physical address to pgt_info structure.
>   * @mmu_shadow_hash: holds a mapping from shadow address to pgt_info structure.
>   * @hpriv: pointer to the private (Kernel Driver) data of the process (fd).
>   * @hdev: pointer to the device structure.
> @@ -814,7 +813,6 @@ struct hl_va_range {
>   */
>  struct hl_ctx {
>         DECLARE_HASHTABLE(mem_hash, MEM_HASH_TABLE_BITS);
> -       DECLARE_HASHTABLE(mmu_phys_hash, MMU_HASH_TABLE_BITS);
>         DECLARE_HASHTABLE(mmu_shadow_hash, MMU_HASH_TABLE_BITS);
>         struct hl_fpriv         *hpriv;
>         struct hl_device        *hdev;
> diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
> index a290d6b49d78..04303950e630 100644
> --- a/drivers/misc/habanalabs/mmu.c
> +++ b/drivers/misc/habanalabs/mmu.c
> @@ -502,7 +502,6 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
>                 return 0;
>
>         mutex_init(&ctx->mmu_lock);
> -       hash_init(ctx->mmu_phys_hash);
>         hash_init(ctx->mmu_shadow_hash);
>
>         return dram_default_mapping_init(ctx);
> --
> 2.17.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
