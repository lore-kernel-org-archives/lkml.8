Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA30207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QyfuHIds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgH2ABt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH2ABs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:01:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80FC061264;
        Fri, 28 Aug 2020 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GA4T/SBE6dahx5pqWnJ6oAB3Y/3yZkPaI5G9WmLDnik=; b=QyfuHIdsrcprTTZcREQL4lV9Go
        QpOv2Qxj6WTAoVnZVCnmgT/D7HJWsiSrpZt4/InMRxKs3V4AaEZj3fToLQhmzZ5Xyvp0X+3Oz7s4C
        ZPMn+qr3TtMEy/uJkF36jsMQKxzvNAoBbyavMO1I6Vgns02eWhMSfoIAaBj1CA0S+FYG6pKeC+Pw5
        I5bImAWuWs8R/uFPKdBs6cQiHR73Ck8x1IOKCfaLapKbMCMNwXFNhrkF2/5FzP+G43P7jC2oPN5ok
        ehr9em5B7j0dTSkTReJIZL1g65gyuEf+FiYxnVqMXgDcTHezNglRc7eBSlQnwitMO90jkrw3swCft
        +VKydvxw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBoJV-00077S-Me; Sat, 29 Aug 2020 00:01:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: [ALTERNATE PATCH] memblock: fix min_low_pfn/max_low_pfn build errors
Date:   Fri, 28 Aug 2020 17:01:39 -0700
Message-Id: <20200829000139.2513-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export min_low_pfn & max_low_pfn in mm/memblock.c to fix build errors
on arch/microblaze/ and arch/ia64/: (e.g.)

  ERROR: "max_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
  ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
  ERROR: "max_low_pfn" [drivers/mtd/spi-nor/spi-nor.ko] undefined!
  ERROR: "min_low_pfn" [drivers/mtd/spi-nor/spi-nor.ko] undefined!
  ERROR: "min_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
  ERROR: "max_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
  ERROR: "max_low_pfn" [drivers/rapidio/devices/rio_mport_cdev.ko] undefined!
  ERROR: "min_low_pfn" [drivers/rapidio/devices/rio_mport_cdev.ko] undefined!
  ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
  ERROR: "max_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
  ERROR: "min_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
  ERROR: "max_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
  ERROR: "max_low_pfn" [drivers/md/dm-integrity.ko] undefined!
  ERROR: "min_low_pfn" [drivers/md/dm-integrity.ko] undefined!
  ERROR: "max_low_pfn" [crypto/tcrypt.ko] undefined!
  ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!

In both arches, these variables are referenced in
arch/$ARCH/include/asm/page.h.

Mike had/has an alternate patch for Microblaze:
https://lore.kernel.org/lkml/20200630111519.GA1951986@linux.ibm.com/

David suggested just exporting min_low_pfn & max_low_pfn in
mm/memblock.c:
https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com/

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
---
 mm/memblock.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20200825.orig/mm/memblock.c
+++ linux-next-20200825/mm/memblock.c
@@ -99,6 +99,8 @@ EXPORT_SYMBOL(contig_page_data);
 
 unsigned long max_low_pfn;
 unsigned long min_low_pfn;
+EXPORT_SYMBOL(min_low_pfn);
+EXPORT_SYMBOL(max_low_pfn);
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
