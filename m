Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3191AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025EB206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598438886;
	bh=u9S5jIsemNuoCEAJSIYsKuNjZQ3fzTD3/s+bcU32+BY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UIIxeM6J4RPGf7Qk2E/jK4TuK9EHt1JOvPpd99CdzIGRp0WZKnkiw30JwrKzjJXOK
	 wz9fNNGh0ReE3ctqGc/isWgrYzKQjD4bLLV6wHMnzcVM0SihaEurNo30R87AHvPx8q
	 DGFSpzwee/JeCxBDS1C7M96adY89/sc0Qv5UV4ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgHZKsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:48:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgHZKre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:47:34 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216542080C;
        Wed, 26 Aug 2020 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598438854;
        bh=u9S5jIsemNuoCEAJSIYsKuNjZQ3fzTD3/s+bcU32+BY=;
        h=From:To:Cc:Subject:Date:From;
        b=oeA/w0BRaimPbrLgbfBFLLChfC+DXbCLljkGhgqjX4y+MlpCD/jrQBaSBHG9MBIHj
         CA8UGaB0bjTlfIZOTVQHyguGO5uJ0ZhtCkqJEBA7x3fk6oesxOwbRQf+XWIMvJAZvY
         9+JrItzuR7nZl8axB01J8am9Q+wvxzeGWnaZ1nRI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kAsxo-002EC4-3P; Wed, 26 Aug 2020 12:47:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] docs: fix location of nommu-mmap.rst file
Date:   Wed, 26 Aug 2020 12:47:30 +0200
Message-Id: <20200826104730.531177-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/nommu-mmap.rst -> admin-guide/mm/ nommu-mmap.rst

Fixes: 800c02f5d030 ("docs: move nommu-mmap.txt to admin-guide and rename to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 init/Kconfig | 2 +-
 mm/Kconfig   | 2 +-
 mm/nommu.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 16dfb8a98c51..8c7788e6db26 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1989,7 +1989,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	  userspace.  Since that isn't generally a problem on no-MMU systems,
 	  it is normally safe to say Y here.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config SYSTEM_DATA_VERIFICATION
 	def_bool n
diff --git a/mm/Kconfig b/mm/Kconfig
index a015c88027bf..e28c436fbe9a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -383,7 +383,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 	  This option specifies the initial value of this option.  The default
 	  of 1 says that all excess pages should be trimmed.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
diff --git a/mm/nommu.c b/mm/nommu.c
index 75a327149af1..0df7ca321314 100644
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
-- 
2.26.2

