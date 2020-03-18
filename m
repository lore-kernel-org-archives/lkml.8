Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE9EC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B780206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cng4qUWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCRDTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:19:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34057 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRDTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:19:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so13116307pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LATsM3w3v18K3dd892tqslG+ZNCO9IM2/WaxTJhD3z0=;
        b=Cng4qUWhiNqqQRtN1Q4whNwobX7pps9GsRdlx1gRy9mugPcZs6AzzwG3lBH4veTUXh
         WiV2CSWX14jxTyDEp41mnk5CLLxxLkgk2DQPbNF6u8J8XG6qvdaNLsUUtOQej7iywBCr
         eq2hTANV78q40l207IvU9CEvpmy42f07vPNVjoo03gCAAnjRdgbNALTjpMbxgSPa9isF
         5z7JzR9lm93Oe7hkA7YyvS9/caraKfeff0/LHIT4egv1rmGmqXAeUDqPhkBt9mAI2jaN
         VW1G94fdERuWGQMosuVjG0VQuPJyzM7OdchZgjY5Bxirf8rydgEs+TV4hJxtNTCcLGxC
         T2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LATsM3w3v18K3dd892tqslG+ZNCO9IM2/WaxTJhD3z0=;
        b=fKem8FZMaKuKNfQZ8ipFGr8NZyJlfIT3KZktgvUhOjoM4rRjX+b4twgmZZ7R5fYJS2
         zprjGlA1fuMNcLSUVxr/I422TZGeJTTFne4P2G9KIxt0m36V+2H6iLCoXgrQIcTRLjSh
         fpqGarfRzE60WKXYYzOWykJlx3H3jl9uQcEJXNE9FssT5OykOz1ZSf2iHJuHZBHJHjge
         gIL9m4L1QgjNKMXw+TkFA0slaatjbzSXZtBQ+RsY1hn5sOAE3S62dR+v4BLk19hc6RPq
         oIhXB99j2ZyEPUFOrKlVfkj8hlzapbR1NPUpEx16h1p+ND4Ah+ZqqQEcb/8Q4Mfzqe83
         /T7g==
X-Gm-Message-State: ANhLgQ3cFA9PW8Hgd0wFDHHa2ani7WOrVwVoEa0c9FzAakSXh5DQTxS1
        ln2xc/67GiNWOa2PW58gEzuJSQ==
X-Google-Smtp-Source: ADFU+vvOFedwgcJUq9RXEcEF3Dr2UMN6YlAR8W1kY0vDv02EnRoovmuMiwFCILVmeCsSMYxhJ7EI9Q==
X-Received: by 2002:a63:c550:: with SMTP id g16mr2544012pgd.9.1584501578496;
        Tue, 17 Mar 2020 20:19:38 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id v59sm639160pjb.26.2020.03.17.20.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 20:19:37 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:19:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     ferar achkar <ferarachkar@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: perf: arm64: libunwind patch
Message-ID: <20200318031928.GA22966@leoy-ThinkPad-X240s>
References: <deb0d490-e2ad-40d5-f804-c51a91edc4d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <deb0d490-e2ad-40d5-f804-c51a91edc4d5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 17, 2020 at 06:29:05PM -0400, ferar achkar wrote:
> hi,
> please find attached a compile error fix.
> regards,

I checked this with the kernel 5.6.0-rc4, but cannot reproduce this
issue on my Arm64 board (DB410c) with Debian Buster.

Below is the GCC version I am using on the Arm64 board:

# gcc --version
gcc (Debian 8.3.0-6) 8.3.0

Thanks,
Leo

