Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859DDC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A0C206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G4V8TrrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgA3MkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:40:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34747 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgA3MkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:40:04 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130124001euoutp017da86bfc716c13bef78cbbd22a5b60a6~uqoOJo00a2601326013euoutp01P
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:40:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130124001euoutp017da86bfc716c13bef78cbbd22a5b60a6~uqoOJo00a2601326013euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580388001;
        bh=Jzdor6fDyEnMsChZ027tOaitTynBCI6a43ngD1bmh0o=;
        h=From:To:Cc:Subject:Date:References:From;
        b=G4V8TrrYGDftuvmy7lSwk8OS7dmash8BRuSalwNmgm19XznE5UE9oI7Jn1sQJNrR+
         TVrObNHktdSt6W8o0m8/lH3spkpk9ln1KCyZ3qh5mBJQnvhucyej9gtTPSNmgQ3R4F
         W9eLq52Pf9z6dXeZZwsdMTMq705orMwTmr2luD80=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130124000eucas1p1aa08fe80f3610b04dfecf70f6c348433~uqoN96rob1361413614eucas1p1-;
        Thu, 30 Jan 2020 12:40:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.69.61286.0AEC23E5; Thu, 30
        Jan 2020 12:40:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130124000eucas1p137943be0fe3e5e1eb45e705dc5c46431~uqoNuQkB42838028380eucas1p1g;
        Thu, 30 Jan 2020 12:40:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130124000eusmtrp29bd8676f25fb6eb1b0a30fbf98336b88~uqoNtltLd2643726437eusmtrp2W;
        Thu, 30 Jan 2020 12:40:00 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-63-5e32cea011e6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.EC.07950.0AEC23E5; Thu, 30
        Jan 2020 12:40:00 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200130124000eusmtip11b04f02223def1624a661e1cc2f980a8~uqoNjVG7W1920319203eusmtip1c;
        Thu, 30 Jan 2020 12:40:00 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [RFC PATCH 0/4] boot/loader: Load kernel directly from firmware
Date:   Thu, 30 Jan 2020 13:39:34 +0100
Message-Id: <20200130123934.3900-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOd0F54ziDPY8sbS4eWgFo8Wmx9dY
        LS7vmsNmMeP8PiYHFo/NS+o9+rasYvT4vEkugDmKyyYlNSezLLVI3y6BK2N1y3nGgnn6FVs+
        nGVvYJyp2sXIySEhYCLx9PYN1i5GLg4hgRWMEj/XTWCCcL4wSjTf+84I4XxmlLj8fwY7TMvs
        u4ehEssZJS68PsQO4TxnlDi6ZzYLSBWbgKNE/9ITrCC2iEC2xOSPX5hAbGYBe4mJs/6zgdjC
        Ah4S608/ArNZBFQldq/ax9zFyMHBK2Al8f5wMsQyeYnzvevAFvMKCEqcnPkEbDy/gJbEmqbr
        LBAj5SWat85mBrlBQuAzm8S8/+dYIZpdJFZua2CEsIUlXh3fAvWBjMT/nfOZQHZJCNRLTJ5k
        BtHbwyixbc4PFogaa4k7536xgdQwC2hKrN+lD1HuKNG2xAHC5JO48VYQ4gI+iUnbpjNDhHkl
        OtqEIGaoSKzr3wM1T0qi99UKqFs8JP4tes84gVFxFpK/ZiH5ZRbC2gWMzKsYxVNLi3PTU4sN
        81LL9YoTc4tL89L1kvNzNzECU8bpf8c/7WD8einpEKMAB6MSD6/HGaM4IdbEsuLK3EOMEhzM
        SiK8oq6GcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUw
        Cm//8f7NX49fByr5hV2//Nty2GjZ1Zzrdbbu32Nt38/QuS30cAvbWreqX8Z7Lmibzoo8XNv+
        f1lPv96/r7cirhqceD4l8wXPUfslR433e2bPdT/THChX8S/6umHfHcuqFoN1kTzO6yoESoMN
        LbhFj5xKeWv3Z6PfXIlD8va71xx+m/k427nphRJLcUaioRZzUXEiALtU5BsVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xu7oLzhnFGdz9rW5x89AKRotNj6+x
        WlzeNYfNYsb5fUwOLB6bl9R79G1ZxejxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbqlvOMBfP0K7Z8OMvewDhTtYuRk0NCwERi9t3D
        jF2MXBxCAksZJTac+craxcgBlJCSWDk3HaJGWOLPtS42iJqnjBIX/x9gA0mwCThK9C89wQpi
        iwjkSlw7dJQdxGYWsJeYOOs/WI2wgIfE+tOPwGwWAVWJ3av2MYPM5xWwknh/OBlivrzE+d51
        YK28AoISJ2c+YQEpYRZQl1g/TwgkzC+gJbGm6ToLxHR5ieats5knMArMQtIxC6FjFpKqBYzM
        qxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIDftuxn1t2MHa9Cz7EKMDBqMTD63HGKE6INbGs
        uDL3EKMEB7OSCK+oq2GcEG9KYmVValF+fFFpTmrxIUZToG8mMkuJJucDozGvJN7Q1NDcwtLQ
        3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAMjX/6JY+lNpY9dJ07e7JIx7bv7zf5Z
        /9TfyR6Lipfp1XQq+TRTstDtRJbqsz9Kbp+erqpfL632cZuJ2UMDyeUyfx79Px0i73fE4P7l
        hZHxNjLS7xm4QptZP5zTKD0cfaS38tIFrtda7sv8Doc9Slq5wjAj9Kbyhpo10U5J/Ozzrgpu
        Ewz2rXunxFKckWioxVxUnAgAImLD3Y4CAAA=
