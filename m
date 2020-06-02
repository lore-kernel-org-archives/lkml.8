Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D36DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF13B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc9Kjh5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBSDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFBSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:03:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFFFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:03:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so1889500pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xduVDJsRlgliJcQL58QqcKbDz/BTgkkM9d/dUnD0dlk=;
        b=hc9Kjh5Ksvxx2g/UwK/Xg+LMKcfr/E0AwwubQnwak+KnY2nYmkOMubnJvCD4cB5PeN
         QclEVzxQDq0N4VsdQnF/KvRsiMbh31TO+kFea8DLl1YPdOyGXCzdartKJvEsPoiIvAiF
         461Pe0ucsyGy+BwIiJBYNg3A1t7bIpiNRonOCq3AWAHULVqjSNA1XI6lpk92ZhKV6YBc
         5Ime/Yulu3Ju/sqEgIIa0P+IEB8b8y8uj0L6WIgav9J1H9NgDAJOPyJXOhdyYBIJ41yo
         R8N2Qc0L7POcZKwzBoIlj48/ItBOA/fcknTSIByEIOZx9Gv/f9K+p0OzrzUI4dVpIwGx
         p70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xduVDJsRlgliJcQL58QqcKbDz/BTgkkM9d/dUnD0dlk=;
        b=S+cYA1or7fTAYR1V8ymK41061UY2XZPJkR/f3l9V1TgCiizWlhfRibO1cBKg6clE6u
         WpKdDkMSgXY7Y4qrCH6MVFyAeNNmlwQJ6DNmEM0Gw5//sdeLfLwJD5A+uvwB+oKwQd0i
         aMFgcGvDtIqTGjAZy33LKVty+QlQaI2sKbd8QtdilJf7wNADAEyURm3EYnJWujrhEkjc
         ADsqh0+97FIpQN+oBaXuJO4STUqnRa9v5pNk9/s1DKGL8mAiNJX+Ksaf+F/YUPPriCSW
         yKVqdIFDq4EEeeBLY0hMuRHBOyNpb5QaQBlpGtC+WC3Y5PN4VscSpecpsjitJ8k3VsWW
         tyJQ==
X-Gm-Message-State: AOAM530llaNFjxJPQJXZ9bSrUwCRKV+jpftHt9bD51jObkrUjg7DxIuP
        tcR1CWsxXoF2MdypJDqC4Tg=
X-Google-Smtp-Source: ABdhPJxaac7TRGf9B4Yfc6/Q7f2PY21P8UBX0Wnr5Ek/4NanfVovw9W+nvYjLwPpbDHD/J3IgwviJg==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr423404pjb.112.1591120986740;
        Tue, 02 Jun 2020 11:03:06 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id p8sm2740053pgs.29.2020.06.02.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:03:06 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time namespace
Date:   Tue,  2 Jun 2020 11:02:55 -0700
Message-Id: <20200602180259.76361-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200602180259.76361-1-avagin@gmail.com>
References: <20200602180259.76361-1-avagin@gmail.com>
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
index 031ee1a8d4a8..33df3cdf7982 100644
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