> ferar
> 
> ------------------
> 
> ferar@barbarian:~/renegade_rk3328/perf_core$ make -j4 ARCH=arm64 ....
> 
> ....
> 
> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h'
> differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
> diff -u tools/arch/arm64/include/uapi/asm/kvm.h
> arch/arm64/include/uapi/asm/kvm.h
> Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h'
> differs from latest version at 'include/uapi/asm-generic/mman-common.h'
> diff -u tools/include/uapi/asm-generic/mman-common.h
> include/uapi/asm-generic/mman-common.h
> 
> Auto-detecting system features:
> ...                         dwarf: [ on  ]
> ...            dwarf_getlocations: [ on  ]
> ...                         glibc: [ on  ]
> ...                          gtk2: [ OFF ]
> ...                      libaudit: [ on  ]
> ...                        libbfd: [ on  ]
> ...                        libcap: [ on  ]
> ...                        libelf: [ on  ]
> ...                       libnuma: [ OFF ]
> ...        numa_num_possible_cpus: [ OFF ]
> ...                       libperl: [ OFF ]
> ...                     libpython: [ OFF ]
> ...                     libcrypto: [ on  ]
> ...                     libunwind: [ on  ]
> ...            libdw-dwarf-unwind: [ on  ]
> ...                          zlib: [ on  ]
> ...                          lzma: [ on  ]
> ...                     get_cpuid: [ OFF ]
> ...                           bpf: [ on  ]
> ...                        libaio: [ on  ]
> ...                       libzstd: [ OFF ]
> ...        disassembler-four-args: [ on  ]
> 
> Makefile.config:497: No sys/sdt.h found, no SDT events are defined, please
> install systemtap-sdt-devel or systemtap-sdt-dev
> 
> ....
> 
>   CC       util/dwarf-regs.o
>   CC       util/unwind-libunwind-local.o
>   CC       util/unwind-libunwind.o
>   CC       util/libunwind/arm64.o
> util/libunwind/arm64.c:20:40: error: no previous prototype for
> ‘libunwind__arm64_reg_id’ [-Werror=missing-prototypes]
>  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
>                                         ^
> util/libunwind/../../arch/arm64/util/unwind-libunwind.c:11:5: note: in
> expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
>  int LIBUNWIND__ARCH_REG_ID(int regnum)
>      ^~~~~~~~~~~~~~~~~~~~~~
>   CC       util/zlib.o
>   CC       util/lzma.o
> util/libunwind/arm64.c:20:40: error: redundant redeclaration of
> ‘libunwind__arm64_reg_id’ [-Werror=redundant-decls]
>  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
>                                         ^
> /home/ferar/renegade_rk3328/linux-5.4.0-rc1/tools/perf/util/unwind.h:49:5:
> note: in expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
>  int LIBUNWIND__ARCH_REG_ID(int regnum);
>      ^~~~~~~~~~~~~~~~~~~~~~
> util/libunwind/arm64.c:20:40: note: previous definition of
> ‘libunwind__arm64_reg_id’ was here
>  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
>                                         ^
> util/libunwind/../../arch/arm64/util/unwind-libunwind.c:11:5: note: in
> expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
>  int LIBUNWIND__ARCH_REG_ID(int regnum)
>      ^~~~~~~~~~~~~~~~~~~~~~
>   CC       util/cap.o
>   CC       util/demangle-java.o
>   CC       util/demangle-rust.o
> ....
> 
> ----------------------------------------------------------------------
> 

> From 0c6bf617d5696dda28ecac776c09b3f5b3921526 Mon Sep 17 00:00:00 2001
> From: ferar achkar <ferarachkar@gmail.com>
> Date: Tue, 17 Mar 2020 18:15:37 -0400
> Subject: [PATCH] Fix Arm64 libunwind trivial compile error
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> fix trivial compile error 'no previous prototype for
> ‘libunwind__arm64_reg_id’' [-Werror=missing-prototypes], this error
> related to including userspace bundled 'unwind.h' instead of using
> perf's local version.
> ---
>  tools/perf/util/libunwind/arm64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
> index 6b4e5a089..fd26e612d 100644
> --- a/tools/perf/util/libunwind/arm64.c
> +++ b/tools/perf/util/libunwind/arm64.c
> @@ -21,7 +21,7 @@
>  #define LIBUNWIND__ARCH_REG_IP PERF_REG_ARM64_PC
>  #define LIBUNWIND__ARCH_REG_SP PERF_REG_ARM64_SP
>  
> -#include "unwind.h"
> +#include "../../util/unwind.h"
>  #include "libunwind-aarch64.h"
>  #include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
>  #include "../../arch/arm64/util/unwind-libunwind.c"
> -- 
> 2.17.1
> 

