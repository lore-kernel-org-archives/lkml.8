Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C80C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A276207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgHXIfu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:35:50 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:59229 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728138AbgHXIfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:35:41 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22218848-1500050 
        for multiple; Mon, 24 Aug 2020 09:35:11 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <65125687-14ae-182f-da07-7d29b4910364@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com> <20190525054136.27810-8-baolu.lu@linux.intel.com> <159803479017.29194.1359332295829225843@build.alporthouse.com> <65125687-14ae-182f-da07-7d29b4910364@linux.intel.com>
Subject: Re: [PATCH v4 07/15] iommu/vt-d: Delegate the dma domain to upper layer
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Date:   Mon, 24 Aug 2020 09:35:11 +0100
Message-ID: <159825811140.30134.5347490249201789397@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lu Baolu (2020-08-24 07:31:23)
> Hi Chris,
> 
> On 2020/8/22 2:33, Chris Wilson wrote:
> > Quoting Lu Baolu (2019-05-25 06:41:28)
> >> This allows the iommu generic layer to allocate a dma domain and
> >> attach it to a device through the iommu api's. With all types of
> >> domains being delegated to upper layer, we can remove an internal
> >> flag which was used to distinguish domains mananged internally or
> >> externally.
> > 
> > I'm seeing some really strange behaviour with this patch on a 32b
> > Skylake system (and still present on mainline). Before this patch
> > everything is peaceful and appears to work correctly. Applying this patch,
> > and we fail to initialise the GPU with a few DMAR errors reported, e.g.
> > 
> > [   20.279445] DMAR: DRHD: handling fault status reg 3
> > [   20.279508] DMAR: [DMA Read] Request device [00:02.0] fault addr 8900a000 [fault reason 05] PTE Write access is not set
> > 
> > Setting an identity map for the igfx made the DMAR errors disappear, but
> > the GPU still failed to initialise.
> > 
> > There's no difference in the DMAR configuration dmesg between working and
> > the upset patch. And the really strange part is that switching to a 64b
> > kernel with this patch, it's working.
> > 
> > Any suggestions on what I should look for?
> 
> Can the patch titled "[PATCH] iommu/intel: Handle 36b addressing for
> x86-32" solve this problem?

It does. Not sure why, but that mystery I can leave for others.
-Chris
