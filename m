Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E865C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A052078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGIQTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:19:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgGIQTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:19:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37A87AEB9;
        Thu,  9 Jul 2020 16:19:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] dma-pool: Fix atomic pool selection
Date:   Thu,  9 Jul 2020 18:19:00 +0200
Message-Id: <20200709161903.26229-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my attempt at fixing one of the regressions we've seen[1] after
the introduction of per-zone atomic pools.

This combined with "dma-pool: Do not allocate pool memory from CMA"[2]
should fix the boot issues on Jeremy's RPi4 setup.

[1] https://lkml.org/lkml/2020/7/2/974
[2] https://lkml.org/lkml/2020/7/8/1108

---

Nicolas Saenz Julienne (4):
  dma-direct: Provide function to check physical memory area validity
  dma-pool: Get rid of dma_in_atomic_pool()
  dma-pool: Introduce dma_guess_pool()
  dma-pool: Make sure atomic pool suits device

 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        |  2 +-
 kernel/dma/pool.c          | 76 +++++++++++++++++++++++++++-----------
 3 files changed, 56 insertions(+), 23 deletions(-)

-- 
2.27.0

