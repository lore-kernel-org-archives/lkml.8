Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1804BC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5F120735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgDMPZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:25:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:64151 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbgDMPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:25:30 -0400
IronPort-SDR: yk9xMZAahcSTAfJs0Jn7fcKJbraOH+ta5apXUqMmSz6U/+kYb0qqgUZaIMOpnI1pG9mmNQpiwZ
 9neyao4F49aw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:25:28 -0700
IronPort-SDR: W0dDkPbPivnevCHh26CIB+Ht0FHcfckngVjnr3EelLm9ViaKBmuEt1zUPDoE/NA7N118bhfOhP
 L2TkZVU8JTCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="363096529"
Received: from araj-mobl1.jf.intel.com ([10.255.32.166])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 08:25:24 -0700
Date:   Mon, 13 Apr 2020 08:25:24 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [RFC PATCH 0/4] mm: Add PG_zero support
Message-ID: <20200413152523.GL23186@araj-mobl1.jf.intel.com>
References: <20200412090728.GA19572@open-light-1.localdomain>
 <f9a3be0b-fe8d-ca25-f0df-4b9fd1f0fed5@intel.com>
 <20200413084915.1bae0007@w520.home>
 <7a064e81-6bc1-b3e7-5f82-292ffa392058@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a064e81-6bc1-b3e7-5f82-292ffa392058@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 08:14:32AM -0700, Dave Hansen wrote:
> On 4/13/20 7:49 AM, Alex Williamson wrote:
> >> VFIO's unconditional page pinning is the real problem here IMNHO.  They
> >> don't *really* need to pin the memory.  We just don't have good
> >> paravirtualized IOMMU support or want to pay the runtime cost for
> >> pin/unpin operations.  You *could* totally have speedy VM startup if
> >> only the pages being accessed or having DMA performed to them were
> >> allocated.  But, the hacks that are in place mean that everything must
> >> be pinned.
> > Maybe in an SEV or Secure Boot environment we can assume the VM guest
> > OS uses the IOMMU exclusively for DMA, but otherwise the IOMMU is
> > optional (at least for x86, other archs do require IOMMU support
> > afaik).  Therefore, how would we know which pages to pin when there are
> > only limited configs where we might be able to lean on the vIOMMU to
> > this extent?  Thanks,
> 
> You can delay pinning until the device is actually used.  That should be
> late enough for the host to figure out whether a paravirtualized IOMMU
> is in place.

When you have a device assigned to a guest, it is used when the guest starts
probing the device. Some devices like VF's need DMA even to probe and get
resources assigned from the PF.

The only way we can do this is when device support ATS and PRS. And host
iommu driver to know if this fault needs to be handled by the host (if the
2nd level is at fault), or the guest if the walk in first level isn't
resolved.

2nd level faults need to be resolved by the VMM.
