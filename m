Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13007C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6A520842
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IkI6ksKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFAO22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:28:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33402 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:28:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601142812euoutp02d9fc3ab4af0072b0c50404a632b4384e~Uccyfde5h2591125911euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:28:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601142812euoutp02d9fc3ab4af0072b0c50404a632b4384e~Uccyfde5h2591125911euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591021692;
        bh=HFutmAJ4iU4eRu//A59XEGsqCOlB4bks5rPsSUwsxYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkI6ksKVUMLdTpX2UzR8W8GeY2bTkRn18ozcd8UtJqBpRpjJ9zbzlXyYkMRDFgoRy
         ZNvpquAECy1TyPOrzO1L54Yaps4K6tBuydayoWC7IhXRyHuSQp4EczQcxdQ3wTF2qh
         GrumXYYJoyTUA2P2QVLP91dvzwfngL66X6YjKHKo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601142811eucas1p19d39e7d97706e1a427081585d8f5e430~UccyKSk7P2463924639eucas1p1t;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EE.EA.61286.B7015DE5; Mon,  1
        Jun 2020 15:28:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200601142811eucas1p260e5a434ea7743eecdb37c4d975c5f05~Uccxwp9c62609926099eucas1p2R;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601142811eusmtrp11c12ae0e99e01cf8f1af56f48ad46e53~UccxwBku83017330173eusmtrp1j;
        Mon,  1 Jun 2020 14:28:11 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-be-5ed5107b54dd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.FB.07950.B7015DE5; Mon,  1
        Jun 2020 15:28:11 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200601142811eusmtip14e43cd3fa12be09844c167c5a24c91ac~UccxjpZJT1573515735eusmtip1l;
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
Subject: [PATCH 4/5] arm: Add kexec_image_info
Date:   Mon,  1 Jun 2020 16:27:53 +0200
Message-Id: <20200601142754.26139-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601142754.26139-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvZ3pMKCtQyHxWIyaqomgglvMJIAR8GEiPPDkg8ZClWGTtqQj
        KPpAcUP2CqmUJUBcAqkIUhEJS8BicKk0UWoL7qgJagRMoUGMtFIGom//Oef7z7l/cklM8k4o
        JdNUp1iNSpEhI/zwjsE5645z1Cv5zroiGd1maBXS5S39Ano0r1tAPy9S0qPmJkSbPtuF9HBX
        LUGb9b2IvvPonQ899nFESN92P0P0T51HQP/pm8PpeyY9dkDMDNtfYEyN9gXOzBu/YkyDKYsx
        GQsI5q29h2AmrVYf5t7NXEb3c4JgStuNiJk2rY9fecQvIonNSMtmNWH7E/1Sx18nZF4Vn3k0
        9hrXoocrC5EvCdReuDZs9ylEfqSEakLguTGH8cUMgtLRb4gvphFc+WQQLlumhicIftCIoHaq
        cokaRzBY1Yx7KYKKgrJbT4TeQSDlEkCXPn/RglE2BGN9HQIvFUCFwmyBFfNqnNoC+Xm9yKtF
        VDjoJ69h/L0NkN/4gPBqXyoC+i1OAc/4w9OqL4vXVlMh0HzesaixBf7C/ZrFFECVkFD3YRbn
        Fx2E1h/1SyEC4Pvjdh9erwNLRfECQy7oXKgo38d7ixF01P5a8obDW+tvwstgVDC0doXx7SjQ
        XnQQvFUMIxP+/BPEUN5RifFtEVy5LOHpzdBS1rO0UAol35uQDsmq/wtT/V+A6n+3GhBmRGvY
        LE6ZwnK7VOzpUE6h5LJUKaEn1EoTWvh0FvdjZydyvTxuRhSJZKtEdz/Y5BKhIpvLUZoRkJgs
        UBQ9ZJFLREmKnLOsRp2gycpgOTMKInHZGtGe69+OSagUxSn2JMtmsprlqYD0lWpRUnNOTI/T
        NXPOcCguNj2NLt24+/bOTZGeCwPvx7mh4GR1p01cf+uYwyldG701cipIndy9wllt1s23/Yq7
        WL/5aOzAm9G84oC52Lr5w2y8w9YbWiBvPGOlLr1MDXSfDU+M1DXMbh+8EyMdmIrQuy3pnhGX
        oSI4Wwjbsg3Fa+2RMpxLVewKwTSc4i9uBwcJcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsVy+t/xu7rVAlfjDPqncVpsnLGe1WLSugNM
        FjcbdzNZnOnOtbh5aAWjxabH11gtLu+aw2ZxaOpeRou1R+6yWzx8cIPVYvW/U4wWHyb8Z7L4
        s/8ni8XmTVOZHfg8Ll+7yOwxu+Eii8ffVS+YPRZsKvXYtKqTzePOtT1sHu/OnWP32Lyk3mPC
        h7dsHn1bVjF6fN4kF8AdpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eT
        kpqTWZZapG+XoJfx/FZ8wUS+iiMPb7E0MB7k7mLk5JAQMJF4f/ktG4gtJLCUUeLuPs0uRg6g
        uJTEyrnpECXCEn+udUGVPGWUODYlB8RmE3CU6F96grWLkYtDROAvk8TBWafZQBxmgWuMEhsn
        nGQGqRIW0JP43nkOzGYRUJVob9zLCGLzClhLTH03jRlig7xE+/LtYBs4BWwkDpz+xASxzVri
        /bRuJoh6QYmTM5+wgBzHLKAusX6eEEiYX0BLYk3TdRYQmxloTPPW2cwTGIVmIemYhdAxC0nV
        AkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIERve3Yzy07GLveBR9iFOBgVOLh3XD/SpwQ
        a2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAr05kVlKNDkfmGzySuINTQ3N
        LSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwZkxf3vlL33YJc/jG6E0xLRWv
        V+wONn0V6rTKXMrIcEFruJT2+SY+3/y7p229DlQ02wsm1yvtC7mqYqVWIzXnUJizsdnnqf08
        MivVX2SE5G67ZrO7Ym6BcNzfhItiU0u+q7wsjRP542XFWKv0m2lC+M2W3gU+287/D298cCmU
        0//p/uu3xauVWIozEg21mIuKEwGpgaMp/gIAAA==
