Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57895C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D44D2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xwRDj4p2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgFAEU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAEU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:20:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D301C08C5C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:20:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so9340754wmd.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gaMeZxKRbbnoVLMQF6dqM6cOYIG1D5PJgYvrar+GJw=;
        b=xwRDj4p2YorlEnHTACn3XXVJQgsANhpObQcpjzC94GITlGstEOoiXLrC9N0kcg9uCT
         8Q7bJusUHFS6AALVDmmxwiqw/+UIBfFGOzmzom09Ixj5/SNMY45MAUSTUg56uwscGso/
         TNMYvsEhs9y3upvTHpG9Wu8hQ1w7c5ZEEfvt8tjj0w9fTYgA4cL/+sa4EtQDC4js9bQD
         zip8ZVFQGYKY1iBos5h1OVHEMQgJODeH3DUZi2qoiX6lHn5jrosM5Zl7GLMRPtGO/3NP
         WbOiNeiwzb2/uz3BRP+iefC+FQe/PnDH0F3L0ukmg9MBhPNEgWANuZum4wQ4ZJ+bzs/J
         GfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gaMeZxKRbbnoVLMQF6dqM6cOYIG1D5PJgYvrar+GJw=;
        b=Udnf6kjP3U21JMaCZ3NErSC4encI/SBRKdK/y3MN4DbVIorwJVsnIjNJVWoph43JVh
         8w5xhXS75U9WnNo2EgEX4Bd+5o7SeOPxIE5x0g3eZC4f0PDP4tY+c9FurCtUZYVjVtYv
         s/EPQZ/VaHM2kV0qLU0YeL8oykj8cvUfJgUu5THRBDHTsuEvSUiXD5H7eNm4TXN2nWYZ
         QYTpx4fBlVjKAMNMvApydepY5//qDgXQwIerKtFoDS7NI3r0ggd8pKI/qpzzd+gDaUcd
         uVNRbyUkhlRzxCvH7WfdpooE90i8J0jhU5arosl2oj8wQlJkK3rHa42NZD9x4PpztQq3
         ZbSg==
X-Gm-Message-State: AOAM531h0R5ix2rMPjncJ/dJni3iumZBIrwnNf4gNaP25nD6U5FE0sGR
        0+EPP66j7hoUnCVQKoMTR9p+Q/NVtHyiKBB+uU22fA==
X-Google-Smtp-Source: ABdhPJzo7iLG02tKKWTkJMhu/UxFu4NxgWLfYWaCeH4TxLc/E/khLp5PztuHnrvqowmY+ODxYov7L2PUtXa41zGmW1Q=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr8963040wme.152.1590985224670;
 Sun, 31 May 2020 21:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200531095748.753388-1-anup.patel@wdc.com>
In-Reply-To: <20200531095748.753388-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 1 Jun 2020 09:50:13 +0530
Message-ID: <CAAhSdy2aoHkJL6Rj5yEE_xvsH-UDv=Cya3b_6CWORZeTqeWPbw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Don't mark init section as non-executable
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 3:28 PM Anup Patel <anup.patel@wdc.com> wrote:
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
>  arch/riscv/mm/init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 736de6c8739f..e0f8ccab8a41 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -482,11 +482,6 @@ static void __init setup_vm_final(void)
>
>  void free_initmem(void)
>  {
> -       unsigned long init_begin = (unsigned long)__init_begin;
> -       unsigned long init_end = (unsigned long)__init_end;
> -
> -       /* Make the region as non-execuatble. */
> -       set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
>         free_initmem_default(POISON_FREE_INITMEM);
>  }

I just realized that updated free_initmem() over here is exactly
same as generic free_initmem() defined in init/main.c so it's better
to remove free_initmem() from here. I will send v2.

Regards,
Anup
