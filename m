Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A137207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 01:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590890200;
	bh=aV7Yv2k4mvodEUB9KbV6pGSLhLcWgkbn0lTY/BBREVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kd2hyYTy/Xw/9MeSsBs8wn2fNj+v+pgZ3mAzeyFcxozEhhWWKFU2x5xX7hoL4UEpx
	 bxNz2LAf8ZdokrDROTcPiPfUdZW0robOzul9HXGtMs+YkDScQShnxpbXkFeI/mpuEE
	 xVXJ3y0BF9FcMDpXhuaR/kwVqJ5RdriPafVEDB+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgEaB4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 21:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbgEaB4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 21:56:39 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D96B120801
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590890198;
        bh=aV7Yv2k4mvodEUB9KbV6pGSLhLcWgkbn0lTY/BBREVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zjkQad076gevko7EXf7J/BHhctHOSkrzb1I5EtvWrEIi+qLxpO4iF5ouDE+/HROLh
         QePnLWoyADhuFORb4RhxmsrL/bTV7eph1Bd/315DvGfSNTxTznZ2/N0RxXr8PzzNLO
         APxvUPK/iiIXng6H5N/U8vk5sG7corvWzB7AFnFc=
Received: by mail-lf1-f49.google.com with SMTP id h188so1913001lfd.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 18:56:37 -0700 (PDT)
X-Gm-Message-State: AOAM532j/81c35QD+S+UjCYd8PWW+m8E6S9ZaBVFw4iElIOJdKqsDOkX
        CJqttPPB3c9cfc7TCRcSwc2sdxhIDjSdXimCczU=
X-Google-Smtp-Source: ABdhPJwHNdagqFyLRCjUuwXRrjjZ5K9b6OQEZPVGRzzRKra0hLRV9+eJ+7l8PkMtyn2Csl/7CaUuJ4aI9bOztFfghjA=
X-Received: by 2002:a05:6512:3291:: with SMTP id p17mr7856343lfe.41.1590890196106;
 Sat, 30 May 2020 18:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 31 May 2020 09:56:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTnLNmNUvDwRSsmD9auaOGuqYXjuucKSyXZQKoEWEq4Ow@mail.gmail.com>
Message-ID: <CAJF2gTTnLNmNUvDwRSsmD9auaOGuqYXjuucKSyXZQKoEWEq4Ow@mail.gmail.com>
Subject: Re: [RFC PATCH v4 05/13] riscv: Add new csr defines related to vector extension
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        palmerdabbelt@google.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greentime,

Why remove vxrm and xstat ?

> Appendix B: Calling Convention
> In the RISC-V psABI, the vector registers v0-v31 are all caller-saved. The vstart, vl, and vtype CSRs are also caller-saved.
> The vxrm and vxsat fields have thread storage duration.

As spec 0.9 mentioned above, vxrm and vxsat are thread storage duration.

When timer 's interrupt coming, we still need to save them in context_switch.

On Tue, May 26, 2020 at 3:03 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Follow the riscv vector spec to add new csr number.
>
> [greentime.hu@sifive.com: update the defined value based on new spec and
> remove unused ones]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 8e18d2c64399..cc13626c4bbe 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -24,6 +24,12 @@
>  #define SR_FS_CLEAN    _AC(0x00004000, UL)
>  #define SR_FS_DIRTY    _AC(0x00006000, UL)
>
> +#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
> +#define SR_VS_OFF       _AC(0x00000000, UL)
> +#define SR_VS_INITIAL   _AC(0x00000200, UL)
> +#define SR_VS_CLEAN     _AC(0x00000400, UL)
> +#define SR_VS_DIRTY     _AC(0x00000600, UL)
> +
>  #define SR_XS          _AC(0x00018000, UL) /* Extension Status */
>  #define SR_XS_OFF      _AC(0x00000000, UL)
>  #define SR_XS_INITIAL  _AC(0x00008000, UL)
> @@ -31,9 +37,9 @@
>  #define SR_XS_DIRTY    _AC(0x00018000, UL)
>
>  #ifndef CONFIG_64BIT
> -#define SR_SD          _AC(0x80000000, UL) /* FS/XS dirty */
> +#define SR_SD          _AC(0x80000000, UL) /* FS/VS/XS dirty */
>  #else
> -#define SR_SD          _AC(0x8000000000000000, UL) /* FS/XS dirty */
> +#define SR_SD          _AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
>  #endif
>
>  /* SATP flags */
> @@ -114,6 +120,12 @@
>  #define CSR_PMPADDR0           0x3b0
>  #define CSR_MHARTID            0xf14
>
> +#define CSR_VSTART             0x8
> +#define CSR_VCSR               0xf
> +#define CSR_VL                 0xc20
> +#define CSR_VTYPE              0xc21
> +#define CSR_VLENB              0xc22
> +
>  #ifdef CONFIG_RISCV_M_MODE
>  # define CSR_STATUS    CSR_MSTATUS
>  # define CSR_IE                CSR_MIE
> --
> 2.26.2
>
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
