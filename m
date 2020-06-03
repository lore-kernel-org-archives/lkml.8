Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A082C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E258420734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591222961;
	bh=FbZizFCbXTo82zhp90elPXeQrp3LeJltCz9UBkieMa0=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=hoYZpmP1K/jv3/YRXzSJ8JvOiygaBfYgrdGiCG8WVP5jXs86Eqmi3SgqYN9NecnQw
	 0RiaO/3pGcCiOo1+cuHDYA3IcS62DqKaxIF/rTRXoXdIDNk4MfIYs+dJMWqrZFe1rn
	 pHM7zLoSifSUzUzuFZR06rCNIlykIChw32OD1tKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFCWWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgFCWWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:22:39 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0902F2067B;
        Wed,  3 Jun 2020 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591222959;
        bh=FbZizFCbXTo82zhp90elPXeQrp3LeJltCz9UBkieMa0=;
        h=Date:From:To:cc:Subject:From;
        b=UliQ4Xc0s6kZlNyoqhnZToK1IzE2Oj4wUjDuW8fE4ZVtpg23emU+hIIetm/p3gS6X
         I5fikv0SrWzGlcMWVVAA/OXGN5h8aK+xYKoyKk0nyhLQCEVjiGuNTKdL5S/YGdf+Y6
         zofhZFz2KDHQnFwvSm3nSU0DF9MBACdKFzRLyvTM=
Date:   Wed, 3 Jun 2020 15:22:38 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com, roman@zededa.com
Subject: [PATCH v2 00/11] fix swiotlb-xen for RPi4
Message-ID: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is a collection of fixes to get Linux running on the RPi4 as
dom0.

Conceptually there are only two significant changes:

- make sure not to call virt_to_page on vmalloc virt addresses (patch
  #1)
- use phys_to_dma and dma_to_phys to translate phys to/from dma
  addresses (all other patches)

In particular in regards to the second part, the RPi4 is the first
board where Xen can run that has the property that dma addresses are
different from physical addresses, and swiotlb-xen was written with the
assumption that phys addr == dma addr.

This series adds the phys_to_dma and dma_to_phys calls to make it work.

Cheers,

Stefano



The following changes since commit b85051e755b0e9d6dd8f17ef1da083851b83287d:

  Merge tag 'fixes-for-5.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux (2020-05-20 13:23:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git fix-rpi4-v2 

for you to fetch changes up to 49783ba67f75da3490d2c01ed9b445d8a89bbb0d:

  xen/arm: call dma_to_phys on the dma_addr_t parameter of dma_cache_maint (2020-06-03 15:05:53 -0700)

----------------------------------------------------------------
Boris Ostrovsky (1):
      swiotlb-xen: use vmalloc_to_page on vmalloc virt addresses

Stefano Stabellini (10):
      swiotlb-xen: remove start_dma_addr
      swiotlb-xen: add struct device* parameter to xen_phys_to_bus
      swiotlb-xen: add struct device* parameter to xen_bus_to_phys
      swiotlb-xen: add struct device* parameter to xen_dma_sync_for_cpu
      swiotlb-xen: add struct device* parameter to xen_dma_sync_for_device
      swiotlb-xen: add struct device* parameter to is_xen_swiotlb_buffer
      swiotlb-xen: introduce phys_to_dma/dma_to_phys translations
      swiotlb-xen: rename xen_phys_to_bus to xen_phys_to_dma and xen_bus_to_phys to xen_dma_to_phys
      xen/arm: introduce phys/dma translations in xen_dma_sync_for_*
      xen/arm: call dma_to_phys on the dma_addr_t parameter of dma_cache_maint

 arch/arm/xen/mm.c         | 32 +++++++++++++++++++-------------
 drivers/xen/swiotlb-xen.c | 72 +++++++++++++++++++++++++++++++++++++-----------------------------------
 include/xen/swiotlb-xen.h | 10 ++++++----
 3 files changed, 62 insertions(+), 52 deletions(-)

