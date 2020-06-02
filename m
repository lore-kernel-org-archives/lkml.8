Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07295C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9D020772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NgwEoJbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBQRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:17:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45583 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgFBQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:17:41 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200602161738euoutp0251c1b3bf3cc3e685c8ac05717bf223d4~UxloN8ZSv1321713217euoutp02B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200602161738euoutp0251c1b3bf3cc3e685c8ac05717bf223d4~UxloN8ZSv1321713217euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591114658;
        bh=ZsH46X2OsHgVVE4UNgCQSLzPGPM56MRSMz7Fj5fkReY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgwEoJbD/s4k7Eq8XJQUVgm0nBv2BSEsmu4Ub4+HK23oaGCe0C6YuDeLLg1hkwuC0
         eh/XvbG9OXLz2i/4Z74QjUcNwx3CxHDTnry/wvfT796CElMZ0XjgdN2m+sMxiUp8HY
         yeFyZW0cPC5e6RDhgz65oFYWxEUm/VPmY21Q5li8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200602161738eucas1p12bde97b5a914113bd67a30baeb678840~Uxln0uBkY1855418554eucas1p1R;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.23.60698.1AB76DE5; Tue,  2
        Jun 2020 17:17:37 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602161737eucas1p2c83700f7c17296c4367ee3fda1c6e783~Uxlnakb1u1812318123eucas1p24;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602161737eusmtrp1b27e313f0a87e0dacc6846a4570f1e5d~UxlnZ44VD2876728767eusmtrp1N;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-15-5ed67ba1bb4d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.29.07950.1AB76DE5; Tue,  2
        Jun 2020 17:17:37 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602161737eusmtip273b20c9f2d5ed78dde100331f078ec25~UxlnNTaQz0825708257eusmtip2B;
        Tue,  2 Jun 2020 16:17:37 +0000 (GMT)
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
Subject: [PATCH v2 1/5] arm: decompressor: set malloc pool size for the
 decompressor
Date:   Tue,  2 Jun 2020 18:17:27 +0200
Message-Id: <20200602161731.23033-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602161731.23033-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3ezety+nP5OFn0GPWHRj4w6kdG9IRbBL2gIMq62W1Gm8rm
        MuuP1gNLTV2a5DM0FM184LQ5zZqtpZa1EGspqZkVvbCMNLIsc7tK/fc953zO+Z4Dh6HkfeIA
        5khMPK+J4VQKiZQ2tY7ZlxafdESGmrpWkNqcGjHJrG4RkZ7Tt0TkUaqa9FjLETG+dohJV1OB
        hFizbyNSZetzI68GusXkxp+HiAwbJkRk3DJGkzpjNrXGk+1ydFJsvr6TZn9XvKfYIqOONVYk
        S9heR7OE/Wy3u7F1JadYw/CQhE2vr0DsN+O8bTP3SFcd4lVHjvGakNUHpNFl95tRXLLX8Wup
        rW56VO2RgtwZwMtgwlAsSUFSRo7LEQz09FNCMILg3os+Wgi+IchNsomnW57VdiOhUIag7tHI
        FPUOgdlc6KIkeC1klLaLnQUfPCqCpuzzLhcKP0XwymISOalZeBekDpVSTk3jxTBQapM4tQxH
        gKXg15TffDhf1jCZZxh3vAryR1QC4g0Pct/QTu2Fg6DyzHOXpibxszfzXUcAzmbAXmyihDkb
        oGZkVCToWfCxrd5N0HOhI+si7ZwP+BRkZS4Xei8iMBX8oAUmAnrtP107UDgQappChPRamGg/
        N9XqCd1D3sIKnpBpukIJaRlcSJIL9CKozmieGhgAaR/LkQEp8v47Ju+/A/L+eRUhqgL58zqt
        Wslrw2P4hGAtp9bqYpTBUbFqI5p8uo4/baNmdGf8oBVhBik8ZKFhjki5mDumTVRbETCUwke2
        7nFHpFx2iEs8wWti92t0Kl5rRXMYWuEvC7/2YZ8cK7l4/ijPx/Ga6aqIcQ/QI/I1KWHAQLb4
        +X7frSyK29RfOXiG+21ONN7NWBftuyEt/pyfrgSXcFEvQ2yaJ9v5tkGfqusRZOfYpcby+IVK
        01tNe4g5P06p37oxIjB95YLBGjLbo7Hl8qfIS8N5X9fHjl/dbMsplGd9aUySf244fGJHIaKT
        r3pbfExL9uItM0QKWhvNhQVRGi33F5M6K6xwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7oLq6/FGWxpkLfYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS9j+dE9jAWd/BWLuo+xNzCu4+li5OSQEDCRuLrxBmMXIxeHkMBSRomTTzpY
        uxg5gBJSEivnpkPUCEv8udbFBlHzlFFizvUbzCAJNgFHif6lJ1hBEiICf5kkDs46DVbFLHCN
        UWLjhJNgVcICIRITj15iBbFZBFQlHiw9wgZi8wpYS+yf85sVYoW8RPvy7WwgmzkFbCRmf8kB
        CQsJ5Eo8XP6KHaJcUOLkzCcsICXMAuoS6+cJgYT5BbQk1jRdZwGxmYGmNG+dzTyBUWgWko5Z
        CB2zkFQtYGRexSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjV24793LKDsetd8CFGAQ5GJR5e
        A8NrcUKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9OVEZinR5Hxgwskr
        iTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cB44erJ3nIWIe/tV26o
        xBt/X1ewrPqYl1FHgPfTLTltByffCTrPp2J67/ic0iu7lBvLTNhTNl4X3vVXqiG+/uOlxJ3v
        Oo+0Sdje2rI4dlfDeVGe9wKXCu/2xIa+KO5yjml3mfR4YS2jzitbX56cK5s+X/57d/H7ayEF
        1X864vt1V5xhmrnevuOlEktxRqKhFnNRcSIAE1ZQ3gADAAA=
