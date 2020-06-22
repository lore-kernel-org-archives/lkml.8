Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C670FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986C520738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c0k1NtG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgFVSP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgFVSP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:15:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B03EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:15:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so8547110pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9K4yuS9GzXVwpGfNy/7h0Iyt2LnJ7F/lC1aAY0PM1GY=;
        b=c0k1NtG8F1EfdXbUPxnygA9bEYRakdc6II6HuX4PavsA2/j92Up8zPCLKJRiuznM1m
         b4u3tZknhb27hGXZhGN3gnnGc1oT+Z7aZeXQVApEqzkXlig0YsTQ4POgo27UqkGlAeWg
         fx7suxzVdaTh0rLT9hTzjzL/CiWecT+CzZmpzmrKk711qUpIzlQQ/PeanghbZC4u4XyA
         neh6nO0Ro1TPvWhK4rLTiGbEWKWsJO3nkxCmgrrLXtU0uYOolQJeCCObvtsvNA4qf/CL
         bGm8Lo2SJy3Zicu6nZ9whutm3MV0tvrPpv8hS8nwTEVjZJ+WLarpsIwXRgYPvv6ZJrRb
         L9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9K4yuS9GzXVwpGfNy/7h0Iyt2LnJ7F/lC1aAY0PM1GY=;
        b=eIeOU09fNySUC4ZMzDEQsmokEEAUjPd8CN8w4J18+HXYIoVeYBNIph+sXTSj3Z3sOR
         2f28mrGRoLNovuknOPbxW662ehdUlXdTZdBfuUAuUaOL9Vp31W2rfdrusMWLCd1A0c4N
         1rXZugxErjZvVYr3MGKHOFZ+yYUuwuULVPMOQp/EtSUCyANuE31prsSuuZu71CLQcE2K
         NI17TvWcKDvbHsBkmsV2tuZnrUTyW9nNj6vJqO2QGWweLvm2C0hW7ZibSU61hljEQ6YB
         ZyDWep3EPdjRphHal53zlv+YX+iuhw8TxCoVO8UIFQ+lx67nWHg1yBveePWQKCnvHZrn
         Ct0Q==
X-Gm-Message-State: AOAM533V8tmySG4psK00rhWYeeJIvXeyfzuUo0J1oYCXKfCBiPuhN7P9
        EcdxVfLICJFuX7JQRu5KiwaNOYlr8fr41rK7WuI3tA==
X-Google-Smtp-Source: ABdhPJwKYwuC7JTdEz6+2aO9SEAL1vuYAN9MDuzRzBtz9+wXCvIYt6D6dzYv79l/9XEbiNBNxmL+Tjlt7EOojraqnfE=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr21820346pfu.169.1592849756434;
 Mon, 22 Jun 2020 11:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200619174127.22304-3-bp@alien8.de> <202006210328.6YokxLP3%lkp@intel.com>
 <20200622170446.GG32200@zn.tnic>
In-Reply-To: <20200622170446.GG32200@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Jun 2020 11:15:44 -0700
Message-ID: <CAKwvOd=PMNx+AYg8wxr5pQC3_RHBQzwpELptHuYx_GLosOvoeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        X86 ML <x86@kernel.org>, kbuild-all@lists.01.org,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:04 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Jun 21, 2020 at 03:55:00AM +0800, kernel test robot wrote:
> > Hi Borislav,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on kselftest/next]
> > [also build test ERROR on tip/auto-latest linus/master v5.8-rc1 next-20=
200618]
> > [cannot apply to tip/x86/core]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use  as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Borislav-Petkov/x86-FP=
U-FPU-sanitization-for-in-kernel-use/20200620-014453
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kse=
lftest.git next
> > config: x86_64-allmodconfig (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 48=
7ca07fcc75d52755c9fe2ee05bcb3b6eeeec44)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Dx86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> ERROR: modpost: "__gtdf2" [lib/test_fpu.ko] undefined!
> > >> ERROR: modpost: "__divdf3" [lib/test_fpu.ko] undefined!
> > >> ERROR: modpost: "__muldf3" [lib/test_fpu.ko] undefined!
> > >> ERROR: modpost: "__adddf3" [lib/test_fpu.ko] undefined!
>
> Hmm, the point here is to actually have SSE* code in a kernel module for
> testing. And gcc does the right thing, see below.
>
> LLVM folks, how can I make llvm not call those library functions and
> actually spit out SSE* code?
>
> Full build command is:
>
>   /mnt/smr/share/src/llvm/tc-build/install/bin/clang-11 -Wp,-MMD,lib/.tes=
t_fpu.o.d  -nostdinc -isystem /mnt/smr/share/src/llvm/tc-build/install/lib/=
clang/11.0.0/include -I./arch/x86/include -I./arch/x86/include/generated  -=
I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I=
./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.=
h -include ./include/linux/compiler_types.h -D__KERNEL__ -Qunused-arguments=
 -Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-alias=
