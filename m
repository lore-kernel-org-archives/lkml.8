Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC2020781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbgFXFrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:47:12 -0400
Received: from verein.lst.de ([213.95.11.211]:42776 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgFXFrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:47:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C6FF68AEF; Wed, 24 Jun 2020 07:47:08 +0200 (CEST)
Date:   Wed, 24 Jun 2020 07:47:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, axboe@fb.com,
        sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported
 macro
Message-ID: <20200624054708.GA17008@lst.de>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com> <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com> <20200623162751.GA4846@lst.de> <20200624025817.GC1291930@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624025817.GC1291930@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:58:17PM -0700, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 06:27:51PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> > > Introduce a new capability macro to indicate if the controller
> > > supports the memory buffer or not, instead of reading the
> > > NVME_REG_CMBSZ register.
> > 
> > This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
> > a backwards incompatible change, as the CMB addressing scheme can lead
> > to data corruption.  The CMBS was added as part of the horribe hack
> > that also involves the CBA field, which we'll need to see before
> > using it to work around the addressing issue.  At the same time we
> > should also continue supporting the legacy pre-1.4 CMB with a warning
> > (and may reject it if we know we run in a VM).
> 
> Well, a CMB from an emulated controller (like qemu's) can be used within
> a VM. It's only if you direct assign a PCI function that CMB usage
> breaks.

But we have no idea if a controller is assigned or emulated.
