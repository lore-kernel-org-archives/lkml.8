Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1176CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A892078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733282AbgDAXcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:32:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:24904 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732503AbgDAXcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:32:55 -0400
IronPort-SDR: 8Nl3LQu1TSQSonU51qJYmvQXh7bgQ6iodmCyqX8Zb+y9LL4aDOZT2hYLKw4LxtPyL8gX0hnWNW
 +TsMNkBz1Htg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 16:32:54 -0700
IronPort-SDR: s+MvrXBQLFn4ubqceqCFVl/EWv6z0E2ybZuK3KV5Ir9IewTFD4Fd8jQ/0W2IXjbPEP3QDoMqjy
 lzFWKPBi2O2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="328632621"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2020 16:32:54 -0700
Date:   Wed, 1 Apr 2020 16:38:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com, "Wu, Hao" <hao.wu@intel.com>
Subject: Re: [PATCH 00/10] IOASID extensions for guest SVA
Message-ID: <20200401163842.09c8e1a6@jacob-builder>
In-Reply-To: <20200401140301.GJ882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200401140301.GJ882512@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 16:03:01 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> On Wed, Mar 25, 2020 at 10:55:21AM -0700, Jacob Pan wrote:
> > IOASID was introduced in v5.5 as a generic kernel allocator service
> > for both PCIe Process Address Space ID (PASID) and ARM SMMU's Sub
> > Stream ID. In addition to basic ID allocation, ioasid_set was
> > introduced as a token that is shared by a group of IOASIDs. This
> > set token can be used for permission checking but lack of some
> > features needed by guest Shared Virtual Address (SVA). In addition,
> > IOASID support for life cycle management is needed among multiple
> > users.
> > 
> > This patchset introduces two extensions to the IOASID code,
> > 1. IOASID set operations
> > 2. Notifications for IOASID state synchronization  
> 
> My main concern with this series is patch 7 changing the spinlock to a
> mutex, which prevents SVA from calling ioasid_free() from the RCU
> callback of MMU notifiers. Could we use atomic notifiers, or do the
> FREE notification another way?
> 
Maybe I am looking at the wrong code, I thought
mmu_notifier_ops.free_notifier() is called outside spinlock with
call_srcu(), which will be invoked in the thread context.
in mmu_notifier.c mmu_notifier_put()
	spin_unlock(&mm->notifier_subscriptions->lock);

	call_srcu(&srcu, &subscription->rcu, mmu_notifier_free_rcu);

Anyway, if we have to use atomic. I tried atomic notifier first, there
are two subscribers to the free event on x86.
1. IOMMU
2. KVM

For #1, the problem is that in the free operation, VT-d driver
needs to do a lot of clean up in thread context.
- hold a mutex to traverse a list of devices
- clear PASID entry and flush cache

For #2, KVM might be able to deal with spinlocks for updating VMCS
PASID translation table. +Hao

Perhaps two solutions I can think of:
1. Use a cyclic IOASID allocator. The main reason of clean up at free
is to prevent race with IOASID alloc. Similar to PID, 2M IOASID
will take long time overflow. Then we can use atomic notifier and a
deferred workqueue to do IOMMU cleanup. The downside is a large and
growing PASID table, may not be a performance issue since it has TLB.

2. Let VFIO ensure free always happen after unbind. Then there is no
need to do cleanup. But that requires VFIO to keep track of all the
PASIDs within each VM. When the VM terminates, VFIO is responsible for
the clean up. That was Yi's original proposal. I also tried to provide
an IOASID set iterator for VFIO to free the IOASIDs within each VM/set,
but the private data belongs to IOMMU driver.

Thanks,

Jacob

