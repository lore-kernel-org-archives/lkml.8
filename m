Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D469AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0536206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFJAah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:30:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:54716 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgFJAah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:30:37 -0400
IronPort-SDR: oxH38JhElLgccQMrCKdRFuitsaM6sYt7HLAH8tda4Z71JZ5umyZJTaW+Gm3GWJ4DhlGipXdULI
 yL89edZoXRDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 17:30:37 -0700
IronPort-SDR: rqpnuMXNA2u3kjIrspzvRGugK/k4VK/iLVhzb20AUfH1hnut5+XdCYAsxXFMXQDQYCom7ORvNV
 kbAdsrwzjtpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="314346217"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2020 17:30:35 -0700
Subject: Re: [kbuild-all] Re: gcc-5: error: -gz is not supported in this
 configuration
To:     Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
 <20200609174954.cckelwl6etwztmhv@google.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
Date:   Wed, 10 Jun 2020 08:30:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200609174954.cckelwl6etwztmhv@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/20 1:49 AM, Fangrui Song wrote:
> On 2020-06-09, Nick Desaulniers wrote:
>> On Tue, Jun 9, 2020 at 6:12 AM kernel test robot <lkp@intel.com> wrote:
>>>
>>> tree: 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>> master
>>> head:   abfbb29297c27e3f101f348dc9e467b0fe70f919
>>> commit: 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace Makefile: support 
>>> compressed debug info
>>> date:   12 days ago
>>> config: x86_64-randconfig-r032-20200609 (attached as .config)
>>> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
>>> reproduce (this is a W=1 build):
>>>         git checkout 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace
>>>         # save the attached .config to linux build tree
>>>         make W=1 ARCH=x86_64
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>
>>> >> gcc-5: error: -gz is not supported in this configuration
>>
>> Hmm...I wonder if the feature detection is incomplete?  I suspect it's
>> possible to not depend on zlib.
>>
>>> make[2]: *** [scripts/Makefile.build:277: scripts/mod/empty.o] Error 1
>>> make[2]: Target '__build' not remade because of errors.
>>> make[1]: *** [Makefile:1169: prepare0] Error 2
>>> make[1]: Target 'prepare' not remade because of errors.
>>> make: *** [Makefile:185: __sub-make] Error 2
>
> The output of gcc-5 -v --version on that machine may help.  The
> convoluted gcc_cv_ld_compress_de logic in gcc/configure.ac may be
> related, but I can't find any mistake that our
> CONFIG_DEBUG_INFO_COMPRESSED conditions may make.

Hi Fangrui,

Here is the output:

$gcc-5 -v --version
Using built-in specs.
COLLECT_GCC=gcc-5
COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper
gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Target: x86_64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu 
5.5.0-12ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-5/README.Bugs 
--enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr 
--program-suffix=-5 --enable-shared --enable-linker-build-id 
--libexecdir=/usr/lib --without-included-gettext --enable-threads=posix 
--libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu 
--enable-libstdcxx-debug --enable-libstdcxx-time=yes 
--with-default-libstdcxx-abi=new --enable-gnu-unique-object 
--disable-vtable-verify --enable-libmpx --enable-plugin 
--enable-default-pie --with-system-zlib --enable-objc-gc 
--enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64 
--with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic 
--enable-checking=release --build=x86_64-linux-gnu 
--host=x86_64-linux-gnu --target=x86_64-linux-gnu
Thread model: posix
gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1)
COLLECT_GCC_OPTIONS='-v' '--version' '-mtune=generic' '-march=x86-64'
  /usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -v -imultiarch 
x86_64-linux-gnu help-dummy -quiet -dumpbase help-dummy -mtune=generic 
-march=x86-64 -auxbase help-dummy -version --version 
-fstack-protector-strong -Wformat -Wformat-security -o /tmp/ccqnZumV.s
GNU C11 (Ubuntu 5.5.0-12ubuntu1) version 5.5.0 20171010 (x86_64-linux-gnu)
         compiled by GNU C version 5.5.0 20171010, GMP version 6.1.2, 
MPFR version 4.0.1, MPC version 1.1.0
warning: MPFR header version 4.0.1 differs from library version 4.0.2.
GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
COLLECT_GCC_OPTIONS='-v' '--version' '-mtune=generic' '-march=x86-64'
  as -v --64 --version -o /tmp/ccRPgs9J.o /tmp/ccqnZumV.s
GNU assembler version 2.34 (x86_64-linux-gnu) using BFD version (GNU 
Binutils for Ubuntu) 2.34
GNU assembler (GNU Binutils for Ubuntu) 2.34
Copyright (C) 2020 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `x86_64-linux-gnu'.
COMPILER_PATH=/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/
LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib/:/lib/x86_64-linux-gnu/:/lib/../lib/:/usr/lib/x86_64-linux-gnu/:/usr/lib/../lib/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../:/lib/:/usr/lib/
COLLECT_GCC_OPTIONS='-v' '--version' '-mtune=generic' '-march=x86-64'
  /usr/lib/gcc/x86_64-linux-gnu/5/collect2 -plugin 
/usr/lib/gcc/x86_64-linux-gnu/5/liblto_plugin.so 
-plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper 
-plugin-opt=-fresolution=/tmp/ccJLhs3y.res 
-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s 
-plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc 
-plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr 
-m elf_x86_64 --hash-style=gnu --as-needed -dynamic-linker 
/lib64/ld-linux-x86-64.so.2 -pie -z now -z relro --version 
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/Scrt1.o 
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o 
/usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o 
-L/usr/lib/gcc/x86_64-linux-gnu/5 
-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu 
-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib 
-L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu 
-L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. 
/tmp/ccRPgs9J.o -lgcc --push-state --as-needed -lgcc_s --pop-state -lc 
-lgcc --push-state --as-needed -lgcc_s --pop-state 
/usr/lib/gcc/x86_64-linux-gnu/5/crtend.o 
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o
collect2 version 5.5.0 20171010
/usr/bin/ld -plugin /usr/lib/gcc/x86_64-linux-gnu/5/liblto_plugin.so 
-plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper 
-plugin-opt=-fresolution=/tmp/ccJLhs3y.res 
-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s 
-plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc 
-plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr 
-m elf_x86_64 --hash-style=gnu --as-needed -dynamic-linker 
/lib64/ld-linux-x86-64.so.2 -pie -z now -z relro --version 
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/Scrt1.o 
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o 
/usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o 
-L/usr/lib/gcc/x86_64-linux-gnu/5 
-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu 
-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib 
-L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu 
-L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. 
/tmp/ccRPgs9J.o -lgcc --push-state --as-needed -lgcc_s --pop-state -lc 
-lgcc --push-state --as-needed -lgcc_s --pop-state 
/usr/lib/gcc/x86_64-linux-gnu/5/crtend.o 
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o
GNU ld (GNU Binutils for Ubuntu) 2.34
Copyright (C) 2020 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or (at your option) a later 
version.
This program has absolutely no warranty.

Best Regards,
Rong Chen
