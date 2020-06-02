Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F2EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B89207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kDpKFxTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgFBQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:17:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45616 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFBQRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:17:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200602161739euoutp02e1dbaa2b6785995b52b60c3aee9fea35~UxlpTIuYk1095510955euoutp02e
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:17:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200602161739euoutp02e1dbaa2b6785995b52b60c3aee9fea35~UxlpTIuYk1095510955euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591114659;
        bh=HFutmAJ4iU4eRu//A59XEGsqCOlB4bks5rPsSUwsxYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDpKFxTftvFUMTsuqhWkNRs1K2P8Rux1Eqlig8Pq10NSNoSQgDoRiosKBa/HgsPA7
         XtiAFavdlsCsxbMQ7nzCyQ05MG+wYu8Hem1zvvhtc247dLVnar+24QsJHyf89WhyfH
         7EX0KJI1QSodNh8eTtnzblY1dDDr6VU0wQ3qIu+4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200602161739eucas1p1b1a27cd4e3f6ba759fb3fec49fc9e4cb~Uxlo62EXM2721427214eucas1p1u;
        Tue,  2 Jun 2020 16:17:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.50.61286.3AB76DE5; Tue,  2
        Jun 2020 17:17:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200602161738eucas1p2ccfaa7610dc6f76e209ba96d6278259e~UxlolbcZw0409404094eucas1p2I;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200602161738eusmtrp156e8802aab6b914fd5875ae556f848fe~Uxlok0RoM2876728767eusmtrp1T;
        Tue,  2 Jun 2020 16:17:38 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-40-5ed67ba352e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.DE.08375.2AB76DE5; Tue,  2
        Jun 2020 17:17:38 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200602161738eusmtip2cb585681ba0044c7b29d1854d16b361d~UxloRNSvZ0083200832eusmtip2X;
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
Subject: [PATCH v2 4/5] arm: Add kexec_image_info
Date:   Tue,  2 Jun 2020 18:17:30 +0200
Message-Id: <20200602161731.23033-5-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602161731.23033-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7djPc7qLq6/FGcxdwGqxccZ6VotJ6w4w
        Wdxs3M1kcaY71+LmoRWMFpseX2O1uLxrDpvFoal7GS3WHrnLbvHwwQ1Wi9X/TjFafJjwn8ni
        z/6fLBabN01lduDzuHztIrPH7IaLLB5/V71g9liwqdRj06pONo871/awebw7d47dY/OSeo8J
        H96yefRtWcXo8XmTXAB3FJdNSmpOZllqkb5dAlfG81vxBRP5Ko48vMXSwHiQu4uRk0NCwESi
        e/VK5i5GLg4hgRWMEtc6DjJBOF8YJZ4eec0K4XxmlPi+4w8jTMuEvgVgtpDAckaJZ5NdIIqe
        M0pMXTmFGSTBJuAo0b/0BFi3iMBXJoldU9vZQBxmgSuMEg/3b2MCqRIWMJSY/v8S0CgODhYB
        VYkHl9lAwrwC1hLXLv9mgtgmL9G+fDsbSAmngI3E7C85ECWCEidnPmEBsfkFtCTWNF0Hs5mB
        ypu3zmaGaJ3KIfFqUTaE7SIxt+8/C4QtLPHq+BZ2CFtG4vTkHhaQ8RIC9RKTJ5mBXCkh0MMo
        sW3OD6h6a4k7536BncAsoCmxfpc+RNhR4t/JVmaIVj6JG28FIS7gk5i0bTpUmFeio00IolpF
        Yl3/HqiBUhK9r1YwTmBUmoXkl1lI7p+FsGsBI/MqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT8
        3E2MwAR3+t/xTzsYv15KOsQowMGoxMNrYHgtTog1say4MvcQowQHs5IIr9PZ03FCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MJYVp76aXGOVFtbaPzWh
        87nQaf/WNL+6Ko35ryfwGq1bwXvYzspK0Dfy5uI6J/O9aW7Ri49ob4xunTN/UtqP/QEKzbZh
        9YI2qX7Hq7+/+tWpLJL9y0t3+4KeKr+kFoN3DOluvLk357WdfCR2pv/PLo87s9zifhl27cye
        XROU8aA4fnnEoQc5SizFGYmGWsxFxYkAXv+GrWwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzo7a7DSNXvzQZRCC1PQ4da95ofpgJ4ky+la2NfTgpF10
        Z7O0D2pC5QKbkWUzh0Sm2WU4u0gXzCmVzUydzGkXXGmaXRCT0lJrJ4n89vD///7Pw8PzkJjk
        Ex5B5upNrFGv1kqJYNy9+PTt5svHvMqY7plNqLnaIURnbz0WoKHSBwLUfVqHhlyNADnfe4XI
        c/8SgVxVjwC62flGhPwjPiG6vvgcoCnrbwGab5vDUYuzCtsayni8fRhTU9KHMwtNExhT5zQz
        zqZygnntfUgwX3t6REzLlWLGOvWFYCpuNwHmm3NtRsh+WbLRYDax6zUGzpQiPUCjWBmdiGSx
        cYkyWq44uCU2XhqdmpzNanMLWGN06iGZZnxYlVcZerTTP4yXgPYQCwgiIRUHrRV1wAKCSQlV
        D6Drql1kAWTAiIDXanOWmDA477UQS8wYgL3nG0W8QVDb4Jn6Z0LeCKcWBLDd5v5LYZQXwGZr
        F8ZTYRQNL/zuB3xXnNoIRzwEL4upJOj1/BIsTVgHTzbcI3gkiEqGNTNaXpZQOuhvmBQt4atg
        18VRnEcwKhI67BJeXklFwRvHB3G+xgJdyu7UYFYgsS1L2P4nbMuoOoA1gXDWzOlydBwt49Q6
        zqzPkWUZdE4QOPTdJ3MtraC/eZ8LUCSQrhDH0F6lRKgu4Ap1LgBJTBou3v7CrZSIs9WFRazR
        oDKatSznAvGBJSuxiNVZhsDb6E0qOp5WoERaIVfIE5B0jfgU1Z4poXLUJvYwy+axxn85ARkU
        UQKKI3dO/GSmHcK28vSPuz77X46iHyktprQys2EHo5iF7nxNm6XWr3y1t1c8acygUauvss5H
        jU+bhwbjhgfO2eT2dxtI3+4KnXbW5SotO8Ht+eD5bh7jqqM60scyHfFHxoVkfofKkFRkSEhQ
        A59qIc1hUhZa7GMDnF3WLMU5jZqOwoyc+g+GBxG0/gIAAA==
X-CMS-MailID: 20200602161738eucas1p2ccfaa7610dc6f76e209ba96d6278259e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200602161738eucas1p2ccfaa7610dc6f76e209ba96d6278259e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200602161738eucas1p2ccfaa7610dc6f76e209ba96d6278259e
References: <20200601142754.26139-1-l.stelmach@samsung.com>
        <20200602161731.23033-1-l.stelmach@samsung.com>
        <CGME20200602161738eucas1p2ccfaa7610dc6f76e209ba96d6278259e@eucas1p2.samsung.com>
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

