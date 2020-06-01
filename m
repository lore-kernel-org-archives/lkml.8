Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F01C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F31207D5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qyaGQUdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAO2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:28:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55322 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:28:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601142811euoutp01cf6fd3add2398f38cf9fc158b22cc87c~UccxjQFZ90989309893euoutp01m
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601142811euoutp01cf6fd3add2398f38cf9fc158b22cc87c~UccxjQFZ90989309893euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591021691;
        bh=TcvRBVgibYuWvdnj8aP2i39hNoNN9xtEvOA0UIuLnMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyaGQUdke+Ls9OJ+3s8sFwH+lw+wAfO0CCXNDuxpcsYibSVTGJ8Dq5BdidR56YU43
         AKS0Udw1/lAF452Dj/BQkYQYrGudgBbecCAeD+A7gbQMYVGE11ee2HSejhNQignxvz
         Csz1jNvk5GsuLuO8WqWOzYwF6VMJKrkh7fksrba0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601142810eucas1p2e42f5919d8046616d8e3dc2637fde2ed~UccxCsaUb0506105061eucas1p28;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0D.EA.61286.A7015DE5; Mon,  1
        Jun 2020 15:28:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601142810eucas1p1767585cf172d26aedb551d7453aa7402~UccwvQZhL2462024620eucas1p1p;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601142810eusmtrp1867c63cae3b0bc092ca73d4ff0bf8430~Uccwubcw43017330173eusmtrp1i;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-bc-5ed5107a92d4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 51.FB.07950.97015DE5; Mon,  1
        Jun 2020 15:28:10 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601142809eusmtip107d07cf168a890f2adfbbed52e457391~UccwgUcus1630616306eusmtip1J;
        Mon,  1 Jun 2020 14:28:09 +0000 (GMT)
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
Subject: [PATCH 1/5] arm: decompressor: set malloc pool size for the
 decompressor
Date:   Mon,  1 Jun 2020 16:27:50 +0200
Message-Id: <20200601142754.26139-2-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObt31ztt67oif75lFTFLTSq5oEZG0f3T6L+g2cyLWW7a5kwt
        dCWozcwX9lAJKSNbljp1lRrKsKyW8/0YKmYF9kAZ85GaWs5r5H/f7/d8fuec7+GQmHiE70HG
        KZNYlVIeLyGccePbxa6ANGpAtr9jcgddd7eGTxc9b+PR1mvNPPpjroK2mqoQbfgyyKf7msoJ
        2lTyGtHP2sec6IlPw3z66eoHRNsK/vDo5dZFnK43lGBHREzfYA/GlGl7cGZF/w1jKgwaxqC/
        QTCjgy0EM22xODH1lRlMgW2KYG416BEzY/CJdDntHBbDxscls6qgw2edzw9oK/HEVWHKU2su
        rkUNLjpEkkAdhILGdB1yJsVUFYL2rlcYZ2YR2CpGEGdmENh/lWD/JsasAi5/jMAyuMLXIcGa
        mUQwZ4h0aIKKgPxH7/gOaDs1x4OmkmzCYTCqH8FEq5HnoLZRp+B+3kvCoXFqN7xq/LieC6lQ
        qNf+Rg4NlC9kP36xzgioMGgz2zcYV3h/7yvu0Fspf6i+PrSusTU+s7FsvQNQeSRk9tiduI2O
        Qa9tmeD0NvjR0bCRe4G5+CbOVcuA4qIQbvYmAmP5As4xoTBqWSIcDEZJoaYpiIsjYKpigseN
        imB4ypW7ggiKjHc2HksIOVlijt4Fz/NbNjb0gLwfVagASUo3lSndVKD0/1kVCNMjN1ajVsSy
        6mAlezlQLVeoNcrYwHMJCgNa+3Lm1Q77SzTXG21CFIkkW4S14/0yMV+erE5VmBCQmGS78Gin
        WSYWxshT01hVQpRKE8+qTciTxCVuwgMPvp8RU7HyJPYiyyayqn+rPFLgoUVPvKTNfeE+pVEX
        c+vYwuGkEzZdrXK4s3k22nPee+e0/86lGf2Q+4uczBap/o9V5t19xe9n9ed4Nr2rfShcmxI4
        3nF7Yc+ytLdTJJtuq1QI3aPCHr6ZWdonSjDu1dlUl1x9hyyuhZpu0i/0eOHWkParsydDB7Lm
        XdysAYeqYy5MSnD1eXmwP6ZSy/8C64uyDG4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xu7pVAlfjDDYeZbLYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS/jasMSloJ/vBWrb3azNDBu4e5i5OCQEDCRuHuTs4uRi0NIYCmjRPfLP6wQ
        cSmJlXPTuxg5gUxhiT/Xutggap4ySkzrv8MEkmATcJToX3qCFSQhIvCXSeLgrNNgVcwC1xgl
        Nk44yQxSJSwQKLHr4npGEJtFQFVi59YzYN28AtYSmxt+M0KskJdoX76dDcTmFLCROHD6E1iN
        EFDN+2ndUPWCEidnPmEBuY5ZQF1i/TwhkDC/gJbEmqbrLCA2M9CY5q2zmScwCs1C0jELoWMW
        kqoFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAqN627GfW3Ywdr0LPsQowMGoxMO74f6V
        OCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFenMis5Rocj4w4eSVxBua
        GppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamA81vy4xZLJqHre9K8L+9NZ
        3KaolIhkNNuprS6fmfVTWzVsHt8bA/21+1ZbPtpn+1SsYyt3/485rOn/uwx8C4SW9z1hPnHi
        YW+QysI8payW2yVTezU91Y/LssouF3jH0tWa/erxKn35zAarzSpXvWoLXJVMYq8ebz9zo1Cj
        xvDeOWvNv322q5VYijMSDbWYi4oTAXE42OUAAwAA
X-CMS-MailID: 20200601142810eucas1p1767585cf172d26aedb551d7453aa7402
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601142810eucas1p1767585cf172d26aedb551d7453aa7402
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601142810eucas1p1767585cf172d26aedb551d7453aa7402
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200601142810eucas1p1767585cf172d26aedb551d7453aa7402@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of malloc pool size of the decompressor to
a single place. This value will be exposed later for kexec_file loader.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 arch/arm/boot/compressed/head.S   | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 9c11e7490292..b3594cd1588c 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -125,6 +125,8 @@ KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
 		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
 		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
+# malloc pool size
+LDFLAGS_vmlinux += --defsym _malloc_size=0x10000
 # Supply ZRELADDR to the decompressor via a linker symbol.
 ifneq ($(CONFIG_AUTO_ZRELADDR),y)
 LDFLAGS_vmlinux += --defsym zreladdr=$(ZRELADDR)
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index e8e1c866e413..dcc1afa60fb9 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -309,7 +309,8 @@ restart:	adr	r0, LC0
 #ifndef CONFIG_ZBOOT_ROM
 		/* malloc space is above the relocated stack (64k max) */
 		add	sp, sp, r0
-		add	r10, sp, #0x10000
+		ldr	r10, =_malloc_size
+		add	r10, r10, sp
 #else
 		/*
 		 * With ZBOOT_ROM the bss/stack is non relocatable,
@@ -623,7 +624,8 @@ not_relocated:	mov	r0, #0
  */
 		mov	r0, r4
 		mov	r1, sp			@ malloc space above stack
-		add	r2, sp, #0x10000	@ 64k max
+		ldr	r2, =_malloc_size	@ 64k max
+		add	r2, r2, sp
 		mov	r3, r7
 		bl	decompress_kernel
 
-- 
2.26.2

