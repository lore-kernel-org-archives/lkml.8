Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A571F2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X9eEGfRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFAO2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:28:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55342 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgFAO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:28:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200601142811euoutp01a4bb520d1370362eb25a104ab5819e79~UccySZZdp1115911159euoutp01F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200601142811euoutp01a4bb520d1370362eb25a104ab5819e79~UccySZZdp1115911159euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591021691;
        bh=rwNNoUfHAlfOFwGSbUnF9y1UjfDAKssjoju9RRF8YRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9eEGfRPZcG2kCvQcz7lT69EaWrGY0YPQHYbpn58OrhQtM0CHyNzCkZFz2n/d3fX+
         giZ6SlLaUlzT5dvfPlYO32S+eimIjHHgSEkKxmhVRB6MX5tDk1sfcpYd5MNoLsDRB6
         P74Igb0ezk8RitetRC9W/2j7TnqBhj3Z0g97EvmU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601142811eucas1p19d9d09310828c63300aced6648478161~Uccx_VV5D2462024620eucas1p1q;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FD.EA.61286.B7015DE5; Mon,  1
        Jun 2020 15:28:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601142810eucas1p1c42ff7c9b417f04bc506261726f08b4f~UccxZuO9D1329813298eucas1p1J;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601142810eusmtrp2836859b3e71da49eeb63b847b58a20e2~UccxZFHZg1485714857eusmtrp2L;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-bd-5ed5107b5dee
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.52.08375.A7015DE5; Mon,  1
        Jun 2020 15:28:10 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601142810eusmtip278d346ce7de36b7c07a496fd7763cb63~UccxP_TsM2559325593eusmtip2g;
        Mon,  1 Jun 2020 14:28:10 +0000 (GMT)
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
Subject: [PATCH 3/5] arm: decompressor: define a new zImage tag
Date:   Mon,  1 Jun 2020 16:27:52 +0200
Message-Id: <20200601142754.26139-4-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOjsvp5xJ80zJYFiRlShEHNMsIOl3oAv4SUk95Usvp2Fxm
        Rl6CLMtck3XZkqwsTfM2TXMp6kitNMN0amWUZFSrRLxghrncjlL/nu99nud9nhc+ipC9E3lT
        8YnJnCqRTZCTEmFd+8yr9WnYGhk4et6Lrr5eKaJ1FS0C+k3mEwHddVFBv7GUINr0qV9E95pv
        krRF34To8qfvxfTwx0ERXTb3AtFjWruAnm2eEdI1Jj2xzY3p7e8hGGNGj5D5U/qVYApNGsZU
        eoFkhvobSWa0u1vM1BSlM9qxnyRzubYUMRMm3wNLIiQhMVxC/AlOtSE0WhL3w2ZHSoPHyTbb
        DVEGmpbmIBcK8Ca49PksmYMklAyXIMi0VQr4xySCMnuL0KGS4QkE38dSFh1v2xsX5sUIRgx7
        eMMXBK0TNchBkDgM8u49EzkITzwlALM+25lB4D4Ew8118xkUtRRvhYb7GodBiFdDzrXbIgeW
        4mCYrG5EfNpKyC6uJx3YBYdAS+e4gNd4wPMbI84W7tgfHmYNODExrz/7yEg4sgBfoaAqN39h
        0Q4YNk4QPF4Kto5aMY+Xg73hlrMP4HTI123mvZcQ1N38JeQ1wTDU/Zt0aAi8FirNG/hxGOgL
        jIi3usHgTw++ghvo6q4R/FgK58/JeLUfVOQ1Liz0hlxbCdIiueG/Ywz/HWD4l1WIiFLkxWnU
        ilhOHZTIpQSoWYVakxgbcCRJYULzX65zrmP8MZp6fdiCMIXkrtKqD32RMhF7Qp2qsCCgCLmn
        dPvLzkiZNIZNPcWpkqJUmgRObUE+lFDuJd1459shGY5lk7njHKfkVIusgHLxzkDh348p3atm
        f7gKlAP2+o/VV9ax1xU49PhpNkr7bm+fbiqD1Bec8WvLCo9ub9Ae01l9fHc1N3sVFReSivKj
        isCuVcvH7g6uSW29oAyz7kpBWcxOaWdOh/HiM9OAsuRgXMzRB01mc9CyEeuWoTQqwpAvAyze
        vHvFdODVwn0t+9fLheo4NsifUKnZvzmN6JFuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7pVAlfjDN7OMbLYOGM9q8WkdQeY
        LG427mayONOda3Hz0ApGi02Pr7FaXN41h83i0NS9jBZrj9xlt3j44Aarxep/pxgtPkz4z2Tx
        Z/9PFovNm6YyO/B5XL52kdljdsNFFo+/q14weyzYVOqxaVUnm8eda3vYPN6dO8fusXlJvceE
        D2/ZPPq2rGL0+LxJLoA7Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS/jzav/jAWzBCuOvprJ2sD4nbeLkZNDQsBE4taxPSxdjFwcQgJLGSUaN28G
        cjiAElISK+emQ9QIS/y51sUGUfOUUWLet73sIAk2AUeJ/qUnWEESIgJ/mSQOzjoNVsUscI1R
        YuOEk8wgk4QF7CV2LisFaWARUJXomr6QFcTmFbCW+LJxDyPEBnmJ9uXb2UBsTgEbiQOnPzGB
        2EJANe+ndTNB1AtKnJz5BOw4ZgF1ifXzhEDC/AJaEmuarrOA2MxAY5q3zmaewCg0C0nHLISO
        WUiqFjAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM6m3Hfm7ewXhpY/AhRgEORiUe3g33
        r8QJsSaWFVfmHmKU4GBWEuF1Ons6Tog3JbGyKrUoP76oNCe1+BCjKdCbE5mlRJPzgQknryTe
        0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY9dV3XTBXQwLPl+/yPzh
        R8RJ5hbuYP3jnxoK41+tvn3JrFo5teaz4ZsgRdd17Et2fw34EZf67OK2BRUHK+zly3k2MyRo
        Mb8PXqhw2d7u1LmdfpV+d4PTbzUp6b5m+/NM5dbe8/uU1s96ZVS75GmksbtvVuqP6yZ/TwlE
        eC94sbf1/ImlEYc9RJRYijMSDbWYi4oTAVQLUIkAAwAA
