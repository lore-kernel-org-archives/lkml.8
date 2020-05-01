Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931F3C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F77D20731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588347517;
	bh=1nePazr9W/llI1NGHsxrrs6qk9ujVqJY+Ur5A8bZUNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wH3siz+fvtMqEggfydgEO9i7WGWWOlIC5deqK0jfaEjXxOsuWnjQOcZDhrBQ0C/bq
	 WHOMVxYTHII8ZagIVPhfsjduznuDC4LSDlW94gxh7LasAbbjpLPFFzuelSMZCzR0sb
	 PGDe/gu4GEuigNoC/WxWqD7gnABaInlW1YohWj6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgEAPig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgEAPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:38:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBB02495E;
        Fri,  1 May 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588347483;
        bh=1nePazr9W/llI1NGHsxrrs6qk9ujVqJY+Ur5A8bZUNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeNtbPq2ipYzIu4K94XhjuEo1JzSpuv6KAHMgo5sfyze2BYjEUNM0Cg5dJ6Fium2J
         z7JKyqbYnARgH12PDe8zGNJX0tELgvBXEi81EhmtOKBFx2Fn/wmLe4UrqNoJOyJHV6
         RMw8nbSU8EfHFAct1biE9mvFvlkgCLD8wvTy3U2s=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUXjl-00FE4m-3f; Fri, 01 May 2020 17:38:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 06/14] docs: debugging-via-ohci1394.txt: add it to the core-api book
Date:   Fri,  1 May 2020 17:37:50 +0200
Message-Id: <9b489d36d08ad89d3ad5aefef1f52a0715b29716.1588345503.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an special chapter inside the core-api book about
some debug infrastructure like tracepoints and debug objects.

It sounded to me that this is the best place to add a chapter
explaining how to use a FireWire controller to do remote
kernel debugging, as explained on this document.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt                 | 2 +-
 .../debugging-via-ohci1394.rst}                                 | 0
 Documentation/core-api/index.rst                                | 1 +
 lib/Kconfig.debug                                               | 2 +-
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename Documentation/{debugging-via-ohci1394.txt => core-api/debugging-via-ohci1394.rst} (100%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 25644daa36ea..d9b61da7809d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3350,7 +3350,7 @@
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
 	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
-			See Documentation/debugging-via-ohci1394.txt for more
+			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
 
 	olpc_ec_timeout= [OLPC] ms delay when issuing EC commands
diff --git a/Documentation/debugging-via-ohci1394.txt b/Documentation/core-api/debugging-via-ohci1394.rst
similarity index 100%
rename from Documentation/debugging-via-ohci1394.txt
rename to Documentation/core-api/debugging-via-ohci1394.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index b70039d458a7..ab056b3626f4 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -99,6 +99,7 @@ Interfaces for kernel debugging
 
    debug-objects
    tracepoint
+   debugging-via-ohci1394
 
 Everything else
 ===============
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8e4aded46281..4e631f294737 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1552,7 +1552,7 @@ config PROVIDE_OHCI1394_DMA_INIT
 	  This code (~1k) is freed after boot. By then, the firewire stack
 	  in charge of the OHCI-1394 controllers should be used instead.
 
-	  See Documentation/debugging-via-ohci1394.txt for more information.
+	  See Documentation/core-api/debugging-via-ohci1394.rst for more information.
 
 source "samples/Kconfig"
 
-- 
2.25.4

