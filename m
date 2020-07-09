Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739DAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537D520663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFYPCKMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIGWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgGIGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:22:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D47C061A0B;
        Wed,  8 Jul 2020 23:22:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so610014wmi.3;
        Wed, 08 Jul 2020 23:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gFF6cRXPZWxd7Qpi0omO8g63vjK0Tifq+qnvPaoGQN4=;
        b=EFYPCKMh/gdOpn8FHMjdfuEIXN6C/VRooCUlnoWy59ORywMooLDtxp+BS7BoIgt0G1
         jmrm8e7JcbBuj9cZR3MvdgZ/nonjZvh7ddEjA+S3wAUi26hnRbCuN/ez9fiSlVKAUem7
         Zj9KcE3DNCGeJImAGqdqCrHddS3WRSYPSauF1ZZKRzkXUJcJb9PqZEVdSCu8GamZHjB9
         GRjHrTD5x1gTsftRjSH6nFTSc9cG3ue/tbdj4cd6RH6yMlWiZ18gsHMbqf2/EWid4yXC
         2JJS6ueLMq/w2U/VS0fjhIB22AHdpqALU1/hRFInm7PLwzxS5UczZg+/OyavlaGG9DnR
         Op8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gFF6cRXPZWxd7Qpi0omO8g63vjK0Tifq+qnvPaoGQN4=;
        b=WmTqbLVqGnATT2XyysMmxpJi6Q7eA0XoYj14kQaXFFpJcayiw9d0KFBwpk8JnyqbBP
         XInv2rPGOV+Ccd0tj7tw+S2UO6k7ByYBbAqy3FPRkmIADPanN/P+cdtMIvSfbezXUR3/
         R75seEYeZTUj4QrhnORbHI6NgU1Oj7b25/y31kEGBnQa4NGohDebOt3Kbr0MQC7whlMt
         O8JDtdLS8w9BfMZ/t+rwGoXIPzjsNgugagZshkdC+G9LSUyEr5jhiuFLJXJ9aMMZhzug
         8Ly3/JWP5ditjLrj3qMv0UaGxGj8UIm5Cr4KgtRG5U6/8hl3Jo0Hgl2Wuna8j64dSsIV
         zS5w==
X-Gm-Message-State: AOAM531vsHXvLnasqlhct/ss+ZSk6QdTgz6EAz7M9GwKwoUopG0w1YA9
        BFa2CZdvjj+thdzN/KNA2oXFyOIrnkb4fv3K/+8=
X-Google-Smtp-Source: ABdhPJw/PQAQz5vRvxXyLsZvKJpX4qH/jBi9iuTgfDOZNLsLiG9CWKsZ0zqUihapgZiMYjxfURhGOGLuZm/C0OD0nwQ=
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr13313090wmb.56.1594275734854;
 Wed, 08 Jul 2020 23:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200708210948.34197-1-kernel@esmil.dk>
In-Reply-To: <20200708210948.34197-1-kernel@esmil.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 9 Jul 2020 08:22:03 +0200
Message-ID: <CAJ+HfNj+dFE70O49-wZC1ckGSVo8Fb4_UcaeZocQABfKkyHmSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: Support R_RISCV_ADD64 and R_RISCV_SUB64 relocs
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 23:10, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> These are needed for the __jump_table in modules using
> static keys/jump-labels with the layout from
> HAVE_ARCH_JUMP_LABEL_RELATIVE on 64bit kernels.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>

> ---
>
> Tested on the HiFive Unleashed board.
>
> This patch is new in v2. It fixes an error loading modules
> containing static keys found by Bj=C3=B6rn T=C3=B6pel.
>
>  arch/riscv/kernel/module.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 7191342c54da..104fba889cf7 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -263,6 +263,13 @@ static int apply_r_riscv_add32_rela(struct module *m=
e, u32 *location,
>         return 0;
>  }
>
> +static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
> +                                   Elf_Addr v)
> +{
> +       *(u64 *)location +=3D (u64)v;
> +       return 0;
> +}
> +
>  static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
>                                     Elf_Addr v)
>  {
> @@ -270,6 +277,13 @@ static int apply_r_riscv_sub32_rela(struct module *m=
e, u32 *location,
>         return 0;
>  }
>
> +static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
> +                                   Elf_Addr v)
> +{
> +       *(u64 *)location -=3D (u64)v;
> +       return 0;
> +}
> +
>  static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
>                                 Elf_Addr v) =3D {
>         [R_RISCV_32]                    =3D apply_r_riscv_32_rela,
> @@ -290,7 +304,9 @@ static int (*reloc_handlers_rela[]) (struct module *m=
e, u32 *location,
>         [R_RISCV_RELAX]                 =3D apply_r_riscv_relax_rela,
>         [R_RISCV_ALIGN]                 =3D apply_r_riscv_align_rela,
>         [R_RISCV_ADD32]                 =3D apply_r_riscv_add32_rela,
> +       [R_RISCV_ADD64]                 =3D apply_r_riscv_add64_rela,
>         [R_RISCV_SUB32]                 =3D apply_r_riscv_sub32_rela,
> +       [R_RISCV_SUB64]                 =3D apply_r_riscv_sub64_rela,
>  };
>
>  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> --
> 2.27.0
>
