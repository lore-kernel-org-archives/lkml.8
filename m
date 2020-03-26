Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68331C2D0E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB0F2074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="D/H04vs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCZDYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:24:54 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39787 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbgCZDYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:24:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id b62so5110268qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=MnZdOr+8pXZ+Q7gD/wn/800kgQqBl+vWc7FKb2K6x14=;
        b=D/H04vs13b+3H+e67P/UARnFyO7yDtN0Ty+ZK+OBnCiOWB9/F+Fc5HLOOOqDcTyHXC
         upUUgW/VGgZc6ZbqtfIcIdr3SJktRRblws7WTorOV6RIpwbJmBWbJZmJn/xEcGByGchL
         cgLawoxwGWLWJDPU5b0SNyZVc/3EonILMFMYCcmx5VbqUVEkhwHQx/8p///+O99PsEfh
         7tHmGRUCwyp4Gjeb4Dw2BjU252LKFebXdKHsAIdI6bsXvV+axA/VrSlQbWfyV2hfRI+F
         7OSwGZufegvOoRbjxEOCpclvwAeJqLE2MQkXVU7ipXNnwAtmZuBXghgbzMJ5ly/fRQMh
         rQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=MnZdOr+8pXZ+Q7gD/wn/800kgQqBl+vWc7FKb2K6x14=;
        b=lw0wcFElncBo7RxMQrdg70wwsuGttoWHjZox8ksyCiYrUl23gSik54JLgOIuOzpe4A
         I2oO4tWY2teOYH1iGhAJnrGxLoxSaTKIF4uvp04fS4TGzMeTkyvWVp5qqTw5mP2uLAfE
         N/6LzBHJH0mhOdBVDOnbEdq79z0ksvrESaSVUIU01bxgAGP1Xs39TrN/7mp+N9BDvA1y
         uHc6Nkly/6fHWINH+ObrsexzI79GBPLRR5sScP2TwRyYUX3cPrByjWHxNiftfLY4jzQY
         U5mhh42m/8NGPNwAx410mP9+eurZpPP13JxMnTiPM5xQ6E4VvpSmYvXpxLEozA7kmqby
         CFUw==
X-Gm-Message-State: ANhLgQ2biAbkeJu7OLJ5uYDJvsvF6o4YXaRaVYVntkMRi33UAYlDzEt/
        uQzLdJCWFNvF8xIPnOZROcNKcCQECVU=
X-Google-Smtp-Source: ADFU+vvws7EYyMJKXCP8dR+RR+Z2bEQdm8J7Bgw0yIj4Z09bNr3plFyZB9XoZ8d3WpnVnyh4mAc+YQ==
X-Received: by 2002:a37:6807:: with SMTP id d7mr6162363qkc.112.1585193090776;
        Wed, 25 Mar 2020 20:24:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u4sm620034qka.35.2020.03.25.20.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 20:24:50 -0700 (PDT)
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
Subject: [PATCH v9 18/18] arm64: kexec: remove head from relocation argument
Date:   Wed, 25 Mar 2020 23:24:20 -0400
Message-Id: <20200326032420.27220-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326032420.27220-1-pasha.tatashin@soleen.com>
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that relocation is done using virtual addresses, reloc_arg->head
is not needed anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 2 --
 arch/arm64/kernel/asm-offsets.c   | 1 -
 arch/arm64/kernel/machine_kexec.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 8f4332ac607a..571a2ba886b9 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -100,7 +100,6 @@ extern const unsigned long kexec_el2_vectors_offset;
 
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
- * head		kimage->head, allows to traverse through relocation segments.
  * entry_addr	kimage->start, where to jump from relocation function (new
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
@@ -116,7 +115,6 @@ extern const unsigned long kexec_el2_vectors_offset;
  * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
-	phys_addr_t head;
 	phys_addr_t entry_addr;
 	phys_addr_t kern_arg0;
 	phys_addr_t kern_arg1;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 58ad5b7816ab..8673a5854807 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -130,7 +130,6 @@ int main(void)
   DEFINE(SDEI_EVENT_PRIORITY,	offsetof(struct sdei_registered_event, priority));
 #endif
 #ifdef CONFIG_KEXEC_CORE
-  DEFINE(KEXEC_KRELOC_HEAD,		offsetof(struct kern_reloc_arg, head));
   DEFINE(KEXEC_KRELOC_ENTRY_ADDR,	offsetof(struct kern_reloc_arg, entry_addr));
   DEFINE(KEXEC_KRELOC_KERN_ARG0,	offsetof(struct kern_reloc_arg, kern_arg0));
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index db96d2fab8b2..2d3290d7b122 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -162,7 +162,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, kexec_relocate_code_start, kexec_relocate_code_size);
 	kimage->arch.kern_reloc = __pa(reloc_code) + kexec_kern_reloc_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
-	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 	/* Setup vector table only when EL2 is available, but no VHE */
-- 
2.17.1

