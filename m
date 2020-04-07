Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85951C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450FA2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gewsdy0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDGCNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:13:08 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46126 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgDGCNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:13:08 -0400
Received: by mail-qv1-f67.google.com with SMTP id bu9so1104938qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 19:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BfSGNCe4oEdtp7HObDoUBxiccfhReNwsRhUVxZRTBNI=;
        b=gewsdy0lwajFLCQWWu6WiPH8/MUhlBoR9q+iW9sg17xdjiLFUdivK0Wx6EsixHvSX3
         zQwX32w/VKiJHmS0WDQevjVGo8+gfgZi7y7DCOhRzKwmY33py4q+jaMI/YD6QapRyGB7
         YbvFsoEbARPUmTaMh0OsJ4hN3wc4UMzH3wf44LZPIUg9X3RkNhnGmhPqB3e4pTBgmVAX
         Ap0KvmbhVNLE3aN/pIyYdtZUPMIWoWig1fp5mfR3gvXwYRD0zjSjOTsu8gUtTijF9KbD
         +IoL4EAP58QvN6dW5LppI3EHYc32ZWcZtjxJH3hX7utI7ZcDL02rl5Zpl7eH0XAl+U/x
         AcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BfSGNCe4oEdtp7HObDoUBxiccfhReNwsRhUVxZRTBNI=;
        b=YOtp2UxBT1qGWNL08ml1Fx8jcbtcjB9WVTyz+T/O8dTJGNQCRSPtyAjJk5WeZcS+u3
         6XVQlu/5/QkrjQP5j7qPum9VeMeHZ5aD/btzAYbMe39Svus5lmLHjuNG8e2nuVvKeCxT
         +pV9k1eu3DNnn/qL8/L/n74GgCfrTVONeKQgP0qzN6sAelSI/K8W9VF25ahmvqo3qslO
         NVDHzmLObmoVvdSeuJjr0j34LOIf+gimusqORSDG0pdWWqtUyTG8GFpkGzqhlA9WItiO
         nRk0vxm1xaOjBn2M5TTJzLNmaCuIueeHYE4lbs/iqOAJ6z6/YFLlIMi/pVxAl7k9q8aq
         K8Fg==
X-Gm-Message-State: AGi0PubXQeLsMd4VaZtugQJrWofMm+IX1AFtCouTuNmgXiIzC2J6WPgS
        D4a5/qP7TYTzwuA2BFvYy1DITLbDHMRpvA==
X-Google-Smtp-Source: APiQypLfdxRR9tnKWUX/fwH+m3mfpC90iHPIxMu/88gfIawO6KT91exQ+B/xGelP+JNMFRVA6Ub71w==
X-Received: by 2002:a0c:b896:: with SMTP id y22mr84351qvf.182.1586225587511;
        Mon, 06 Apr 2020 19:13:07 -0700 (PDT)
Received: from ovpn-66-196.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d5sm103120qke.14.2020.04.06.19.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 19:13:07 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Date:   Mon,  6 Apr 2020 22:12:46 -0400
Message-Id: <20200407021246.10941-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fetch_pte() could race with increase_address_space() because it held no
lock from iommu_unmap_page(). On the CPU that runs fetch_pte() it could
see a stale domain->pt_root and a new increased domain->mode from
increase_address_space(). As the result, it could trigger invalid
accesses later on. Fix it by using a pair of smp_[w|r]mb in those
places.

 kernel BUG at drivers/iommu/amd_iommu.c:1704!
 BUG_ON(unmapped && !is_power_of_2(unmapped));
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 RIP: 0010:amd_iommu_unmap+0x1b2/0x1d0
 Call Trace:
  <IRQ>
  __iommu_unmap+0x106/0x320
  iommu_unmap_fast+0xe/0x10
  __iommu_dma_unmap+0xdc/0x1a0
  iommu_dma_unmap_sg+0xae/0xd0
  scsi_dma_unmap+0xe7/0x150
  pqi_raid_io_complete+0x37/0x60 [smartpqi]
  pqi_irq_handler+0x1fc/0x13f0 [smartpqi]
  __handle_irq_event_percpu+0x78/0x4f0
  handle_irq_event_percpu+0x70/0x100
  handle_irq_event+0x5a/0x8b
  handle_edge_irq+0x10c/0x370
  do_IRQ+0x9e/0x1e0
  common_interrupt+0xf/0xf
  </IRQ>

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20cce366e951..22328a23335f 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1434,6 +1434,11 @@ static bool increase_address_space(struct protection_domain *domain,
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					iommu_virt_to_phys(domain->pt_root));
 	domain->pt_root  = pte;
+	/*
+	 * Make sure fetch_pte() will see the new domain->pt_root before it
+	 * snapshots domain->mode.
+	 */
+	smp_wmb();
 	domain->mode    += 1;
 
 	ret = true;
@@ -1460,6 +1465,8 @@ static u64 *alloc_pte(struct protection_domain *domain,
 		*updated = increase_address_space(domain, address, gfp) || *updated;
 
 	level   = domain->mode - 1;
+	/* To pair with smp_wmb() in increase_address_space(). */
+	smp_rmb();
 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
 	address = PAGE_SIZE_ALIGN(address, page_size);
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
@@ -1545,6 +1552,8 @@ static u64 *fetch_pte(struct protection_domain *domain,
 		return NULL;
 
 	level	   =  domain->mode - 1;
+	/* To pair with smp_wmb() in increase_address_space(). */
+	smp_rmb();
 	pte	   = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
-- 
2.21.0 (Apple Git-122.2)

