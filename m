Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D57F208C7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593243297;
	bh=Itmuk4QOyPwIKwsALdhVa2cCBtOvlPtICWP8yExdrkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0sDWMpau4j4dd2oeYfiiKBuUZDhixV2IbmUTkGY7w2C5xpFbkTGqq7uwNwLOpI/BZ
	 fj8XHkyf3rRcvM3XNkVtyOgBiV9RdZHdqDF6Wq9ouL3rAUjngK4wOkfgaWI//NvOrv
	 9rm7g1CGHC3SUe9yfHNH2mwbezIGCOpmwz8DGfJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgF0Hez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0Hez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:34:55 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56A9208C7;
        Sat, 27 Jun 2020 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593243294;
        bh=Itmuk4QOyPwIKwsALdhVa2cCBtOvlPtICWP8yExdrkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ytezSzQykMahou3pqLknMYHGq+8/x5+uhogNAXuiNCmvKi+ZCWECBx4qXvEXFr6Mx
         z8PnK82Z+4iYXLLovPvGmQvxQe541i2I74VThkMfoyx5fVus9V3LCSg05Yv2Lv0rk1
         tAHHSyaG/18Tsv2tnlQ32CghSrWn3xV1pzFN2yAs=
Received: by mail-ot1-f45.google.com with SMTP id 5so8758778oty.11;
        Sat, 27 Jun 2020 00:34:54 -0700 (PDT)
X-Gm-Message-State: AOAM530m4f2yXk4MmQl8DbNzkmPgbn3Kt6lc0Zo6bEDX75Nfo2ZTmF6K
        9DRzG6SiV9pUNrYJ1fYqN/MpPn/fnVv5ggHL+nQ=
X-Google-Smtp-Source: ABdhPJxo4GBgpI3CfYGRDTcSeYC19Y/AaYwBMPAP0EKLufVSK5++jOx6RFOZghHqIsVnypd++ND2Rq+oIwGgJMhTXEw=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr5423029oth.90.1593243294044;
 Sat, 27 Jun 2020 00:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200618064307.32739-1-hch@lst.de> <20200618064307.32739-3-hch@lst.de>
In-Reply-To: <20200618064307.32739-3-hch@lst.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 27 Jun 2020 09:34:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH985Aqma47yf96N45CYkTGePVpvihrc_TmOAp2f0vN-g@mail.gmail.com>
Message-ID: <CAMj1kXH985Aqma47yf96N45CYkTGePVpvihrc_TmOAp2f0vN-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hyperv@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        X86 ML <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Jessica Yu <jeyu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 at 08:44, Christoph Hellwig <hch@lst.de> wrote:
>
> Use PAGE_KERNEL_ROX directly instead of allocating RWX and setting the
> page read-only just after the allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index d1c95dcf1d7833..cbe49cd117cfec 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -120,15 +120,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>
>  void *alloc_insn_page(void)
>  {
> -       void *page;
> -
> -       page = vmalloc_exec(PAGE_SIZE);
> -       if (page) {
> -               set_memory_ro((unsigned long)page, 1);
> -               set_vm_flush_reset_perms(page);
> -       }
> -
> -       return page;
> +       return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> +                       GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> +                       NUMA_NO_NODE, __func__);

Why is this passing a string for the 'caller' argument, and not the
address of the caller?


>  }
>
>  /* arm kprobe: install breakpoint in text */
> --
> 2.26.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
