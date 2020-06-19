Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24225C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0877F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbgFSMIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:08:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732846AbgFSMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:07:56 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M42X0-1jmFoJ0ZMW-0000dz for <linux-kernel@vger.kernel.org>; Fri, 19 Jun
 2020 14:07:55 +0200
Received: by mail-qk1-f182.google.com with SMTP id l6so4994837qkc.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 05:07:54 -0700 (PDT)
X-Gm-Message-State: AOAM530pBj1ogtWhUJ8NvpUDVlYoy/wAG9SiK69sS/P9sPq9ibHPS60+
        jZE6nyWoAMPD5UJ/BXAUP8fCB9ZdmXVOp+2Vhs8=
X-Google-Smtp-Source: ABdhPJwHx2uaIMhEGlEMDgOdw7u23u0WTOydTXFPEmc56fSEQqUwklU3gb9vWno9ShiFPoxSOoPySMVl5vIdoNyR1Y8=
X-Received: by 2002:a37:8384:: with SMTP id f126mr565913qkd.471.1592568473970;
 Fri, 19 Jun 2020 05:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200616135617.2937252-1-mpe@ellerman.id.au> <20200616135617.2937252-2-mpe@ellerman.id.au>
In-Reply-To: <20200616135617.2937252-2-mpe@ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Jun 2020 14:07:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0+PBCg=TJXgwbuA02841M3NgQyoxfrua0XpovFz0K98A@mail.gmail.com>
Message-ID: <CAK8P3a0+PBCg=TJXgwbuA02841M3NgQyoxfrua0XpovFz0K98A@mail.gmail.com>
Subject: Re: [PATCH 2/2] powerpc/syscalls: Split SPU-ness out of ABI
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, linux-arch@ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dIBrSAJOVcOL94yEVVbdoWD3jDqP5SE46s19szXCxkab1rTnSWI
 KH0w3Yrfnp7t5EmZ9oT2MQKNZ74S5It0aYazarD5VqJU7sWF/GKsIJn6zOGkAqp3QU+ePSr
 +YeWHnRcOaG6J4WtinxTuxnkfeuQGV9yHQXJ2dsObRFmWOlwqVc+oBlizjgN3eMho1HCyyY
 qNIT7+tZ3cI8Ig88BF+Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f/KtunD0xBQ=:ZiBFEvp982Wu0recaFb2wb
 S83RgdTK30UPS0IEGsYmpJSme7ehCMeZix6rNNeRfATpR/cNjO7ETHOW3WOA+O3IVKduAQuur
 n3uZXUW+UYhZgxB+wtCzWR+HE/Ydm7T/iOB4Mk0Yf4KlROibKRYF0JK1rcZGSoSK8aPj4UaPh
 9eN/grYTBWcZObYjdwIJTdnxSyNL+n8ECnw3RKDWXeVKksBd5yeXHtIG6Lo59YSGAEuqd9c1J
 8Tmorf1AxVZh2TFuibf8dySjccOyBb9T9g1sphXAK92uzSJcUCmSdygTM+k/+g6W8r0O06QQJ
 kV80G53e4Zanfj1febLI578ud3U0Q/GwRUCopkXhsTtZ1Q6AElBUDxvH6L7ZHqnaybGZHkaqG
 SCPoxzOqucwHrXN11NAMVwfELE2F1+wWgPk53Gq6zEOV0MXcffUN+nY5tZxlhsnH8Cl2vxITu
 kVh/wadLbTEbumejuj111kLmnrxFIa3KnOsEJkAVFDLnYEvGmFaQd2UuTGz9m/M4bFdQYciQS
 jfXl2WrPqU1HYthaCWeO2Vfc8vjVTcgmy2wxJnrflw2aJYa3SDGXgb5oFXn1Pwu1panWl3fIS
 XytNw7iBVHEo/1GSE581Aohe9MKeZBn6Etyqt0oA+J9b+xc3A6jjSMvjHITcBFtEkoVDnEL4O
 MDiCMn73ElgnCTiqyU83Ohf/tBadII0+Y0qfw6xuAwG8/oxU/Gp49lt+4JA60v9eSOxWV6bra
 j6kSaXyfg80/vOKgVyDPdf/1oY1pWqwSdUl7Gk24QvpVWiWXC6Cwf/sw22vRatRuixtf7Kdxn
 U5OL/5zQz5xf2iXXa0YuhCKPA2qADcKxJ3UwPahkTSqVQ2P8KA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 3:56 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Using the ABI field to encode whether a syscall is usable by SPU
> programs or not is a bit of kludge.
>
> The ABI of the syscall doesn't change depending on the SPU-ness, but
> in order to make the syscall generation work we have to pretend that
> it does.

The idea of the ABI field is not to identify which ABI a syscall follows
but which ABIs do or do not implement it. This is the same with e.g.
the x32 ABI on x86.

> It also means we have more duplicated syscall lines than we need to,
> and the SPU logic is not well contained, instead all of the syscall
> generation targets need to know if they are spu or nospu.
>
> So instead add a separate file which contains the information on which
> syscalls are available for SPU programs. It's just a list of syscall
> numbers with a single "spu" field. If the field has the value "spu"
> then the syscall is available to SPU programs, any other value or no
> entry entirely means the syscall is not available to SPU programs.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I have a patch series originally from Firoz that was never quite finished
to unify the scripts across all architectures. I think making the format of
the table format more powerpc specific like you do here takes it a step
backwards and makes it harder to do that eventually.

>  4 files changed, 523 insertions(+), 128 deletions(-)
>  create mode 100644 arch/powerpc/kernel/syscalls/spu.tbl
>
>
> I'm inclined to put this in next and ask Linus to pull it before rc2, that seems
> like the least disruptive way to get this in, unless anyone objects?

I still hope we can get a better solution.

> diff --git a/arch/powerpc/kernel/syscalls/spu.tbl b/arch/powerpc/kernel/syscalls/spu.tbl
> new file mode 100644
> index 000000000000..5eac04919303
> --- /dev/null
> +++ b/arch/powerpc/kernel/syscalls/spu.tbl
> @@ -0,0 +1,430 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# The format is:
> +# <number> <name> <spu>
> +#
> +# To indicate a syscall can be used by SPU programs use "spu" for the spu column.
> +#
> +# Syscalls that are not to be used by SPU programs can be left out of the file
> +# entirely, or an entry with a value other than "spu" can be added.
> +0      restart_syscall                 -
> +1      exit                            -
> +2      fork                            -
> +3      read                            spu
> +4      write                           spu
> +5      open                            spu

Having a new table format here also makes it harder for others to add
a new system call, both because it doesn't follow the syscall*.tbl naming
and because one has to first understand what the format is.

If you absolutely want to split it out, could you at least make the format
compatible with the existing scripts and avoid the change to
the syscalltbl.sh file?

       Arnd
