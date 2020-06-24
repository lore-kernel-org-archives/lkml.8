Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D5AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD8721789
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfdUW/uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390437AbgFXIdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbgFXId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:33:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E5C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so772095plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6L0sSvuJwPBVGN9Ohq5sd3L0jaFGTHLmQeT1JCfgJfY=;
        b=VfdUW/uzzvEmR/U+vmvbk643UTJcokTJAKQfqN5Kut6DFr8gbaCfTe64IU8Yi4zNP2
         66LdHf+2Y/TzC/HWot/VVYnFEv7FvY5KFXPU+zUlSAViJb/pgvvZdwq/bTvDv35Lj8qP
         dUDTRQtw5RLqnPbskCOEpWj0Z7jpO5h7C0Kbwfkb8V0ONRg32Pi0vRqh+ZicTpACB/Q5
         hhq5GkSA41HCg2bw9UCbkPrwzZ+D2ErkGOwoeUMv+ZgwtcVAOJ6hYrb/HM6mdjTFdfGr
         3Zup1MHOWff/+WaErP94/+5gh2YJy0VnA0riiQGn/FRmkJn1gUgF5uqC021Aq6aTYq3R
         2uDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6L0sSvuJwPBVGN9Ohq5sd3L0jaFGTHLmQeT1JCfgJfY=;
        b=lwNg5q8rLBmbcM39u5spD/mJ94I5a0C7voSAE2n1vtyMjuxw05P2Tf07aHxVMjTHKP
         c1yJAg/CWLZd3CrpjtjvO5skccj/mk8ik6pmXSZc1aR1E9qZDJwhdQ62I7/NLq6RSHy8
         zN7hrKxnIhPkdhkHwvd4+Bj74YX6u7B58/sqqUSGqflhGU7NhifbQQqpE1XfVHTd6jg1
         N4aVKrABAviVFnJ8cqhHL+MzFRv+r2p/RP3jrC3VaP6LvZWB7n0KdHV0Aw5vKflYyBkG
         S1u9ZYJUM3m8LJv+ZJqXP0Yi2mraxxe5yzuOnrDCXxUDX2MNp22HqvxIh6C4FjOVfcXF
         wGiQ==
X-Gm-Message-State: AOAM530OcvVEGVpU+ojEgw15wVCEzC1IytlWRMYtZOZSveFg5oZMl3mS
        +WTf65lFGwLqDOKK4oXig+k=
X-Google-Smtp-Source: ABdhPJznW9WmgcnAZJ1i65s0e6ryKofDyAzqw/jLqIO9jdzsh+wDjR8S+aZaTnpL4ko6Rs16mnwTzA==
X-Received: by 2002:a17:90a:c797:: with SMTP id gn23mr26694003pjb.165.1592987605689;
        Wed, 24 Jun 2020 01:33:25 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id g17sm4558614pju.11.2020.06.24.01.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:33:24 -0700 (PDT)
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
Subject: [PATCH 2/6] arm64/vdso: Zap vvar pages when switching to a time namespace
Date:   Wed, 24 Jun 2020 01:33:17 -0700
Message-Id: <20200624083321.144975-3-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order of vvar pages depends on whether a task belongs to the root
time namespace or not. In the root time namespace, a task doesn't have a
per-namespace page. In a non-root namespace, the VVAR page which contains
the system-wide VDSO data is replaced with a namespace specific page
that contains clock offsets.

Whenever a task changes its namespace, the VVAR page tables are cleared
and then they will be re-faulted with a corresponding layout.

A task can switch its time namespace only if its ->mm isn't shared with
another task.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/kernel/vdso.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 7c4620451fa5..bdf492a17dff 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -124,6 +124,37 @@ static int __vdso_init(enum vdso_abi abi)
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar mapping contains data for a specific time namespace, so when a task
+ * changes namespace we must unmap its vvar data for the old namespace.
+ * Subsequent faults will map in data for the new namespace.
+ *
+ * For more details see timens_setup_vdso_data().
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	mmap_read_lock(mm);
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
+	mmap_read_unlock(mm);
+	return 0;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-- 
2.24.1