X-CMS-MailID: 20200602161737eucas1p2c83700f7c17296c4367ee3fda1c6e783
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602161737eucas1p2c83700f7c17296c4367ee3fda1c6e783
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602161737eucas1p2c83700f7c17296c4367ee3fda1c6e783
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200602161731.23033-1-l.stelmach@samsung.com>
        <CGME20200602161737eucas1p2c83700f7c17296c4367ee3fda1c6e783@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of malloc pool size of the decompressor to
a single place. This value will be exposed later for kexec_file loader.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/Makefile | 7 +++++--
 arch/arm/boot/compressed/head.S   | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 9c11e7490292..c4195651e371 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -7,7 +7,9 @@
 
 OBJS		=
 
-AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
+MALLOC_SIZE     =0x10000
+
+AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET) -DMALLOC_SIZE=$(MALLOC_SIZE)
 HEAD	= head.o
 OBJS	+= misc.o decompress.o
 ifeq ($(CONFIG_DEBUG_UNCOMPRESS),y)
@@ -68,7 +70,8 @@ ZTEXTADDR	:= 0
 ZBSSADDR	:= ALIGN(8)
 endif
 
-CPPFLAGS_vmlinux.lds := -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)"
+CPPFLAGS_vmlinux.lds := -DTEXT_START="$(ZTEXTADDR)" -DBSS_START="$(ZBSSADDR)" \
+			-DMALLOC_SIZE="$(MALLOC_SIZE)"
 
 compress-$(CONFIG_KERNEL_GZIP) = gzip
 compress-$(CONFIG_KERNEL_LZO)  = lzo
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index e8e1c866e413..55758264e776 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -309,7 +309,8 @@ restart:	adr	r0, LC0
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
 		add	sp, sp, r0
-		add	r10, sp, #0x10000
+		mov	r10, #MALLOC_SIZE
+		add	r10, r10, sp
 #else
 		/*
 		 * With ZBOOT_ROM the bss/stack is non relocatable,
@@ -623,7 +624,8 @@ not_relocated:	mov	r0, #0
  */
 		mov	r0, r4
 		mov	r1, sp			@ malloc space above stack
-		add	r2, sp, #0x10000	@ 64k max
+		mov	r2, #MALLOC_SIZE	@ 64k max
+		add	r2, r2, sp
 		mov	r3, r7
 		bl	decompress_kernel
 
-- 
2.26.2

