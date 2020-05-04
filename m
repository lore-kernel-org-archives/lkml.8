Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A89C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E810720746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 06:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="SKdMUg2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgEDGZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 02:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgEDGZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 02:25:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA14C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 23:25:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so19399759wrg.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=306i5OZb3rUOZcrOciamuAcP/j7L85jZXHqSzcVM+8k=;
        b=SKdMUg2m2SJUotPrI5/s9K2BOuYt+BZ7YCjLtRW5CL2yNeZ9E5af4QO0qX+nfoV+Nj
         0YYoVBNzfpzZrh9UBmDSdKU9FHJFuSbpYjc7C72qwtDWY4GHxkqcYNgSW9vRHz3suwC9
         u8RhrsPkKo/K8IJcRr564X2IVspwJhg7OBGGc0glsav76MgsrqDFuTht912eCJ4H6CeD
         IHofHbUTRY6uQ+tEhNe+pwkzM+dtafFw1oRtP9WbxN5pivgrv3b4rhlGtCTcGd/dO6Qj
         T9E2fWzdaOCw1fjh+Fnlb5nmJRqTk95MQkKUIZIvdF4Lxrs5CT+L5JWx5rTBlWkc1zMI
         AkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=306i5OZb3rUOZcrOciamuAcP/j7L85jZXHqSzcVM+8k=;
        b=GEi4gtqWAmwz246m859pWQsTJ0vDfbRLlvEeSAXa5ukewnDUal7K5JQznDfpjP1yGW
         i1L5Y7FyCPCbRP3a4B+Tn3WdVA0lh6W/pnmPQhtsnOPxhsgK9wFToH3ngfoQHc1BXr+7
         8UAjp5/ozpuzzdG89JvrQ1hKcmA58BBTgH4vumz2DKVMqxBR+iW/GFZQ52sarWwLJmpj
         7pjTtDe9T7Ya7b1Ct8GXA/sHB6353QdeJaVdQnA9fMcIQbLHxxyGCpGIO5uFfybb4DyU
         HZXoavCHxbdCLlxZVtcQu0Onocou+s5KvN0Wx4q/a80v6rVv6SBMD1RQPrj7wDbRVtjO
         772g==
X-Gm-Message-State: AGi0PuZzQ5bH+Z8Gk0bj82jTIDXEoXBnHYG/7H01YW1avdxcrOYfby3N
        mYyFgkSwp2F1i0VfuKK0Eyjw4liLsBsrGX8oYe+rMQ==
X-Google-Smtp-Source: APiQypJvk5cxpJtUzTo7O489Rc340Sftnq7QDcwugQGlOTRxHy+twmDNTb3JcGmVqQn1MWHTHXD+tN+epQfSzrhkz5c=
X-Received: by 2002:adf:fcc8:: with SMTP id f8mr17129641wrs.230.1588573516436;
 Sun, 03 May 2020 23:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200504035448.13893-1-zong.li@sifive.com>
In-Reply-To: <20200504035448.13893-1-zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 4 May 2020 11:55:05 +0530
Message-ID: <CAAhSdy23jzYvZcmXoX_5F1wDenBQ8NpvNpoO41=aBGHoONPCgg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: force __cpu_up_ variables to put in data section
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 9:24 AM Zong Li <zong.li@sifive.com> wrote:
>
> Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
> Currently, these two variables are put in bss section, there is a
> potential risk that secondary harts get the uninitialized value before
> main hart finishing the bss clearing. In this case, all secondary
> harts would pass the waiting loop and enable the MMU before main hart
> set up the page table.
>
> This issue happened on random booting of multiple harts, which means
> it will manifest for BBL and OpenSBI which older than v0.6. In OpenSBI
> v0.7, it had included HSM extension, all the secondary harts are
> waiting in firmware, so it could work fine without this change.

Slightly improved text:

This issue happens on random booting of multiple harts, which means
it will manifest for BBL and OpenSBI v0.6 (or older version). In OpenSBI
v0.7 (or higher version), we have HSM extension so all the secondary harts
are brought-up by Linux kernel in an orderly fashion. This means we don't
this change for OpenSBI v0.7 (or higher version).

>
> Changes in v2:
>   - Add commit description about random booting.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/kernel/cpu_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index c4c33bf02369..0ec22354018c 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -15,8 +15,8 @@
>
>  const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
>
> -void *__cpu_up_stack_pointer[NR_CPUS];
> -void *__cpu_up_task_pointer[NR_CPUS];
> +void *__cpu_up_stack_pointer[NR_CPUS] __section(.data);
> +void *__cpu_up_task_pointer[NR_CPUS] __section(.data);
>
>  extern const struct cpu_operations cpu_ops_sbi;
>  extern const struct cpu_operations cpu_ops_spinwait;
> --
> 2.26.1
>

Apart from above, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
