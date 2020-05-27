Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E7720835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbgE0UCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:02:39 -0400
Received: from foss.arm.com ([217.140.110.172]:44210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0UCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:02:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7394C31B;
        Wed, 27 May 2020 13:02:38 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45AE93F52E;
        Wed, 27 May 2020 13:02:36 -0700 (PDT)
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
From:   Robin Murphy <robin.murphy@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
 <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com>
Message-ID: <d2bf55cf-8b72-3f88-3c0b-5dfb4e120f7f@arm.com>
Date:   Wed, 27 May 2020 21:02:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <34f261f7-c4b5-a628-9a4c-eb97b75fba52@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-27 20:28, Robin Murphy wrote:
> On 2020-05-27 18:55, Nick Desaulniers wrote:
>> On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> 
>> wrote:
>>>
>>> On 2020-05-26 18:31, Nick Desaulniers wrote:
>>>> Custom toolchains that modify the default target to -mthumb cannot
>>>> compile the arm64 compat vdso32, as
>>>> arch/arm64/include/asm/vdso/compat_gettimeofday.h
>>>> contains assembly that's invalid in -mthumb.  Force the use of -marm,
>>>> always.
>>>
>>> FWIW, this seems suspicious - the only assembly instructions I see there
>>> are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
>>> -march=armv7a baseline that we set.
>>>
>>> On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
>>> built a Thumb VDSO quite happily with Ubuntu 19.04's
>>> gcc-arm-linux-gnueabihf. What was the actual failure you saw?
>>
>>  From the link in the commit message: `write to reserved register 'R7'`
>> https://godbolt.org/z/zwr7iZ
>> IIUC r7 is reserved for the frame pointer in THUMB?
> 
> It can be, if you choose to build with frame pointers and the common 
> frame pointer ABI for Thumb code that uses r7. However it can also be 
> for other things like the syscall number in the Arm syscall ABI too. I 

Oh, and for the avoidance of ambiguity that's "Arm" as in the 32-bit Arm 
architecture port, not a specific instruction set.

Robin.

> take it Clang has decided that writing syscall wrappers with minimal 
> inline asm is not a thing people deserve to do without arbitrary other 
> restrictions?
> 
>> What is the implicit default of your gcc-arm-linux-gnueabihf at -O2?
>> -mthumb, or -marm?
> 
> As Dave pointed out, like the probable majority of users it's Thumb:
> 
> $ arm-linux-gnueabihf-gcc -v
> Using built-in specs.
> COLLECT_GCC=arm-linux-gnueabihf-gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/arm-linux-gnueabihf/8/lto-wrapper
> Target: arm-linux-gnueabihf
> Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 
> 8.3.0-6ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-8/README.Bugs 
> --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr 
> --with-gcc-major-version-only --program-suffix=-8 --enable-shared 
> --enable-linker-build-id --libexecdir=/usr/lib 
> --without-included-gettext --enable-threads=posix --libdir=/usr/lib 
> --enable-nls --with-sysroot=/ --enable-clocale=gnu 
> --enable-libstdcxx-debug --enable-libstdcxx-time=yes 
> --with-default-libstdcxx-abi=new --enable-gnu-unique-object 
> --disable-libitm --disable-libquadmath --disable-libquadmath-support 
> --enable-plugin --enable-default-pie --with-system-zlib 
> --with-target-system-zlib --enable-multiarch --enable-multilib 
> --disable-sjlj-exceptions --with-arch=armv7-a --with-fpu=vfpv3-d16 
> --with-float=hard --with-mode=thumb --disable-werror --enable-multilib 
> --enable-checking=release --build=aarch64-linux-gnu 
> --host=aarch64-linux-gnu --target=arm-linux-gnueabihf 
> --program-prefix=arm-linux-gnueabihf- 
> --includedir=/usr/arm-linux-gnueabihf/include
> Thread model: posix
> gcc version 8.3.0 (Ubuntu/Linaro 8.3.0-6ubuntu1)
> 
> (yeah, I didn't actually need to hack my makefile at all)
> 
> Robin.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
