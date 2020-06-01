Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD50C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81134207D0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591002841;
	bh=x7c+S0R2buWnKrtRNJziq9FOv/13giWgGdxyEHxAFdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kcpCJxFk+vc+t/p7MTZJ8BoY+OqK/5+hOk0RATdvuJ5AajpbcmIVfQAFHVBLxAobV
	 BLpL++2+F09Eb307U5YOgmggtLchkRKSBbFKzC6idDJ6SiS+a4C05vb4H++yBDmxmH
	 vV1bpmCe+ddaRRoMnSFGCuHIZciDnDXcJ0VXArNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAJOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbgFAJOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:14:00 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690332074B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591002839;
        bh=x7c+S0R2buWnKrtRNJziq9FOv/13giWgGdxyEHxAFdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CL4iEJwqcN+m3tDYIC0n6yPU+A3vjClNIAaiG26YnpaUM/v60ddvDAF5oBErqDx0U
         GRFtEDDPjQ7GU1ZTX9FizTDAA+hyTklX9I0K57vRPNF22PW9AUTsMvBhJbhaT8UOXA
         dzgvCNEmoj1pN0BzVIpOR1MhDXfPLGYDWr84XcQ8=
Received: by mail-lj1-f176.google.com with SMTP id z18so7162615lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:13:59 -0700 (PDT)
X-Gm-Message-State: AOAM532fzJeA8wJ8g/mFX36WbG3WjIZeOQmA8S/QlYbbrphhjlH/6vt/
        PeiY55ksEZx8PpLounLiw6XfbX3GHlENJWObAQA=
X-Google-Smtp-Source: ABdhPJxhsOdKWEAtnlJOb15IZGLETXZ6MaQD5nPaEjaODsGv89c/S4kRUUC2nWJF1njCgh9v8Uy5Hh9o1HSWcOJoyE8=
X-Received: by 2002:a2e:611a:: with SMTP id v26mr8809271ljb.265.1591002837783;
 Mon, 01 Jun 2020 02:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <e896db91e3303f64ac401021f848e536e9d42aaa.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <e896db91e3303f64ac401021f848e536e9d42aaa.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 17:13:46 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT81u=Kk3XPvnoh-AFJn5JGRpNXZjWAKGT5T_4KzLreag@mail.gmail.com>
Message-ID: <CAJF2gTT81u=Kk3XPvnoh-AFJn5JGRpNXZjWAKGT5T_4KzLreag@mail.gmail.com>
Subject: Re: [RFC PATCH v4 07/13] riscv: Add has_vector/riscv_vsize to save
 vector features.
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it has been redesigned with new version spec, please change the
first-author :)

And add me as Co-developed.

On Tue, May 26, 2020 at 3:03 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch is used to detect vector support status of CPU and use
> riscv_vsize to save the size of all the vector registers. It assumes
> all harts has the same capabilities in SMP system.
>
> [greentime.hu@sifive.com: add support for dynamic vlen]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c8527d770c98..5a68a926da68 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -16,6 +16,10 @@ unsigned long elf_hwcap __read_mostly;
>  #ifdef CONFIG_FPU
>  bool has_fpu __read_mostly;
>  #endif
> +#ifdef CONFIG_VECTOR
> +bool has_vector __read_mostly;
> +unsigned long riscv_vsize __read_mostly;
> +#endif
>
>  void riscv_fill_hwcap(void)
>  {
> @@ -73,4 +77,11 @@ void riscv_fill_hwcap(void)
>         if (elf_hwcap & (COMPAT_HWCAP_ISA_F | COMPAT_HWCAP_ISA_D))
>                 has_fpu = true;
>  #endif
> +
> +#ifdef CONFIG_VECTOR
> +       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> +               has_vector = true;
> +               riscv_vsize = csr_read(CSR_VLENB) * 32;
> +       }
> +#endif
>  }
> --
> 2.26.2
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
