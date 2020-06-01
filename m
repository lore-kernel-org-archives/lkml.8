Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B499C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 764F82068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ei3Fbr0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFAO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:28:09 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55292 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:28:09 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601142807euoutp01cd99a82359e4c946e581f7a4cbc76d57~UccuRu4XN0989309893euoutp01i
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:28:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601142807euoutp01cd99a82359e4c946e581f7a4cbc76d57~UccuRu4XN0989309893euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591021687;
        bh=RsmNPtERewy68jytV4caViX5l4E08Yym2BhyOFIHcP4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ei3Fbr0hYf/FYqOTOQDwwUSDRYsjaZwbt9/qj19bHyslqOPJHowc9fAKANKKico9a
         eact3HfCtd0DhGxi6akwb+FE63Cu/PM9e3oRaK5OTOJ8JD0u9aETKPukbAo4qp9AUn
         2iHyu4gVw4chXrMtu5dHEzaVNam17KvMPIxxEbgA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601142807eucas1p28a191e83cda6d6b61b8f98fb1de4fe1d~Ucct6mooy1927019270eucas1p2d;
        Mon,  1 Jun 2020 14:28:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id AE.E9.60679.67015DE5; Mon,  1
        Jun 2020 15:28:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601142806eucas1p2680c5625411e7a695d8469760a926520~UcctTdbE30046600466eucas1p29;
        Mon,  1 Jun 2020 14:28:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601142806eusmtrp21c10612fd4f697e0d47d9fd09391a39c~UcctSpChv1487114871eusmtrp28;
        Mon,  1 Jun 2020 14:28:06 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-df-5ed51076fd47
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 22.52.08375.67015DE5; Mon,  1
        Jun 2020 15:28:06 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601142806eusmtip130913d607995f7f15efb787f606c1abf~UcctIiS_r0934709347eusmtip1k;
        Mon,  1 Jun 2020 14:28:06 +0000 (GMT)
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
Subject: [PATCH 0/5] kexec_file_load() for arm
Date:   Mon,  1 Jun 2020 16:27:49 +0200
Message-Id: <20200601142754.26139-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxNcRjH/e556VRufh1tHlHWxYZxby/Y2fIW2s74h9loUdx0luje2j3d
        kq0VlpeSWuSlFxEqqeiWiyvieomQtVu5Wdkt77awVaZQOs5t/Pd9nufzfb6/Z/sxBPuK8mZi
        9YmCQa+NU9FupPnR0IsFybg90r87iqs9dYXi8mruKrjOvbcU3LMsHddprUCc6U0HxdksRTRn
        zb+NuOoH3S5cj8NOcZdHmhH3LXdUwf1qHCK5OlM+scKDt3W0EnxheivJ/678SPBnTUbeVHmY
        5rs6Gmj+S0uLC193IY3P/dZH80frKxHfb/Jd5x7utiRaiItNEgyaZdvcdpQWttMJp913X95/
        g0pHr5lM5MoAXgjW1q8oE7kxLK5A0N+X4SwGEFy/10NIFIv7EbzIXjPuyKrrdkLlCOyHTjiL
        Dwiq7MWURNE4BHIuPqakgRceVIAl/yAtFQRuQ9DTaFZI1GSshtLhkb8OEs+GmqvXxvIYRomD
        4ZQtXI6bAQfLr9OSVmJPeHL6LSnpSXgeVO17+VcTY8z+a4WEtB/wkAsMHnfQsnk1HH7mIGU9
        GT431bvIejqM3ixRSFmA0+BY3mLZewSBueiHkw+GrpZhWmIIPBeuWDRyOwTqq8uRbPUAe5+n
        /AQPyDOfJOS2Eg4dYGV6FtTkNDgXekP25wqnk4eOI5tzkV/Bf3cV/HdLwb/Ys4ioRFMEo6iL
        EcRAvZCsFrU60aiPUW+P15nQ2I97OtI0cANZfkVZEWaQaqKS6W2LZCltkpiisyJgCJWXcuXz
        p5GsMlqbskcwxG81GOME0YqmMaRqijKo9FMEi2O0icIuQUgQDONTBePqnY481x+tORcKGcbU
        KotCHbFBnx5wbCkU7wwKrffTJN3JOOkTOJr8brGnD2vxG8jW5xHkxrRNvWYfjw/DU89MSPN7
        r/b9vlL0ImPYnvPU/ANdmuq4gLAyTfCllJ8zlw/yixwPy1ady4oscAzZ79eGhTZnhJTMoW2p
        b/23BNiEtWvKVKS4QxswjzCI2j8kYsT8bQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7plAlfjDE7ekrDYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS9j0eyrbAUzuStWN+9gbWC8x9HFyMkhIWAi0b35LmMXIxeHkMBSRom/N/+z
        dDFyACWkJFbOTYeoEZb4c62LDaLmKaPEp7MXmEESbAKOEv1LT7CCJEQE/jJJHJx1GqyKWeAa
        o8TGCSfBqoQF9CQW/frHCmKzCKhKrNuwlRlkA6+AtcSMy1EQG+Ql2pdvZwOxeQUEJU7OfAJ2
        BLOAusT6eUIgYX4BLYk1TddZQGxmoPLmrbOZJzAKzELSMQuhYxaSqgWMzKsYRVJLi3PTc4sN
        9YoTc4tL89L1kvNzNzECo3TbsZ+bdzBe2hh8iFGAg1GJh3fD/StxQqyJZcWVuYcYJTiYlUR4
        nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr0zURmKdHkfGACySuJNzQ1NLewNDQ3Njc2s1AS5+0Q
        OBgjJJCeWJKanZpakFoE08fEwSnVwOjHHR5S+V36hGDErEX2tcUVQVrHjJe/V3r3zaSFfcUf
        034mVUmeCTo8B1s3snn84BF/5e/YdJd1wsrJJefS9Lz335XJWZV54MN1S4EJAgXGi98GFplG
        zzLbbhH+7UlZt56Jvni1M9NPxYT0JdFPL/Fe/hfnHralYKP97qiwHWebVshZHTztr8RSnJFo
        qMVcVJwIAEqCq3HoAgAA