X-CMS-MailID: 20200130124000eucas1p137943be0fe3e5e1eb45e705dc5c46431
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200130124000eucas1p137943be0fe3e5e1eb45e705dc5c46431
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130124000eucas1p137943be0fe3e5e1eb45e705dc5c46431
References: <CGME20200130124000eucas1p137943be0fe3e5e1eb45e705dc5c46431@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is a PoC showing, it is possible and advantageous to
integrate platform setup code in the kernel tree instead of maintaining
it in a separate bootloader project.

Bringing up a new ARM platform today requires developing the following
pieces code in both bootloader and kernel:

+ platform setup (DRAM, minimal set of clocks and PMICs etc)
  - minimal setup in bootloader
  - full setup in kernel
+ device drivers (storage, network interface, display)
  - in both bootloader and kernel

We've noticed that most code required in bootloader can be ported from
Linux. This isn't, however, effortless. We also consider further
maintenance of two copies of code an unnecessary burden. Making platform
setup code a part of kernel source tree makes it possible to reuse existing
Linux drivers in bootloading environment as well as to avoid creating
and maintainig two different drivers for new devices.

The following patches enables building Linux image that is loadable
directly by Odroid XU4's firmware (bl2). The goal for such arrangement
is to use Linux as a boot loader that later runs a full OS using kexec.

Hardkernel, the vendor of Odroid XU4, provides signed, and thus,
cumbersome to replace, platform setup code (bl1 and bl2). We decided not
to replace them, but rather make the kernel loadable by the bl2 code by
adding only a tiny amount of code to set up the consol. The kernel
needs, however, to be small enough to be loaded succesfully (1 MiB).

The patchset also provides hsinit (in tools/hsinit) userland program,
which is a tiny init program that extracts designated archive to
initramfs and executes /init. At the moment any initramfs image can be
used at this stage.

Although hsinit can be linked against glibc it makes little sense
because together with the kernel it wont fit in 1 MiB. Instead it is
recommended to link hsinit against musl libc. Install musl from your OS
vendor or follow the upstream instructions. With musl available enter
tools/hsinit and run the following commands.

--8<---------------cut here---------------start------------->8---
wget -P vendor/ https://libarchive.org/downloads/libarchive-3.3.2.tar.gz
wget -P vendor/ http://prdownloads.sourceforge.net/libpng/zlib-1.2.11.tar.gz

./bootstrap

