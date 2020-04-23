Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB064C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2C20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNYFFwO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgDWQdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729423AbgDWQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:33:16 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB050C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:33:14 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id i9so1448477ool.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+P4exUzF4xLf5Y60Fmf3k7cdV4ADYZbeIV1x1d0wOko=;
        b=MNYFFwO71GxTHjfwhwqDqQUViIZw7WnUjWaZYoPQ5OAhdhHzbLi34HtdRffTnlnSsV
         bG7hZOz8t0SJsZ/AUrCDCwN4eNJ/e4O7StVzNnCGnnz/rpcONRo2QFrg+0zYKQnJIIa0
         VsQr44874KxvDeGyDFGmb6bupmXGeJz/66605bXrAT87njr2yse3aDnKS4QtFrTMBuS/
         xx1KTHq0l4G8oFdv+05VFPOp6X9LsbhjNRp0gbuMrBSqSaNmqrGr67Xa+WJhqEQwDVH3
         /3x0XgFHZ4AHERqymDlvLA3O5aSyfWPsLaTwf30f5r2oy+K+coP5dnfRucDKCg6r+2mr
         qx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+P4exUzF4xLf5Y60Fmf3k7cdV4ADYZbeIV1x1d0wOko=;
        b=VFJB2IWwFeIPtgAKyeMOOCNp3omZaIBhtoogKS8KEwsTkfx0opYru0/kJ31psEjjjo
         s4cpEZUxWX1MFa9fV8eMn5HgdVflEYxwWtaKtL4z975Pazf2GeSWnYz2k46rfOnhb9AZ
         XA6f/VdDShSqRYVuuchTjwq2KaJV475jIz7iTY5DLq6zrRyBxTdCUXs0uH4JIRBchuT0
         1ajanvkvnyAfP8UIR95U8OYhGVelDeUd/czbVm4vfpuK+Ln+CSyjqAk/a08xDrgCXY40
         HZkIkSVcWclxKYoKDAeMSkTGbfFF2Fr0VKpiQJBMHcSMiwD02tADK0bWN1oYWYZUmr1X
         YHQw==
X-Gm-Message-State: AGi0PuYPgXRXByi0gp/Waws8PsDQWR62GSROwxDAGmYeYKJAg8D+REYS
        CZ0aoCWodOc++JiqmFmQ6E3c80ssRg0=
X-Google-Smtp-Source: APiQypJVM26C/ljYr3jxqCuUV7DPpi5sh5YyUwSHv/XwZUBfyTYt/PBaL4ICgxA5YQb5WYKgkE/+Qg==
X-Received: by 2002:a4a:bb10:: with SMTP id f16mr4021122oop.43.1587659593810;
        Thu, 23 Apr 2020 09:33:13 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k12sm764896oik.30.2020.04.23.09.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 09:33:12 -0700 (PDT)
Date:   Thu, 23 Apr 2020 09:33:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Dirk Mueller <dmueller@suse.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast
 in a inline asm context requiring an l-value: remove the cast or build with
 -fheinous-gnu-extensions
Message-ID: <20200423163311.GA6774@ubuntu-s3-xlarge-x86>
References: <202004232041.oMgr2Xiq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004232041.oMgr2Xiq%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 08:00:47PM +0800, kbuild test robot wrote:
> Hi Dirk,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c578ddb39e565139897124e74e5a43e56538cb33
> commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> date:   4 weeks ago
> config: powerpc-randconfig-a001-20200423 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project bbf386f02b05db017fda66875cc5edef70779244)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         git checkout e33a814e772cdc36436c8c188d8c42d019fda639
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                    umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    1 error generated.
> --
> >> lib/mpi/generic_mpih-mul2.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                    umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    1 error generated.
> --
> >> lib/mpi/generic_mpih-mul3.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                    umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
>                    ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    1 error generated.
> --
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:750:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:751:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:757:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:758:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:764:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:765:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:771:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:772:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
> >> lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:778:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:99:20: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                    sub_ddmmss(n1, n0, n1, n0, d1, d0);
>                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:779:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:18: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:725:21: note: expanded from macro 'add_ssaaaa'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:22: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~
>    lib/mpi/longlong.h:726:20: note: expanded from macro 'add_ssaaaa'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:18: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:732:21: note: expanded from macro 'add_ssaaaa'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:22: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~
>    lib/mpi/longlong.h:733:20: note: expanded from macro 'add_ssaaaa'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:18: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~^~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:739:21: note: expanded from macro 'add_ssaaaa'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:120:22: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                                    add_ssaaaa(n1, n0, r - d0,
>                                                    ~~~~~~~~~~~~~~~^~~~~~~~~~~
>    lib/mpi/longlong.h:740:20: note: expanded from macro 'add_ssaaaa'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:129:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                            umul_ppmm(n1, n0, d0, q);
>                                            ~~~~~~~~~~^~~~~~~~~~~~~~
>    lib/mpi/longlong.h:790:20: note: expanded from macro 'umul_ppmm'
>            : "=r" ((USItype) ph) \
>                    ~~~~~~~~~~^~
>    lib/mpi/mpih-div.c:137:17: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                            sub_ddmmss(n1, n0, n1, n0, 0, d0);
>                                            ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:750:21: note: expanded from macro 'sub_ddmmss'
>                    : "=r" ((USItype)(sh)), \
>                            ~~~~~~~~~~^~~
>    lib/mpi/mpih-div.c:137:21: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
>                                            sub_ddmmss(n1, n0, n1, n0, 0, d0);
>                                            ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
>    lib/mpi/longlong.h:751:20: note: expanded from macro 'sub_ddmmss'
>                    "=&r" ((USItype)(sl)) \
>                           ~~~~~~~~~~^~~
>    fatal error: too many errors emitted, stopping now [-ferror-limit=]
>    20 errors generated.
> 
> vim +37 lib/mpi/generic_mpih-mul1.c

Obviously not caused by that commit but I sent a patch a week and a half
ago:

https://lore.kernel.org/lkml/20200413195041.24064-1-natechancellor@gmail.com/

https://github.com/ClangBuiltLinux/linux/issues/991

Cheers,
Nathan