X-CMS-MailID: 20200601142811eucas1p260e5a434ea7743eecdb37c4d975c5f05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200601142811eucas1p260e5a434ea7743eecdb37c4d975c5f05
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200601142811eucas1p260e5a434ea7743eecdb37c4d975c5f05
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <CGME20200601142811eucas1p260e5a434ea7743eecdb37c4d975c5f05@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kexec_image_info to print detailed information about a kexec image.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 76300f3813e8..c10a2dfd53d1 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -31,6 +31,32 @@ extern unsigned long kexec_boot_atags;
 
 static atomic_t waiting_for_crash_ipi;
 
+/**
+ * kexec_image_info - For debugging output.
+ */
+#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
+static void _kexec_image_info(const char *func, int line,
+	const struct kimage *kimage)
+{
+	unsigned long i;
+
+	pr_debug("%s:%d:\n", func, line);
+	pr_debug("  kexec kimage info:\n");
+	pr_debug("    type:        %d\n", kimage->type);
+	pr_debug("    start:       %lx\n", kimage->start);
+	pr_debug("    head:        %lx\n", kimage->head);
+	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+
+	for (i = 0; i < kimage->nr_segments; i++) {
+		pr_debug("      segment[%lu]: %08lx - %08lx, 0x%x bytes, %lu pages\n",
+			i,
+			kimage->segment[i].mem,
+			kimage->segment[i].mem + kimage->segment[i].memsz,
+			kimage->segment[i].memsz,
+			kimage->segment[i].memsz /  PAGE_SIZE);
+	}
+}
+
 /*
  * Provide a dummy crash_notes definition while crash dump arrives to arm.
  * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
@@ -42,6 +68,8 @@ int machine_kexec_prepare(struct kimage *image)
 	__be32 header;
 	int i, err;
 
+	kexec_image_info(image);
+
 	image->arch.kernel_r2 = image->start - KEXEC_ARM_ZIMAGE_OFFSET
 				     + KEXEC_ARM_ATAGS_OFFSET;
 
-- 
2.26.2

