Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263ACC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1802076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YAS31mZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGPNUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGPNUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:20:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C703C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:20:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so7009495wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfpSq4DvBlL0D7ejymaDz8bArWnsRIi88cDneCbu2y8=;
        b=YAS31mZ/STKIbmeo2sBBPloQfilq26Uf4dTWQCS2bWyUHtZRLm2xpBxxXLF4fuj9f1
         Wmo4WpB8a+hibAYAD8LrJVxMgJQqYfkiDjgOPxYJfrVyntyI/aqWXKvihxJTsOEQdug1
         zobpXzlLehzzNhH9tloFP8WLI5hMkghNQGOQGaNThXI0cB4IufWue9wTdZDBHtVgH/KG
         481nblD7Y/1/C5/uIeNqa4kZP8XpcYFRRBIDCpeEUO8UJyaV3NoKql4KEIRMi4GYUArK
         OYbESX2VcAc3b9E2YdzxiPLMq9DRhasta+A2+i4bbuEoVfFoJ9jxL3+VOSwwws1QHJQk
         HOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfpSq4DvBlL0D7ejymaDz8bArWnsRIi88cDneCbu2y8=;
        b=Hv9Gxs3dO57bX3N8tONTB/lz0SwQcweK0mjjmSfycuxhnS+qC16IUOgM1R7neaVFxr
         CcM/9BR0Xt4rIXSRsKyZGIhKwg6c7mv2P9FgLibiI/oNXlW+tWXtT266NEmm2OBYQ59s
         kB2XzfnksFRba0gZQzfZqBuvZ05WirKfFqR3O1j8SGuKgd41ZYLoEb/TsrZTEEMwR4/h
         LJyQWUV1seIuR6UaraZ4MH1JrFaJsUp5yYThvadMzU5hxIL3xZStGZrxFMu0sKrG3tL9
         mKXngZIPgtTRkHY1mWA467Lmmt9JQ7f9ozKzL2caJ0/vHt+y8ltPoW9Vk6Klvhf6cKN+
         F/JA==
X-Gm-Message-State: AOAM533IhIP/ZgtbTbIA8V75gGHdg6NkG+9AIDyrjFTS/e/hZ5QYWsvt
        omxfgdZquUfmgkhImva6uhaSIU3bP78tGTyN2p3BmQ==
X-Google-Smtp-Source: ABdhPJwdS5FgCKFmROVTu2BMJ/9+zwBq3b9LDYGDDGp/YQhzWsDX2aDEPh7oicx6LMFSG8DHSjtjKOnoj3Z6bCb3V1I=
X-Received: by 2002:adf:fcca:: with SMTP id f10mr4975330wrs.325.1594905629196;
 Thu, 16 Jul 2020 06:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594886530.git.zong.li@sifive.com> <8691a6a78271c748a2f75f1430b36f304551838d.1594886530.git.zong.li@sifive.com>
In-Reply-To: <8691a6a78271c748a2f75f1430b36f304551838d.1594886530.git.zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Jul 2020 18:50:14 +0530
Message-ID: <CAAhSdy3q8SCj4aTanyvgywuEa+DWCOZeOF3=-xHW+UjzXXcd_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: Fix build warning for mm/pageattr
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 6:36 PM Zong Li <zong.li@sifive.com> wrote:
>
> Add header for missing prototype. Also, static keyword should be at
> beginning of declaration.
>
> The warning messages as follows (with W=1 build):
>
> arch/riscv/mm/pageattr.c:130:5:
> warning: no previous prototype for 'set_memory_ro' [-Wmissing-prototypes]
>
> arch/riscv/mm/pageattr.c:136:5:
> warning: no previous prototype for 'set_memory_rw' [-Wmissing-prototypes]
>
> arch/riscv/mm/pageattr.c:142:5:
> warning: no previous prototype for 'set_memory_x' [-Wmissing-prototypes]
>
> arch/riscv/mm/pageattr.c:147:5:
> warning: no previous prototype for 'set_memory_nx' [-Wmissing-prototypes]
>
> arch/riscv/mm/pageattr.c:152:5:
> warning: no previous prototype for 'set_direct_map_invalid_noflush' [-Wmissing-prototypes]
>
> arch/riscv/mm/pageattr.c:169:5:
> warning: no previous prototype for 'set_direct_map_default_noflush' [-Wmissing-prototypes]
>
> arch/riscv/mm/pageattr.c:97:1:
> warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Pekka Enberg <penberg@kernel.org>
> ---
>  arch/riscv/mm/pageattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 289a9a5ea5b5..19fecb362d81 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -7,6 +7,7 @@
>  #include <linux/pgtable.h>
>  #include <asm/tlbflush.h>
>  #include <asm/bitops.h>
> +#include <asm/set_memory.h>
>
>  struct pageattr_masks {
>         pgprot_t set_mask;
> @@ -94,7 +95,7 @@ static int pageattr_pte_hole(unsigned long addr, unsigned long next,
>         return 0;
>  }
>
> -const static struct mm_walk_ops pageattr_ops = {
> +static const struct mm_walk_ops pageattr_ops = {
>         .pgd_entry = pageattr_pgd_entry,
>         .p4d_entry = pageattr_p4d_entry,
>         .pud_entry = pageattr_pud_entry,
> --
> 2.27.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
