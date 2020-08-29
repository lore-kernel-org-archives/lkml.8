Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A6DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F552207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 00:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XnN3KDJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgH2AB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgH2ABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 20:01:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A5C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VZBQ4C/lsfFT4AafE4ufQjnGxwhG0L0ghO6R1ZlHtsI=; b=XnN3KDJeKJtFNCfoVkMtKlrVyR
        GlmJsBTNhQI6+RhENQdeipat54DivxP8qth6eEsfzGhg8fOqDRePciLOj5gMOlXHI6o6jaI+DXSSI
        LP60M35YthVIXePOQaEhPqtqrRcsYcNkm66ozN+fKw7XctxkohKbBhXid8uhPozJZbN4sBp9YQbQm
        ec9NrtVm5BL4ut3jxGckXwlywN0gvQf5gZ//wpccrVmUTb/CpWFdjv6CRrv/INOPmqgwO2T5GnWDU
        2Ti9blJ7Wyq25ggiMhZnj5UnQIceSFeFkWGT3ESMRbilGDE3ZFdYjC77J/2pbgebxMwiNaLWLoa+L
        nz86w0tw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBoJ2-0006wn-Kp; Sat, 29 Aug 2020 00:01:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] microblaze: fix min_low_pfn/max_low_pfn build errors
Date:   Fri, 28 Aug 2020 17:01:10 -0700
Message-Id: <20200829000110.2408-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix min_low_pfn/max_low_pfn build errors for arch/microblaze/: (e.g.)

  ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
  ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu_sink.ko] undefined!
  ERROR: "min_low_pfn" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!
  ERROR: "min_low_pfn" [drivers/mmc/core/mmc_core.ko] undefined!
  ERROR: "min_low_pfn" [drivers/md/dm-crypt.ko] undefined!
  ERROR: "min_low_pfn" [drivers/net/wireless/ath/ath6kl/ath6kl_sdio.ko] undefined!
  ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
  ERROR: "min_low_pfn" [crypto/asymmetric_keys/asym_tpm.ko] undefined!

Mike had/has an alternate patch for Microblaze:
https://lore.kernel.org/lkml/20200630111519.GA1951986@linux.ibm.com/

David suggested just exporting min_low_pfn & max_low_pfn in
mm/memblock.c:
https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2006291911220.1118534@chino.kir.corp.google.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>
---
 arch/microblaze/mm/init.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20200825.orig/arch/microblaze/mm/init.c
+++ linux-next-20200825/arch/microblaze/mm/init.c
@@ -46,6 +46,9 @@ unsigned long memory_size;
 EXPORT_SYMBOL(memory_size);
 unsigned long lowmem_size;
 
+EXPORT_SYMBOL(min_low_pfn);
+EXPORT_SYMBOL(max_low_pfn);
+
 #ifdef CONFIG_HIGHMEM
 pte_t *kmap_pte;
 EXPORT_SYMBOL(kmap_pte);