> Most of my other comments are just confusion on my part, I think, as I
> haven't yet properly looked through the VFIO and VT-d changes. I'd
> rather avoid the change to ioasid_find() if possible, because it adds
> a seemingly unnecessary indirection to the fast path, but it's
> probably insignificant.
> 
> Thanks,
> Jean
> 
> > 
> > Part #1:
> > IOASIDs used by each VM fits naturally into an ioasid_set. The usage
> > for per set management requires the following features:
> > 
> > - Quota enforcement - This is to prevent one VM from abusing the
> >   allocator to take all the system IOASIDs. Though VFIO layer can
> > also enforce the quota, but it cannot cover the usage with both
> > guest and host SVA on the same system.
> > 
> > - Stores guest IOASID-Host IOASID mapping within the set. To
> >   support live migration, IOASID namespace should be owned by the
> >   guest. This requires per IOASID set look up between guest and host
> >   IOASIDs. This patchset does not introduce non-identity guest-host
> >   IOASID lookup, we merely introduce the infrastructure in per set
> > data.
> > 
> > - Set level operations, e.g. when a guest terminates, it is likely
> > to free the entire set. Having a single place to manage the set
> > where the IOASIDs are stored makes iteration much easier.
> > 
> > 
> > New APIs are:
> > - void ioasid_install_capacity(ioasid_t total);
> >   Set the system capacity prior to any allocations. On x86, VT-d
> > driver calls this function to set max number of PASIDs, typically 1
> > million (20 bits).
> > 
> > - int ioasid_alloc_system_set(int quota);
> >   Host system has a default ioasid_set, during boot it is expected
> > that this default set is allocated with a reasonable quota, e.g.
> > PID_MAX. This default/system set is used for baremetal SVA.
> > 
> > - int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int
> > *sid);
> >   Allocate a new set with a token, returned sid (set ID) will be
> > used to allocate IOASIDs within the set. Allocation of IOASIDs
> > cannot exceed the quota.
> > 
> > - void ioasid_free_set(int sid, bool destroy_set);
> >   Free the entire set and notify all users with an option to destroy
> >   the set. Set ID can be used for allocation again if not destroyed.
> > 
> > - int ioasid_find_sid(ioasid_t ioasid);
> >   Look up the set ID from an ioasid. There is no reference held,
> >   assuming set has a single owner.
> > 
> > - int ioasid_adjust_set(int sid, int quota);
> >   Change the quota of the set, new quota cannot be less than the
> > number of IOASIDs already allocated within the set. This is useful
> > when IOASID resource needs to be balanced among VMs.
> > 
> > Part #2
> > Notification service. Since IOASIDs are used by many consumers that
> > follow publisher-subscriber pattern, notification is a natural
> > choice to keep states synchronized. For example, on x86 system,
> > guest PASID allocation and bind call results in VFIO IOCTL that can
> > add and change guest-host PASID states. At the same time, IOMMU
> > driver and KVM need to maintain its own PASID contexts. In this
> > case, VFIO is the publisher within the kernel, IOMMU driver and KVM
> > are the subscribers.
> > 
> > This patchset introduces a global blocking notifier chain and APIs
> > to operate on. Not all events nor all IOASIDs are of interests to
> > all subscribers. e.g. KVM is only interested in the IOASIDs within
> > its set. IOMMU driver is not ioasid_set aware. A further
> > optimization could be having both global and per set notifier. But
> > consider the infrequent nature of bind/unbind and relatively long
> > process life cycle, this optimization may not be needed at this
> > time.
> > 
> > To register/unregister notification blocks, use these two APIs:
> > - int ioasid_add_notifier(struct notifier_block *nb);
> > - void ioasid_remove_notifier(struct notifier_block *nb)
> > 
> > To send notification on an IOASID with one of the commands (FREE,
> > BIND/UNBIND, etc.), use:
> > - int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
> > 
> > This work is a result of collaboration with many people:
> > Liu, Yi L <yi.l.liu@intel.com>
> > Wu Hao <hao.wu@intel.com>
> > Ashok Raj <ashok.raj@intel.com>
> > Kevin Tian <kevin.tian@intel.com>
> > 
> > Thanks,
> > 
> > Jacob
> > 
> > Jacob Pan (10):
> >   iommu/ioasid: Introduce system-wide capacity
> >   iommu/vt-d: Set IOASID capacity when SVM is enabled
> >   iommu/ioasid: Introduce per set allocation APIs
> >   iommu/ioasid: Rename ioasid_set_data to avoid confusion with
> >     ioasid_set
> >   iommu/ioasid: Create an IOASID set for host SVA use
> >   iommu/ioasid: Convert to set aware allocations
> >   iommu/ioasid: Use mutex instead of spinlock
> >   iommu/ioasid: Introduce notifier APIs
> >   iommu/ioasid: Support ioasid_set quota adjustment
> >   iommu/vt-d: Register PASID notifier for status change
> > 
> >  drivers/iommu/intel-iommu.c |  20 ++-
> >  drivers/iommu/intel-svm.c   |  89 ++++++++--
> >  drivers/iommu/ioasid.c      | 387
> > +++++++++++++++++++++++++++++++++++++++-----
> > include/linux/intel-iommu.h |   1 + include/linux/ioasid.h      |
> > 86 +++++++++- 5 files changed, 522 insertions(+), 61 deletions(-)
> > 
> > -- 
> > 2.7.4
> >   

[Jacob Pan]
