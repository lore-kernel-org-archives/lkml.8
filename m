Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8CC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2392620776
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592919130;
	bh=tN9aRL4pHrBCYhyfhZTcndNej+VastPj+Z3hzYU/sxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfuxYMg63BOxOUgutx0i1t3QNUBAqcjsmeZFywhCS9+sm3T3dUKHdJgC9HExjFBjt
	 b8+s0vhU8b9hqTnLbgPHI1zIRtNS+ZaZnGHSWr0ptFZyuKSwm8fL79QiOk1WO/xmId
	 KCLXWxR1DSE1qnLtskNaBeGvK5Daw2nxQVJ6BN8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgFWNcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbgFWNbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:31:45 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AD52082F;
        Tue, 23 Jun 2020 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592919104;
        bh=tN9aRL4pHrBCYhyfhZTcndNej+VastPj+Z3hzYU/sxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQU2DpCpmVq12wLuLrk0MrKQUOgMkCPGT+rmign2Kj5uahu12lS4nRQyauln7+ahW
         gTYcHP0qWrjGLx1/iau3BvvNLNJtIQ6Eu3wWDw/kXAT7GaHzmYwLCO0GBvF0If4f7p
         a6C/5dim3pncgyVECy1BGmVEZmukvtT4HfR6UV04=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnj1Z-007VJh-DS; Tue, 23 Jun 2020 15:31:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nitin Gupta <nigupta@nvidia.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 3/7] docs: move nommu-mmap.txt to admin-guide and rename to ReST
Date:   Tue, 23 Jun 2020 15:31:36 +0200
Message-Id: <3a63d1833b513700755c85bf3bda0a6c4ab56986.1592918949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592918949.git.mchehab+huawei@kernel.org>
References: <cover.1592918949.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nommu-mmap.txt file provides description of user visible
behaviuour. So, move it to the admin-guide.

As it is already at the ReST, also rename it.

Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/mm/index.rst                          | 1 +
 Documentation/{nommu-mmap.txt => admin-guide/mm/nommu-mmap.rst} | 0
 Documentation/admin-guide/sysctl/vm.rst                         | 2 +-
 Documentation/gpu/drm-mm.rst                                    | 2 +-
 init/Kconfig                                                    | 2 +-
 mm/Kconfig                                                      | 2 +-
 mm/nommu.c                                                      | 2 +-
 7 files changed, 6 insertions(+), 5 deletions(-)
 rename Documentation/{nommu-mmap.txt => admin-guide/mm/nommu-mmap.rst} (100%)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 11db46448354..774dad6d3d29 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -31,6 +31,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
+   nommu-map
    numa_memory_policy
    numaperf
    pagemap
diff --git a/Documentation/nommu-mmap.txt b/Documentation/admin-guide/mm/nommu-mmap.rst
similarity index 100%
rename from Documentation/nommu-mmap.txt
rename to Documentation/admin-guide/mm/nommu-mmap.rst
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4b7c496199ca..4b9d2e8e9142 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -598,7 +598,7 @@ trimming of allocations is initiated.
 
 The default value is 1.
 
-See Documentation/nommu-mmap.txt for more information.
+See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 
 numa_zonelist_order
diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index 8d10e6b38918..9abee1589c1e 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -311,7 +311,7 @@ To use drm_gem_cma_get_unmapped_area(), drivers must fill the struct
 a pointer on drm_gem_cma_get_unmapped_area().
 
 More detailed information about get_unmapped_area can be found in
-Documentation/nommu-mmap.txt
+Documentation/admin-guide/mm/nommu-mmap.rst
 
 Memory Coherency
 ----------------
diff --git a/init/Kconfig b/init/Kconfig
index a46aa8f3174d..2dd5531dae98 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1957,7 +1957,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	  userspace.  Since that isn't generally a problem on no-MMU systems,
 	  it is normally safe to say Y here.
 
-	  See Documentation/nommu-mmap.txt for more information.
+	  See Documentation/mm/nommu-mmap.rst for more information.
 
 config SYSTEM_DATA_VERIFICATION
 	def_bool n
diff --git a/mm/Kconfig b/mm/Kconfig
index f2104cc0d35c..d41f3fa7e923 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -387,7 +387,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 	  This option specifies the initial value of this option.  The default
 	  of 1 says that all excess pages should be trimmed.
 
-	  See Documentation/nommu-mmap.txt for more information.
+	  See Documentation/mm/nommu-mmap.rst for more information.
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
diff --git a/mm/nommu.c b/mm/nommu.c
index f32a69095d50..314174817b04 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -5,7 +5,7 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
- *  See Documentation/nommu-mmap.txt
+ *  See Documentation/mm/nommu-mmap.rst
  *
  *  Copyright (c) 2004-2008 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
-- 
2.26.2

