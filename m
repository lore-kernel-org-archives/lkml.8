Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49A8207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592919114;
	bh=bq8CoMqSMZ8uYUWvgHDvhKEDwfU1WGAh6kK39NUzLyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HyYzl6yVgwORX9AMualzSi9szlMKRbdYkeD70XmeKRIm9wel5qLIzdu7js3SN0GTH
	 XlHqa16CR532HDTaP97uW5mL4zoiNsUOHbXhBldAAxp3GXhbzJTIxex2LY/hmz1H2/
	 8KFT5cXrE5LERXhSEjHjrabLxOrUknhPup+Y2234=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgFWNbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732649AbgFWNbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:31:44 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2619E20829;
        Tue, 23 Jun 2020 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592919104;
        bh=bq8CoMqSMZ8uYUWvgHDvhKEDwfU1WGAh6kK39NUzLyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZqN3XzInwyOuECDJgqiNX14M95Hx0iiQFuPrNzsfZqTTVMxqVxBTAFjrSa1dWKW6
         FdNcxmIdGa6hwbYQ0GWje+Gdpa/2dftb7EN0NoR7oQwGzrdm/Ws4+FuQkHPxxdzzcB
         W8mi+CfxSZiHBSy/X/mm6eiHdjGYb7EaQuRiwu48=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnj1Z-007VJp-G3; Tue, 23 Jun 2020 15:31:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?q?Ricardo=20Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 5/7] docs: move other kAPI documents to core-api
Date:   Tue, 23 Jun 2020 15:31:38 +0200
Message-Id: <86d979ed183adb76af93a92f20189bccf97f0055.1592918949.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592918949.git.mchehab+huawei@kernel.org>
References: <cover.1592918949.git.mchehab+huawei@kernel.org>
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
 .../bus-virt-phys-mapping.rst}                                 | 0
 Documentation/core-api/index.rst                               | 3 +++
 Documentation/{this_cpu_ops.txt => core-api/this_cpu_ops.rst}  | 0
 .../{process => core-api}/unaligned-memory-access.rst          | 0
 arch/Kconfig                                                   | 2 +-
 5 files changed, 4 insertions(+), 1 deletion(-)
 rename Documentation/{bus-virt-phys-mapping.txt => core-api/bus-virt-phys-mapping.rst} (100%)
 rename Documentation/{this_cpu_ops.txt => core-api/this_cpu_ops.rst} (100%)
 rename Documentation/{process => core-api}/unaligned-memory-access.rst (100%)

diff --git a/Documentation/bus-virt-phys-mapping.txt b/Documentation/core-api/bus-virt-phys-mapping.rst
similarity index 100%
rename from Documentation/bus-virt-phys-mapping.txt
rename to Documentation/core-api/bus-virt-phys-mapping.rst
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 15ab86112627..69171b1799f2 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -39,6 +39,8 @@ Library functionality that is used throughout the kernel.
    rbtree
    generic-radix-tree
    packing
+   bus-virt-phys-mapping
+   this_cpu_ops
    timekeeping
    errseq
 
@@ -82,6 +84,7 @@ more memory-management documentation in :doc:`/vm/index`.
    :maxdepth: 1
 
    memory-allocation
+   unaligned-memory-access
    dma-api
    dma-api-howto
    dma-attributes
diff --git a/Documentation/this_cpu_ops.txt b/Documentation/core-api/this_cpu_ops.rst
similarity index 100%
rename from Documentation/this_cpu_ops.txt
rename to Documentation/core-api/this_cpu_ops.rst
diff --git a/Documentation/process/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
similarity index 100%
rename from Documentation/process/unaligned-memory-access.rst
rename to Documentation/core-api/unaligned-memory-access.rst
diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..2a439fb8069e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -147,7 +147,7 @@ config HAVE_EFFICIENT_UNALIGNED_ACCESS
 	  problems with received packets if doing so would not help
 	  much.
 
-	  See Documentation/unaligned-memory-access.txt for more
+	  See Documentation/core-api/unaligned-memory-access.rst for more
 	  information on the topic of unaligned memory accesses.
 
 config ARCH_USE_BUILTIN_BSWAP
-- 
2.26.2

