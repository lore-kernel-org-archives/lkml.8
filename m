Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E856C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030EF207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbgFWRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbgFWRsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:48:13 -0400
Received: from gaia (unknown [2.26.170.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E85D206D4;
        Tue, 23 Jun 2020 17:48:10 +0000 (UTC)
Date:   Tue, 23 Jun 2020 18:48:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Maydell <Peter.Maydell@linaro.org>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
Message-ID: <20200623174807.GD5180@gaia>
References: <20200617123844.29960-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617123844.29960-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Jun 17, 2020 at 01:38:42PM +0100, Steven Price wrote:
> These patches add support to KVM to enable MTE within a guest. It is
> based on Catalin's v4 MTE user space series[1].
> 
> [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
> 
> Posting as an RFC as I'd like feedback on the approach taken. First a
> little background on how MTE fits within the architecture:
> 
> The stage 2 page tables have limited scope for controlling the
> availability of MTE. If a page is mapped as Normal and cached in stage 2
> then it's the stage 1 tables that get to choose whether the memory is
> tagged or not. So the only way of forbidding tags on a page from the
> hypervisor is to change the cacheability (or make it device memory)
> which would cause other problems.  Note this restriction fits the
> intention that a system should have all (general purpose) memory
> supporting tags if it support MTE, so it's not too surprising.
> 
> However, the upshot of this is that to enable MTE within a guest all
> pages of memory mapped into the guest as normal cached pages in stage 2
> *must* support MTE (i.e. we must ensure the tags are appropriately
> sanitised and save/restore the tags during swap etc).
> 
> My current approach is that KVM transparently upgrades any pages
> provided by the VMM to be tag-enabled when they are faulted in (i.e.
> sets the PG_mte_tagged flag on the page) which has the benefit of
> requiring fewer changes in the VMM. However, save/restore of the VM
> state still requires the VMM to have a PROT_MTE enabled mapping so that
> it can access the tag values. A VMM which 'forgets' to enable PROT_MTE
> would lose the tag values when saving/restoring (tags are RAZ/WI when
> PROT_MTE isn't set).
> 
> An alternative approach would be to enforce the VMM provides PROT_MTE
> memory in the first place. This seems appealing to prevent the above
> potentially unexpected gotchas with save/restore, however this would
> also extend to memory that you might not expect to have PROT_MTE (e.g. a
> shared frame buffer for an emulated graphics card). 

As you mentioned above, if memory is mapped as Normal Cacheable at Stage
2 (whether we use FWB or not), the guest is allowed to turn MTE on via
Stage 1. There is no way for KVM to prevent a guest from using MTE other
than the big HCR_EL2.ATA knob.

This causes potential issues since we can't guarantee that all the
Cacheable memory slots allocated by the VMM support MTE. If they do not,
the arch behaviour is "unpredictable". We also can't trust the guest to
not enable MTE on such Cacheable mappings.

On the host kernel, mmap'ing with PROT_MTE is only allowed for anonymous
mappings and shmem. So requiring the VMM to always pass PROT_MTE mapped
ranges to KVM, irrespective of whether it's guest RAM, emulated device,
virtio etc. (as long as they are Cacheable), filters unsafe ranges that
may be mapped into guest.

Note that in the next revision of the MTE patches I'll drop the DT
memory nodes checking and rely only on the CPUID information (arch
updated promised by the architects).

I see two possible ways to handle this (there may be more):

1. As in your current patches, assume any Cacheable at Stage 2 can have
   MTE enabled at Stage 1. In addition, we need to check whether the
   physical memory supports MTE and it could be something simple like
   pfn_valid(). Is there a way to reject a memory slot passed by the
   VMM?

2. Similar to 1 but instead of checking whether the pfn supports MTE, we
   require the VMM to only pass PROT_MTE ranges (filtering already done
   by the host kernel). We need a way to reject the slot and return an
   error to the VMM.

I think rejecting a slot at the Stage 2 fault time is very late. You
probably won't be able to do much other than killing the guest.

Both 1 and 2 above risk breaking existing VMMs just because they happen
to start on an MTE-capable machine. So, can we also require the VMM to
explicitly opt in to MTE support in guests via some ioctl()? This in
turn would enable the additional checks in KVM for the MTE capability of
the memory slots (1 or 2 above).

An alternative to an MTE enable ioctl(), if all the memory slots are set
up prior to the VM starting, KVM could check 1 or 2 above and decide
whether to expose MTE to guests (HCR_EL2.ATA).

More questions than solutions above, mostly for the KVM and Qemu
maintainers.

Thanks.

-- 
Catalin
