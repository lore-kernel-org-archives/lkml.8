Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812EEC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6001B2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEFR40jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406646AbgDPF1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406481AbgDPF0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:26:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB62C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so946394plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qrvi9cfOMWugmztCzSRhVUwuOgDWuroc1zUU7Jui6fE=;
        b=nEFR40jzawzbAo86Fn7AlbI47j6RcYuIHU57HJodL+mJEh/+ODMMd0houcnmMRTDQm
         CmNFos10maNtWktoQ/xvzPG0knqvXQR5Lj9P5NaI9lto16D140T3cud32vm4qRGYF7aN
         bEkIpF0d16foHYOPyDCbUIK3CCmetinOblwsamt90Rqtvta2GkhCPmXmU5J1HVybRdOS
         kYRb/4ivlnxk16x/UPxjYKNWtKjCOjYObTVuJbBg5kpbuaOmNH2E4JA4HXkXE7nemtEG
         BOZsq2UU0iOk8vh8GdP0OUNqkZjolusbFMks/2NAmsEHRaHca+9q2Ya9SzKX/Xd+A5FO
         fBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qrvi9cfOMWugmztCzSRhVUwuOgDWuroc1zUU7Jui6fE=;
        b=M8q8C7eq5SBck6uuOI3PjcVIoBsEP1ptnyw2THL7dWdpMA2tX7UWJDRFh2fAoxfUv7
         2kdul6Td2Zo+BsH/LOUFPGaViVTFZJvTLHjsVAMEZFkF4R4ik5EQFBLjJvWLUgjdlkIo
         +S19gdVoAxLGkKfA3GM8mA46R0HuGjtArAZaSXj+qfTWWnMwQQ9qfGoE+rKzfvjOwpez
         eF+hOAJpq86cMddsahIuWwWwkALih6Wyc7koQhHs6bNVaAVJiAlAVbQVXmdm0T+v5Sa0
         moRVvOebg0aq2lANjf/8tthWkk3OX/F6BCfFJ4YzaCYWj7jUFSSNRgGdaN/A9nEtr+s7
         cdwQ==
X-Gm-Message-State: AGi0Pub4uvCAc3FU0j5g5COFe5LtimPbTMxpb9goZ7AMB1cI9b9lpcvn
        3+C0ESArgutO7z6kbbbI348=
X-Google-Smtp-Source: APiQypKao4SzdhZEtr7vlpmK90LbMhqJidYVNIjSwySwr3ySDyw4BnlPpNR50T9Hw+R9x2EN5QA2EA==
X-Received: by 2002:a17:90a:3726:: with SMTP id u35mr3113764pjb.162.1587014804922;
        Wed, 15 Apr 2020 22:26:44 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id c21sm53699pjr.2.2020.04.15.22.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 22:26:44 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time namespace
Date:   Wed, 15 Apr 2020 22:26:14 -0700
Message-Id: <20200416052618.804515-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200416052618.804515-1-avagin@gmail.com>
References: <20200416052618.804515-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will be re-faulted with a
corresponding layout.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 290c36d74e03..6ac9cdeac5be 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -131,6 +131,38 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, vdso_lookup[ARM64_VDSO].dm))
+			zap_page_range(vma, vma->vm_start, size);
+#ifdef CONFIG_COMPAT_VDSO
+		if (vma_is_special_mapping(vma, vdso_lookup[ARM64_VDSO32].dm))
+			zap_page_range(vma, vma->vm_start, size);
+#endif
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-- 
2.24.1

