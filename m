Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB19C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA9821D82
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgDQGu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:50:59 -0400
Received: from verein.lst.de ([213.95.11.211]:55946 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDQGu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:50:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22EAA68BEB; Fri, 17 Apr 2020 08:50:55 +0200 (CEST)
Date:   Fri, 17 Apr 2020 08:50:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/3] iommu/vt-d: Allow 32bit devices to uses DMA
 domain
Message-ID: <20200417065054.GA18880@lst.de>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com> <20200416062354.10307-2-baolu.lu@linux.intel.com> <20200416070102.GA12588@lst.de> <e11d8138-f704-2f5e-c0b1-70b367a33d5d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e11d8138-f704-2f5e-c0b1-70b367a33d5d@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:40:38PM +0800, Lu Baolu wrote:
>> description.  I'd need to look at the final code, but it seems like
>> this will still cause bounce buffering instead of using dynamic
>> mapping, which still seems like an awful idea.
>
> Yes. If the user chooses to use identity domain by default through
> kernel command, identity domain will be applied for all devices. For
> those devices with limited addressing capability, bounce buffering will
> be used when they try to access the memory beyond their address
> capability. This won't cause any kernel regression as far as I can see.
>
> Switching domain during runtime with drivers loaded will cause real
> problems as I said in the commit message. That's the reason why I am
> proposing to remove it. If we want to keep it, we have to make sure that
> switching domain for one device should not impact other devices which
> share the same domain with it. Furthermore, it's better to implement it
> in the generic layer to keep device driver behavior consistent on all
> architectures.

I don't disagree with the technical points.  What I pointed out is that

 a) the actual technical change is not in the commit log, which it
    should be
 b) that I still think taking away the ability to dynamically map
    devices in the identify domain after all the time we allowed for
    that is going to cause nasty regressions.

