Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E73C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CCD2073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347514;
	bh=X9IwW9Dgu1ZI2pQWkGwOoQW72Fqs/UdpS+9EuBxTAMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O4IUyVwU8aKvcKmBa758d1P+FytX208fh5yT8vurhOUGabexIfdMxBw3tbDtvvmMv
	 YrLfvKjKaHIE8vJHRwVUFEDz0lyXwD+ZN3esO1mo4+2aTCxl596nxkO6QmdUDgoEFF
	 fmIxszz7XgJDOjr1+sYqcU5iMtp05yf5Gho+65Sk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgEAPic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729853AbgEAPiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C702496C;
        Fri,  1 May 2020 15:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=X9IwW9Dgu1ZI2pQWkGwOoQW72Fqs/UdpS+9EuBxTAMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=etq06kbGpfocH4wTcLTCj5CUBNhx2E/wFL1e+ua6SGhKezE5HsiwpYvhwXnQ4SgvV
         J3u04HIdzbDjrs9SmxDE8PV9whI77H2Agr6IHtE6R/o19qvwVdZu+svjo4+0biyrfQ
         ZAwxiVZkBiKcWs6jSwfiVZgv+n93c3NVjMPF0bI0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE59-7w; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: [PATCH 11/14] docs: move other kAPI documents to core-api
Date:   Fri,  1 May 2020 17:37:55 +0200
Message-Id: <70cca102282ccd36b107487c60346f414011c684.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of random documents that seem to be
describing some aspects of the core-api. Move them to such
directory, adding them at the core-api/index.rst file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/sysctl/vm.rst                     | 2 +-
 Documentation/core-api/index.rst                            | 6 ++++++
 Documentation/{mailbox.txt => core-api/mailbox.rst}         | 0
 Documentation/{nommu-mmap.txt => core-api/nommu-mmap.rst}   | 0
 .../{this_cpu_ops.txt => core-api/this_cpu_ops.rst}         | 0
 .../unaligned-memory-access.rst}                            | 0
 Documentation/gpu/drm-mm.rst                                | 2 +-
 arch/Kconfig                                                | 2 +-
 init/Kconfig                                                | 2 +-
 mm/Kconfig                                                  | 2 +-
 mm/nommu.c                                                  | 2 +-
 11 files changed, 12 insertions(+), 6 deletions(-)
 rename Documentation/{mailbox.txt => core-api/mailbox.rst} (100%)
 rename Documentation/{nommu-mmap.txt => core-api/nommu-mmap.rst} (100%)
 rename Documentation/{this_cpu_ops.txt => core-api/this_cpu_ops.rst} (100%)
 rename Documentation/{unaligned-memory-access.txt => core-api/unaligned-memory-access.rst} (100%)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 0329a4d3fa9e..0bf2f2a84a9f 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -583,7 +583,7 @@ trimming of allocations is initiated.
 
 The default value is 1.
 
-See Documentation/nommu-mmap.txt for more information.
+See Documentation/core-api/nommu-mmap.rst for more information.
 
 
 numa_zonelist_order
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index eeac63ba17c3..fe03a639a91a 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -38,10 +38,14 @@ Library functionality that is used throughout the kernel.
    circular-buffers
    rbtree
    generic-radix-tree
+   mailbox
    packing
+   rbtree
+   this_cpu_ops
    timekeeping
    errseq
 
+
 Concurrency primitives
 ======================
 
@@ -82,11 +86,13 @@ more memory-management documentation in :doc:`/vm/index`.
    :maxdepth: 1
 
    memory-allocation
+   unaligned-memory-access
    dma-api
    dma-api-howto
    dma-attributes
    dma-isa-lpc
    bus-virt-phys-mapping
+   nommu-mmap
    mm-api
    genalloc
    pin_user_pages
diff --git a/Documentation/mailbox.txt b/Documentation/core-api/mailbox.rst
similarity index 100%
rename from Documentation/mailbox.txt
rename to Documentation/core-api/mailbox.rst
diff --git a/Documentation/nommu-mmap.txt b/Documentation/core-api/nommu-mmap.rst
similarity index 100%
rename from Documentation/nommu-mmap.txt
rename to Documentation/core-api/nommu-mmap.rst
diff --git a/Documentation/this_cpu_ops.txt b/Documentation/core-api/this_cpu_ops.rst
similarity index 100%
rename from Documentation/this_cpu_ops.txt
rename to Documentation/core-api/this_cpu_ops.rst
diff --git a/Documentation/unaligned-memory-access.txt b/Documentation/core-api/unaligned-memory-access.rst
similarity index 100%
rename from Documentation/unaligned-memory-access.txt
rename to Documentation/core-api/unaligned-memory-access.rst
diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index 1839762044be..e0bbcbb6f512 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -314,7 +314,7 @@ To use drm_gem_cma_get_unmapped_area(), drivers must fill the struct
 a pointer on drm_gem_cma_get_unmapped_area().
 
 More detailed information about get_unmapped_area can be found in
-Documentation/nommu-mmap.txt
+Documentation/core-api/nommu-mmap.rst
 
 Memory Coherency
 ----------------
diff --git a/arch/Kconfig b/arch/Kconfig
index 786a85d4ad40..b0b4046c9d13 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -147,7 +147,7 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	  problems with received packets if doing so would not help
 	  much.
 
-	  See Documentation/unaligned-memory-access.txt for more
+	  See Documentation/core-api/unaligned-memory-access.rst for more
 	  information on the topic of unaligned memory accesses.
 
 config ARCH_USE_BUILTIN_BSWAP
diff --git a/init/Kconfig b/init/Kconfig
index 492bb7000aa4..61ccfd9243e3 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1950,7 +1950,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	  userspace.  Since that isn't generally a problem on no-MMU systems,
 	  it is normally safe to say Y here.
 
-	  See Documentation/nommu-mmap.txt for more information.
+	  See Documentation/core-api/nommu-mmap.rst for more information.
 
 config SYSTEM_DATA_VERIFICATION
 	def_bool n
diff --git a/mm/Kconfig b/mm/Kconfig
index db626b8d4fdb..2a133c40a4b7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -382,7 +382,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 	  This option specifies the initial value of this option.  The default
 	  of 1 says that all excess pages should be trimmed.
 
-	  See Documentation/nommu-mmap.txt for more information.
+	  See Documentation/core-api/nommu-mmap.rst for more information.
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
diff --git a/mm/nommu.c b/mm/nommu.c
index 371697bf372d..e3e707d6f124 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -5,7 +5,7 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
- *  See Documentation/nommu-mmap.txt
+ *  See Documentation/core-api/nommu-mmap.rst
  *
  *  Copyright (c) 2004-2008 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
-- 
2.25.4

