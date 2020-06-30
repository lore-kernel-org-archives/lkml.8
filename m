Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF255C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8018F206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgF3TXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:23:05 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:14590 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbgF3TXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:23:04 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id D8065201D0;
        Tue, 30 Jun 2020 22:22:55 +0300 (MSK)
Date:   Tue, 30 Jun 2020 22:22:55 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
Message-ID: <alpine.LNX.2.20.13.2006302219240.6255@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru> <56761139-f794-39b1-4dfa-dfc05fbe5f60@amd.com> <alpine.LNX.2.20.13.2006011132530.16067@monopod.intra.ispras.ru> <dba1e37a-1ed7-ef7f-7252-2ebd1d6bde8c@amd.com> <alpine.LNX.2.20.13.2006152346320.21123@monopod.intra.ispras.ru>
 <b01994db-da9b-d8e6-e0c1-1af35dd62191@amd.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020, Suravee Suthikulpanit wrote:

> > > On 6/1/20 4:01 PM, Alexander Monakov wrote:
> > > > On Mon, 1 Jun 2020, Suravee Suthikulpanit wrote:
> > > > 
> > > > > > Moving init_iommu_perf_ctr just after iommu_flush_all_caches
> > > > > > resolves the issue. This is the earliest point in amd_iommu_init_pci
> > > > > > where the call succeeds on my laptop.
> > > > > According to your description, it should just need to be anywhere
> > > > > after the pci_enable_device() is called for the IOMMU device, isn't
> > > > > it? So, on your system, what if we just move the init_iommu_perf_ctr()
> > > > > here:
> > > > No, this doesn't work, as I already said in the paragraph you are
> > > > responding to. See my last sentence in the quoted part.
> > > > 
> > > > So the implication is init_device_table_dma together with subsequent
> > > > cache flush is also setting up something that is necessary for counters
> > > > to be writable.
> > > > 
> > > > Alexander
> > > > 
> > > Instead of blindly moving the code around to a spot that would just work,
> > > I am trying to understand what might be required here. In this case,
> > > the init_device_table_dma()should not be needed. I suspect it's the IOMMU
> > > invalidate all command that's also needed here.
> > > 
> > > I'm also checking with the HW and BIOS team. Meanwhile, could you please
> > > give the following change a try:
> > Hello. Can you give any update please?
> > 
> > Alexander
> > 
> 
> Sorry for late reply. I have a reproducer and working with the HW team to
> understand the issue.
> I should be able to provide update with solution by the end of this week.

Hi, can you share any information (two more weeks have passed)?

Alexander
