Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBE3520644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cm5lXkEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgFVRE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:04:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:04:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2500329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 888181EC0283;
        Mon, 22 Jun 2020 19:04:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592845494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZE0rblkVRU8ADgHdusXh5/vN8EII/na4ZFDGRwtdqk=;
        b=Cm5lXkEbESAPW6MhL1FDLPEIlasK2bpDO2dHRCM5f/MKy/kP8ifybhVdyFkhmbbWSI+Nya
        TTMhaTZT3L2Hq9l/Ap1gqeZBipeKgN7tWfh805bt/azoNGnIZZpUzHJ+qk15YnkSbvHG/V
        tVa6HsUQlJ2wotPe1GGdhpJiWOOIWI0=
Date:   Mon, 22 Jun 2020 19:04:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com
Cc:     X86 ML <x86@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200622170446.GG32200@zn.tnic>
References: <20200619174127.22304-3-bp@alien8.de>
 <202006210328.6YokxLP3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202006210328.6YokxLP3%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 03:55:00AM +0800, kernel test robot wrote:
> Hi Borislav,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on kselftest/next]
> [also build test ERROR on tip/auto-latest linus/master v5.8-rc1 next-2020=
0618]
> [cannot apply to tip/x86/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
>=20
> url:    https://github.com/0day-ci/linux/commits/Borislav-Petkov/x86-FPU-=
FPU-sanitization-for-in-kernel-use/20200620-014453
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kself=
test.git next
> config: x86_64-allmodconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 487c=
a07fcc75d52755c9fe2ee05bcb3b6eeeec44)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Dx86_64=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "__gtdf2" [lib/test_fpu.ko] undefined!
> >> ERROR: modpost: "__divdf3" [lib/test_fpu.ko] undefined!
> >> ERROR: modpost: "__muldf3" [lib/test_fpu.ko] undefined!
> >> ERROR: modpost: "__adddf3" [lib/test_fpu.ko] undefined!

Hmm, the point here is to actually have SSE* code in a kernel module for
testing. And gcc does the right thing, see below.

LLVM folks, how can I make llvm not call those library functions and
actually spit out SSE* code?

Full build command is:

  /mnt/smr/share/src/llvm/tc-build/install/bin/clang-11 -Wp,-MMD,lib/.test_=
fpu.o.d  -nostdinc -isystem /mnt/smr/share/src/llvm/tc-build/install/lib/cl=
ang/11.0.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I.=
/include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./=
include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h =
-include ./include/linux/compiler_types.h -D__KERNEL__ -Qunused-arguments -=
Wall -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasin=
g -fno-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaratio=
n -Werror=3Dimplicit-int -Wno-format-security -std=3Dgnu89 -no-integrated-a=
s -Werror=3Dunknown-warning-option -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -=
mno-avx -m64 -mno-80387 -mstack-alignment=3D8 -march=3Dk8 -mno-red-zone -mc=
model=3Dkernel -Wno-sign-compare -fno-asynchronous-unwind-tables -mretpolin=
e-external-thunk -fno-delete-null-pointer-checks -Wno-frame-address -Wno-ad=
dress-of-packed-member -O2 -Wframe-larger-than=3D2048 -fstack-protector -Wn=
o-format-invalid-specifier -Wno-gnu -mno-global-merge -Wno-unused-const-var=
iable -g -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer=
-sign -Wno-array-bounds -fno-strict-overflow -fno-merge-all-constants -fno-=
stack-check -Werror=3Ddate-time -Werror=3Dincompatible-pointer-types -fmacr=
o-prefix-map=3D./=3D -fcf-protection=3Dnone -Wno-initializer-overrides -Wno=
-format -Wno-sign-compare -Wno-format-zero-length -Wno-pointer-to-enum-cast=
 -Wno-tautological-constant-out-of-range-compare -mhard-float -msse  -DMODU=
LE  -DKBUILD_BASENAME=3D'"test_fpu"' -DKBUILD_MODNAME=3D'"test_fpu"' -c -o =
lib/test_fpu.o lib/test_fpu.c

Thx.

