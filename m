Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67729C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D32320774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Nt3Xinqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCZDYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43853 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgCZDYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id a5so4169403qtw.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=thpe0Z5kEvTnM2eeAPZkTi6F3w4Pb+HUczSr2KuT1UY=;
        b=Nt3Xinqq4GDXUh4q1gt240eSwVB4FlleAi4yheETVwWyB9pE4ZB9fhvoPxAwkhLLpP
         Hel+tkJ2MOJLYJF6Ft+ia7fYJNDVTK0/BQEdJGWtrFp/KqJf+jbtO1QKVz1d4/aVr7E/
         odepPYYW/C2vMcwYOzeuK7gefOa2hthxOoxybyCgMgvMvSdaIgKnF2VBz1guVAylP8wj
         gcmFQcPycw8EOZJFcOXFSSph4/YpQFH5NYwCOlC6tBBxmCoZi3jeb5xpSXXAV3abItoU
         Am7UWAXBZHc8yP9UBGR9FlYtvqfxFO/+pzq6qBUb0dxaMy7wgRE0cMJ/Kt4mHT9uxfON
         EOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=thpe0Z5kEvTnM2eeAPZkTi6F3w4Pb+HUczSr2KuT1UY=;
        b=kzvrbtMjRzbaU/ves5bUJ3xvBBqq74C+KN0XLRMTsQAIjt0u+vQK0Gl3RhXV7o6HDq
         BHSPgb3tvZVvT3q3D/irxzcJqF5ENzNaROGyW2YikmxiaB34rS0r+duuNRkSBqy1OWrz
         MaMC7Z076dNf8DhewQCLW6bs+0FgZsH6nsiWdRD54m2vGtgrtKJMCWJL7vPBm5Q6DHZt
         Wnemzt/yyqihq7kpwQrVkuMQSZIfGeWxfGMQoC95sDKe7ItM3TYOZve20OmeP3rkcneH
         kyswZns1iLFc2Y6H/LKPEtyXG8+M232PTfgF/BoQmoC735EIb+ZjfSunCzwQdoYbz6Un
         Zefg==
X-Gm-Message-State: ANhLgQ3inerCXnB2KQeMBt0Z1r1ON6gpqeCfTLrcEAJZBJHDDA0JNB50
        6MAYZer4r7KXqznbIPpNgaa2FA==
X-Google-Smtp-Source: ADFU+vs8AB+ycYsqo1ntrv2C2y3Y5wNtM59sTWQw+jvfb/SJvWSGTmarQ+JsRphJYNn9X4qaL+i0xg==
X-Received: by 2002:ac8:4982:: with SMTP id f2mr6355374qtq.38.1585193064365;
        Wed, 25 Mar 2020 20:24:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:23 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de, selindag@gmail.com
Subject: [PATCH v9 01/18] arm64: kexec: make dtb_mem always enabled
Date:   Wed, 25 Mar 2020 23:24:03 -0400
Message-Id: <20200326032420.27220-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
enabled. This adds ugly ifdefs to c files.

Always enabled dtb_mem, when it is not used, it is NULL.
Change the dtb_mem to phys_addr_t, as it is a physical address.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 4 ++--
 arch/arm64/kernel/machine_kexec.c | 6 +-----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d24b527e8c00..61530ec3a9b1 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,18 +90,18 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
-#ifdef CONFIG_KEXEC_FILE
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
 	void *dtb;
-	unsigned long dtb_mem;
+	phys_addr_t dtb_mem;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
 	unsigned long elf_headers_sz;
 };
 
+#ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8e9c924423b4..ae1bad0156cd 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -203,11 +203,7 @@ void machine_kexec(struct kimage *kimage)
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
 	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
-#ifdef CONFIG_KEXEC_FILE
-						kimage->arch.dtb_mem);
-#else
-						0);
-#endif
+			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
 }
-- 
2.17.1

