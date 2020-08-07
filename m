Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1898922CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 05:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGFEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 01:04:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgHGFEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 01:04:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7F1DAB8B;
        Fri,  7 Aug 2020 05:05:08 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.9-rc1
Date:   Fri,  7 Aug 2020 07:04:50 +0200
Message-Id: <20200807050450.7517-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9-rc1-tag

xen: branch for v5.9-rc1

It contains the following:

- two trivial comment fixes
- A small series for the Xen balloon driver fixing some issues
- A series of the Xen privcmd driver targeting elimination of using
  get_user_pages*() in this driver
- A series for the Xen swiotlb driver cleaning it up and adding support
  for letting the kernel run as dom0 on Rpi4


Thanks.

Juergen

 arch/arm/xen/mm.c                    |  34 +++++-----
 arch/x86/include/asm/xen/hypercall.h |   2 +-
 drivers/xen/balloon.c                |  26 +++-----
 drivers/xen/privcmd.c                |  32 +++++-----
 drivers/xen/swiotlb-xen.c            | 119 +++++++++++++++++++++--------------
 include/uapi/xen/gntdev.h            |   2 +-
 include/xen/page.h                   |   1 -
 include/xen/swiotlb-xen.h            |   8 +--
 8 files changed, 119 insertions(+), 105 deletions(-)

Boris Ostrovsky (1):
      swiotlb-xen: use vmalloc_to_page on vmalloc virt addresses

Randy Dunlap (2):
      xen/gntdev: gntdev.h: drop a duplicated word
      xen: hypercall.h: fix duplicated word

Roger Pau Monne (3):
      xen/balloon: fix accounting in alloc_xenballooned_pages error path
      xen/balloon: make the balloon wait interruptible
      Revert "xen/balloon: Fix crash when ballooning on x86 32 bit PAE"

Souptick Joarder (3):
      xen/privcmd: Corrected error handling path
      xen/privcmd: Mark pages as dirty
      xen/privcmd: Convert get_user_pages*() to pin_user_pages*()

Stefano Stabellini (10):
      swiotlb-xen: remove start_dma_addr
      swiotlb-xen: add struct device * parameter to xen_phys_to_bus
      swiotlb-xen: add struct device * parameter to xen_bus_to_phys
      swiotlb-xen: add struct device * parameter to xen_dma_sync_for_cpu
      swiotlb-xen: add struct device * parameter to xen_dma_sync_for_device
      swiotlb-xen: add struct device * parameter to is_xen_swiotlb_buffer
      swiotlb-xen: remove XEN_PFN_PHYS
      swiotlb-xen: introduce phys_to_dma/dma_to_phys translations
      xen/arm: introduce phys/dma translations in xen_dma_sync_for_*
      xen/arm: call dma_to_phys on the dma_addr_t parameter of dma_cache_maint
