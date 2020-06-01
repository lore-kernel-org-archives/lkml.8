Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F152C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFBD2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591002243;
	bh=mZoOdPkZk2DZjNiEBBJ1O/bqy4RJwqz6WBO326FTpN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yine9llSuucxbluqTq9tOc7hrcV2HR8OMo16SNS3lXHZbgW0ytdulUBghermYToFM
	 2Vm27dgQVXO8/kUhW0ctPVUyFyUJuxaD7p7vy1tV3/Agp0aMy11nGwZ4GAEeFjzgmV
	 05jLxUBfShrPJ6UKUHbngbJ/OAYJ4jCzhp8qTVmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgFAJEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFAJEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:04:01 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1119207BC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591002241;
        bh=mZoOdPkZk2DZjNiEBBJ1O/bqy4RJwqz6WBO326FTpN0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c/A//E/GZwmxIqOef2zlDY1PpPmDdHCTn5AEv++fYHII4Xbt6VkUIa17/aqcwnit4
         4QHmj65XbmnGbnq4WJpwtpCT9HYHrLFZZumv1Eci0qByvQ55FG3Csjh1DI8xPx9vj1
         4EphXhKKwOqMlmnLyqmoUrX2dANJa58mSemBEFmw=
Received: by mail-lj1-f171.google.com with SMTP id z18so7128606lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:04:00 -0700 (PDT)
X-Gm-Message-State: AOAM533j8dkXfs8b4jdyBRSlf3J0rYbYGLQL1uxXq2xH1+vjp+EBKdLs
        12E+QqMID+LofmoaTp1pfeSKTOl3nezR9ttETso=
X-Google-Smtp-Source: ABdhPJxH0heF7O0h7klVCXpBPsCHEbZ7tp+mLB6EAx9L0OfYC3vopYfjOHTZky7cAvnqnlkafk0AyihHiaUpokploJ4=
X-Received: by 2002:a2e:a0cc:: with SMTP id f12mr5807926ljm.250.1591002238945;
 Mon, 01 Jun 2020 02:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 17:03:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ=S+tbxVOoL3w3DjQ1H0UP6L7F++i-OAcaeY+QNmd=mw@mail.gmail.com>
Message-ID: <CAJF2gTQ=S+tbxVOoL3w3DjQ1H0UP6L7F++i-OAcaeY+QNmd=mw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 05/13] riscv: Add new csr defines related to vector extension
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
