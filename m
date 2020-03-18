Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F1C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581A82076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdLXnW6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCRXrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:47:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40428 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:47:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so570614wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=1ZwkJTSe/N0nx9bzPX4TSnRpe18i81HZN5KJN9b0wCM=;
        b=RdLXnW6eKzmMX1iQSIXwPp+rasw+IFCms1ipYrpQlJUmuh0D1FEdahFybUUM7gl3TF
         TUsSlqnStSPDV810rt5bQKZa+EBptYiHjqhY0qL6eKvN/KvheExbN0nco6itoSSirkvx
         I3n0TMNQ4eQ7gTMVsAGCccOq19FoIqaGPgCKoTrlMPyLhSRk4IRcx//a23OdEqJdiRPu
         8Q8apDiJbbB+OLcvXVTA8s1LM3bdf/j/Jo6A1f1WvzbrD7nbYAYaVypXzmhT0w/4QnGO
         mHH0dYuIu9XsL+IH13P19HpZn5izz8tLRTSkmlk8rhBCyOR5d0zZWEFUvsHxMpML2DaY
         1yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=1ZwkJTSe/N0nx9bzPX4TSnRpe18i81HZN5KJN9b0wCM=;
        b=nGNXFtgVG/0rmvgex5rqmM12Kj4IPGbwSxLc9rwDMrVj8vdLj2DLglmwgZ3+yR4q8z
         e+27ANy19BmNw8xMLAWpefIYMh/YxcHtK78SMiDtpvBF5E8+XqfCTUxS+CCKiy8KHWHh
         iQkIInX5rU5DG//QXb8dVsWc9Mm9BUymU1FzcixhF3PlNiQUVKu0SKMWbwLjNcEdKiWM
         4sCQt0iv9sV/8BMzf9NXj3FeueXgfUtU2UIDQ3ZZaWAxNTCqxwwynScPadXY6sqj/ey8
         jHQ0W+snNTD6QzuNO+BIaQwYwG+08+ZP3HD1Z0aCVjw6KGBMaSKOMNfoQ4tSdvUXR7IY
         Qgbw==
X-Gm-Message-State: ANhLgQ2QJLwt82P02QLeMFUG1qoMRDHt8GnLn6njAz9ws4dqFH3Z/3UE
        gBB+U+fUaq7wJi8CZ9+LZmXrHcUBjww=
X-Google-Smtp-Source: ADFU+vvoL+9peYYQ1hIU3SpDePFBEJsYjd8qdOeuNNVf8KxT35yeK3WJD2ZtnkRzi1BgA2dCtqWXEg==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr421722wrv.5.1584575271476;
        Wed, 18 Mar 2020 16:47:51 -0700 (PDT)
Received: from [192.168.1.159] (mtrlpq3125w-lp130-01-174-91-231-91.dsl.bell.ca. [174.91.231.91])
        by smtp.gmail.com with ESMTPSA id t193sm548257wmt.14.2020.03.18.16.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 16:47:50 -0700 (PDT)
Subject: Re: perf: arm64: libunwind patch
To:     Leo Yan <leo.yan@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
References: <deb0d490-e2ad-40d5-f804-c51a91edc4d5@gmail.com>
 <20200318031928.GA22966@leoy-ThinkPad-X240s>
From:   ferar achkar <ferarachkar@gmail.com>
Message-ID: <f7f55fd3-df95-6858-18e3-f82041fcefb7@gmail.com>
Date:   Wed, 18 Mar 2020 19:47:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318031928.GA22966@leoy-ThinkPad-X240s>
Content-Type: multipart/mixed;
 boundary="------------D3E40FFF4EC395A06ADDCDDF"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D3E40FFF4EC395A06ADDCDDF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Leo,

you are doing a native build, while the compile error I am having shows 
when cross compiling on x86_64 Linux Host:

ferar@barbarian:~/renegade_rk3328/perf_core$ make -j4 ARCH=arm64 
CROSS_COMPILE=/home/ferar/vim3/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu- 
-C tools/perf

ferar@barbarian:~/renegade_rk3328/perf_core$ head Makefile
# SPDX-License-Identifier: GPL-2.0
VERSION = 5
PATCHLEVEL = 6
SUBLEVEL = 0
EXTRAVERSION = -rc6
NAME = Kleptomaniac Octopus

...

ferar@barbarian:~/renegade_rk3328/perf_core$

regard,

ferar

