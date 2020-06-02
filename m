Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE111C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870CB206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eVm0Fqey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgFBQRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:17:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39361 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgFBQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:17:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200602161738euoutp012f830a446b0c290c9a3deb84cd36938b~UxloDu9f12656226562euoutp01i
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200602161738euoutp012f830a446b0c290c9a3deb84cd36938b~UxloDu9f12656226562euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591114658;
        bh=j/PSbzf6lrcO66laTAdT7EAr/x351R/C6wzGDMCSIm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVm0FqeyqFN3D8I3XhNlFEg/3JPG9UgvatIugb9gaabwYB96c5Q+ikTtyarbd56P1
         nBlq6WmE5UgUEMCpB+dF/A0srCtbahjb76sqX/TiJxhffLkefNlJGG40KrP5TojYgA
         fqeOIP3mV/rheJI5OqL3SqVyIzPyLV8vE0DPq5Hc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602161737eucas1p2904ac203291fee2a3e53bd6300fc2800~UxlnaC1Bp1812718127eucas1p2x;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.81.60679.1AB76DE5; Tue,  2
        Jun 2020 17:17:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602161737eucas1p241dd0e0a9b5eea7c5d5774c46b3c570b~UxlnCnuci1103811038eucas1p2T;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602161737eusmtrp19e8a12671829c8af45fcf9e379bc087b~UxlnCAFO32876728767eusmtrp1M;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-9d-5ed67ba17c13
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.29.07950.1AB76DE5; Tue,  2
        Jun 2020 17:17:37 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602161736eusmtip13d171833d1a9fdf7a556e537819b2626~Uxlm19sc02213922139eusmtip1i;
        Tue,  2 Jun 2020 16:17:36 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 0/5] kexec_file_load() for arm
Date:   Tue,  2 Jun 2020 18:17:26 +0200
Message-Id: <20200602161731.23033-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVBMYRTGvXv33r0tm+vKOJMmMzsxo6Hka64pKcPMNYMY/GOIpatSu+3c
        Ld+0NCMSZclHGSMfUxZLu7Vqq5HN1GpJa1lFqFlCpjTksy/t3gz/Pec9v+c558y8JEa/xv3J
        RFUqx6sUyXJCKjbX/Xo8o3CPK3bmQOtkpuTsLZzRGWpETMuBShHz8KiSabEWI8boduGM03Ke
        YKx51Yi5ef+VhGlva8aZ64MNiOnJHRIx/Xd/iRmTMQ+L8mWdLgfGFmgdYnZA/wFjLxrTWKP+
        CMG2uqoItruxUcKarqSzuT1dBHu8VI/Yr8bAlaPXSSPiuOTE7RwfGrlJmvDG1SlRV8t2Vtu0
        Ii2qk2YhHxKoOXDvfZ0kC0lJmipG0GDVE0LRi6CmYgATiq8IyvsKsL+WnIqmkUYRghfvukeK
        9wiednUQHoqgoiHnqg33NPyobyKw5GV6gzHqKYL2u2aRhxpPhUFbbYc3V0xNgZwep9ijZVQ4
        /LhdQgjzJkNm0R2v9qEioMb+RSQw4+DBubdefiwVDDcOPvdqbJjPKCvwrgTUCRKGmj7jQtBi
        +N7+c0SPh876UomgA8B+MnvYTA7rdDipmyd4sxGYz/8UC0w4tDb+JjwMRk2DW5ZQ4TkaKvtO
        4YLVF5q7xgkr+ILOfAYTnmVw+BAt0EFgyKkaCfSHY53FKBfJ8/87Jv+/A/L/zbqIMD2ayKVp
        lPGcZpaK2xGiUSg1aar4kC0pSiMa/nX2wfrecmTp32xFFInkY2Qzw1yxNK7YrtmltCIgMbmf
        bNEjeywti1Ps2s3xKRv5tGROY0WTSLF8omz2pY8baCpekcolcZya4/92RaSPvxalXIiOyWqY
        evnhwtShspexfmsin/jVrm/avy+7eZPtRYAs16Zz0BWOuNkTHqkkyFFIJwXWZ/fFYM/XJu0N
        +uE01fKV8/El8pS5hvAxJds+BV5z0/1ZLeqBZyv4pakL1LojELTs6mM7lpi+LKMtwW0yrIqy
        FI4aG7Cc3zp99ekyt1ysSVCEBWO8RvEH9DnZxXEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xu7oLq6/FGbSsZLPYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS/j/rVX7AV7eSv2nmhgamA8xtXFyMkhIWAi0b/zAnMXIxeHkMBSRok9LY9Y
        uhg5gBJSEivnpkPUCEv8udbFBlHzlFHi9rH3rCAJNgFHif6lJ1hBEiICf5kkDs46DVbFLHCN
        UWLjhJPMIFXCAoYSDw4/A7NZBFQl+j9cZgGxeQWsJb5v2MgGsUJeon35djCbU8BG4sDpT0wg
        thBQzftp3UwQ9YISJ2c+AbuOWUBdYv08IZAwv4CWxJqm62AjmYHGNG+dzTyBUWgWko5ZCB2z
        kFQtYGRexSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjX24793LKDsetd8CFGAQ5GJR5eA8Nr
        cUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9OZEZinR5HxgyskriTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDI8+irx8xNvF7NOsebFv46
        tO+hmUKPkJSByb78K0l3ynsun1krFf5qxgdR12bhJzHXYuzWPFfNelVxYGLqjJflMx4x13Ha
        39ZyfJfE5HR3UZ+h0PnHcTLVOoeOPzLIffB4md4EhdUF5de9zLVm39hx0ubEC5u49kV8R/Pe
        yT8ylH7v+IpLNDJDiaU4I9FQi7moOBEAn1adVgEDAAA=