ing -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declarat=
ion -Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -no-integrated=
-as -Werror=3Dunknown-warning-option -mno-sse -mno-mmx -mno-sse2 -mno-3dnow=
 -mno-avx -m64 -mno-80387 -mstack-alignment=3D8 -march=3Dk8 -mno-red-zone -=
mcmodel=3Dkernel -Wno-sign-compare -fno-asynchronous-unwind-tables -mretpol=
ine-external-thunk -fno-delete-null-pointer-checks -Wno-frame-address -Wno-=
address-of-packed-member -O2 -Wframe-larger-than=3D2048 -fstack-protector -=
Wno-format-invalid-specifier -Wno-gnu -mno-global-merge -Wno-unused-const-v=
ariable -g -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-point=
er-sign -Wno-array-bounds -fno-strict-overflow -fno-merge-all-constants -fn=
o-stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -fma=
cro-prefix-map=3D./=3D -fcf-protection=3Dnone -Wno-initializer-overrides -W=
no-format -Wno-sign-compare -Wno-format-zero-length -Wno-pointer-to-enum-ca=
st -Wno-tautological-constant-out-of-range-compare -mhard-float -msse  -DMO=
DULE  -DKBUILD_BASENAME=3D'"test_fpu"' -DKBUILD_MODNAME=3D'"test_fpu"' -c -=
o lib/test_fpu.o lib/test_fpu.c

