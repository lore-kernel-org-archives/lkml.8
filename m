Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1F6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675182087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bgxj/wCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgH0QVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbgH0QVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598545289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDfQUQHB+BREJSkQebzePvSFb6/f0niXAznSdAWH3bQ=;
        b=Bgxj/wCB5h1TvHmZpf3om0ft1DmLCz4Izarre7JW3H5t63848WEGLzQ5ww4KXpz2hKABh+
        9FyV0cZirvvr7AcMWGDTDRAQdPL9j38EsOFN4HDSW/q4XzW84QtTQJa0mFaH9yz/vzzGxA
        tYK00NAozFHwUCyr0W0OoPPmANY1AKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-0zuQgoNMOVK09o4vBRU7Sg-1; Thu, 27 Aug 2020 12:21:14 -0400
X-MC-Unique: 0zuQgoNMOVK09o4vBRU7Sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 627CB802B60;
        Thu, 27 Aug 2020 16:21:12 +0000 (UTC)
Received: from [10.36.112.112] (ovpn-112-112.ams2.redhat.com [10.36.112.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BE7310013D0;
        Thu, 27 Aug 2020 16:21:09 +0000 (UTC)
Subject: Re: [PATCH v2 1/9] docs: Document IO Address Space ID (IOASID) APIs
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.pan.linux@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824103239.GA3210689@myrica>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <15e94dd2-5c4d-27fc-f2b1-13e212538c42@redhat.com>
Date:   Thu, 27 Aug 2020 18:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200824103239.GA3210689@myrica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,
On 8/24/20 12:32 PM, Jean-Philippe Brucker wrote:
> On Fri, Aug 21, 2020 at 09:35:10PM -0700, Jacob Pan wrote:
>> IOASID is used to identify address spaces that can be targeted by device
>> DMA. It is a system-wide resource that is essential to its many users.
>> This document is an attempt to help developers from all vendors navigate
>> the APIs. At this time, ARM SMMU and Intel’s Scalable IO Virtualization
>> (SIOV) enabled platforms are the primary users of IOASID. Examples of
>> how SIOV components interact with IOASID APIs are provided in that many
>> APIs are driven by the requirements from SIOV.
>>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Wu Hao <hao.wu@intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> ---
>>  Documentation/ioasid.rst | 618 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 618 insertions(+)
>>  create mode 100644 Documentation/ioasid.rst
>>
>> diff --git a/Documentation/ioasid.rst b/Documentation/ioasid.rst
> 
> Thanks for writing this up. Should it go to Documentation/driver-api/, or
> Documentation/driver-api/iommu/? I think this also needs to Cc
> linux-doc@vger.kernel.org and corbet@lwn.net
> 
>> new file mode 100644
>> index 000000000000..b6a8cdc885ff
>> --- /dev/null
>> +++ b/Documentation/ioasid.rst
>> @@ -0,0 +1,618 @@
>> +.. ioasid:
>> +
>> +=====================================
>> +IO Address Space ID
>> +=====================================
>> +
>> +IOASID is a generic name for PCIe Process Address ID (PASID) or ARM
>> +SMMU sub-stream ID. An IOASID identifies an address space that DMA
> 
> "SubstreamID"
On ARM if we don't use PASIDs we have streamids (SID) which can also
identify address spaces that DMA requests can target. So maybe this
definition is not sufficient.

> 
>> +requests can target.
>> +
>> +The primary use cases for IOASID are Shared Virtual Address (SVA) and
>> +IO Virtual Address (IOVA). However, the requirements for IOASID
> 
> IOVA alone isn't a use case, maybe "multiple IOVA spaces per device"?
> 
>> +management can vary among hardware architectures.
>> +
>> +This document covers the generic features supported by IOASID
>> +APIs. Vendor-specific use cases are also illustrated with Intel's VT-d
>> +based platforms as the first example.
>> +
>> +.. contents:: :local:
>> +
>> +Glossary
>> +========
>> +PASID - Process Address Space ID
>> +
>> +IOASID - IO Address Space ID (generic term for PCIe PASID and
>> +sub-stream ID in SMMU)
> 
> "SubstreamID"
> 
>> +
>> +SVA/SVM - Shared Virtual Addressing/Memory
>> +
>> +ENQCMD - New Intel X86 ISA for efficient workqueue submission [1]
> 
> Maybe drop the "New", to keep the documentation perennial. It might be
> good to add internal links here to the specifications URLs at the bottom.
> 
>> +
>> +DSA - Intel Data Streaming Accelerator [2]
>> +
>> +VDCM - Virtual device composition module [3]
>> +
>> +SIOV - Intel Scalable IO Virtualization
>> +
>> +
>> +Key Concepts
>> +============
>> +
>> +IOASID Set
>> +-----------
>> +An IOASID set is a group of IOASIDs allocated from the system-wide
>> +IOASID pool. An IOASID set is created and can be identified by a
>> +token of u64. Refer to IOASID set APIs for more details.
> 
> Identified either by an u64 or an mm_struct, right?  Maybe just drop the
> second sentence if it's detailed in the IOASID set section below.
> 
>> +
>> +IOASID set is particularly useful for guest SVA where each guest could
>> +have its own IOASID set for security and efficiency reasons.
>> +
>> +IOASID Set Private ID (SPID)
>> +----------------------------
>> +SPIDs are introduced as IOASIDs within its set. Each SPID maps to a
>> +system-wide IOASID but the namespace of SPID is within its IOASID
>> +set.
> 
> The intro isn't super clear. Perhaps this is simpler:
> "Each IOASID set has a private namespace of SPIDs. An SPID maps to a
> single system-wide IOASID."
or, "within an ioasid set, each ioasid can be associated with an alias
ID, named SPID."
> 
>> SPIDs can be used as guest IOASIDs where each guest could do
>> +IOASID allocation from its own pool and map them to host physical
>> +IOASIDs. SPIDs are particularly useful for supporting live migration
>> +where decoupling guest and host physical resources are necessary.
>> +
>> +For example, two VMs can both allocate guest PASID/SPID #101 but map to
>> +different host PASIDs #201 and #202 respectively as shown in the
>> +diagram below.
>> +::
>> +
>> + .------------------.    .------------------.
>> + |   VM 1           |    |   VM 2           |
>> + |                  |    |                  |
>> + |------------------|    |------------------|
>> + | GPASID/SPID 101  |    | GPASID/SPID 101  |
>> + '------------------'    -------------------'     Guest
>> + __________|______________________|______________________
>> +           |                      |               Host
>> +           v                      v
>> + .------------------.    .------------------.
>> + | Host IOASID 201  |    | Host IOASID 202  |
>> + '------------------'    '------------------'
>> + |   IOASID set 1   |    |   IOASID set 2   |
>> + '------------------'    '------------------'
>> +
>> +Guest PASID is treated as IOASID set private ID (SPID) within an
>> +IOASID set, mappings between guest and host IOASIDs are stored in the
>> +set for inquiry.
>> +
>> +IOASID APIs
>> +===========
>> +To get the IOASID APIs, users must #include <linux/ioasid.h>. These APIs
>> +serve the following functionalities:
>> +
>> +  - IOASID allocation/Free
>> +  - Group management in the form of ioasid_set
>> +  - Private data storage and lookup
>> +  - Reference counting
>> +  - Event notification in case of state change
(a)
>> +
>> +IOASID Set Level APIs
>> +--------------------------
>> +For use cases such as guest SVA it is necessary to manage IOASIDs at
>> +a group level. For example, VMs may allocate multiple IOASIDs for
I would use the introduced ioasid_set terminology instead of "group".
>> +guest process address sharing (vSVA). It is imperative to enforce
>> +VM-IOASID ownership such that malicious guest cannot target DMA
> 
> "a malicious guest"
> 
>> +traffic outside its own IOASIDs, or free an active IOASID belong to
> 
> "that belongs to"
> 
>> +another VM.
>> +::
>> +
>> + struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota, u32 type)
what is this void *token? also the type may be explained here.
>> +
>> + int ioasid_adjust_set(struct ioasid_set *set, int quota);
> 
> These could be named "ioasid_set_alloc" and "ioasid_set_adjust" to be
> consistent with the rest of the API.
> 
>> +
>> + void ioasid_set_get(struct ioasid_set *set)
>> +
>> + void ioasid_set_put(struct ioasid_set *set)
>> +
>> + void ioasid_set_get_locked(struct ioasid_set *set)
>> +
>> + void ioasid_set_put_locked(struct ioasid_set *set)
>> +
>> + int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> 
> Might be nicer to keep the same argument names within the API. Here "set"
> rather than "sdata".
> 
>> +                                void (*fn)(ioasid_t id, void *data),
>> +				void *data)
> 
> (alignment)
> 
>> +
>> +
>> +IOASID set concept is introduced to represent such IOASID groups. Each
> 
> Or just "IOASID sets represent such IOASID groups", but might be
> redundant.
> 
>> +IOASID set is created with a token which can be one of the following
>> +types:
I think this explanation should happen before the above function prototypes
>> +
>> + - IOASID_SET_TYPE_NULL (Arbitrary u64 value)
>> + - IOASID_SET_TYPE_MM (Set token is a mm_struct)
>> +
>> +The explicit MM token type is useful when multiple users of an IOASID
>> +set under the same process need to communicate about their shared IOASIDs.
>> +E.g. An IOASID set created by VFIO for one guest can be associated
>> +with the KVM instance for the same guest since they share a common mm_struct.
>> +
>> +The IOASID set APIs serve the following purposes:
>> +
>> + - Ownership/permission enforcement
>> + - Take collective actions, e.g. free an entire set
>> + - Event notifications within a set
>> + - Look up a set based on token
>> + - Quota enforcement
> 
> This paragraph could be earlier in the section

