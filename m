Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F1B20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHCQKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:10:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:50674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgHCQKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:10:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B266B6F2;
        Mon,  3 Aug 2020 16:10:18 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     amit.pundir@linaro.org, hch@lst.de, linux-kernel@vger.kernel.org
Cc:     rientjes@google.com, jeremy.linton@arm.com,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 0/2] dma-pool fixes
Date:   Mon,  3 Aug 2020 18:09:54 +0200
Message-Id: <20200803160956.19235-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have an explanation to Amir's issue, I took the liberty to
respin the previous dma-pool fixes series with some changes/fixes of my
own.

---

Changes since v1:
 - Make cma_in_zone() more strict, GFP_KERNEL doesn't default to true
   now

 - Check if phys_addr_ok() exists prior calling it

Christoph Hellwig (1):
  dma-pool: fix coherent pool allocations for IOMMU mappings

Nicolas Saenz Julienne (1):
  dma-pool: Only allocate from CMA when in same memory zone

 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 +++-
 kernel/dma/pool.c           | 148 ++++++++++++++++++++----------------
 5 files changed, 95 insertions(+), 78 deletions(-)

-- 
2.28.0

