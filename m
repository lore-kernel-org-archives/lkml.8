Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01648C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C1820786
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420460;
	bh=30tMeSPdpSpzi9JMvJiPg87Z492wFVcJ870fYtV5zZQ=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=2samR2h/sRd0sFj8B/7AoZr1x9LMga/djsLPqbkZbbIvYoXUmCyr8dQxMqecYmBce
	 SSADk8zD7V3VEw9RLgK0kpMuG57tJs25DYXxxXjQUiQVXjPnxOgS9SB8NNWV1IhLOb
	 fsFzKOs46n1r8j9w1CVUxoOYKlGEeEsNT76X+3oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGJWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgGJWeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:19 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD5C20720;
        Fri, 10 Jul 2020 22:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594420459;
        bh=30tMeSPdpSpzi9JMvJiPg87Z492wFVcJ870fYtV5zZQ=;
        h=Date:From:To:cc:Subject:From;
        b=Pw2KlUzZl4LpIy2xtWqNZk6KKD9pfLyg08tNZvDitK+/OGlAAkx2eGh0w/G6sD1pp
         qR2XHpnwwbJHysHRwhK/G42ZbVPzC3jOPtnW3QqHPQmSyltqJeX0y49vaJ8+J0YM7O
         xNtCHhTP/6SAsY0ESmmxCgCDbFBAdbmoyzak/Mpo=
Date:   Fri, 10 Jul 2020 15:34:18 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com, hch@infradead.org
Subject: [PATCH v3 00/11] fix swiotlb-xen for RPi4
Message-ID: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is a collection of fixes to get Linux running on the RPi4 as
dom0. Conceptually there are only two significant changes:

- make sure not to call virt_to_page on vmalloc virt addresses (patch
  #1)
- use phys_to_dma and dma_to_phys to translate phys to/from dma
  addresses (all other patches)


I addressed all comments by Christoph to v2 of the series except from
the one about merging the precursor "add struct device *" patches. I can
always merge them together at any time as needed.


Boris gave his Reviewed-by to the whole series v2. I added his
Reviewed-by to all patches, including the ones with small cosmetic
fixes, except for patch #8 #9 #10 because they are either new or changed
significantly in this version of the series.

I retained Roman and Corey's Tested-by.


Cheers,

Stefano


git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git fix-rpi4-v3


Boris Ostrovsky (1):
      swiotlb-xen: use vmalloc_to_page on vmalloc virt addresses

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

 arch/arm/xen/mm.c         |  34 +++++++++++++++----------------
 drivers/xen/swiotlb-xen.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 include/xen/page.h        |   1 -
 include/xen/swiotlb-xen.h |   8 ++++----
 4 files changed, 93 insertions(+), 69 deletions(-)