Add -msse2.  See also:
commit e8a170ff9a35 ("drm/amdgpu: enable -msse2 for GCC 7.1+ users")
potentially relevant, though less so:
commit 00db297106e8 ("drm/amdgpu: fix stack alignment ABI mismatch for
GCC 7.1+")
commit c868868f6b6a ("drm/amdgpu: fix stack alignment ABI mismatch for Clan=
g")
and may your stacks always share the same alignment.

>
> Thx.
>
> --- /tmp/test_fpu.s.gcc 2020-06-22 18:51:25.828615337 +0200
> +++ /tmp/test_fpu.s.llvm-11     2020-06-22 18:50:35.080614534 +0200
> @@ -1,74 +1,49 @@
> -test_fpu_get:
> -       pushq   %r12    #
> -       pushq   %rbx    #
> -       movq    %rsi, %rbx      # tmp119, val
> -       subq    $56, %rsp       #,
> -# lib/test_fpu.c:58:   kernel_fpu_begin();
> -       call    kernel_fpu_begin        #
> -# lib/test_fpu.c:32:   a =3D 4.0;
> -       movlpd  .LC1(%rip), %xmm0       #, tmp106
> -       movsd   %xmm0, (%rsp)   # tmp106, a
> -# lib/test_fpu.c:33:   b =3D 1e-15;
> -       movlpd  .LC2(%rip), %xmm0       #, tmp107
> -       movsd   %xmm0, 8(%rsp)  # tmp107, b
> -# lib/test_fpu.c:34:   c =3D 1e-310;
> -       movlpd  .LC3(%rip), %xmm0       #, tmp108
> -       movsd   %xmm0, 16(%rsp) # tmp108, c
> -# lib/test_fpu.c:37:   d =3D a + b;
> -       movlpd  (%rsp), %xmm0   # a, a.2_8
> -       movlpd  8(%rsp), %xmm1  # b, b.3_9
> -       addsd   %xmm1, %xmm0    # b.3_9, _10
> -# lib/test_fpu.c:37:   d =3D a + b;
> -       movsd   %xmm0, 24(%rsp) # _10, d
> -# lib/test_fpu.c:40:   e =3D a + b / 2;
> -       movlpd  8(%rsp), %xmm0  # b, b.4_11
> -# lib/test_fpu.c:40:   e =3D a + b / 2;
> -       movlpd  (%rsp), %xmm1   # a, a.5_13
> -# lib/test_fpu.c:40:   e =3D a + b / 2;
> -       mulsd   .LC4(%rip), %xmm0       #, tmp109
> -# lib/test_fpu.c:40:   e =3D a + b / 2;
> -       addsd   %xmm1, %xmm0    # a.5_13, _14
> -# lib/test_fpu.c:40:   e =3D a + b / 2;
> -       movsd   %xmm0, 32(%rsp) # _14, e
> -# lib/test_fpu.c:43:   f =3D b / c;
> -       movlpd  8(%rsp), %xmm0  # b, b.6_15
> -       movlpd  16(%rsp), %xmm1 # c, c.7_16
> -       divsd   %xmm1, %xmm0    # c.7_16, _17
> -# lib/test_fpu.c:43:   f =3D b / c;
> -       movsd   %xmm0, 40(%rsp) # _17, f
> -# lib/test_fpu.c:46:   g =3D a + c * f;
> -       movlpd  16(%rsp), %xmm0 # c, c.8_18
> -       movlpd  40(%rsp), %xmm2 # f, f.9_19
> -# lib/test_fpu.c:46:   g =3D a + c * f;
> -       movlpd  (%rsp), %xmm1   # a, a.10_21
> -# lib/test_fpu.c:46:   g =3D a + c * f;
> -       mulsd   %xmm2, %xmm0    # f.9_19, tmp111
> -# lib/test_fpu.c:46:   g =3D a + c * f;
> -       addsd   %xmm1, %xmm0    # a.10_21, _22
> -# lib/test_fpu.c:46:   g =3D a + c * f;
> -       movsd   %xmm0, 48(%rsp) # _22, g
> -# lib/test_fpu.c:48:   if (d > a && e > a && g > a)
> -       movlpd  24(%rsp), %xmm1 # d, d.11_23
> -       movlpd  (%rsp), %xmm0   # a, a.12_24
> -# lib/test_fpu.c:48:   if (d > a && e > a && g > a)
> -       comisd  %xmm0, %xmm1    # a.12_24, d.11_23
> -       jbe     .L15    #,
> -# lib/test_fpu.c:48:   if (d > a && e > a && g > a)
> -       movlpd  32(%rsp), %xmm1 # e, e.13_25
> -       movlpd  (%rsp), %xmm0   # a, a.14_26
> -# lib/test_fpu.c:48:   if (d > a && e > a && g > a)
> -       comisd  %xmm0, %xmm1    # a.14_26, e.13_25
> -       jbe     .L15    #,
> -# lib/test_fpu.c:48:   if (d > a && e > a && g > a)
> -       movlpd  48(%rsp), %xmm1 # g, g.15_27
> -# lib/test_fpu.c:51:           return -EINVAL;
> -       movl    $0, %r12d       #, tmp117
> -       movl    $-22, %eax      #, tmp118
> -# lib/test_fpu.c:48:   if (d > a && e > a && g > a)
> -       movlpd  (%rsp), %xmm0   # a, a.16_28
> -# lib/test_fpu.c:51:           return -EINVAL;
> -       comisd  %xmm0, %xmm1    # a.16_28, g.15_27
> -       cmovbe  %eax, %r12d     # tmp117,, tmp118, <retval>
> -.L4:
> -# lib/test_fpu.c:60:   kernel_fpu_end();
> -       call    kernel_fpu_end  #
> +test_fpu_get:                           # @test_fpu_get
> +# %bb.0:
> +       pushq   %rbp
> +       pushq   %rbx
> +       subq    $56, %rsp
> +       movq    %rsi, %rbx
> +       callq   kernel_fpu_begin
> +       movabsq $4616189618054758400, %rax # imm =3D 0x4010000000000000
> +       movq    %rax, (%rsp)
> +       movabsq $4382569440205035030, %rax # imm =3D 0x3CD203AF9EE75616
> +       movq    %rax, 8(%rsp)
> +       movabsq $20240225330731, %rax   # imm =3D 0x12688B70E62B
> +       movq    %rax, 16(%rsp)
> +       movq    (%rsp), %rdi
> +       movq    8(%rsp), %rsi
> +       callq   __adddf3
> +       movq    %rax, 48(%rsp)
> +       movq    (%rsp), %rbp
> +       movq    8(%rsp), %rdi
> +       movabsq $4602678819172646912, %rsi # imm =3D 0x3FE0000000000000
> +       callq   __muldf3
> +       movq    %rbp, %rdi
> +       movq    %rax, %rsi
> +       callq   __adddf3
> +       movq    %rax, 40(%rsp)
> +       movq    8(%rsp), %rdi
> +       movq    16(%rsp), %rsi
> +       callq   __divdf3
> +       movq    %rax, 32(%rsp)
> +       movq    (%rsp), %rbp
> +       movq    16(%rsp), %rdi
> +       movq    32(%rsp), %rsi
> +       callq   __muldf3
> +       movq    %rbp, %rdi
> +       movq    %rax, %rsi
> +       callq   __adddf3
> +       movq    %rax, 24(%rsp)
> +       movq    48(%rsp), %rdi
> +       movq    (%rsp), %rsi
> +       callq   __gtdf2
> +       testl   %eax, %eax
> +       jle     .LBB3_3
> +# %bb.1:
> +       movq    40(%rsp), %rdi
> +       movq    (%rsp), %rsi
> +       callq   __gtdf2
> +       testl   %eax, %eax
> +       jle     .LBB3_3
> +# %bb.2:
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/20200622170446.GG32200%40zn.tnic.



--=20
Thanks,
~Nick Desaulniers
