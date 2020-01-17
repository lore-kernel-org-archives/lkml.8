Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5DFC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF92073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 08:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgAQIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:05:06 -0500
Received: from verein.lst.de ([213.95.11.211]:60964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgAQIFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:05:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 137E368B05; Fri, 17 Jan 2020 09:05:04 +0100 (CET)
Date:   Fri, 17 Jan 2020 09:05:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>,
        Manish Narani <manish.narani@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] microblaze: Wire CMA allocator
Message-ID: <20200117080503.GB8980@lst.de>
References: <cover.1579248206.git.michal.simek@xilinx.com> <b2e5d3c9c94aa09b5897f60ec86d858041ee62df.1579248206.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e5d3c9c94aa09b5897f60ec86d858041ee62df.1579248206.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 09:03:32AM +0100, Michal Simek wrote:
> Based on commit 04e3543e228f ("microblaze: use the generic dma coherent
> remap allocator")
> CMA can be easily enabled by calling dma_contiguous_reserve() at the end of
> mmu_init(). High limit is end of lowmem space which is completely unused at
> this point of time.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
