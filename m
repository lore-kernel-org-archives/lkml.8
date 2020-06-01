Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F306FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3558206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="V03H8YHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgFASmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbgFASmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:42:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED6C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:23:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so813692wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ORKuPDr81ZTRpp39aYW+4mCM6zzq+FYt0tOhd8RtB8=;
        b=V03H8YHXT0J3zKfEHNyuFSM+8VZyYqjgKZmFQoD7IoWAdl5ue3WkPABR4A2m1qnxIv
         TEi0T0Bs71krCQoC2Hz1kmVhqKEsfEYxAaUXego6pB3dMnsl4fgP28IxSqNy3yfo1KY6
         JtB21X3S69XND6s4AR5BKc65vUpNJV77q9Ptw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ORKuPDr81ZTRpp39aYW+4mCM6zzq+FYt0tOhd8RtB8=;
        b=f/Ra+l6lhtAloGl4kLX/x2aq2+BwKI2hSXBVnqRmjbIkv24NppFbjYWMb+j/7iazj/
         UfIApsDFpb5X+JNknDkyzQT8au1BmSz/M9ErugdrD1YpKY5w9dtdru/ERW+fPMcbY5yG
         0PfLVUc7P7f0Uf83uF4h+skOMAzfVQqP6he/k404Bslyuvg92LspScyq1ld1ribQisA9
         hMnWRECCcrXwDe4WCbyTK0a+EaZZeYua/hUfe/x6s3XCrCjpcVB40hKA2rb/V/qH6Vqy
         KFt+5kqoTZ6W/qWlL8Ooio5oQHrxFCgRB8Z4r7kwRHAxSajTh+5VHRovH+rVD1FbGu6V
         XZNg==
X-Gm-Message-State: AOAM5327cn+lvjs8COKkqPJj73OyvVmTVp+p2mJalaLzHGb81mHf6t9t
        8QJC3fVJZOImBh577rlCXm7/QujvGQaM99XdPWCf
X-Google-Smtp-Source: ABdhPJzUqjNllZMEEg1nn6d/J5AuzWmQPqp4dOddQX+lLHvzFb+TTwXYz/WenpZhHpRJLxBXZKmb6pusTzpc3hUhqhk=
X-Received: by 2002:adf:edc8:: with SMTP id v8mr22011928wro.176.1591035802832;
 Mon, 01 Jun 2020 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200601050656.826296-1-anup.patel@wdc.com>
In-Reply-To: <20200601050656.826296-1-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 1 Jun 2020 11:23:11 -0700
Message-ID: <CAOnJCUKT_DT-F9g21q5kvYfYgHC3PQ9dJLrqbQ4z87ULpBiyBQ@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Don't mark init section as non-executable
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 10:07 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The head text section (i.e. _start, secondary_start_sbi, etc) and the
> init section fall under same page table level-1 mapping.
>
> Currently, the runtime CPU hotplug is broken because we are marking
> init section as non-executable which in-turn marks head text section
> as non-executable.
>
> Further investigating other architectures, it seems marking the init
> section as non-executable is redundant because the init section pages
> are anyway poisoned and freed.
>
> To fix broken runtime CPU hotplug, we simply remove the code marking
> the init section as non-executable.
>
> Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
> Changes since v1:
>  - Updated free_initmem() is same as generic free_initmem() defined in
>    init/main.c so we completely remove free_initmem() from arch/riscv
> ---
>  arch/riscv/mm/init.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 736de6c8739f..fdc772f57edc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -479,17 +479,6 @@ static void __init setup_vm_final(void)
>         csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>         local_flush_tlb_all();
>  }
> -
> -void free_initmem(void)
> -{
> -       unsigned long init_begin = (unsigned long)__init_begin;
> -       unsigned long init_end = (unsigned long)__init_end;
> -
> -       /* Make the region as non-execuatble. */
> -       set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
> -       free_initmem_default(POISON_FREE_INITMEM);
> -}
> -
>  #else
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> --
> 2.25.1
>
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