X-CMS-MailID: 20200601142810eucas1p1c42ff7c9b417f04bc506261726f08b4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601142810eucas1p1c42ff7c9b417f04bc506261726f08b4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601142810eucas1p1c42ff7c9b417f04bc506261726f08b4f
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200601142810eucas1p1c42ff7c9b417f04bc506261726f08b4f@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
requirements of the decompressor code.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/vmlinux.lds.S |  9 ++++++++-
 arch/arm/include/asm/image.h           | 13 +++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 308e9cd6a897..dcfdb3209c90 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -39,6 +39,11 @@ SECTIONS
     LONG(ARM_ZIMAGE_MAGIC3)
     LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
     LONG(ZIMAGE_MAGIC(_kernel_bss_size))
+    LONG(ZIMAGE_MAGIC(5))
+    LONG(ARM_ZIMAGE_MAGIC4)
+    LONG(ZIMAGE_MAGIC(_end - __bss_start))
+    LONG(ZIMAGE_MAGIC(_stack_end - _stack_start))
+    LONG(ZIMAGE_MAGIC(_malloc_size))
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
index d5c18a0f6a34..624438740f23 100644
--- a/arch/arm/include/asm/image.h
+++ b/arch/arm/include/asm/image.h
@@ -15,6 +15,7 @@
 #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
 #define ARM_ZIMAGE_MAGIC2 (0x45454545)
 #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
+#define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
 
 #ifndef __ASSEMBLY__
 
@@ -43,6 +44,18 @@ struct arm_zimage_tag {
 	} u;
 };
 
+struct arm_zimage_tag_dc {
+	struct tag_header hdr;
+	union {
+#define ZIMAGE_TAG_DECOMP_SIZE ARM_ZIMAGE_MAGIC4
+		struct zimage_decomp_size {
+			__le32 bss_size;
+			__le32 stack_size;
+			__le32 malloc_size;
+		} decomp_size;
+	} u;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_IMAGE_H */
-- 
2.26.2

