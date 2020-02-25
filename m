Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511DBC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F4D21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF+L0SkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgBYHhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:37:45 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51562 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgBYHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:37:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so884936pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AkyLcT/M41H8pNXfB2E+BzqT+C+wAkbHPxgbVN+0zTc=;
        b=hF+L0SkX3QFj58j9vqoEJ6IjIYswDgAEBWiesoy+sopgxymcU+R/Q2leded9N+UiPA
         yLatd1d8S25usCpHooLBktyUToJ6eO0zSHRZzBlsSzsunV4XlcRcGT0cIKFD3nSRfKRA
         hipJWwUyXC+TViT9VcLD5RfONN7yAKMnvq67oknJIIqp85Vjf9rRN00+pt2KGDF2MbX3
         4c2AS/WkRmpUJLcqnV5MFTtxJbVPA1SM/u1fgEFN8ngV5GbrP8Ta+3zhKlv449eH4MO6
         3Ri631Htals7fy2Oh4T/voA6GGp3QfuJ+uNLmwjxjsuMRgeetUxhrk4ctpQJvmQJOSOo
         0cLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AkyLcT/M41H8pNXfB2E+BzqT+C+wAkbHPxgbVN+0zTc=;
        b=T1lgeE0pu2zB60k8CEdbBur+b8GnI+jNXtw/zIilXi7mm5Pf/fqtyBSjW3/UlmxGQl
         Gn3QC+JGj99wlGotzvVoZX21oTSoJ3wIGBVm8+VO0+9D1/hRTxoBBqaCJc2MiI8IR7Bg
         jcU+Rb74FOL/A2d2BWYKF10TUO5WsKrrQyUHj3iWKnkPbYPQAAObyLGN3Lzdl7TincGF
         3r7Wq4qUkVB9pbPMOfoRtaqn4HSUI9HIgGaucDIXD4cr6UUhfplPlTJP4tKeKVPUvY06
         P6NvyaH5SCfoNSSBo0U+xCExFlIk6qdejfRMONpAJXk5P1cPV3laoPZGgS+n6SmyKgxP
         1viQ==
X-Gm-Message-State: APjAAAVrIAOQUqgkZjuKExl4Ht1ziu5QYWKMgXZ/o73s/KX10vOb368S
        2o5uefzRprNIfX8FcFOvXco=
X-Google-Smtp-Source: APXvYqwnmes/Pi/02QPjNqcbuZoJp4CZnWoJVVApGWQqfgKMt8MSEPCZzU8aeC8A78O3AeoOmzvmhQ==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr55796788plb.268.1582616262049;
        Mon, 24 Feb 2020 23:37:42 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id m128sm15979390pfm.183.2020.02.24.23.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:37:41 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 2/6] arm64/vdso: Zap vvar pages when switching to a time namespace
Date:   Mon, 24 Feb 2020 23:37:27 -0800
Message-Id: <20200225073731.465270-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will be re-faulted with a
corresponding layout.

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

