Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC734C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2BF207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgHLJXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:23:02 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:46337 "EHLO
        7.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgHLJXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:23:02 -0400
Received: from player760.ha.ovh.net (unknown [10.108.42.170])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id E142613DA0F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:22:59 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id B3CDB15353C10;
        Wed, 12 Aug 2020 09:22:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-95G001fc86ea76-4989-4d97-a23d-2b9d13cd592a,
                    6B47CEF5255F3F5086931DB51E807497F854451F) smtp.auth=steve@sk2.org
From:   Stephen Kitt <steve@sk2.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] Fix references to nommu-mmap.rst
Date:   Wed, 12 Aug 2020 11:22:30 +0200
Message-Id: <20200812092230.27541-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13038765346632781299
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrledvgdduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nommu-mmap.rst was moved to Documentation/admin-guide/mm; this patch
updates the remaining stale references to Documentation/mm.

Fixes: 800c02f5d030 ("docs: move nommu-mmap.txt to admin-guide and rename to ReST")
Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 init/Kconfig | 2 +-
 mm/Kconfig   | 2 +-
 mm/nommu.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 2dd5531dae98..8d5fefd1f229 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1957,7 +1957,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	  userspace.  Since that isn't generally a problem on no-MMU systems,
 	  it is normally safe to say Y here.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config SYSTEM_DATA_VERIFICATION
 	def_bool n
diff --git a/mm/Kconfig b/mm/Kconfig
index d41f3fa7e923..29e239497718 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -387,7 +387,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 	  This option specifies the initial value of this option.  The default
 	  of 1 says that all excess pages should be trimmed.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
diff --git a/mm/nommu.c b/mm/nommu.c
index 64539971188b..e8e2c5bb6f0a 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -5,7 +5,7 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
- *  See Documentation/mm/nommu-mmap.rst
+ *  See Documentation/admin-guide/mm/nommu-mmap.rst
  *
  *  Copyright (c) 2004-2008 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>

base-commit: e176b7a3054eef44a22f6ca3d14168dcf9bad21e
-- 
2.20.1