X-CMS-MailID: 20200602161737eucas1p241dd0e0a9b5eea7c5d5774c46b3c570b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602161737eucas1p241dd0e0a9b5eea7c5d5774c46b3c570b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602161737eucas1p241dd0e0a9b5eea7c5d5774c46b3c570b
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200602161737eucas1p241dd0e0a9b5eea7c5d5774c46b3c570b@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches provides implementation of the
kexec_file_load() system call form the arm architecture. zImage and uImage
(legacy format) files are supported. Like on arm64, there is no
possibility of loading a new DTB and the currently loaded is reused.

Changes in v2:
  - add CONFIG_KEXEC_FILE_UIMAGE for optional uImage support
  - MALLOC_SIZE as a define instead of a symbol
  - DCSZ tag holds combined dynamic memory requirements (bss+stack+malloc)
  - use union for a single tag structure
  - copyright notice includes Russell King

Łukasz Stelmach (5):
  arm: decompressor: set malloc pool size for the decompressor
  arm: add image header definitions
  arm: decompressor: define a new zImage tag
  arm: Add kexec_image_info
  arm: kexec_file: load zImage or uImage, initrd and dtb

 arch/arm/Kconfig                       |  25 +++
 arch/arm/boot/compressed/Makefile      |   7 +-
 arch/arm/boot/compressed/head.S        |   9 +-
 arch/arm/boot/compressed/vmlinux.lds.S |  22 +--
 arch/arm/include/asm/image.h           |  77 +++++++++
 arch/arm/include/asm/kexec.h           |  14 ++
 arch/arm/kernel/Makefile               |   5 +-
 arch/arm/kernel/kexec_uimage.c         |  80 ++++++++++
 arch/arm/kernel/kexec_zimage.c         | 194 +++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c        |  39 ++++-
 arch/arm/kernel/machine_kexec_file.c   | 211 +++++++++++++++++++++++++
 11 files changed, 662 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/include/asm/image.h
 create mode 100644 arch/arm/kernel/kexec_uimage.c
 create mode 100644 arch/arm/kernel/kexec_zimage.c
 create mode 100644 arch/arm/kernel/machine_kexec_file.c

-- 
2.26.2