On 2020-03-17 11:19 p.m., Leo Yan wrote:
> Hi,
>
> On Tue, Mar 17, 2020 at 06:29:05PM -0400, ferar achkar wrote:
>> hi,
>> please find attached a compile error fix.
>> regards,
> I checked this with the kernel 5.6.0-rc4, but cannot reproduce this
> issue on my Arm64 board (DB410c) with Debian Buster.
>
> Below is the GCC version I am using on the Arm64 board:
>
> # gcc --version
> gcc (Debian 8.3.0-6) 8.3.0
>
> Thanks,
> Leo
>
>> ferar
>>
>> ------------------
>>
>> ferar@barbarian:~/renegade_rk3328/perf_core$ make -j4 ARCH=arm64 ....
>>
>> ....
>>
>> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h'
>> differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
>> diff -u tools/arch/arm64/include/uapi/asm/kvm.h
>> arch/arm64/include/uapi/asm/kvm.h
>> Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/mman-common.h'
>> differs from latest version at 'include/uapi/asm-generic/mman-common.h'
>> diff -u tools/include/uapi/asm-generic/mman-common.h
>> include/uapi/asm-generic/mman-common.h
>>
>> Auto-detecting system features:
>> ...                         dwarf: [ on  ]
>> ...            dwarf_getlocations: [ on  ]
>> ...                         glibc: [ on  ]
>> ...                          gtk2: [ OFF ]
>> ...                      libaudit: [ on  ]
>> ...                        libbfd: [ on  ]
>> ...                        libcap: [ on  ]
>> ...                        libelf: [ on  ]
>> ...                       libnuma: [ OFF ]
>> ...        numa_num_possible_cpus: [ OFF ]
>> ...                       libperl: [ OFF ]
>> ...                     libpython: [ OFF ]
>> ...                     libcrypto: [ on  ]
>> ...                     libunwind: [ on  ]
>> ...            libdw-dwarf-unwind: [ on  ]
>> ...                          zlib: [ on  ]
>> ...                          lzma: [ on  ]
>> ...                     get_cpuid: [ OFF ]
>> ...                           bpf: [ on  ]
>> ...                        libaio: [ on  ]
>> ...                       libzstd: [ OFF ]
>> ...        disassembler-four-args: [ on  ]
>>
>> Makefile.config:497: No sys/sdt.h found, no SDT events are defined, please
>> install systemtap-sdt-devel or systemtap-sdt-dev
>>
>> ....
>>
>>    CC       util/dwarf-regs.o
>>    CC       util/unwind-libunwind-local.o
>>    CC       util/unwind-libunwind.o
>>    CC       util/libunwind/arm64.o
>> util/libunwind/arm64.c:20:40: error: no previous prototype for
>> ‘libunwind__arm64_reg_id’ [-Werror=missing-prototypes]
>>   #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
>>                                          ^
>> util/libunwind/../../arch/arm64/util/unwind-libunwind.c:11:5: note: in
>> expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
>>   int LIBUNWIND__ARCH_REG_ID(int regnum)
>>       ^~~~~~~~~~~~~~~~~~~~~~
>>    CC       util/zlib.o
>>    CC       util/lzma.o
>> util/libunwind/arm64.c:20:40: error: redundant redeclaration of
>> ‘libunwind__arm64_reg_id’ [-Werror=redundant-decls]
>>   #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
>>                                          ^
>> /home/ferar/renegade_rk3328/linux-5.4.0-rc1/tools/perf/util/unwind.h:49:5:
>> note: in expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
>>   int LIBUNWIND__ARCH_REG_ID(int regnum);
>>       ^~~~~~~~~~~~~~~~~~~~~~
>> util/libunwind/arm64.c:20:40: note: previous definition of
>> ‘libunwind__arm64_reg_id’ was here
>>   #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
>>                                          ^
>> util/libunwind/../../arch/arm64/util/unwind-libunwind.c:11:5: note: in
>> expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
>>   int LIBUNWIND__ARCH_REG_ID(int regnum)
>>       ^~~~~~~~~~~~~~~~~~~~~~
>>    CC       util/cap.o
>>    CC       util/demangle-java.o
>>    CC       util/demangle-rust.o
>> ....
>>
>> ----------------------------------------------------------------------
>>
>>  From 0c6bf617d5696dda28ecac776c09b3f5b3921526 Mon Sep 17 00:00:00 2001
>> From: ferar achkar <ferarachkar@gmail.com>
>> Date: Tue, 17 Mar 2020 18:15:37 -0400
>> Subject: [PATCH] Fix Arm64 libunwind trivial compile error
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> fix trivial compile error 'no previous prototype for
>> ‘libunwind__arm64_reg_id’' [-Werror=missing-prototypes], this error
>> related to including userspace bundled 'unwind.h' instead of using
>> perf's local version.
>> ---
>>   tools/perf/util/libunwind/arm64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
>> index 6b4e5a089..fd26e612d 100644
>> --- a/tools/perf/util/libunwind/arm64.c
>> +++ b/tools/perf/util/libunwind/arm64.c
>> @@ -21,7 +21,7 @@
>>   #define LIBUNWIND__ARCH_REG_IP PERF_REG_ARM64_PC
>>   #define LIBUNWIND__ARCH_REG_SP PERF_REG_ARM64_SP
>>   
>> -#include "unwind.h"
>> +#include "../../util/unwind.h"
>>   #include "libunwind-aarch64.h"
>>   #include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
>>   #include "../../arch/arm64/util/unwind-libunwind.c"
>> -- 
>> 2.17.1
>>

--------------D3E40FFF4EC395A06ADDCDDF
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Fix-Arm64-libunwind-trivial-compile-error.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-Fix-Arm64-libunwind-trivial-compile-error.patch"

From 0c6bf617d5696dda28ecac776c09b3f5b3921526 Mon Sep 17 00:00:00 2001
From: ferar achkar <ferarachkar@gmail.com>
Date: Tue, 17 Mar 2020 18:15:37 -0400
Subject: [PATCH] Fix Arm64 libunwind trivial compile error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fix trivial compile error 'no previous prototype for
‘libunwind__arm64_reg_id’' [-Werror=missing-prototypes], this error
related to including userspace bundled 'unwind.h' instead of using
perf's local version.
---
 tools/perf/util/libunwind/arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
index 6b4e5a089..fd26e612d 100644
--- a/tools/perf/util/libunwind/arm64.c
+++ b/tools/perf/util/libunwind/arm64.c
@@ -21,7 +21,7 @@
 #define LIBUNWIND__ARCH_REG_IP PERF_REG_ARM64_PC
 #define LIBUNWIND__ARCH_REG_SP PERF_REG_ARM64_SP
 
-#include "unwind.h"
+#include "../../util/unwind.h"
 #include "libunwind-aarch64.h"
 #include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
 #include "../../arch/arm64/util/unwind-libunwind.c"
-- 
2.17.1


--------------D3E40FFF4EC395A06ADDCDDF--
