Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E5C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0717222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607961;
	bh=r9xKMrfjsCH7A7sq9FAn3xenWtfx94nRGSwIgf1QNaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x3+KMlpnFHealLSk57SrMm4HzfTCL0gdxvIAFx2GQjwLTPZDpCFvFRuynsaZI5qqq
	 GnwTLkvdak1SiwnoBaDbYbesS3JODlW+v8iC0ubVQ9mLX1M3ORrEX1aAyCGZfHkBtt
	 tmixmn1BWVHzNAjUAWLQsJUkZBN2Q3TZ1zRFevm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgBMPcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgBMP2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:44 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72DA5206DB;
        Thu, 13 Feb 2020 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607723;
        bh=r9xKMrfjsCH7A7sq9FAn3xenWtfx94nRGSwIgf1QNaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGLRXC+/GFjLbVMaozNqtl5ett+bEHJ65H9cIYfibfUfEattuTz3C1eGiXr0UYhdQ
         oA0GY2YibcEM3zPU/eoUZZ9xl2na8PiRmH0M1OfNnaGUEWp0peAcYl/YVAJ5qOQ4jN
         tEGY6qspwxbPM8k9Vu6P3XwBHEiJmMXXRM4wo75w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 068/120] Revert "powerpc/pseries/iommu: Dont use dma_iommu_ops on secure guests"
Date:   Thu, 13 Feb 2020 07:21:04 -0800
Message-Id: <20200213151924.466380273@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

commit d862b44133b7a1d7de25288e09eabf4df415e971 upstream.

This reverts commit edea902c1c1efb855f77e041f9daf1abe7a9768a.

At the time the change allowed direct DMA ops for secure VMs; however
since then we switched on using SWIOTLB backed with IOMMU (direct mapping)
and to make this work, we need dma_iommu_ops which handles all cases
including TCE mapping I/O pages in the presence of an IOMMU.

Fixes: edea902c1c1e ("powerpc/pseries/iommu: Don't use dma_iommu_ops on secure guests")
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
[aik: added "revert" and "fixes:"]
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191216041924.42318-2-aik@ozlabs.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/iommu.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -36,7 +36,6 @@
 #include <asm/udbg.h>
 #include <asm/mmzone.h>
 #include <asm/plpar_wrappers.h>
-#include <asm/svm.h>
 
 #include "pseries.h"
 
@@ -1320,15 +1319,7 @@ void iommu_init_early_pSeries(void)
 	of_reconfig_notifier_register(&iommu_reconfig_nb);
 	register_memory_notifier(&iommu_mem_nb);
 
-	/*
-	 * Secure guest memory is inacessible to devices so regular DMA isn't
-	 * possible.
-	 *
-	 * In that case keep devices' dma_map_ops as NULL so that the generic
-	 * DMA code path will use SWIOTLB to bounce buffers for DMA.
-	 */
-	if (!is_secure_guest())
-		set_pci_dma_ops(&dma_iommu_ops);
+	set_pci_dma_ops(&dma_iommu_ops);
 }
 
 static int __init disable_multitce(char *str)


