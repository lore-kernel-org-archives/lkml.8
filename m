Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB24C433FB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A789206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="fNwK/byX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGYFMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGYFMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44386C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:12:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so6551484pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Q/SEp1IUfbBlV7LP81dOutu3bytkejFynPFlKD4ZJG4=;
        b=fNwK/byX6yrilqyV2sQALIcpb63IuFOUy0tZ7WtIG0GUB7qNh4L5FssW/tFCNUTyIn
         E/lzsylfzN3ybuqdgd5r3ZyGS8LMth20sRHr5VDXMA3zF3Vn3+0kmTHRe6J7abRoiUeN
         l8aYBLb0Mtjs1M++nehKhuEt7QX+eD/825oGLykzhnVOH3Q0la6O8riJf2WOuZhEYzxp
         dUM+s2n8rjIg4yeNiXg/xDykqnsk5cgupRzGOMkjw7KMzz/EC0+ceaQ083AWsidGgqhP
         G5WpwMTbuqRg+lcpC8xkyOy9bFL5XpCHzUbvI3fcTU3wlwyhKV4eZFlTljjZjhKLNiXM
         DOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Q/SEp1IUfbBlV7LP81dOutu3bytkejFynPFlKD4ZJG4=;
        b=tzF+z/i/EEgvZ8WS1pmTcrFFQk6EohhRo/wxF0L4FBnlzKCO90pg4DXlp2YEMy4buJ
         RvGtNf6Ms9HoxVmH2IEpuZMuoKyq5jlf9AMj7dYYBtukNe29kZ3+jp5WLHN8RfNHlt4H
         PMqnw6+n/4ObQoimrAOFKncz1vHzwZ1UmBsVfnrEy8JKagTtdYlZcD67yDfxZEL74/h0
         2C32yJoodNNO7sM4w3e4mKnkylDWu1kpptVtlpfIXvuwH8Mydg2QR871qLjei1xoXVSt
         bpadZh40kBB2dlj5ONZP+mvsiskiP3QytuXvyaTkdLP+QgtovP9CPNarAd3r1a/+22BA
         /Usw==
X-Gm-Message-State: AOAM5301mRPrm15tOlPRGmVQ/5xhJLQXi4onQuXNyX81CuyJf+K3ldFE
        jrgtxvGHD+TOfY9WZE4ENfGmIkNf/nU=
X-Google-Smtp-Source: ABdhPJzcuuAwbZtUI39T6hZUASv10qjY1nNCHpdIgDnAXqB1zxrR1Ylsrjfjpx+4lPcDfY7HQhFjgQ==
X-Received: by 2002:aa7:9189:: with SMTP id x9mr11393378pfa.325.1595653960471;
        Fri, 24 Jul 2020 22:12:40 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 7sm7645777pgh.80.2020.07.24.22.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 22:12:39 -0700 (PDT)
Date:   Fri, 24 Jul 2020 22:12:39 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Jul 2020 18:57:25 PDT (-0700)
Subject:     Re: [PATCH 2/4] RISC-V: Set maximum number of mapped pages correctly
In-Reply-To: <20200715233009.27183-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, sudeep.holla@arm.com,
        vincent.chen@sifive.com, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-89ff7200-0f8c-4d3e-af79-f8fa1a9231db@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:30:07 PDT (-0700), Atish Patra wrote:
> Currently, maximum number of mapper pages are set to the pfn calculated
> from the memblock size of the memblock containing kernel. This will work
> until that memblock spans the entire memory. However, it will be set to
> a wrong value if there are multiple memblocks defined in kernel
> (e.g. with efi runtime services).
>
> Set the the maximum value to the pfn calculated from dram size.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f4adb3684f3d..8d22973bde40 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -150,9 +150,9 @@ void __init setup_bootmem(void)
>  	/* Reserve from the start of the kernel to the end of the kernel */
>  	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>
> -	set_max_mapnr(PFN_DOWN(mem_size));
>  	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
>  	max_low_pfn = max_pfn;
> +	set_max_mapnr(max_low_pfn);
>
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	setup_initrd();

This one I'm putting on fixes, as there's nothing preventing us from having
multiple memory regions in a current boot and this seems very safe.