yes this is a kind of repetition of (a), above
> 
>> +
>> +Individual IOASID APIs
>> +----------------------
>> +Once an ioasid_set is created, IOASIDs can be allocated from the set.
>> +Within the IOASID set namespace, set private ID (SPID) is supported. In
>> +the VM use case, SPID can be used for storing guest PASID.
>> +
>> +::
>> +
>> + ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>> +                       void *private);
>> +
>> + int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
>> +
>> + void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
>> +
>> + int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
>> +
>> + void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
>> +
>> + void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>> +                   bool (*getter)(void *));
>> +
>> + ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
>> +
>> + int ioasid_attach_data(struct ioasid_set *set, ioasid_t ioasid,
>> +                        void *data);
>> + int ioasid_attach_spid(struct ioasid_set *set, ioasid_t ioasid,
>> +                        ioasid_t ssid);
> 
> s/ssid/spid>
>> +
>> +
>> +Notifications
>> +-------------
>> +An IOASID may have multiple users, each user may have hardware context
>> +associated with an IOASID. When the status of an IOASID changes,
>> +e.g. an IOASID is being freed, users need to be notified such that the
>> +associated hardware context can be cleared, flushed, and drained.
>> +
>> +::
>> +
>> + int ioasid_register_notifier(struct ioasid_set *set, struct
>> +                              notifier_block *nb)
>> +
>> + void ioasid_unregister_notifier(struct ioasid_set *set,
>> +                                 struct notifier_block *nb)
>> +
>> + int ioasid_register_notifier_mm(struct mm_struct *mm, struct
>> +                                 notifier_block *nb)
>> +
>> + void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct
>> +                                    notifier_block *nb)
the mm_struct prototypes may be justified
>> +
>> + int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd,
>> +                   unsigned int flags)
this one is not obvious either.
>> +
>> +
>> +Events
>> +~~~~~~
>> +Notification events are pertinent to individual IOASIDs, they can be
>> +one of the following:
>> +
>> + - ALLOC
>> + - FREE
>> + - BIND
>> + - UNBIND
>> +
>> +Ordering
>> +~~~~~~~~
>> +Ordering is supported by IOASID notification priorities as the
>> +following (in ascending order):
>> +
>> +::
>> +
>> + enum ioasid_notifier_prios {
>> +	IOASID_PRIO_LAST,
>> +	IOASID_PRIO_IOMMU,
>> +	IOASID_PRIO_DEVICE,
>> +	IOASID_PRIO_CPU,
>> + };

