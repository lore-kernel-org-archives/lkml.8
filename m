Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AEBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DA120738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+Ye99eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgCQW3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:29:12 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42793 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQW3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:29:12 -0400
Received: by mail-wr1-f52.google.com with SMTP id v11so27878762wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=QmEcBWgjpuVkinmTKkZC0iNXZQ7u/zp6+iU7/ZMx1s0=;
        b=L+Ye99ehBJRLs2n/47a3Y+pkHjQO95VJERthGNVavLhDyxm/MLbICjwqOtcxURmgn5
         OLZbWzhsABGPApdaqfVLu0vepDxgXgrd+/eR7tN0LYja8t1y0dy7wUjomF7ZNIHQiVQC
         wWxlHw8Dpgk7zvxv2CsI1nG5bvs7kOxbhBCqSqIJB+eWq47IOouZcJUuDKcbZ5Bjr7mD
         z4vHWk5bt3Hf22vRpbOVrvOz3ZoiLzUSljyj/Qipxuq0J07DQbJfyPN2IgP8t7OEL8AY
         43wylyeX3Kv+/MSeI2gSVjFsiGuG9BoN6jCpDsR4q9pNdmkqV9pyg88Fly/Av7u6V9o7
         0QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=QmEcBWgjpuVkinmTKkZC0iNXZQ7u/zp6+iU7/ZMx1s0=;
        b=QjmgRVSJDGkxO0peMDXztRuq21mhJ5UpgTxkfeqQvjMb9jX6BNyfSp12xGdIvQ0v9+
         m+lH4S/wXK3ac1StsSw3za+WW1RUk7rp/KBf6d3MW0Dj7G+JqBjcpiQ02Af5VxWfcJmc
         bq3BRIeiuS39/m2RVI/FM5BR6JsfCRXf+k/gCAiMcXsYXmYsbM4NbllosjMK6U/nXlMx
         VGxY9b/sm29Kg0omwQAQY0vsZB8Fqym3ZJlaMTFtnM7gv8IvwSjDY1OWbZF23Q2TcWVr
         aWukpqVELGlRDUNdanWa5v9dx33HCsqNcxzvYbltjYBMXcOkn3HHhTAzE+MJ14dO9PRX
         7hXA==
X-Gm-Message-State: ANhLgQ0QepXmbLzdR05x+Q+pyTaeqnq51pQUHjSHotEWaa/WGKTnXokl
        GylNHQRtfUKdiVNw6UNvb5mNs6EQrDM=
X-Google-Smtp-Source: ADFU+vuB/7SvpJYsGLi+PygYKYnxj2wXc2yAO9sbrzFPRXCX98LzUyEeeoPqdBR8AvymCBLZehtxSQ==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr1129352wrw.383.1584484149687;
        Tue, 17 Mar 2020 15:29:09 -0700 (PDT)
Received: from [192.168.1.159] (mtrlpq3125w-lp130-01-174-91-231-91.dsl.bell.ca. [174.91.231.91])
        by smtp.gmail.com with ESMTPSA id p10sm6046250wru.4.2020.03.17.15.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 15:29:08 -0700 (PDT)
From:   ferar achkar <ferarachkar@gmail.com>
Subject: perf: arm64: libunwind patch
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <deb0d490-e2ad-40d5-f804-c51a91edc4d5@gmail.com>
Date:   Tue, 17 Mar 2020 18:29:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1642366C7F0A923ADE9BAC2E"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1642366C7F0A923ADE9BAC2E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

hi,
please find attached a compile error fix.
regards,

ferar

------------------

ferar@barbarian:~/renegade_rk3328/perf_core$ make -j4 ARCH=arm64 ....

....

Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' 
differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
diff -u tools/arch/arm64/include/uapi/asm/kvm.h 
arch/arm64/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 
'tools/include/uapi/asm-generic/mman-common.h' differs from latest 
version at 'include/uapi/asm-generic/mman-common.h'
diff -u tools/include/uapi/asm-generic/mman-common.h 
include/uapi/asm-generic/mman-common.h

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ OFF ]
...        disassembler-four-args: [ on  ]

Makefile.config:497: No sys/sdt.h found, no SDT events are defined, 
please install systemtap-sdt-devel or systemtap-sdt-dev

....

   CC       util/dwarf-regs.o
   CC       util/unwind-libunwind-local.o
   CC       util/unwind-libunwind.o
   CC       util/libunwind/arm64.o
util/libunwind/arm64.c:20:40: error: no previous prototype for 
‘libunwind__arm64_reg_id’ [-Werror=missing-prototypes]
  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
                                         ^
util/libunwind/../../arch/arm64/util/unwind-libunwind.c:11:5: note: in 
expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
  int LIBUNWIND__ARCH_REG_ID(int regnum)
      ^~~~~~~~~~~~~~~~~~~~~~
   CC       util/zlib.o
   CC       util/lzma.o
util/libunwind/arm64.c:20:40: error: redundant redeclaration of 
‘libunwind__arm64_reg_id’ [-Werror=redundant-decls]
  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
                                         ^
/home/ferar/renegade_rk3328/linux-5.4.0-rc1/tools/perf/util/unwind.h:49:5: 
note: in expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
  int LIBUNWIND__ARCH_REG_ID(int regnum);
      ^~~~~~~~~~~~~~~~~~~~~~
util/libunwind/arm64.c:20:40: note: previous definition of 
‘libunwind__arm64_reg_id’ was here
  #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arm64_reg_id(regnum)
                                         ^
util/libunwind/../../arch/arm64/util/unwind-libunwind.c:11:5: note: in 
expansion of macro ‘LIBUNWIND__ARCH_REG_ID’
  int LIBUNWIND__ARCH_REG_ID(int regnum)
      ^~~~~~~~~~~~~~~~~~~~~~
   CC       util/cap.o
   CC       util/demangle-java.o
   CC       util/demangle-rust.o
....

----------------------------------------------------------------------


--------------1642366C7F0A923ADE9BAC2E
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


--------------1642366C7F0A923ADE9BAC2E--