X-CMS-MailID: 20200601142806eucas1p2680c5625411e7a695d8469760a926520
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601142806eucas1p2680c5625411e7a695d8469760a926520
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601142806eucas1p2680c5625411e7a695d8469760a926520
References: <CGME20200601142806eucas1p2680c5625411e7a695d8469760a926520@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches provides implementation of the
kexec_file_load() system call form the arm architecture. zImage and uImage
(legacy format) files are supported. Like on arm64, there is no
possibility of loading a new DTB and the currently loaded is reused.

Łukasz Stelmach (5):
  arm: decompressor: set malloc pool size for the decompressor
  arm: add image header definitions
  arm: decompressor: define a new zImage tag
  arm: Add kexec_image_info
  arm: kexec_file: load zImage or uImage, initrd and dtb

 arch/arm/Kconfig                       |  15 ++
 arch/arm/boot/compressed/Makefile      |   2 +
 arch/arm/boot/compressed/head.S        |   9 +-
 arch/arm/boot/compressed/vmlinux.lds.S |  22 +--
 arch/arm/include/asm/image.h           |  87 ++++++++++
 arch/arm/include/asm/kexec.h           |  14 ++
 arch/arm/kernel/Makefile               |   5 +-
 arch/arm/kernel/kexec_uimage.c         |  80 ++++++++++
 arch/arm/kernel/kexec_zimage.c         | 199 +++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c        |  39 ++++-
 arch/arm/kernel/machine_kexec_file.c   | 209 +++++++++++++++++++++++++
 11 files changed, 662 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/include/asm/image.h
 create mode 100644 arch/arm/kernel/kexec_uimage.c
 create mode 100644 arch/arm/kernel/kexec_zimage.c
 create mode 100644 arch/arm/kernel/machine_kexec_file.c

-- 
2.26.2