--- /tmp/test_fpu.s.gcc	2020-06-22 18:51:25.828615337 +0200
+++ /tmp/test_fpu.s.llvm-11	2020-06-22 18:50:35.080614534 +0200
@@ -1,74 +1,49 @@
-test_fpu_get:
-	pushq	%r12	#
-	pushq	%rbx	#
-	movq	%rsi, %rbx	# tmp119, val
-	subq	$56, %rsp	#,
-# lib/test_fpu.c:58: 	kernel_fpu_begin();
-	call	kernel_fpu_begin	#
-# lib/test_fpu.c:32: 	a =3D 4.0;
-	movlpd	.LC1(%rip), %xmm0	#, tmp106
-	movsd	%xmm0, (%rsp)	# tmp106, a
-# lib/test_fpu.c:33: 	b =3D 1e-15;
-	movlpd	.LC2(%rip), %xmm0	#, tmp107
-	movsd	%xmm0, 8(%rsp)	# tmp107, b
-# lib/test_fpu.c:34: 	c =3D 1e-310;
-	movlpd	.LC3(%rip), %xmm0	#, tmp108
-	movsd	%xmm0, 16(%rsp)	# tmp108, c
-# lib/test_fpu.c:37: 	d =3D a + b;
-	movlpd	(%rsp), %xmm0	# a, a.2_8
-	movlpd	8(%rsp), %xmm1	# b, b.3_9
-	addsd	%xmm1, %xmm0	# b.3_9, _10
-# lib/test_fpu.c:37: 	d =3D a + b;
-	movsd	%xmm0, 24(%rsp)	# _10, d
-# lib/test_fpu.c:40: 	e =3D a + b / 2;
-	movlpd	8(%rsp), %xmm0	# b, b.4_11
-# lib/test_fpu.c:40: 	e =3D a + b / 2;
-	movlpd	(%rsp), %xmm1	# a, a.5_13
-# lib/test_fpu.c:40: 	e =3D a + b / 2;
-	mulsd	.LC4(%rip), %xmm0	#, tmp109
-# lib/test_fpu.c:40: 	e =3D a + b / 2;
-	addsd	%xmm1, %xmm0	# a.5_13, _14
-# lib/test_fpu.c:40: 	e =3D a + b / 2;
-	movsd	%xmm0, 32(%rsp)	# _14, e
-# lib/test_fpu.c:43: 	f =3D b / c;
-	movlpd	8(%rsp), %xmm0	# b, b.6_15
-	movlpd	16(%rsp), %xmm1	# c, c.7_16
-	divsd	%xmm1, %xmm0	# c.7_16, _17
-# lib/test_fpu.c:43: 	f =3D b / c;
-	movsd	%xmm0, 40(%rsp)	# _17, f
-# lib/test_fpu.c:46: 	g =3D a + c * f;
-	movlpd	16(%rsp), %xmm0	# c, c.8_18
-	movlpd	40(%rsp), %xmm2	# f, f.9_19
-# lib/test_fpu.c:46: 	g =3D a + c * f;
-	movlpd	(%rsp), %xmm1	# a, a.10_21
-# lib/test_fpu.c:46: 	g =3D a + c * f;
-	mulsd	%xmm2, %xmm0	# f.9_19, tmp111
-# lib/test_fpu.c:46: 	g =3D a + c * f;
-	addsd	%xmm1, %xmm0	# a.10_21, _22
-# lib/test_fpu.c:46: 	g =3D a + c * f;
-	movsd	%xmm0, 48(%rsp)	# _22, g
-# lib/test_fpu.c:48: 	if (d > a && e > a && g > a)
-	movlpd	24(%rsp), %xmm1	# d, d.11_23
-	movlpd	(%rsp), %xmm0	# a, a.12_24
-# lib/test_fpu.c:48: 	if (d > a && e > a && g > a)
-	comisd	%xmm0, %xmm1	# a.12_24, d.11_23
-	jbe	.L15	#,
-# lib/test_fpu.c:48: 	if (d > a && e > a && g > a)
-	movlpd	32(%rsp), %xmm1	# e, e.13_25
-	movlpd	(%rsp), %xmm0	# a, a.14_26
-# lib/test_fpu.c:48: 	if (d > a && e > a && g > a)
-	comisd	%xmm0, %xmm1	# a.14_26, e.13_25
-	jbe	.L15	#,
-# lib/test_fpu.c:48: 	if (d > a && e > a && g > a)
-	movlpd	48(%rsp), %xmm1	# g, g.15_27
-# lib/test_fpu.c:51: 		return -EINVAL;
-	movl	$0, %r12d	#, tmp117
-	movl	$-22, %eax	#, tmp118
-# lib/test_fpu.c:48: 	if (d > a && e > a && g > a)
-	movlpd	(%rsp), %xmm0	# a, a.16_28
-# lib/test_fpu.c:51: 		return -EINVAL;
-	comisd	%xmm0, %xmm1	# a.16_28, g.15_27
-	cmovbe	%eax, %r12d	# tmp117,, tmp118, <retval>
-.L4:
-# lib/test_fpu.c:60: 	kernel_fpu_end();
-	call	kernel_fpu_end	#
+test_fpu_get:                           # @test_fpu_get
+# %bb.0:
+	pushq	%rbp
+	pushq	%rbx
+	subq	$56, %rsp
+	movq	%rsi, %rbx
+	callq	kernel_fpu_begin
+	movabsq	$4616189618054758400, %rax # imm =3D 0x4010000000000000
+	movq	%rax, (%rsp)
+	movabsq	$4382569440205035030, %rax # imm =3D 0x3CD203AF9EE75616
+	movq	%rax, 8(%rsp)
+	movabsq	$20240225330731, %rax   # imm =3D 0x12688B70E62B
+	movq	%rax, 16(%rsp)
+	movq	(%rsp), %rdi
+	movq	8(%rsp), %rsi
+	callq	__adddf3
+	movq	%rax, 48(%rsp)
+	movq	(%rsp), %rbp
+	movq	8(%rsp), %rdi
+	movabsq	$4602678819172646912, %rsi # imm =3D 0x3FE0000000000000
+	callq	__muldf3
+	movq	%rbp, %rdi
+	movq	%rax, %rsi
+	callq	__adddf3
+	movq	%rax, 40(%rsp)
+	movq	8(%rsp), %rdi
+	movq	16(%rsp), %rsi
+	callq	__divdf3
+	movq	%rax, 32(%rsp)
+	movq	(%rsp), %rbp
+	movq	16(%rsp), %rdi
+	movq	32(%rsp), %rsi
+	callq	__muldf3
+	movq	%rbp, %rdi
+	movq	%rax, %rsi
+	callq	__adddf3
+	movq	%rax, 24(%rsp)
+	movq	48(%rsp), %rdi
+	movq	(%rsp), %rsi
+	callq	__gtdf2
+	testl	%eax, %eax
+	jle	.LBB3_3
+# %bb.1:
+	movq	40(%rsp), %rdi
+	movq	(%rsp), %rsi
+	callq	__gtdf2
+	testl	%eax, %eax
+	jle	.LBB3_3
+# %bb.2:

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