Maybe:
when registered, notifiers are assigned a priority that affect the call
order. Notifiers with CPU priority get called before notifiers with
device priority and so on.
>> +
>> +The typical use case is when an IOASID is freed due to an exception, DMA
>> +source should be quiesced before tearing down other hardware contexts
>> +in the system. This will reduce the churn in handling faults. DMA work
>> +submission is performed by the CPU which is granted higher priority than
>> +devices.
>> +
>> +
>> +Scopes
>> +~~~~~~
>> +There are two types of notifiers in IOASID core: system-wide and
>> +ioasid_set-wide.
>> +
>> +System-wide notifier is catering for users that need to handle all
>> +IOASIDs in the system. E.g. The IOMMU driver handles all IOASIDs.
>> +
>> +Per ioasid_set notifier can be used by VM specific components such as
>> +KVM. After all, each KVM instance only cares about IOASIDs within its
>> +own set.
>> +
>> +
>> +Atomicity
>> +~~~~~~~~~
>> +IOASID notifiers are atomic due to spinlocks used inside the IOASID
>> +core. For tasks cannot be completed in the notifier handler, async work
> 
> "tasks that cannot be"
> 
>> +can be submitted to complete the work later as long as there is no
>> +ordering requirement.
>> +
>> +Reference counting
>> +------------------
>> +IOASID lifecycle management is based on reference counting. Users of
>> +IOASID intend to align lifecycle with the IOASID need to hold
> 
> "who intend to"
> 
>> +reference of the IOASID. IOASID will not be returned to the pool for
> 
> "a reference to the IOASID. The IOASID"
> 
>> +allocation until all references are dropped. Calling ioasid_free()
>> +will mark the IOASID as FREE_PENDING if the IOASID has outstanding
>> +reference. ioasid_get() is not allowed once an IOASID is in the
>> +FREE_PENDING state.
>> +
>> +Event notifications are used to inform users of IOASID status change.
>> +IOASID_FREE event prompts users to drop their references after
>> +clearing its context.
>> +
>> +For example, on VT-d platform when an IOASID is freed, teardown
>> +actions are performed on KVM, device driver, and IOMMU driver.
>> +KVM shall register notifier block with::
>> +
>> + static struct notifier_block pasid_nb_kvm = {
>> +	.notifier_call = pasid_status_change_kvm,
>> +	.priority      = IOASID_PRIO_CPU,
>> + };
>> +
>> +VDCM driver shall register notifier block with::
>> +
>> + static struct notifier_block pasid_nb_vdcm = {
>> +	.notifier_call = pasid_status_change_vdcm,
>> +	.priority      = IOASID_PRIO_DEVICE,
>> + };
not sure those code snippets are really useful. Maybe simply say who is
supposed to use each prio.
>> +
>> +In both cases, notifier blocks shall be registered on the IOASID set
>> +such that *only* events from the matching VM is received.
>> +
>> +If KVM attempts to register notifier block before the IOASID set is
>> +created for the MM token, the notifier block will be placed on a
using the MM token
>> +pending list inside IOASID core. Once the token matching IOASID set
>> +is created, IOASID will register the notifier block automatically.
Is this implementation mandated? Can't you enforce the ioasid_set to be
created before the notifier gets registered?
>> +IOASID core does not replay events for the existing IOASIDs in the
>> +set. For IOASID set of MM type, notification blocks can be registered
>> +on empty sets only. This is to avoid lost events.
>> +
>> +IOMMU driver shall register notifier block on global chain::
>> +
>> + static struct notifier_block pasid_nb_vtd = {
>> +	.notifier_call = pasid_status_change_vtd,
>> +	.priority      = IOASID_PRIO_IOMMU,
>> + };
>> +
>> +Custom allocator APIs
>> +---------------------
>> +
>> +::
>> +
>> + int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>> +
>> + void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>> +
>> +Allocator Choices
>> +~~~~~~~~~~~~~~~~~
>> +IOASIDs are allocated for both host and guest SVA/IOVA usage. However,
>> +allocators can be different. For example, on VT-d guest PASID
>> +allocation must be performed via a virtual command interface which is
>> +emulated by VMM.
>> +
>> +IOASID core has the notion of "custom allocator" such that guest can
>> +register virtual command allocator that precedes the default one.
>> +
>> +Namespaces
>> +~~~~~~~~~~
>> +IOASIDs are limited system resources that default to 20 bits in
>> +size. Since each device has its own table, theoretically the namespace
>> +can be per device also. However, for security reasons sharing PASID
>> +tables among devices are not good for isolation. Therefore, IOASID
>> +namespace is system-wide.
> 
> I don't follow this development. Having per-device PASID table would work
> fine for isolation (assuming no hardware bug necessitating IOMMU groups).
> If I remember correctly IOASID space was chosen to be OS-wide because it
> simplifies the management code (single PASID per task), and it is
> system-wide across VMs only in the case of VT-d scalable mode.
> 
>> +
>> +There are also other reasons to have this simpler system-wide
>> +namespace. Take VT-d as an example, VT-d supports shared workqueue
>> +and ENQCMD[1] where one IOASID could be used to submit work on
> 
> Maybe use the Sphinx glossary syntax rather than "[1]"
> https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#glossary-directive
> 
>> +multiple devices that are shared with other VMs. This requires IOASID
>> +to be system-wide. This is also the reason why guests must use an
>> +emulated virtual command interface to allocate IOASID from the host.
>> +
>> +
>> +Life cycle
>> +==========
>> +This section covers IOASID lifecycle management for both bare-metal
>> +and guest usages. In bare-metal SVA, MMU notifier is directly hooked
>> +up with IOMMU driver, therefore the process address space (MM)
>> +lifecycle is aligned with IOASID.
therefore the IOASID lifecyle matches the process address space (MM)
lifecyle?
>> +
>> +However, guest MMU notifier is not available to host IOMMU driver,
the guest MMU notifier
>> +when guest MM terminates unexpectedly, the events have to go through
the guest MM
>> +VFIO and IOMMU UAPI to reach host IOMMU driver. There are also more
>> +parties involved in guest SVA, e.g. on Intel VT-d platform, IOASIDs
>> +are used by IOMMU driver, KVM, VDCM, and VFIO.
>> +
>> +Native IOASID Life Cycle (VT-d Example)
>> +---------------------------------------
>> +
>> +The normal flow of native SVA code with Intel Data Streaming
>> +Accelerator(DSA) [2] as example:
>> +
>> +1. Host user opens accelerator FD, e.g. DSA driver, or uacce;
>> +2. DSA driver allocate WQ, do sva_bind_device();
>> +3. IOMMU driver calls ioasid_alloc(), then bind PASID with device,
>> +   mmu_notifier_get()
>> +4. DMA starts by DSA driver userspace
>> +5. DSA userspace close FD
>> +6. DSA/uacce kernel driver handles FD.close()
>> +7. DSA driver stops DMA
>> +8. DSA driver calls sva_unbind_device();
>> +9. IOMMU driver does unbind, clears PASID context in IOMMU, flush
>> +   TLBs. mmu_notifier_put() called.
>> +10. mmu_notifier.release() called, IOMMU SVA code calls ioasid_free()*
>> +11. The IOASID is returned to the pool, reclaimed.
>> +
>> +::
>> +
> 
> Use a footnote? https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#footnotes
> 
>> +   * With ENQCMD, PASID used on VT-d is not released in mmu_notifier() but
>> +     mmdrop(). mmdrop comes after FD close. Should not matter.
> 
> "comes after FD close, which doesn't make a difference?"
> The following might not be necessary since early process termination is
> described later.
> 
>> +     If the user process dies unexpectedly, Step #10 may come before
>> +     Step #5, in between, all DMA faults discarded. PRQ responded with
> 
> PRQ hasn't been defined in this document.
> 
>> +     code INVALID REQUEST.
>> +
>> +During the normal teardown, the following three steps would happen in
>> +order:
can't this be illustrated in the above 1-11 sequence, just adding NORMAL
TEARDONW before #7?
>> +
>> +1. Device driver stops DMA request
>> +2. IOMMU driver unbinds PASID and mm, flush all TLBs, drain in-flight
>> +   requests.
>> +3. IOASID freed
>> +
Then you can just focus on abnormal termination
>> +Exception happens when process terminates *before* device driver stops
>> +DMA and call IOMMU driver to unbind. The flow of process exists are as
Can't this be explained with something simpler looking at the steps 1-11?
> 
> "exits"
> 
>> +follows:
>> +
>> +::
>> +
>> +   do_exit() {
>> +	exit_mm() {
>> +		mm_put();
>> +		exit_mmap() {
>> +			intel_invalidate_range() //mmu notifier
>> +			tlb_finish_mmu()
>> +			mmu_notifier_release(mm) {
>> +				intel_iommu_release() {
>> +   [2]					intel_iommu_teardown_pasid();
> 
> Parentheses might be better than square brackets for step numbers
> 
>> +                                        intel_iommu_flush_tlbs();
>> +				}
>> +				// tlb_invalidate_range cb removed
>> +			}
>> +			unmap_vmas();
>> +                        free_pgtables(); // IOMMU cannot walk PGT after this
>> +		};
>> +	}
>> +	exit_files(tsk) {
>> +		close_files() {
>> +			dsa_close();
>> +   [1]			dsa_stop_dma();
>> +                        intel_svm_unbind_pasid(); //nothing to do
>> +		}
>> +	}
>> +   }
>> +
>> +   mmdrop() /* some random time later, lazy mm user */ {
>> +   	mm_free_pgd();
>> +        destroy_context(mm); {
>> +   [3]	        ioasid_free();
>> +	}
>> +   }
>> +
>> +As shown in the list above, step #2 could happen before
>> +#1. Unrecoverable(UR) faults could happen between #2 and #1.
>> +
>> +Also notice that TLB invalidation occurs at mmu_notifier
>> +invalidate_range callback as well as the release callback. The reason
>> +is that release callback will delete IOMMU driver from the notifier
>> +chain which may skip invalidate_range() calls during the exit path.
>> +
>> +To avoid unnecessary reporting of UR fault, IOMMU driver shall disable
UR?
>> +fault reporting after free and before unbind.
>> +
>> +Guest IOASID Life Cycle (VT-d Example)
>> +--------------------------------------
>> +Guest IOASID life cycle starts with guest driver open(), this could be
>> +uacce or individual accelerator driver such as DSA. At FD open,
>> +sva_bind_device() is called which triggers a series of actions.
>> +
>> +The example below is an illustration of *normal* operations that
>> +involves *all* the SW components in VT-d. The flow can be simpler if
>> +no ENQCMD is supported.
>> +
>> +::
>> +
>> +     VFIO        IOMMU        KVM        VDCM        IOASID       Ref
>> +   ..................................................................
>> +   1             ioasid_register_notifier/_mm()
>> +   2 ioasid_alloc()                                               1
>> +   3 bind_gpasid()
>> +   4             iommu_bind()->ioasid_get()                       2
>> +   5             ioasid_notify(BIND)
>> +   6                          -> ioasid_get()                     3
>> +   7                          -> vmcs_update_atomic()
>> +   8 mdev_write(gpasid)
>> +   9                                    hpasid=
>> +   10                                   find_by_spid(gpasid)      4
>> +   11                                   vdev_write(hpasid)
>> +   12 -------- GUEST STARTS DMA --------------------------
>> +   13 -------- GUEST STOPS DMA --------------------------
>> +   14 mdev_clear(gpasid)
>> +   15                                   vdev_clear(hpasid)
>> +   16                                   ioasid_put()               3
>> +   17 unbind_gpasid()
>> +   18            iommu_ubind()
>> +   19            ioasid_notify(UNBIND)
>> +   20                          -> vmcs_update_atomic()
>> +   21                          -> ioasid_put()                     2
>> +   22 ioasid_free()                                                1
>> +   23            ioasid_put()                                      0
>> +   24                                                 Reclaimed
>> +   -------------- New Life Cycle Begin ----------------------------
>> +   1  ioasid_alloc()                                  ->           1
>> +
>> +   Note: IOASID Notification Events: FREE, BIND, UNBIND
>> +
>> +Exception cases arise when a guest crashes or a malicious guest
>> +attempts to cause disruption on the host system. The fault handling
>> +rules are:
>> +
>> +1. IOASID free must *always* succeed.
>> +2. An inactive period may be required before the freed IOASID is
>> +   reclaimed. During this period, consumers of IOASID perform cleanup.
>> +3. Malfunction is limited to the guest owned resources for all
>> +   programming errors.
>> +
>> +The primary source of exception is when the following are out of
>> +order:
>> +
>> +1. Start/Stop of DMA activity
>> +   (Guest device driver, mdev via VFIO)
please explain the meaning of what is inside (): initiator?
>> +2. Setup/Teardown of IOMMU PASID context, IOTLB, DevTLB flushes
>> +   (Host IOMMU driver bind/unbind)
>> +3. Setup/Teardown of VMCS PASID translation table entries (KVM) in
>> +   case of ENQCMD
>> +4. Programming/Clearing host PASID in VDCM (Host VDCM driver)
>> +5. IOASID alloc/free (Host IOASID)
>> +
>> +VFIO is the *only* user-kernel interface, which is ultimately
>> +responsible for exception handlings.
> 
> "handling"
> 
>> +
>> +#1 is processed the same way as the assigned device today based on
>> +device file descriptors and events. There is no special handling.
>> +
>> +#3 is based on bind/unbind events emitted by #2.
>> +
>> +#4 is naturally aligned with IOASID life cycle in that an illegal
>> +guest PASID programming would fail in obtaining reference of the
>> +matching host IOASID.
>> +
>> +#5 is similar to #4. The fault will be reported to the user if PASID
>> +used in the ENQCMD is not set up in VMCS PASID translation table.
>> +
>> +Therefore, the remaining out of order problem is between #2 and
>> +#5. I.e. unbind vs. free. More specifically, free before unbind.
>> +
>> +IOASID notifier and refcounting are used to ensure order. Following
>> +a publisher-subscriber pattern where:
with the following actors:
>> +
>> +- Publishers: VFIO & IOMMU
>> +- Subscribers: KVM, VDCM, IOMMU
this may be introduced before.
>> +
>> +IOASID notifier is atomic which requires subscribers to do quick
>> +handling of the event in the atomic context. Workqueue can be used for
>> +any processing that requires thread context.
repetition of what was said before.
 IOASID reference must be
