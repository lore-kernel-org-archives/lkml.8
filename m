Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC239C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A824206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OkUxzICY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgFAIP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFAIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:15:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A830C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:15:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c14so7227427qka.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sk/qZ0PCKuKPpHB9HjPSmK4jmV57qb64kZf7c48kCF0=;
        b=OkUxzICYBcJ/T23uVyaiKrQRWk4oQTuGUExzoH9tTvqqLd0WJYCUcoC+rEJ5TNqtcr
         W3L5Vtj+3omzytqwnni8m1uWnj3zsYpe1gbZ6XAObufDkgRtCeV25VbM3ia2SYvculyS
         0TZPqrYBhiSe0144ZS6jiCqOJtQQgT7B7TJFwYMqlFTPNMi7ze84O3hmXePGKuyQUqtc
         f+SP+b0/mYsZn6l4tF4VCwwlgUEEc8Yz5srZhVCu8VQJv7aNVVYritdidqgQSGEIjhTS
         hfWQBK3AVgEGmNLNk6wyEla/z/nZ/0I1Z8VnzEOUHxOZRWWyqvgAFtSO/Cd/E5O4B35C
         hfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sk/qZ0PCKuKPpHB9HjPSmK4jmV57qb64kZf7c48kCF0=;
        b=fKPTCHLB2lHiEQx0srCFo7tZVvpNpl/76Kj17UHmexNqgzLucEvR7ee/icXtdCwC/A
         Af1epLUnZ/s2wOPVmAnwW/japAXTqjPb7A9OD2I++nPIqNcP1pOkxy/j50F3BJIjA1+x
         baBbAjoNmXR7I2KywKVDYB4IsfdzVBawgkWzM/2VMlSJ/iq/Cu//qJLt415CaGMfKevk
         oNWitHI8z+O8u44sOwyhaN0DfMEU494pUa2t6VsTdKARxqOvDsHoAra9nRz88zqTGGBj
         4ovKzeCQLpyc1dLMrExwLtKpERl+eHuiVuBbiFyQybtBnz19F7puNYZ/OacmF9kkTsTC
         Ndgg==
X-Gm-Message-State: AOAM532quvLTb1Fg3nzntDz2ca0qBDJxep80k6DKyuj8T0snGwM2e0EC
        oUMB6Z6iUW/VFtqMrOz6HbC06mFniNhipcV3tCua6A==
X-Google-Smtp-Source: ABdhPJwAZIYguqwZTxoHINg27uUeFDW9ssNvRHKAZfR70FyR5LAn3osu3KVqu7LBFqe+vVsr5skBCE0r7JFHOmVIU50=
X-Received: by 2002:a37:9bd7:: with SMTP id d206mr19591161qke.113.1590999326270;
 Mon, 01 Jun 2020 01:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <fe966314eae51a5089033f7186ac86c39719e0a0.1590474856.git.greentime.hu@sifive.com>
 <CAJF2gTTnLNmNUvDwRSsmD9auaOGuqYXjuucKSyXZQKoEWEq4Ow@mail.gmail.com>
In-Reply-To: <CAJF2gTTnLNmNUvDwRSsmD9auaOGuqYXjuucKSyXZQKoEWEq4Ow@mail.gmail.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 1 Jun 2020 16:15:14 +0800
Message-ID: <CAHCEeh+d+ya6+Xrh8hdWVSGo2kk_rZ8PV2eMM-2LLaOojAaBtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 05/13] riscv: Add new csr defines related to vector extension
To:     Guo Ren <guoren@kernel.org>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guo Ren <guoren@kernel.org> =E6=96=BC 2020=E5=B9=B45=E6=9C=8831=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Greentime,
>
> Why remove vxrm and xstat ?
>
> > Appendix B: Calling Convention
> > In the RISC-V psABI, the vector registers v0-v31 are all caller-saved. =
The vstart, vl, and vtype CSRs are also caller-saved.
> > The vxrm and vxsat fields have thread storage duration.
>
Hi Guo,

https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc#vector-contro=
l-and-status-register-vcsr
"The vxrm and vxsat separate CSRs can also be accessed via fields in
the vector control and status CSR, vcsr."

Since vcsr will save all these information, I think it should be ok to
save vcsr only.

> As spec 0.9 mentioned above, vxrm and vxsat are thread storage duration.
>
> When timer 's interrupt coming, we still need to save them in context_swi=
tch.
>
> On Tue, May 26, 2020 at 3:03 PM Greentime Hu <greentime.hu@sifive.com> wr=
ote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Follow the riscv vector spec to add new csr number.
> >
> > [greentime.hu@sifive.com: update the defined value based on new spec an=
d
> > remove unused ones]
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/include/asm/csr.h | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 8e18d2c64399..cc13626c4bbe 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -24,6 +24,12 @@
> >  #define SR_FS_CLEAN    _AC(0x00004000, UL)
> >  #define SR_FS_DIRTY    _AC(0x00006000, UL)
> >
> > +#define SR_VS           _AC(0x00000600, UL) /* Vector Status */
> > +#define SR_VS_OFF       _AC(0x00000000, UL)
> > +#define SR_VS_INITIAL   _AC(0x00000200, UL)
> > +#define SR_VS_CLEAN     _AC(0x00000400, UL)
> > +#define SR_VS_DIRTY     _AC(0x00000600, UL)
> > +
> >  #define SR_XS          _AC(0x00018000, UL) /* Extension Status */
> >  #define SR_XS_OFF      _AC(0x00000000, UL)
> >  #define SR_XS_INITIAL  _AC(0x00008000, UL)
> > @@ -31,9 +37,9 @@
> >  #define SR_XS_DIRTY    _AC(0x00018000, UL)
> >
> >  #ifndef CONFIG_64BIT
> > -#define SR_SD          _AC(0x80000000, UL) /* FS/XS dirty */
> > +#define SR_SD          _AC(0x80000000, UL) /* FS/VS/XS dirty */
> >  #else
> > -#define SR_SD          _AC(0x8000000000000000, UL) /* FS/XS dirty */
> > +#define SR_SD          _AC(0x8000000000000000, UL) /* FS/VS/XS dirty *=
/
> >  #endif
> >
> >  /* SATP flags */
> > @@ -114,6 +120,12 @@
> >  #define CSR_PMPADDR0           0x3b0
> >  #define CSR_MHARTID            0xf14
> >
> > +#define CSR_VSTART             0x8
> > +#define CSR_VCSR               0xf
> > +#define CSR_VL                 0xc20
> > +#define CSR_VTYPE              0xc21
> > +#define CSR_VLENB              0xc22
> > +
> >  #ifdef CONFIG_RISCV_M_MODE
> >  # define CSR_STATUS    CSR_MSTATUS
> >  # define CSR_IE                CSR_MIE
> > --
> > 2.26.2
> >
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
