Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A6FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C7620838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YubdVILj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgH2ABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2ABe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:01:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B30C061264;
        Fri, 28 Aug 2020 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+Zwv5kkct+jkKHl87kFaXuKzv2xv4JFYcagXkCr1IzE=; b=YubdVILjTR2nyG51zlpaGRABVi
        pfZI1LQj2eYL2o3AgH41PMQKwI7ObnaInOd1OT8fWqK8mm11v0ziQawbGRMBqcgTx7VkkOF/cMZjX
        tYl2ojXRrSmXoeF7/lqOwKPXZSY3LkyI24/6KMwmBZV3xMLv/6ug8HIVzUA3yg8eaJx5yb+tcLPVX
        0DfWfSb14Tzc72vhP4I12MU23A6mt6S45i0dz231VfdoWMLklPOurlrToQv8LrJJyegaaAkALX+tM
        aPmG+FbA7npzoHx1vsbDb+ECN/ox5a/DHiDDBjk0rYGwCP6cuncCb/bbWBcyDathDQfIxbTjij/1O
        xGvM7K8w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBoJH-000723-Nr; Sat, 29 Aug 2020 00:01:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: fix min_low_pfn/max_low_pfn build errors
Date:   Fri, 28 Aug 2020 17:01:26 -0700
Message-Id: <20200829000126.2463-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix min_low_pfn/max_low_pfn build errors for arch/ia64/: (e.g.)

 ERROR: "max_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
 ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
 ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
 ERROR: "max_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
 ERROR: "min_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
 ERROR: "max_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
 ERROR: "max_low_pfn" [drivers/md/dm-integrity.ko] undefined!
 ERROR: "min_low_pfn" [drivers/md/dm-integrity.ko] undefined!
 ERROR: "max_low_pfn" [crypto/tcrypt.ko] undefined!
 ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
 ERROR: "min_low_pfn" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
 ERROR: "max_low_pfn" [security/keys/encrypted-keys/encrypted-keys.ko] undefined!
 ERROR: "min_low_pfn" [arch/ia64/kernel/mca_recovery.ko] undefined!
 ERROR: "max_low_pfn" [arch/ia64/kernel/mca_recovery.ko] undefined!

David suggested just exporting min_low_pfn & max_low_pfn in
mm/memblock.c:
https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/kernel/ia64_ksyms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200825.orig/arch/ia64/kernel/ia64_ksyms.c
+++ linux-next-20200825/arch/ia64/kernel/ia64_ksyms.c
@@ -3,7 +3,7 @@
  * Architecture-specific kernel symbols
  */
 
-#ifdef CONFIG_VIRTUAL_MEM_MAP
+#if defined(CONFIG_VIRTUAL_MEM_MAP) || defined(CONFIG_DISCONTIGMEM)
 #include <linux/compiler.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