>> +acquired before receiving the FREE event. The reference must be
>> +dropped at the end of the processing in order to return the IOASID to
>> +the pool.
>> +
>> +Let's examine the IOASID life cycle again when free happens *before*
>> +unbind. This could be a result of misbehaving guests or crash. Assuming
>> +VFIO cannot enforce unbind->free order. Notice that the setup part up
>> +until step #12 is identical to the normal case, the flow below starts
>> +with step 13.
>> +
>> +::
>> +
>> +     VFIO        IOMMU        KVM        VDCM        IOASID       Ref
>> +   ..................................................................
>> +   13 -------- GUEST STARTS DMA --------------------------
>> +   14 -------- *GUEST MISBEHAVES!!!* ----------------
>> +   15 ioasid_free()
>> +   16                                             ioasid_notify(FREE)
>> +   17                                             mark_ioasid_inactive[1]
>> +   18                          kvm_nb_handler(FREE)
>> +   19                          vmcs_update_atomic()
>> +   20                          ioasid_put_locked()   ->           3
>> +   21                                   vdcm_nb_handler(FREE)
>> +   22            iomm_nb_handler(FREE)
>> +   23 ioasid_free() returns[2]          schedule_work()           2
>> +   24            schedule_work()        vdev_clear_wk(hpasid)
>> +   25            teardown_pasid_wk()
>> +   26                                   ioasid_put() ->           1
>> +   27            ioasid_put()                                     0
>> +   28                                                 Reclaimed
>> +   29 unbind_gpasid()
>> +   30            iommu_unbind()->ioasid_find() Fails[3]
>> +   -------------- New Life Cycle Begin ----------------------------
>> +
>> +Note:
>> +
>> +1. By marking IOASID inactive at step #17, no new references can be
> 
> Is "inactive" FREE_PENDING?
> 
>> +   held. ioasid_get/find() will return -ENOENT;
>> +2. After step #23, all events can go out of order. Shall not affect
>> +   the outcome.
>> +3. IOMMU driver fails to find private data for unbinding. If unbind is
>> +   called after the same IOASID is allocated for the same guest again,
>> +   this is a programming error. The damage is limited to the guest
>> +   itself since unbind performs permission checking based on the
>> +   IOASID set associated with the guest process.
>> +
>> +KVM PASID Translation Table Updates
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Per VM PASID translation table is maintained by KVM in order to
>> +support ENQCMD in the guest. The table contains host-guest PASID
>> +translations to be consumed by CPU ucode. The synchronization of the
>> +PASID states depends on VFIO/IOMMU driver, where IOCTL and atomic
>> +notifiers are used. KVM must register IOASID notifier per VM instance
>> +during launch time. The following events are handled:
>> +
>> +1. BIND/UNBIND
>> +2. FREE
>> +
>> +Rules:
>> +
>> +1. Multiple devices can bind with the same PASID, this can be different PCI
>> +   devices or mdevs within the same PCI device. However, only the
>> +   *first* BIND and *last* UNBIND emit notifications.
>> +2. IOASID code is responsible for ensuring the correctness of H-G
>> +   PASID mapping. There is no need for KVM to validate the
>> +   notification data.
>> +3. When UNBIND happens *after* FREE, KVM will see error in
>> +   ioasid_get() even when the reclaim is not done. IOMMU driver will
>> +   also avoid sending UNBIND if the PASID is already FREE.
>> +4. When KVM terminates *before* FREE & UNBIND, references will be
>> +   dropped for all host PASIDs.
>> +
>> +VDCM PASID Programming
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +VDCM composes virtual devices and exposes them to the guests. When
>> +the guest allocates a PASID then program it to the virtual device, VDCM
programs as well
>> +intercepts the programming attempt then program the matching host
> 
> "programs"
> 
> Thanks,
> Jean
> 
>> +PASID on to the hardware.
>> +Conversely, when a device is going away, VDCM must be informed such
>> +that PASID context on the hardware can be cleared. There could be
>> +multiple mdevs assigned to different guests in the same VDCM. Since
>> +the PASID table is shared at PCI device level, lazy clearing is not
>> +secure. A malicious guest can attack by using newly freed PASIDs that
>> +are allocated by another guest.
>> +
>> +By holding a reference of the PASID until VDCM cleans up the HW context,
>> +it is guaranteed that PASID life cycles do not cross within the same
>> +device.
>> +
>> +
>> +Reference
>> +====================================================
>> +1. https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
>> +
>> +2. https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator
>> +
>> +3. https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
>> -- 
>> 2.7.4

Thanks

Eric
>>
> 

