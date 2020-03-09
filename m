Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A8BC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22F2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="GIFufCwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCIMAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:00:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34486 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCIMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:00:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so10751513wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XB8GNe6/v7EQn1hDBocDW32S0oBZB3GFkZAZ+BQoKuQ=;
        b=GIFufCwRBHYqYm6ZosJpdHi0QYnmtcPhKd/fkJOwlVTOKyQfn2epXhcKTh2cH0DzSK
         DoVEbszPfmXyrx+zeQnsKgNh/KxLeWw9ur8GxOsDye9MtH4bLfcQoTlyS7kAVmnNBxHy
         TbWlwgEddpv+jDE5dHca8Ymbpgxs9E1fy53Pb1T/kaMJKcAvZZ6ngvtfNnq7+i64BYhg
         dqqCNoQ6w12FNF/d+IceyM74kVMyGJ0FVCuWkn42Rn8OnJqKVS8LECJSv6lutdgWUh6S
         ghFxENqIL5/tjNMLC4rtY1/ZNwAg4dmNrQEhckPujGBgRN1YVth+HrqtcxcpjzXu7KG4
         d1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XB8GNe6/v7EQn1hDBocDW32S0oBZB3GFkZAZ+BQoKuQ=;
        b=k2Hg/2GbvyycHMkaS3x5JmM4EM2coqX63yNm2oKe7PMnN46ODDiYtfdvoLxj+l7nUM
         jh69UGUoCgdZnOsIi10cwjzfh1PCWTiPrqBaYrS2HzGgOg8g+NBTGfXS3tuCcsZ1zJOQ
         ynlwKl/w88Eq602fxFUM3LTtq77liKynXUGiwQ4l6kj8IRDhKwcTh6hndMDkV2exiYwh
         cdOIJrM2aO0Vce7MFYEElM6reLjPUAiFFVujzTpr+mCsfLC0iSso/zU7NDXt4VqxJkAV
         risp2QftPd++4jBW2ScJwDHWkOSpDS6R9Uy1lF+QJekYPn5hiMacxxV7xl4IhsAxJvi7
         GaOQ==
X-Gm-Message-State: ANhLgQ2Ty0C8mKxsMkfl6wIkutfiNfPiKNVBXN0TTyTqyghsc5jVvgM9
        eeJuYtMxqi8dqf8ckl0rEkicwhHioe5b0V0f2lo5LQ==
X-Google-Smtp-Source: ADFU+vt7I1yKlPHTHMtEOhumNiODgbHFpFxK/YWSYzY0A4G7ewobR9tMGoTyGv4Qn6oMW731JhqPaNfW/gRfEr279sk=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr20454127wrn.230.1583755250950;
 Mon, 09 Mar 2020 05:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200309110211.91130-1-anup.patel@wdc.com> <20200309110211.91130-6-anup.patel@wdc.com>
In-Reply-To: <20200309110211.91130-6-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Mar 2020 17:30:39 +0530
Message-ID: <CAAhSdy0t__RvDFkBkjEsaPma5j4_pOH9TvT4AFw3yuH2M6_PHA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Remove do_IRQ() function
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Marc's email address.

On Mon, Mar 9, 2020 at 4:33 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The only thing do_IRQ() does is call handle_arch_irq function
> pointer. We can very well call handle_arch_irq function pointer
> directly from assembly and remove do_IRQ() function hence this
> patch.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/kernel/entry.S | 4 +++-
>  arch/riscv/kernel/irq.c   | 6 ------
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 208702d8c18e..238f0ca070db 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -183,7 +183,9 @@ ENTRY(handle_exception)
>
>         /* Handle interrupts */
>         move a0, sp /* pt_regs */
> -       tail do_IRQ
> +       la a1, handle_arch_irq
> +       REG_L a1, (a1)
> +       jr a1
>  1:
>         /*
>          * Exceptions run with interrupts enabled or disabled depending on the
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index eb8777642ce6..7207fa08d78f 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -16,12 +16,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>         return 0;
>  }
>
> -asmlinkage __visible void __irq_entry do_IRQ(struct pt_regs *regs)
> -{
> -       if (handle_arch_irq)
> -               handle_arch_irq(regs);
> -}
> -
>  void __init init_IRQ(void)
>  {
>         irqchip_init();
> --
> 2.17.1
>
