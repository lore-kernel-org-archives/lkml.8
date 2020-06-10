Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0301BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC7E206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2VQGVtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgFJA6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgFJA6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:58:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC2C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 17:58:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so140422pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=deHHT0idWxDBGhMm7GznkipejMLDkeZgyFXOCK9e0nY=;
        b=a2VQGVtjfGp/6p2R9KLhqE1l1RZ6wzJ3kYwdrtabn2QITdVWDf1Gbb7pOd6CeOginN
         6kNzsHrAc6LJ7tAp/peiYp3adzOzFDF8LxoeH6wxNAB5jZi5T2XGMgMbBMvRckt1ZWMr
         r4WKPRkJa8zto8gnCKI9XhPHiJEFIxB5/pewFl6u8g8MMTXh1f3/AbYY68s40JMYroMt
         7HDBxKM7o19+mTENBaVMnFl4P2jQ3d96d+Np40clMdGJim98/wPfexFen4sXNNBP158P
         9KadOFEV0TUNvoCD33+kOsVluS0XTlmcLj8P2LFSV+lHw3TALtmrZVBveJ8EImr9ECM1
         iGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=deHHT0idWxDBGhMm7GznkipejMLDkeZgyFXOCK9e0nY=;
        b=jmmfu7GMs/IchYMNglUA1KMp4OoO3X2B/3EpOFZYHIefdysL9iTxcUUSBI2/iQeMgD
         pdqEws40VYqFJ7ZamznxqXWBWCPtNhXFv0M5Hm6pMELCmYA6PAVOvvqmhcuHhsI1HNmv
         Xb1P2d19fgjSbVw0dDXprDMmTcpsZEcpiulQ9wz6vdNidX8OUnM0pu4YsSmhxU8IJmRx
         04E70KO0ty3fzCCv/oFO8Dnx7E4A8n99mLXohBoxApNmlQB81d38RamWzddcORNuXuX8
         gf2Ey6AzTyQASulOzl1gVBY9N1ixY4ah4ViU3ESwRmkPFVK4xhUnyNPs3Du+G/+WTNPu
         pLGQ==
X-Gm-Message-State: AOAM533nqs3frVZ0IVjTjbm/8ZeLFgx98UX5NAuOXLYdZKpZLOwrJbNd
        k3K7/qNRo5oA9wEMnfkDFhOfuA==
X-Google-Smtp-Source: ABdhPJx0qbV5onDMGzQHEvitE/oGAZGMK1v6t+PPyKk3DNvNNlCwPd2aHrHK/PiiGth/Z4joJQHorg==
X-Received: by 2002:a17:902:b68d:: with SMTP id c13mr885114pls.210.1591750713318;
        Tue, 09 Jun 2020 17:58:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id f14sm3405328pjq.36.2020.06.09.17.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 17:58:32 -0700 (PDT)
Date:   Tue, 9 Jun 2020 17:58:30 -0700
From:   Fangrui Song <maskray@google.com>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: gcc-5: error: -gz is not supported in this
 configuration
Message-ID: <20200610005830.s6gus7r3umwgzozk@google.com>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
 <20200609174954.cckelwl6etwztmhv@google.com>
 <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-10, Rong Chen wrote:
>
>
>On 6/10/20 1:49 AM, Fangrui Song wrote:
>>On 2020-06-09, Nick Desaulniers wrote:
>>>On Tue, Jun 9, 2020 at 6:12 AM kernel test robot <lkp@intel.com> wrote:
>>>>
>>>>tree: 
>>>>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>>>>master
>>>>head:   abfbb29297c27e3f101f348dc9e467b0fe70f919
>>>>commit: 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace Makefile: 
>>>>support compressed debug info
>>>>date:   12 days ago
>>>>config: x86_64-randconfig-r032-20200609 (attached as .config)
>>>>compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
>>>>reproduce (this is a W=1 build):
>>>>        git checkout 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace
>>>>        # save the attached .config to linux build tree
>>>>        make W=1 ARCH=x86_64
>>>>
>>>>If you fix the issue, kindly add following tag as appropriate
>>>>Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>>All errors (new ones prefixed by >>, old ones prefixed by <<):
>>>>
>>>>>> gcc-5: error: -gz is not supported in this configuration
>>>
>>>Hmm...I wonder if the feature detection is incomplete?  I suspect it's
>>>possible to not depend on zlib.
>>>
>>>>make[2]: *** [scripts/Makefile.build:277: scripts/mod/empty.o] Error 1
>>>>make[2]: Target '__build' not remade because of errors.
>>>>make[1]: *** [Makefile:1169: prepare0] Error 2
>>>>make[1]: Target 'prepare' not remade because of errors.
>>>>make: *** [Makefile:185: __sub-make] Error 2
>>
>>The output of gcc-5 -v --version on that machine may help.  The
>>convoluted gcc_cv_ld_compress_de logic in gcc/configure.ac may be
>>related, but I can't find any mistake that our
>>CONFIG_DEBUG_INFO_COMPRESSED conditions may make.
>
>Hi Fangrui,
>
>Here is the output:
>
>$gcc-5 -v --version
>Using built-in specs.
>COLLECT_GCC=gcc-5
>COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper
>gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
>Copyright (C) 2015 Free Software Foundation, Inc.
>This is free software; see the source for copying conditions.  There is NO
>warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
>
>Target: x86_64-linux-gnu
>Configured with: ../src/configure -v --with-pkgversion='Ubuntu 
>5.5.0-12ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-5/README.Bugs 
>--enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr 
>--program-suffix=-5 --enable-shared --enable-linker-build-id 
>--libexecdir=/usr/lib --without-included-gettext 
>--enable-threads=posix --libdir=/usr/lib --enable-nls --with-sysroot=/ 
>--enable-clocale=gnu --enable-libstdcxx-debug 
>--enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new 
>--enable-gnu-unique-object --disable-vtable-verify --enable-libmpx 
>--enable-plugin --enable-default-pie --with-system-zlib 
>--enable-objc-gc --enable-multiarch --disable-werror 
>--with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 
>--enable-multilib --with-tune=generic --enable-checking=release 
>--build=x86_64-linux-gnu --host=x86_64-linux-gnu 
>--target=x86_64-linux-gnu
>Thread model: posix
>gcc version 5.5.0 20171010 (Ubuntu 5.5.0-12ubuntu1)
>COLLECT_GCC_OPTIONS='-v' '--version' '-mtune=generic' '-march=x86-64'
> /usr/lib/gcc/x86_64-linux-gnu/5/cc1 -quiet -v -imultiarch 
>x86_64-linux-gnu help-dummy -quiet -dumpbase help-dummy -mtune=generic 
>-march=x86-64 -auxbase help-dummy -version --version 
>-fstack-protector-strong -Wformat -Wformat-security -o /tmp/ccqnZumV.s
>GNU C11 (Ubuntu 5.5.0-12ubuntu1) version 5.5.0 20171010 (x86_64-linux-gnu)
>        compiled by GNU C version 5.5.0 20171010, GMP version 6.1.2, 
>MPFR version 4.0.1, MPC version 1.1.0
>warning: MPFR header version 4.0.1 differs from library version 4.0.2.
>GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
>COLLECT_GCC_OPTIONS='-v' '--version' '-mtune=generic' '-march=x86-64'
> as -v --64 --version -o /tmp/ccRPgs9J.o /tmp/ccqnZumV.s
>GNU assembler version 2.34 (x86_64-linux-gnu) using BFD version (GNU 
>Binutils for Ubuntu) 2.34
>GNU assembler (GNU Binutils for Ubuntu) 2.34
>Copyright (C) 2020 Free Software Foundation, Inc.
>This program is free software; you may redistribute it under the terms of
>the GNU General Public License version 3 or later.
>This program has absolutely no warranty.
>This assembler was configured for a target of `x86_64-linux-gnu'.
>COMPILER_PATH=/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/
>LIBRARY_PATH=/usr/lib/gcc/x86_64-linux-gnu/5/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib/:/lib/x86_64-linux-gnu/:/lib/../lib/:/usr/lib/x86_64-linux-gnu/:/usr/lib/../lib/:/usr/lib/gcc/x86_64-linux-gnu/5/../../../:/lib/:/usr/lib/
>COLLECT_GCC_OPTIONS='-v' '--version' '-mtune=generic' '-march=x86-64'
> /usr/lib/gcc/x86_64-linux-gnu/5/collect2 -plugin 
>/usr/lib/gcc/x86_64-linux-gnu/5/liblto_plugin.so 
>-plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper 
>-plugin-opt=-fresolution=/tmp/ccJLhs3y.res 
>-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s 
>-plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc 
>-plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id 
>--eh-frame-hdr -m elf_x86_64 --hash-style=gnu --as-needed 
>-dynamic-linker /lib64/ld-linux-x86-64.so.2 -pie -z now -z relro 
>--version 
>/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/Scrt1.o 
>/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o 
>/usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o 
>-L/usr/lib/gcc/x86_64-linux-gnu/5 
>-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu 
>-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib 
>-L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu 
>-L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. 
>/tmp/ccRPgs9J.o -lgcc --push-state --as-needed -lgcc_s --pop-state -lc 
>-lgcc --push-state --as-needed -lgcc_s --pop-state 
>/usr/lib/gcc/x86_64-linux-gnu/5/crtend.o 
>/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o
>collect2 version 5.5.0 20171010
>/usr/bin/ld -plugin /usr/lib/gcc/x86_64-linux-gnu/5/liblto_plugin.so 
>-plugin-opt=/usr/lib/gcc/x86_64-linux-gnu/5/lto-wrapper 
>-plugin-opt=-fresolution=/tmp/ccJLhs3y.res 
>-plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s 
>-plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc 
>-plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id 
>--eh-frame-hdr -m elf_x86_64 --hash-style=gnu --as-needed 
>-dynamic-linker /lib64/ld-linux-x86-64.so.2 -pie -z now -z relro 
>--version 
>/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/Scrt1.o 
>/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crti.o 
>/usr/lib/gcc/x86_64-linux-gnu/5/crtbeginS.o 
>-L/usr/lib/gcc/x86_64-linux-gnu/5 
>-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu 
>-L/usr/lib/gcc/x86_64-linux-gnu/5/../../../../lib 
>-L/lib/x86_64-linux-gnu -L/lib/../lib -L/usr/lib/x86_64-linux-gnu 
>-L/usr/lib/../lib -L/usr/lib/gcc/x86_64-linux-gnu/5/../../.. 
>/tmp/ccRPgs9J.o -lgcc --push-state --as-needed -lgcc_s --pop-state -lc 
>-lgcc --push-state --as-needed -lgcc_s --pop-state 
>/usr/lib/gcc/x86_64-linux-gnu/5/crtend.o 
>/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crtn.o
>GNU ld (GNU Binutils for Ubuntu) 2.34
>Copyright (C) 2020 Free Software Foundation, Inc.
>This program is free software; you may redistribute it under the terms of
>the GNU General Public License version 3 or (at your option) a later 
>version.
>This program has absolutely no warranty.
>
>Best Regards,
>Rong Chen

Hi Rong,

binutils (both GNU as and GNU ld) is new. It oughts to support
--compress-debug-sections=zlib . The failure looks strange to me.

Can you extract the gcc-5 command line building scripts/mod/empty.o
and run it manually? Also run gcc-5 -g -gz=zlib a.c -c on a trivial file and check whether `readelf -WS a.o`
has the section flag C ("compressed").


Regards,
