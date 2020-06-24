Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1253C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C4E20823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0I2N5m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390397AbgFXIdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389050AbgFXId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D74C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ev7so385718pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+phrT2AIdF4lRnMSVXuWInx9nAkEBMgCLH5q3WFhgHA=;
        b=f0I2N5m0fzWQAgaAToovJ+mgoHHV7sYYaDPhna45YTff7YHh0Z+1WKoPHFzeCDQ1uf
         eBz5MFamNgglzinB3hqAsBNG1jzQ/4rOcvpqgYHf9aMtvePAoWLBJ/PGHVh67cfqUDng
         WzLJVQs7gQS+sPPeDBKkHbqBAwu6AYEMSP5BMTS5I7YzfK2JREj0qLqfWOT2ax/UxLf8
         jFDzntIjEjnzqf4tq9nLYdezKdRkmuWinYkNilFKVBRf+/F7OH8vrtiy9Gw7TkoB8C4z
         L8J+EAIpZy4EvhwSQt34sSakOsD4GC2jtggLvm6Gc0nlROno9P7xygb1qqoVJMS+L/2+
         9aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+phrT2AIdF4lRnMSVXuWInx9nAkEBMgCLH5q3WFhgHA=;
        b=BNTCdsP4OglUUk2HxdkFR5t6+FP1VF5DUiU6dGNUUcBCv0/HRGEXcaADragIKRopIm
         nGSBR/iil32wS5xrjMImmWqZ/BGHZ2BUSCXdLYhFek8cttuDwPqGuCEs8tvYB8nP/hH/
         NoHT+I3QcKqPgArympYzpKBDMORWNctugjC3FQROHzIkJPzCgtSr0wpiow5gnWSD1sZX
         5JoHo1MegGsicJKvnd1zXHm2WwE3uUYyfcFTYmLkcdeJ2wYES81bHFYiS/t6nW+rJ4Yi
         cXCTv4fJdT+voFOWhxlVZbCF+2UHlTbZPcbaEc1x4J9Utrwc/nx4nMj0n7wXb5QxuPFt
         flUQ==
X-Gm-Message-State: AOAM5320XIFMahCfVT0/y+SPp9EFZVZO23yyBCrzV+y+1VSqNUAUwWMy
        Y86sw9RiFUDGj9E1b/umsJs=
X-Google-Smtp-Source: ABdhPJxEt2RHWxak+h/6okxR79SS4HgDc3N0nuv8EGttbDypYw9/wQ+ih8+B+khvyDujbln0caVp5g==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr21427195plz.87.1592987608751;
        Wed, 24 Jun 2020 01:33:28 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:28 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 5/6] arm64/vdso: Restrict splitting VVAR VMA
Date:   Wed, 24 Jun 2020 01:33:20 -0700
Message-Id: <20200624083321.144975-6-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forbid splitting VVAR VMA resulting in a stricter ABI and reducing the
amount of corner-cases to consider while working further on VDSO time
namespace support.

As the offset from timens to VVAR page is computed compile-time, the pages
in VVAR should stay together and not being partically mremap()'ed.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index be9ca8c46cff..8be6bd6625db 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -224,6 +224,17 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		       struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+
+	if (new_size != VVAR_NR_PAGES * PAGE_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -306,6 +317,7 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VVAR] = {
 		.name = "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
@@ -474,6 +486,7 @@ static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	[AA64_MAP_VVAR] = {
 		.name	= "[vvar]",
 		.fault = vvar_fault,
+		.mremap = vvar_mremap,
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-- 
2.24.1

