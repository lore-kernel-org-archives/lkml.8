Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F208DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DA02077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFCGvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:51:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39286 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:51:06 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gavin.guo@canonical.com>)
        id 1jgNEt-0004nG-KD
        for linux-kernel@vger.kernel.org; Wed, 03 Jun 2020 06:51:03 +0000
Received: by mail-pg1-f197.google.com with SMTP id l25so1491671pgn.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=eCLQVK9qJ2IyH8+bGAqeIKvnAUBdF7t/xylwmKDU1d4=;
        b=KumgXyZVCRo7eCxJ74K+ZKgTkfgZrqwirIGmBI59PVpgFCYKN6CcJZUbs4ph8SvBcE
         SIlYovkP4mHv/nP89LFJdu+DY2n8e8FQA/Kcsy8bWOfalskzN6IRWiirn18mwPouybVg
         CyDZjgCsYL7CWmJp/gb+w72x5z1smqooDzqb5q0j8b+26t6W6wNWC0/EStTmjwog5jhK
         oeXGXdPw5d4mrtuB592iZSGazKPqxaJyE2/InAE8hfrXpdAygsX5qamQkugu2C84pfLD
         lTLKTD9l1Z2wzwotQJy7EiO/9iObkPK5YpAI022oE8f1qCXHOquSfBldfzHYkbI9jijv
         Y7Hg==
X-Gm-Message-State: AOAM533YtqomM/alY4ZCVMGf3/Wnh20Nz50p2w4ZhTLkKj2NqTZJeVUZ
        kGS2NfoMsyPP7FiCoZvxUti7E6rjr4om5PuLoeI9b2rGWA0GgPRjv/Je8xM4xXmqkuPDy1cwekF
        8LUVSAefHHm2yvXHYUiFc87kq3971J0Ax4tsQBYyIoA==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr3853973pjb.163.1591167061837;
        Tue, 02 Jun 2020 23:51:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX53r2sjzMJdQDKkzuuCAeGrCvBN1Boj0smlMgcsA0who1iLAyv2K+zvB6deoZufCShNd+Gw==
X-Received: by 2002:a17:90b:2350:: with SMTP id ms16mr3853948pjb.163.1591167061452;
        Tue, 02 Jun 2020 23:51:01 -0700 (PDT)
Received: from gavin-P70.buildd ([2001:67c:1560:8007::aac:c1c2])
        by smtp.gmail.com with ESMTPSA id j6sm984277pfi.183.2020.06.02.23.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 23:51:00 -0700 (PDT)
From:   Gavin Guo <gavin.guo@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: [PATCH] mm: thp: Add new kernel parameters transparent_hugepage_defrag/khugepaged_defrag
Date:   Wed,  3 Jun 2020 14:50:49 +0800
Message-Id: <20200603065049.11598-1-gavin.guo@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to set up the defrag options in boot time. And it's
useful to set it up by default instead of making it work by a
systemd/upstart service or put the command to set up defrag inside
/etc/rc.local.

Signed-off-by: Gavin Guo <gavin.guo@canonical.com>
---
 .../admin-guide/kernel-parameters.txt         | 18 ++++++++
 mm/huge_memory.c                              | 43 +++++++++++++++++++
 mm/khugepaged.c                               | 21 +++++++++
 3 files changed, 82 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6253849afac2..a9fd020d78db 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2149,6 +2149,16 @@
 	kgdbwait	[KGDB] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
+	khugepaged_defrag=
+			[KNL]
+			Format: { "0" | "1" }
+			0 - disable the defrag
+			1 - enable the defrag
+			Control the defrag efforts when generating the
+			transparent hugepages through khugepaged.
+			See Documentation/admin-guide/mm/transhuge.rst
+			for more details.
+
 	kmac=		[MIPS] korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
@@ -5146,6 +5156,14 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
 
+	transparent_hugepage_defrag=
+			[KNL]
+			Format: [always|defer|defer+madvise|madvise|never]
+			Control the defrag efforts when generating the
+			transparent hugepages.
+			See Documentation/admin-guide/mm/transhuge.rst
+			for more details.
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8091b780cd7a..86b20a3a1aac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -481,6 +481,49 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
+static int __init setup_transparent_hugepage_defrag(char *str)
+{
+	int ret = 0;
+	if (!str)
+		goto out;
+	if (!strcmp(str, "always")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "defer+madvise")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "defer")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "madvise")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "never")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG, &transparent_hugepage_flags);
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG, &transparent_hugepage_flags);
+		ret = 1;
+	}
+out:
+	if (!ret)
+		pr_warn("transparent_hugepage_defrag= cannot parse, ignored\n");
+	return ret;
+}
+__setup("transparent_hugepage_defrag=", setup_transparent_hugepage_defrag);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b043c40a21d4..39bbf2107a23 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -394,6 +394,27 @@ int __init khugepaged_init(void)
 	return 0;
 }
 
+static int __init setup_khugepaged_defrag(char *str)
+{
+	int ret = 0;
+	if (!str)
+		goto out;
+	if (!strcmp(str, "0")) {
+		clear_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
+			  &transparent_hugepage_flags);
+		ret = 1;
+	} else if (!strcmp(str, "1")) {
+		set_bit(TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
+			&transparent_hugepage_flags);
+		ret = 1;
+	}
+out:
+	if (!ret)
+		pr_warn("khugepaged_defrag= cannot parse, ignored\n");
+	return ret;
+}
+__setup("khugepaged_defrag=", setup_khugepaged_defrag);
+
 void __init khugepaged_destroy(void)
 {
 	kmem_cache_destroy(mm_slot_cache);
-- 
2.17.1

