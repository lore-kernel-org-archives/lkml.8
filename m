Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F053C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402B920772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G3yHcZOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgFBQRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:17:41 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39389 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFBQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:17:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200602161739euoutp0179856467741b9bd1ae768c8e4ed329aa~Uxlo5DecW2755627556euoutp01I
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:17:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200602161739euoutp0179856467741b9bd1ae768c8e4ed329aa~Uxlo5DecW2755627556euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591114659;
        bh=UQuTozY2MxX8UBgz0xZ3wonyIu/c1B+C4uicBd24pYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3yHcZOlkuPt9kxT427OqGHvNtKAhYsXUp2y8tB4cvBu80mmOUq65hG27xSZFGn7H
         R+ZqDZKQvJZEqmdxjCEKl/pC+Y6ntw36fbUr44qRD9sXUwF8sMfl0pMwV+Q9Y3oC+z
         9jcqlZ8b5p1Hgw7+7dQUwAgAiL/en6x4o2n+tKS0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200602161738eucas1p15e82a7613dba95267f60bdb5b4239d69~Uxlonj1ap2724027240eucas1p1r;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 9A.81.60679.2AB76DE5; Tue,  2
        Jun 2020 17:17:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602161738eucas1p2151f88b526bb009c27820a4f290a961e~UxloH1urK2274322743eucas1p24;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602161738eusmtrp124c2fc089d2eefc0e4f645c81f22f111~UxloG8qmZ2876728767eusmtrp1R;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a0-5ed67ba20cfa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.DE.08375.2AB76DE5; Tue,  2
        Jun 2020 17:17:38 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602161738eusmtip107f00e3cd9844fdc6d380d542d79d533~Uxln48eu12690626906eusmtip13;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
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
Subject: [PATCH v2 3/5] arm: decompressor: define a new zImage tag
Date:   Tue,  2 Jun 2020 18:17:29 +0200
Message-Id: <20200602161731.23033-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602161731.23033-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7HpfT40nYi0XFukCWZRl2QukiBYf6URH4I2g186SWW7E5
        L0WlRVk27wx1s/AWmnmhabPctDUry6UmxcpLkSVlmqWoWVJW21nUv+d9n+d53+f9+EiM7hP6
        k7HKeE6llMdJCRFuevi9K7D0pEMWpG0NYm4W1AmZ3FqrgOlJNQuYJ5cVTI+tEjHGdw4h86yp
        iGBsumbE1Nx/5cEMvHkpZG7MtiNmLPuXgPlx9zvO1Bt12BZv9pmjG2MNKd04+7NqCGOLjRrW
        WHWJYPsdFoL93NnpwdaXn2Gzx0YJNrOhCrETxoW75+4ThUVxcbEJnGrNpoOimM9v3+PH+3yS
        UhrMghRk9kpHJAnUehgwhKUjEUlTlQj6r3ThfDGJoGx2BuOLCQSDFcUoHXm6HOVpQ4QT01QF
        gpYZ4EUfEDw18gRBbYWsa4+ETsKPmhJAky6NcBYY9RzBwF2TwKmaR4XDcMc47sQ4tQwu6Ysw
        JxZToZA/aPHg1y2CtIpGwhnWkwoDw2QcL/GFx4WDLqsPFQDVZ1+4MPZHfu6WwRUbqAwSHhhK
        BfycbXA157X7hHkw3Nbgnr8A7HlanH+MM5CXG8J7tQhMRd9wXhMK/Z0zrgwYtQLqmtbw7a1g
        tedgvNUbXo768hG8IdeU726L4eIFmlcvhdosi3ugP2QMV6JsJNX/d4z+vwP0/3YVI6wKSTiN
        WhHNqdcpucTVarlCrVFGrz50TGFEf76cfbZt8jZq+hFpQxSJpF7ioLUOGS2UJ6iTFTYEJCb1
        E4d32GW0OEqefIJTHTug0sRxahuaT+JSiTi49ON+moqWx3NHOe44p/rLCkhP/xRESszXa79m
        nn5CJ2/X7rH2bAwMe0R6WczBWb3WECQTf5puaa7efGfkfNuyDXN29QbT7I59hTV53UlJKnJ8
        JJQ1fSkzrnKUJB6JOhzrsbhr1dSplZKI1gzNlsay1GmtsiC3fVthi09O+968kiUR9ct1rR1z
        R8burSyujokc3+knkUhxdYx8bQCmUst/A2AsUHxuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xu7qLqq/FGTz8zWuxccZ6VotJ6w4w
        Wdxs3M1kcaY71+LmoRWMFpseX2O1uLxrDpvFoal7GS3WHrnLbvHwwQ1Wi9X/TjFafJjwn8ni
        z/6fLBabN01lduDzuHztIrPH7IaLLB5/V71g9liwqdRj06pONo871/awebw7d47dY/OSeo8J
        H96yefRtWcXo8XmTXAB3lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1N
        SmpOZllqkb5dgl7Gu0fPWApu81c0bNnN1MC4m6eLkZNDQsBEYkn7CzYQW0hgKaPEwX72LkYO
        oLiUxMq56RAlwhJ/rnUBlXABlTxllGh6/Q2snk3AUaJ/6QlWkISIwF8miYOzToNVMQtcY5TY
        OOEkM0iVsICTxKuzH1lAbBYBVYnOWXPA4rwC1hLTn+xhh1ghL9G+fDsbyGZOARuJ2V9yIA7K
        lXi4/BU7RLmgxMmZT1hASpgF1CXWzxMCCfMLaEmsaboONp0ZaErz1tnMExiFZiHpmIXQMQtJ
        1QJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBMb3t2M/NOxgvbQw+xCjAwajEw2tgeC1O
        iDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYG+nMgsJZqcD0w3eSXxhqaG
        5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGOd3+GvbJa67XVaUcyBxfeLR
        ufs583Udc25t0I2XOs02K3zDkrhVjHsLpNfn9Ny+o1W+TE5Ha3H3jzsx+h+/n3/2RP5c1Jx1
        yZwtU3x5g74zFQjVfZfkOT4rKyFDT3c1T3P8r5o0X5a/TQW79pVqaZ6dZZVv91h0XuzDzvW3
        buVvuX3V+uXmFCWW4oxEQy3mouJEAFVibh//AgAA