MUSL_DIR=/usr/lib/arm-linux-musleabi/ \
GCC_CROSS_DIR=/usr/lib/gcc-cross/arm-linux-gnueabi/8/ \
CPPFLAGS='-nostdinc -isystem /usr/include/arm-linux-musleabi/' \
CFLAGS='-mthumb -Os -ffunction-sections -fdata-sections' \
LIBARCHIVE_CPP_FLAGS=-I/usr/include/arm-linux-musleabi/ \
LIBARCHIVE_C_FLAGS=$CFLAGS \
ZLIB_C_FLAGS=$CFLAGS \
LDFLAGS="-nostdlib -L${MUSL_DIR}/ -L${GCC_CROSS_DIR}/ ${MUSL_DIR}/crt1.o  ${MUSL_DIR}/crti.o  ${GCC_CROSS_DIR}/crtbegin.o -Wl,--gc-sections -Wl,--start-group  ${GCC_CROSS_DIR}/libgcc.a  ${GCC_CROSS_DIR}/libgcc_eh.a -Wl,--end-group ${GCC_CROSS_DIR}/crtend.o  ${MUSL_DIR}/crtn.o -s"  \
LIBS="-lc -lgcc" \
./configure --enable-local-libraries --host=arm-linux-gnueabi --enable-static

make
--8<---------------cut here---------------end--------------->8---

To build bootImage file that is loadable by Odroid XU4's bl2 the following
commands need to be issued (CROSS_COMPILE and ARCH ommited)

--8<---------------cut here---------------start------------->8---
make odroidxu4_bootloader_defconfig
make dtbs
make bootImage
--8<---------------cut here---------------end--------------->8---

The resulting arch/arm/boot/bootImage should be renamed to u-boot-mmc.bin and
flashed onto an SD or eMMC card with sd_fusing scritp.




Łukasz Stelmach (4):
  scripts/dtc: update fdtget.c to upstream version v1.4.7-57-gf267e674d145
  scripts: add get_console_base.pl
  Add tools/hsinit
  boot/loader: Enable building bootloader replacement for Odroid XU4

 arch/arm/Kconfig                              |   8 +
 arch/arm/Makefile                             |   8 +-
 arch/arm/boot/Makefile                        |  17 +
 arch/arm/boot/loader/Kconfig                  |  23 ++
 arch/arm/boot/loader/Makefile                 |  42 +++
 arch/arm/boot/loader/odroid-console.c         | 136 ++++++++
 arch/arm/boot/loader/odroid-crt0.S            |  40 +++
 arch/arm/boot/loader/piggy.S                  |  14 +
 arch/arm/boot/loader/vectors.S                | 112 +++++++
 arch/arm/boot/loader/vmlinux.lds              |  17 +
 .../configs/odroidxu4_bootloader_defconfig    | 127 ++++++++
 scripts/dtc/.gitignore                        |   4 +
 scripts/dtc/Makefile                          |   5 +
 scripts/dtc/fdtget.c                          | 125 ++++----
 scripts/dtc/update-dtc-source.sh              |   4 +-
 scripts/get_console_base.pl                   |  26 ++
 tools/hsinit/Makefile.am                      |  29 ++
 tools/hsinit/README.org                       |  56 ++++
 tools/hsinit/bootstrap                        |   7 +
 tools/hsinit/configure.ac                     | 128 ++++++++
 tools/hsinit/hsinit.c                         | 299 ++++++++++++++++++
 tools/hsinit/vendor/.gitignore                |   5 +
 tools/hsinit/vendor/SHA256SUMS                |   2 +
 23 files changed, 1177 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/boot/loader/Kconfig
 create mode 100644 arch/arm/boot/loader/Makefile
 create mode 100644 arch/arm/boot/loader/odroid-console.c
 create mode 100644 arch/arm/boot/loader/odroid-crt0.S
 create mode 100644 arch/arm/boot/loader/piggy.S
 create mode 100644 arch/arm/boot/loader/vectors.S
 create mode 100644 arch/arm/boot/loader/vmlinux.lds
 create mode 100644 arch/arm/configs/odroidxu4_bootloader_defconfig
 create mode 100755 scripts/get_console_base.pl
 create mode 100644 tools/hsinit/Makefile.am
 create mode 100644 tools/hsinit/README.org
 create mode 100755 tools/hsinit/bootstrap
 create mode 100644 tools/hsinit/configure.ac
 create mode 100644 tools/hsinit/hsinit.c
 create mode 100644 tools/hsinit/vendor/.gitignore
 create mode 100644 tools/hsinit/vendor/SHA256SUMS

-- 
2.20.1

