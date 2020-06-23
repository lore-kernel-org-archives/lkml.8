Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D386C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3673820724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592906035;
	bh=bq8CoMqSMZ8uYUWvgHDvhKEDwfU1WGAh6kK39NUzLyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zIIPMloKlCIBSLxizOcJMurJ8JJzl/SCJj8w/fkwpa3cEaOVeUuo6LE6KXp/uVQBy
	 P8N6UXyrUPVp3NsLORwxtCTkMR2lgiMpXiyG9ehee3wS3g1FnWW81L7wGDdv38Gh2p
	 YBPyWZl17T6oQLtoDCji2jTQ8S1bqW8IQsBjXi0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732329AbgFWJxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbgFWJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:53:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E07520791;
        Tue, 23 Jun 2020 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592905986;
        bh=bq8CoMqSMZ8uYUWvgHDvhKEDwfU1WGAh6kK39NUzLyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwV0w7+c+4KgVFSyQ6qfVc4+O2eNDLiQtVd0exq8jkJUQBMLarkIVYX10KXFYtISg
         2AZI94v62JrtywFPNBEz8sUi4ppYYDXbBiYmk4MXSxoLrjTt8d54fhcbTaO+hUVOJw
         xy4KH71V+mmR4/4/FNcal6JDlUqS0ryytOUpcpKA=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnfc0-004C3Z-DG; Tue, 23 Jun 2020 11:53:04 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 7/9] docs: move other kAPI documents to core-api
Date:   Tue, 23 Jun 2020 11:53:00 +0200
Message-Id: <d4ee2e60590b605eeba7c9d14fe75f28d17e4272.1592905407.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
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

