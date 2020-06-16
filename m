Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61F1206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW8gH2+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFPH4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPHz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:55:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D8C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:55:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so2623478plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Pc3zQ9D2av6U7xF9LkytuVQ3TEKU9mvAt7OV64zjjY=;
        b=HW8gH2+TWNb0LHKZx/L2PoIBSnyiXdbLTjOzJ/095pH2++lNTMOONJ7xnnd0H+jHXW
         cy2ds/KJlPcq6GvcObZ0FRsBjmMtjKWL04vJrlL98/z3To2opDDDxNgkBGN8RuF7Ae3x
         26fr4H4QJtPjynRAQ+ouigUzMUv/iRlDT0tVGf/ctsZen6y3c52pZY+T9a7+kTgc7hfX
         +JWpN6PEiFPBEQX8/EqL6YsmcotVfmmhSi+4UuWoXiZEhIsClFPnNzka2k7W8rVdpxFy
         p/t6p2eVOdaj9vQ12Q81vUnfC+XghwjgAFfIukI5h4ap265404FgcNAAVN7Y1VA0acZ9
         uP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Pc3zQ9D2av6U7xF9LkytuVQ3TEKU9mvAt7OV64zjjY=;
        b=uEMZxtJBcYUW9En2yAhTRlij65QkwJMXn+sJOYxe+0IW5qONbYJOjSWYitTWr2AaeI
         6vJGRGMTnorm3mfVYDXYNiuUox8WsD6pb34VUiHp4dPDFff6sLPLr3k/bda1oRXhQ9ec
         JKy8iZ9hwlDsPciDQXNVHt4TrPo3pLlGUMdtIn/IiiT9jV6wcuem4NlTp6RI6ZuIBC3S
         DhfvCj3RMvQTrI0Fib0UF/ntF+OAgQ09+csydBTBZdlLjFamNSAHAOB3xyOUb1VgJU6n
         laZxumsgV2+VrE4BpPPzYrSDhOa5ZqKScGyXfkRdbMH9OoPEQ8l8oBN3jUDjRJSH2W3L
         wGGQ==
X-Gm-Message-State: AOAM53361prmP1BKGGzZbhZXBGC28iySFXJRKG2/jaszKoP8jHQwu5bq
        KnxPAkBdJkBOnA6vrNmyQ+U=
X-Google-Smtp-Source: ABdhPJysK/fjxfmRiTrNZmw9EgjGa6tFHoxvuUSFZZaxSjSNA9SxfwRSCAcSao3vO+Osm947ZTQLzw==
X-Received: by 2002:a17:90b:3448:: with SMTP id lj8mr1567308pjb.163.1592294157009;
        Tue, 16 Jun 2020 00:55:57 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id g6sm16168984pfb.164.2020.06.16.00.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:55:56 -0700 (PDT)
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
Date:   Tue, 16 Jun 2020 00:55:41 -0700
Message-Id: <20200616075545.312684-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200616075545.312684-1-avagin@gmail.com>
References: <20200616075545.312684-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will be re-faulted with a
corresponding layout.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index b0aec4e8c9b4..df4bb736d28a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -125,6 +125,38 @@ static int __vdso_init(enum vdso_abi abi)
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
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
+			zap_page_range(vma, vma->vm_start, size);
+#ifdef CONFIG_COMPAT_VDSO
+		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA32].dm))
+			zap_page_range(vma, vma->vm_start, size);
+#endif
+	}
+
+	mmap_write_unlock(mm);
+	return 0;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-- 
2.24.1

