Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B264207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="AfYhAglE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgEYGMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYGMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:12:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D62C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:12:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so15924904wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8mBNVGYZkHU9Quhb03FrsiJkGOZXcv8WLnSN8Y0whs=;
        b=AfYhAglE5mHr6xcqgT7WBdJor1q8lrol2npLRIvdqpwEKibvRWSt4BrSy0zCmYV5EF
         uVuTNnKqCrDHCKxF4+jktE8qTrOxxWBro2YItGT2l/vXJMBMSVcycXdl3qUJpZgLpgWL
         IICKpPIZ5fbc/31Mevzs6fja8SB7Odm/Bax7Vs+jW7toWqwLqnjd7/3LnU4krT/4fOxw
         dhmzhboiBqUtKFGne897dyD2mMwt+HTbd6RffntZofTgyeLmxSyyW9S3Qd7+tywdMgLZ
         eGtnyn22Sp2iaIsQInyo3Cat7Wzc0uRaX4VTn/5oRgeoqyaUFEOedUYK16JSSITAaCR0
         JdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8mBNVGYZkHU9Quhb03FrsiJkGOZXcv8WLnSN8Y0whs=;
        b=ZLaa3vMjF2bMSqef5l5KpHLfzn6ylTzA1cIbyL+YuZf6pLi12PCeSBrBZX3ze4FXfA
         DXQw5w6fzeR7zl4TrgK3Lu7ASLRb21P+FRCQPSg1Ju4/YP6zwPrdLWztThG6J5IeOd4s
         OZMmSvwKSaKfp4+eaCKuV6z6XG5D6oV3xB5/myAB9P5qZBEJqelTMnJhsW4PgwNsC6HY
         0JoGxs6gb26/7sUxNvf34/92edjUGHD8bA6n9B04DW27V6IfkeURB5O5Tanu7bVnKtK5
         ACDT0strLKnky47URjRzamiGO/EYtoGTy1XAoPzllowe8yNPAl9bKljNf3pPfhnDJxPf
         t0RA==
X-Gm-Message-State: AOAM530m5p8At0Z8RGCWQ21DPrkUIpfQWOq18q9sRg0fVHd1yUTqMiZ1
        QClue7SKCTcy6EfbS6TdkTjetheqGPPE2LRj7uBCHA==
X-Google-Smtp-Source: ABdhPJyPX3ZiUTZT/8mtgGaL4HlnKXmKgiYFgFgHS40tjaarYFLPubJJ2w3R/soHzu+PGjuLaHWViJjKKuGHrJQ7EBA=
X-Received: by 2002:a5d:484b:: with SMTP id n11mr12229511wrs.356.1590387137034;
 Sun, 24 May 2020 23:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200524091008.25587-1-alex@ghiti.fr> <20200524091008.25587-7-alex@ghiti.fr>
In-Reply-To: <20200524091008.25587-7-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 May 2020 11:42:05 +0530
Message-ID: <CAAhSdy2VrKVZPTem4J2B=PQtSC4Tst57_mJr9TOF5QcaHUiXXw@mail.gmail.com>
Subject: Re: [PATCH 6/8] riscv: Allow user to downgrade to sv39 when hw
 supports sv48
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 2:46 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> This is made possible by using the mmu-type property of the cpu node of
> the device tree.
>
> By default, the kernel will boot with 4-level page table if the hw supports
> it but it can be interesting for the user to select 3-level page table as
> it is less memory consuming and faster since it requires less memory
> accesses in case of a TLB miss.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/mm/init.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bad8da099ff6..1776eeb53d61 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -509,11 +509,32 @@ void disable_pgtable_l4(void)
>   * then read SATP to see if the configuration was taken into account
>   * meaning sv48 is supported.
>   */
> -asmlinkage __init void set_satp_mode(uintptr_t load_pa)
> +asmlinkage __init void set_satp_mode(uintptr_t load_pa, uintptr_t dtb_pa)
>  {
>         u64 identity_satp, hw_satp;
>         int cpus_node;
>
> +       /* 1/ Check if the user asked for sv39 explicitly in the device tree */
> +       cpus_node = fdt_path_offset((void *)dtb_pa, "/cpus");
> +       if (cpus_node >= 0) {
> +               int node;
> +
> +               fdt_for_each_subnode(node, (void *)dtb_pa, cpus_node) {
> +                       const char *mmu_type = fdt_getprop((void *)dtb_pa, node,
> +                                                       "mmu-type", NULL);
> +                       if (!mmu_type)
> +                               continue;
> +
> +                       if (!strcmp(mmu_type, "riscv,sv39")) {
> +                               disable_pgtable_l4();
> +                               return;
> +                       }
> +
> +                       break;
> +               }
> +       }
> +
> +       /* 2/ Determine if the HW supports sv48: if not, fallback to sv39 */
>         create_pgd_mapping(early_pg_dir, load_pa, (uintptr_t)early_pud,
>                            PGDIR_SIZE, PAGE_TABLE);
>         create_pud_mapping(early_pud, load_pa, (uintptr_t)early_pmd,
> @@ -561,7 +582,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         load_sz = (uintptr_t)(&_end) - load_pa;
>
>  #if defined(CONFIG_64BIT) && !defined(CONFIG_MAXPHYSMEM_2GB)
> -       set_satp_mode(load_pa);
> +       set_satp_mode(load_pa, dtb_pa);
>  #endif
>
>         kernel_virt_addr = KERNEL_VIRT_ADDR;
> --
> 2.20.1
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
