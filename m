Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F610C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C10F2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tK0NSCo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393159AbgFWUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:50:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54833 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388016AbgFWUub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:50:31 -0400
Received: from [IPv6:2601:646:8600:3281:793b:110b:9a95:572b] ([IPv6:2601:646:8600:3281:793b:110b:9a95:572b])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 05NKnsMA2994193
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 23 Jun 2020 13:49:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 05NKnsMA2994193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020052301; t=1592945401;
        bh=ZPhdAYw0DZqPh39NH3i9vcQbK+fMod7/4PWe2cDAUow=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=tK0NSCo5lz87kwexbz8w4k4xxP53yygNw6yw50FeH8gxO7t6R24X8Sudq073jIXrR
         Cv2EAMR4/nESFO8mhlNay1uPywCxbHWaKCMWcpmJNi2wgL5RnozFeIfcD1krRv8YTq
         UeYy6VuTu8pu+4UxCE33YGkSCI7+ts8j3EMRkLixnRn2303bvLYUL1fFQ+Bdqhv7D2
         oOfrqtNMGrsjaypDOT5Eq2ZVSFJFVY+PvkcyjYG4Y8Ijh5QakFbo7v8SafiDPgWWye
         8p8WyMlTiHPtj9CEDC4wO43Hm9UC9JhBffHILIEkfYIxTSmgbOrmfyAVVZQyJwnlRi
         bsghPTlPA3nLA==
Date:   Tue, 23 Jun 2020 13:49:47 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2jA3rdfCA-UYGEtRPrYCChK1wzHfVUhbrHiqGL3iL4PBA@mail.gmail.com>
References: <20200616142315.375918-1-brgerst@gmail.com> <20200616142315.375918-2-brgerst@gmail.com> <CALCETrXUjM9g2e5v7chFXWoadvUO_7cqhGvuFn2s7YVpyff__Q@mail.gmail.com> <CAMzpN2jA3rdfCA-UYGEtRPrYCChK1wzHfVUhbrHiqGL3iL4PBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] x86/x32: Use __x64 prefix for X32 compat syscalls
To:     Brian Gerst <brgerst@gmail.com>, Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
From:   hpa@zytor.com
Message-ID: <6D37758F-E61F-4DF9-9D86-C02DF91B4BDE@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 16, 2020 10:17:29 AM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Tue, Jun 16, 2020 at 12:49 PM Andy Lutomirski <luto@kernel=2Eorg>
>wrote:
>>
>> On Tue, Jun 16, 2020 at 7:23 AM Brian Gerst <brgerst@gmail=2Ecom>
>wrote:
>> >
>> > The ABI prefix for syscalls specifies the argument register
>mapping, so
>> > there is no specific reason to continue using the __x32 prefix for
>the
>> > compat syscalls=2E  This change will allow using native syscalls in
>the X32
>> > specific portion of the syscall table=2E
>>
>> Okay, I realize that the x86 syscall machinery is held together by
>> duct tape and a lot of luck, but:
>>
>> >
>> > Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>> > ---
>> >  arch/x86/entry/syscall_x32=2Ec           |  8 +++-----
>> >  arch/x86/include/asm/syscall_wrapper=2Eh | 10 +++++-----
>> >  2 files changed, 8 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/arch/x86/entry/syscall_x32=2Ec
>b/arch/x86/entry/syscall_x32=2Ec
>> > index 3d8d70d3896c=2E=2Ef993e6254043 100644
>> > --- a/arch/x86/entry/syscall_x32=2Ec
>> > +++ b/arch/x86/entry/syscall_x32=2Ec
>> > @@ -9,15 +9,13 @@
>> >  #include <asm/syscall=2Eh>
>> >
>> >  #define __SYSCALL_64(nr, sym)
>> > +#define __SYSCALL_COMMON(nr, sym) __SYSCALL_X32(nr, sym)
>> >
>> > -#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const
>struct pt_regs *);
>> > -#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const
>struct pt_regs *);
>> > +#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const
>struct pt_regs *);
>> >  #include <asm/syscalls_64=2Eh>
>> >  #undef __SYSCALL_X32
>> > -#undef __SYSCALL_COMMON
>> >
>> > -#define __SYSCALL_X32(nr, sym) [nr] =3D __x32_##sym,
>> > -#define __SYSCALL_COMMON(nr, sym) [nr] =3D __x64_##sym,
>> > +#define __SYSCALL_X32(nr, sym) [nr] =3D __x64_##sym,
>> >
>> >  asmlinkage const sys_call_ptr_t
>x32_sys_call_table[__NR_x32_syscall_max+1] =3D {
>> >         /*
>> > diff --git a/arch/x86/include/asm/syscall_wrapper=2Eh
>b/arch/x86/include/asm/syscall_wrapper=2Eh
>> > index a84333adeef2=2E=2E267fae9904ff 100644
>> > --- a/arch/x86/include/asm/syscall_wrapper=2Eh
>> > +++ b/arch/x86/include/asm/syscall_wrapper=2Eh
>> > @@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct
>pt_regs *regs);
>> >   * __x64_sys_*()         - 64-bit native syscall
>> >   * __ia32_sys_*()        - 32-bit native syscall or common compat
>syscall
>> >   * __ia32_compat_sys_*() - 32-bit compat syscall
>>
>> On a 64-bit kernel, an "ia32" compat syscall is __ia32_compat_sys_*,
>but=2E=2E=2E
>>
>> > - * __x32_compat_sys_*()  - 64-bit X32 compat syscall
>> > + * __x64_compat_sys_*()  - 64-bit X32 compat syscall
>>
>> Now an x32 compat syscall is __x64_compat?  This seems nonsensical=2E
>
>Again, think of it as how the registers are mapped, not which syscall
>table it belongs to=2E  X32 and X64 are identical in that regard=2E
>
>> I'm also a bit confused as to how this is even necessary for your
>> other patch=2E
>
>This came out of discussion on Cristoph's patch to combine compat
>execve*() into the native version:
>https://lore=2Ekernel=2Eorg/lkml/20200615141239=2EGA12951@lst=2Ede/
>
>The bottom line is that marking a syscall as X32-only in the syscall
>table forces an __x32 prefix even if it's not a "compat" syscall=2E
>This causes a link failure=2E  This is just another quirk caused by how
>X32 was designed=2E  The solution is to make the prefix consistent for
>the whole table=2E  The other alternative is to use __x32 for all the
>common syscalls=2E
>
>The second patch isn't really necessary, but it makes more sense to
>not have a compat syscall with no corresponding native version=2E
>
>--
>Brian Gerst

Please don't use "x64" to mean anything other than x86-64, as some, ahem, =
other OSes use those as synonyms=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
