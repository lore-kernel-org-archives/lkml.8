Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B7C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607C82073E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583955211;
	bh=Bw4/xEpyDHzYLhZEHshtNZum9AZNeo7acrZD+FQGz0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WzVskFs8A4/AvWkfZus9gbgjHPp5wKfYjU29nLz39ywt6T9ZFijxi6eC9ucroXkLb
	 0yidt6RExEFPZMX37Zi0YllmYJnzr0q1zSMoeSFfagM059oD5ud56UqAD5xM8hHIj9
	 +kNmzMBvBSby6YfkQrZc0gZI9uITly7K+KMWHhGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731394AbgCKTd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:33:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731376AbgCKTdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:33:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180887FA;
        Wed, 11 Mar 2020 12:33:25 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6D33F534;
        Wed, 11 Mar 2020 12:33:24 -0700 (PDT)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v9 12/13] mm: smaps: Report arm64 guarded pages in smaps
Date:   Wed, 11 Mar 2020 19:26:07 +0000
Message-Id: <20200311192608.40095-13-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311192608.40095-1-broonie@kernel.org>
References: <20200311192608.40095-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kiss <daniel.kiss@arm.com>

The arm64 Branch Target Identification support is activated by marking
executable pages as guarded pages.  Report pages mapped this way in
smaps to aid diagnostics.

Signed-off-by: Daniel Kiss <daniel.kiss@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/filesystems/proc.txt | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 99ca040e3f90..ed5465d0f435 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -519,6 +519,7 @@ manner. The codes are the following:
     hg  - huge page advise flag
     nh  - no-huge page advise flag
     mg  - mergable advise flag
+    bt  - arm64 BTI guarded page
 
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3ba9ae83bff5..1e3409c484d1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -668,6 +668,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_ARCH_1)]	= "ar",
 		[ilog2(VM_WIPEONFORK)]	= "wf",
 		[ilog2(VM_DONTDUMP)]	= "dd",
+#ifdef CONFIG_ARM64_BTI
+		[ilog2(VM_ARM64_BTI)]	= "bt",
+#endif
 #ifdef CONFIG_MEM_SOFT_DIRTY
 		[ilog2(VM_SOFTDIRTY)]	= "sd",
 #endif
-- 
2.20.1

