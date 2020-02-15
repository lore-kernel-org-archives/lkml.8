Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E269C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 13:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCAE2083B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 13:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="AETsr1wM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgBONlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 08:41:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42000 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgBONlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 08:41:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so14284167wrd.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 05:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bvbp7c5toLr2Yh1pvx/xh6i9s0n9bxm1bo8lfDqxtVg=;
        b=AETsr1wM3uuQ+zyCzeyH+iS5CfSEbaVtJHCOcch65tFOAVWr4TGnzk1ZhgqX/P00Hi
         vV8236IAJ3MKxyHTeriZo2Cvf0Z6Tu/TU4J5Gc4ncmOv045e9zBFxTueGJcAECE93JMW
         9VtsNdbTT/nyOqGnz7uYxbZZQxgg5eO9b/QF1BZNzBmIhgG+FDX9tRHJuyK1EmBZrDSv
         hqMhhd9/HjU9Hl0UgLOIZ6cde/VjQ3PSBzqwLNwbS+TxqSD/eYWtxW18RXuZOwjnxS6S
         4rXHNIQ7xh/AKVqHmLAsRLEgnEcmxeUr7jrFO+p9GQkDAGNVE5J8o629uaMQH7DxjFZN
         5Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bvbp7c5toLr2Yh1pvx/xh6i9s0n9bxm1bo8lfDqxtVg=;
        b=O1wdodwepTJiPRUP01gog7Ml3C+9Ry6/pjurAGg15C/RoQatQ/iK5JRhELlfH03TnH
         B85vG2tuoXFfSow91QTp9fK+KZwGEls5j1HDEVDOxj8lqIFeplUwVwlhdsIMiu6i32OX
         MSRx4u0MCflfTeryCALcpVgbSlAbdJom1Qu4AYXvM+AqvkZxID0GgnU6YBpAoRkTTQ7A
         rPB4083xr2E2vsczEEaIjoVX26vAv4DZb6VaXYuB/gn8HhqsqNx98AQUEIQQlK79yyRn
         sCqU7ciLfWJOF1DjvreUFdVBnHiyyp5fEh6WKbzINPX5sVULej7VzlMPoj574Bg93f0A
         3DLw==
X-Gm-Message-State: APjAAAVX/62dDRxnlMu8bWAaS51dT6a2yMWOFL3ydwvOKRznQhWzOiaZ
        zNVmj+ovoz/YUl5a3FhF5+DIhKFvD4hHb8Rhu0U1HA==
X-Google-Smtp-Source: APXvYqz3TqP3RF2qhX4GRggNReYHvb1iCkHq5gaPNR7sx6SKc6nqN1h2V+xHFCeEtiunYMtgNxzz5xF39MXeunrJEZ8=
X-Received: by 2002:adf:ec84:: with SMTP id z4mr10326398wrn.61.1581774069508;
 Sat, 15 Feb 2020 05:41:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581767384.git.jan.kiszka@web.de> <617f75f4eaacb02cd9d0a7044434e3e9b65e9e8b.1581767384.git.jan.kiszka@web.de>
In-Reply-To: <617f75f4eaacb02cd9d0a7044434e3e9b65e9e8b.1581767384.git.jan.kiszka@web.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 15 Feb 2020 19:10:57 +0530
Message-ID: <CAAhSdy0LQ7ov0Gm0ATxrmJuyKpjjn5e9iAxMPJLCVXA9Pdduqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] riscv: Add support for mem=
To:     Jan Kiszka <jan.kiszka@web.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 5:20 PM Jan Kiszka <jan.kiszka@web.de> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This sets a memory limit provided via mem= on the command line,
> analogously to many other architectures.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/riscv/mm/init.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 965a8cf4829c..aec39a56d6cf 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -118,6 +118,23 @@ static void __init setup_initrd(void)
>  }
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> +static phys_addr_t memory_limit = PHYS_ADDR_MAX;
> +
> +/*
> + * Limit the memory size that was specified via FDT.
> + */
> +static int __init early_mem(char *p)
> +{
> +       if (!p)
> +               return 1;
> +
> +       memory_limit = memparse(p, &p) & PAGE_MASK;
> +       pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
> +
> +       return 0;
> +}
> +early_param("mem", early_mem);
> +
>  static phys_addr_t dtb_early_pa __initdata;
>
>  void __init setup_bootmem(void)
> @@ -127,6 +144,8 @@ void __init setup_bootmem(void)
>         phys_addr_t vmlinux_end = __pa_symbol(&_end);
>         phys_addr_t vmlinux_start = __pa_symbol(&_start);
>
> +       memblock_enforce_memory_limit(memory_limit);
> +
>         /* Find the memory region containing the kernel */
>         for_each_memblock(memory, reg) {
>                 phys_addr_t end = reg->base + reg->size;
> --
> 2.16.4
>
>

This is a good addition for Linux RISC-V.

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
