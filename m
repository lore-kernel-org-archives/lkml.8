Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB365C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90122074A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ETKHiK8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGYFMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGYFMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BFBC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:12:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t10so309573plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DrFSqlp6N5hVS2J5LBpv5q3jiLHrhXO1dKkZQLcwDsA=;
        b=ETKHiK8nr+iV+B62aVfQqRgoTi6y+8Nsvrymauknp+n3HnLTwS+VKgHGHraHbeVx4m
         0rWCXMn0/E+pyv74rE29/PmaGadbtm1+iCgkOFxW/rfdg5SBLA1Q9yUjg1VbL42DDvtD
         H07m44nsy9AmpsOQpHrPMlzNxEUizgdmfjGZK3xKPa70ompTgOhdpNSFywA00iHdt6gN
         FK9QYJ5Rtg+5drnkPizzhIVsPJDXLoUrGee01RRmz5+kKMJCB5n/sWsvCb0XmOpU7iME
         ACosYF00v1HkwxsZYCaztK5QbANtyoXntqGZg/4COPjOkzMBo0ecF45fubJaq2+gFECi
         DydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DrFSqlp6N5hVS2J5LBpv5q3jiLHrhXO1dKkZQLcwDsA=;
        b=dHIYpG8kiLiimpdKDgCYOU+wyfwGPvKG/Auzhgh7rrgxVz5IZGFZz2K38Zd9w0Fdr+
         aBztLHBKklsbtqobPxAb9XULy+0a+eN4oMAi2R4N14rytYHOUojF3G0mLcF3Y7YnotIF
         6ykIcgA9fb7OZBVJtfI4FFT5FXWmpFAjy5yhwhCclou0qqTi2gl7Saem1V0okaBKkhZx
         9MRn8crWb2ix9r042dw66n9EjWhm0Adu/YH9oXeutSnPKmZTeKgBJwol3BNONz+OBVid
         d8tpvSKP9RHikzj+AYoMJOd0ThTAx22G//J+v/SzcgvLry7HEcoXh2zyrJO8DsXddlMT
         xNlQ==
X-Gm-Message-State: AOAM532L79tnuWWJhfwCj2Adz+gcKvBMXef77Dc30Vfls5MOxvs6Ib5B
        kcHi8OaS4fa/oSSR3URXssnT4SOgYKI=
X-Google-Smtp-Source: ABdhPJyXmUxeH1ONAeqCmQMGdvJCGS+jcxFlXcVe7yZ/XLfUb+q1nuecmx1rA+GGh534a1pzJFs5Sw==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr9091398pju.159.1595653963045;
        Fri, 24 Jul 2020 22:12:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z2sm7972048pfq.67.2020.07.24.22.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 22:12:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 22:12:42 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Jul 2020 22:08:22 PDT (-0700)
Subject:     Re: [PATCH 4/4] riscv: Parse all memory blocks to remove unusable memory
In-Reply-To: <20200715233009.27183-5-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, sudeep.holla@arm.com,
        vincent.chen@sifive.com, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-ab4785af-26a2-4494-81f7-b0c206711515@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:30:09 PDT (-0700), Atish Patra wrote:
> Currently, maximum physical memory allowed is equal to -PAGE_OFFSET.
> That's why we remove any memory blocks spanning beyond that size. However,
> it is done only for memblock containing linux kernel which will not work
> if there are multiple memblocks.
>
> Process all memory blocks to figure out how much memory needs to be removed
> and remove at the end instead of updating the memblock list in place.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f818a47a72d1..79e9d55bdf1a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -147,26 +147,29 @@ void __init setup_bootmem(void)
>  {
>  	struct memblock_region *reg;
>  	phys_addr_t mem_size = 0;
> +	phys_addr_t total_mem = 0;
> +	phys_addr_t mem_start, end = 0;
>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>  	phys_addr_t vmlinux_start = __pa_symbol(&_start);
>
>  	/* Find the memory region containing the kernel */
>  	for_each_memblock(memory, reg) {
> -		phys_addr_t end = reg->base + reg->size;
> -
> -		if (reg->base <= vmlinux_start && vmlinux_end <= end) {
> -			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> -
> -			/*
> -			 * Remove memblock from the end of usable area to the
> -			 * end of region
> -			 */
> -			if (reg->base + mem_size < end)
> -				memblock_remove(reg->base + mem_size,
> -						end - reg->base - mem_size);
> -		}
> +		end = reg->base + reg->size;
> +		if (!total_mem)
> +			mem_start = reg->base;
> +		if (reg->base <= vmlinux_start && vmlinux_end <= end)
> +			BUG_ON(reg->size == 0);
> +		total_mem = total_mem + reg->size;
>  	}
> -	BUG_ON(mem_size == 0);
> +
> +	/*
> +	 * Remove memblock from the end of usable area to the
> +	 * end of region
> +	 */
> +	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
> +	if (mem_start + mem_size < end)
> +		memblock_remove(mem_start + mem_size,
> +				end - mem_start - mem_size);
>
>  	/* Reserve from the start of the kernel to the end of the kernel */
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);

Thanks, this one is also on fixes.