X-CMS-MailID: 20200602161738eucas1p2151f88b526bb009c27820a4f290a961e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602161738eucas1p2151f88b526bb009c27820a4f290a961e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602161738eucas1p2151f88b526bb009c27820a4f290a961e
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200602161731.23033-1-l.stelmach@samsung.com>
        <CGME20200602161738eucas1p2151f88b526bb009c27820a4f290a961e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
requirements of the decompressor code.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/vmlinux.lds.S | 9 ++++++++-
 arch/arm/include/asm/image.h           | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 308e9cd6a897..d15c1269eb5d 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -39,6 +39,11 @@ SECTIONS
     LONG(ARM_ZIMAGE_MAGIC3)
     LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
+    LONG(ZIMAGE_MAGIC(3))
+    LONG(ARM_ZIMAGE_MAGIC4)
+    LONG(ZIMAGE_MAGIC((_end - __bss_start) +
+                      (_stack_end - _stack_start) +
+                      MALLOC_SIZE))
     LONG(0)
     _table_end = .;
   }
@@ -108,10 +113,12 @@ SECTIONS
   . = BSS_START;
   __bss_start = .;
   .bss			: { *(.bss) }
+  . = ALIGN(8);		/* the stack must be 64-bit aligned and adjoin bss */
   _end = .;
 
-  . = ALIGN(8);		/* the stack must be 64-bit aligned */
+  _stack_start = .;
   .stack		: { *(.stack) }
+  _stack_end = .;
 
   PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
   PROVIDE(__pecoff_end = ALIGN(512));
diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
index d5c18a0f6a34..55b51faa6b7e 100644
--- a/arch/arm/include/asm/image.h
+++ b/arch/arm/include/asm/image.h
@@ -15,6 +15,7 @@
 #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
 #define ARM_ZIMAGE_MAGIC2 (0x45454545)
 #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
+#define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
 
 #ifndef __ASSEMBLY__
 
@@ -40,6 +41,8 @@ struct arm_zimage_tag {
 			__le32 size_ptr;
 			__le32 bss_size;
 		} krnl_size;
+#define ZIMAGE_TAG_ZIMAGE_MEM ARM_ZIMAGE_MAGIC4
+		__le32 zimage_mem;
 	} u;
 };
 
-- 
2.26.2

