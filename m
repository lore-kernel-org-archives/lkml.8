Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D02C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E342C214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgDQXIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:08:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:47835 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgDQXIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 19:08:14 -0400
IronPort-SDR: J2/QeMJZLD95ZJsXMLuv4JZgxsmBKQIOfmxaSLiMCDOm2bHGWzRqyZCMp90DyFy9jbQKHrdf6q
 im2mrWgrc1Vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 16:08:13 -0700
IronPort-SDR: NMf2GyKaBT7mM+wW2++JC7mW26nSqnGhRqrO1tM1HH3WO5rLQnR6iN+C6o7HgcZ/yKLVcOvs3P
 gVWLh+CB50+A==
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="428389969"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.16.52]) ([10.251.16.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 16:08:13 -0700
Subject: Re: [RFC PATCH v2 0/2] x86/resctrl: Start abstraction for a second
 arch
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com>
 <e3e4b142-d6e2-4fa8-be57-e829fc6e48f7@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <74fbe0a4-f5c5-888f-0219-22f695b0349c@intel.com>
Date:   Fri, 17 Apr 2020 16:08:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e3e4b142-d6e2-4fa8-be57-e829fc6e48f7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/15/2020 5:59 AM, James Morse wrote:
> On 14/04/2020 19:56, Reinette Chatre wrote:
>> On 12/31/1969 4:00 PM, James Morse wrote:
>>> These two patches are the tip of the MPAM iceberg.
>>>
>>> Arm have some CPU support for dividing caches into portions, and
>>> applying bandwidth limits at various points in the SoC. The collective term
>>> for these features is MPAM: Memory Partitioning and Monitoring.
>>>
>>> MPAM is similar enough to Intel RDT, that it should use the defacto linux
>>> interface: resctrl. This filesystem currently lives under arch/x86, and is
>>> tightly coupled to the architecture.
>>> Ultimately, my plan is to split the existing resctrl code up to have an
>>> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
>>> MPAM can be wired up.
>>>
>>> These two patches are step one: Split the two structs that resctrl uses
>>> to have an arch<->fs split. These sit on top of the cleanup posted here:
>>> lore.kernel.org/r/20200214182401.39008-1-james.morse@arm.com
>>>
>>> I'm after strong opinions like "No! struct mbm_state is obviously arch
>>> specific.". Making the hardware configuration belong to the arch code
>>> instead of resctrl is so that it can be scaled on arm64, where MPAM
>>> allows terrifyingly large portion bitmaps for the caches.
>>>
>>>
>>>
>>> Last time these were posted, the request was for the spec, and to see
>>> the whole fully assembled iceberg.
>>>
>>> The spec is here:
>>> https://static.docs.arm.com/ddi0598/ab/DDI0598A_b_MPAM_supp_armv8a.pdf
>>>
>>> For a slightly dated view of the whole tree:
>>> 1. Don peril sensitive sunglasses
>>> 2. https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/feb
>>>
>>> The tree is generally RFC-quality. It gets more ragged once you get out of
>>> the x86 code. I anticipate all the arm64 code being rewritten before its
>>> considered for merging.
>>>
>>> (I haven't reposted the CDP origami as before, as I think that series
>>> will be clearer if I re-order the patches ... it may even be shorter)
>>>
>>>
>>> Does it all work? Almost. Monitor groups are proving to be a problem, I
>>> can't see a way of getting these working without a user-visible change of
>>> behaviour.
>>> MPAMs counters aren't 1:1 with RMIDs, so supporting MBM_* on
>>> any likely hardware will have to be via something other than resctrl.
> 
> 
>> Before jumping to the details within the patches of this work ...
>>
>> Could you please summarize the salient points from the spec, pointing
>> readers to the spec for more information?
> 
> Its probably the differences with RDT that are important, so I'll focus on those:
> 
> MPAM has has a CPU interface that controls how the CPU tags traffic, and controls that are
> scattered through the system, and are accessible via MMIO.

(... so many more controls than in RDT or PQoS.)

> 
> Arm doesn't specify a cache topology, (hence we have funny terms like PoU), so likewise
> the controls, and where they are in the address space, are totally up to the implementer.
> Linux would have to discover all this from an ACPI-table/DT-node.

ok, I see. I am just starting now to familiarize myself how you were
able to align all these concepts between MPAM and RDT using the
mpam_device and mpam_component.

> 
> MPAM has ~six different types of control, all of which are optional. Cache Portion bitmaps
> correspond closely to CAT's behaviour. MBM's behaviour can be approximated with either the
> bandwidth bitmap or the bandwidth max/min controls.

ok. Not all the partitioning types are quite clear to me
(proportional-stride partitioning specifically), but I can see that
there are similarities. (I am assuming you meant MBA)

> 
> MPAM has partid's, which correspond perfectly with closid.

I am not sure about "perfectly".

If I understand correctly at least there is the caveat that MPAM is like
RDT with CDP always enabled without reducing number of CLOSIDs?

But ...

The assumption of resctrl fs is that a task would belong to a single
resource group, which in turn represents a single CLOSID/PARTID(?). On
the other hand MPAM allows a task to have different PARTIDs for code and
data. It seems that perhaps MPAM will be supported in Linux by having
its PARTIDs behave as RDT with CDP enabled (the odd/even pairing) and
thus perhaps not as flexible as the architecture supports/intends?
(Although I see you later mention that the goal is _not_ for MPAM to
emulate CDP so it is not clear to me how this would be supported).

Would user looking at schemata on resctrl on Arm thus always see the
CODE/DATA prefix on the cache resources? I am trying to create a high
level idea of what a user's interaction with resctrl fs would look like
on an Arm system and how that would be translated on a high level to
what it means for the hardware (allocating new PARTIDs, setting of
PARTIDs, etc.). (small steps)

> It has performance monitors,
> but these behave much more like a PMU than RDT's monitors. This is where it gets messy:
> 
> RDT has RMIDs as an independent value used for monitoring. There is one monitor per RMID.

Currently up to three monitors per RMID if considering a monitor to be
the same as a counter?

> MPAM has 'PMG', that subdivide the partid space. There are a number of PMU-like monitors
> that can be configured to count for a partid, or a partid-and-pmg. It is very likely that
> the number of these counters is much smaller than the number of partid, or partid+pmg.

If I understand correctly the PARTID and PMG are global because that is
the MPAM information that accompanies all memory requests as it
traverses through the system.

In comparison the resource monitors seem to be entirely contained in the
MSC to which they belong ... and an MSC is allowed to have up to 2^16 of
each type.

It seems that it may at least theoretically be possible to have many
more counters than PARTID, or PARTID+PMG.

I see your point about them being more similar to PMU.

> 
> PMG does not correspond to RMID, even though they look compatible from a distance.
> (I can't see a way of fixing this is a compatible way. Supporting it via a different
> mechanism is my best bet).

I've been trying to different ideas also but cannot find a good fit in
resctrl either.

(I seem to have trouble mapping both the partioning and monitoring MPAM
features to resctrl ... apologies as it is taking me some time to catch
up with where you are at this time)

> 
> MPAM has something like the CPU interface for tagging traffic in Arm's irqchip and IOMMU.

I cannot find mention of this specifically in the new spec. Do you
perhaps have other documentation about this?

> MPAM has virtualisation support in the CPU, for mapping virtual partids to physical partids.
> 
> 
>> A start would be how resctrl is expected to support MPAM.
> 
> Exactly as it works on an Intel Xeon today!
> User-space should not be able to tell the difference.
> 
> I intend to get as much of MPAM going with this constraint as possible. We can then
> discuss what needs changing/extending to allow other features to be used. (and what those
> features are good for).
> 
> Practically this means that systems with MPAM can only use resctrl if they look a bit like
> a Xeon. (i.e. bitmap controls on L2 or L3, bandwidth controls on-or-behind L3)
> 

This sounds manageable.

> 
>> Could you highlight where does resctrl interface or assumptions currently fall short?
>> How is the planned MPAM integration addressing these shortcomings?
> 
> (shortcomings -> Design decisions that make sense for resctrl to support RDT.)
> 
> The resctrl monitor code implicitly assumes 'this' CPU all over the place. For MPAM any
> 'this' CPU may be a set of CPUs, which make this code tricky to work with.
> 
> tangent: (what! why? ... Reported by more than one of Arm's partners, is that part of
> their system is made up of slices, which act as one component when integrated together. I
> assume this helps scale the design, or improve the yield. There is one set of MPAM
> controls per slice, which means each of the controls needs to be configured the same to
> give one behaviour for the component. The MPAM controls may only be accessible from the
> local CPUs if this slice thing contains CPUs... Arm's software model does exactly this
> with its L3).

Apologies, the issue is not clear to me. I am familiar with the slicing
of L3, Intel systems do that also. Your concern that preceded this was
that the monitor code implicitly assumes "this" CPU. Could you please
elaborate more on this? The RMIDs have global scope within the package
(L3 cache domain instance) and keeps track of all CPUs associated with
it (rdt_domain->cpu_mask). The user queries each domain separately and
the counter value is read from any CPU associated with the particular
domain. How I see it the monitor code thus tracks which CPUs are
associated with a particular cache instance and would interact with an
appropriate CPU depending on which data/counter the user is requesting.

> resctrl doesn't have the concept of having to allocate a counter for an RMID, because for
> RDT these things are 1:1. Because the bandwidth counters are left running, and accessible
> via the filesystem, MPAM cannot let resctrl use the bandwidth counters unless there are as
> many PMU-like monitors as there are partid+pmg, which isn't likely.
> 
> My plan here is to add a 'resctrl_pmu' to perf. (I know there is some history with perf
> here). This would allow perf to read the values that are already exposed via resctrl.
> For MPAM this should give us the schedule-in/out hooks we need to allocate the PMU-like
> counter when its actually being used.
> 
> I'd expect this to be done in the core /fs/ code, so that it uses a common interface to
> resctrl, and works in exactly the same way with RDT. (no additional arch code means it
> works on the next architecture to support resctrl too)

Are you saying that resctrl fs would provide an interface to the
"resctrl_pmu" addition to perf?

> The rdt_resources_all array, and these alloc_enabled, alloc_capable flags are a really
> neat trick to implement CDP on RDT. But this looks very much like an array of every SoC
> that has been built, which is tricky if the topology is discovered at boot. It also leaves
> properties of the user visible schemata file in the hands of the arch code.
> I want it to be, very difficult, for Arm to invent new schemata without discussing whether
> the interface is abstract enough to support on other architectures.
> A good chunk of the MPAM tree is moving all the user-visible CDP behaviour into the code
> that moves to /fs. This lets the arch code only deal with L2 or L3, and CDP becomes a
> property of the configuration.

I did see the introduction of the new schema list that points to the
resources that appears to separate the user interface and the
architecture differences very well.

> 
> (this is probably one of the stranger looking changes. Secondary motivations are to avoid
> emulating CDP under arch/arm64, and avoiding the nightmare SoC topology where there are
> more MPAM controls to be configured, because of this slicing, in L2 than there are in
> L2CODE....)

... oh ... no to emulate CDP. (I need to understand how the two PARTIDs
of a task are configured ... I will keep digging through the spec and
the patches).

> 
> 
>> Some higher level questions I have after scanning the spec and patches are:
>>
>> * The spec contains many details of how MPAM supports virtualization. Is
>> it expected that all of this would be supported with resctrl?
> 
> For now, that is totally out of scope.
> 
> 
>> For
>> example, while some registers may be abstracted it seems some interface
>> may be needed to configure the virt to phy PARTID mappings. Information
>> about how resctrl is envisioned to support MPAM's virtualization would
>> help a lot.
> 
> As you asked!
> The principle here is not to change the user-visible bits of resctrl at all.
> 
> We only need to support KVM, and the definition of KVM's virtual machine (memory layout,
> number of CPUs etc) comes from its user-space virtual-machine-manager, which is typically
> Qemu.
> KVM only needs to support the CPU-interface parts of MPAM. The controls, configured via
> MMIO could be emulated by the VMM. (this lets it give an accurate model of the machine it
> is emulating)
> The VMM would need to allocate a number of control groups via resctrl, then pass their
> names (or preferably closid) to KVM to set up the mapping. The MPAM hardware performs the
> mapping when the guest uses a partid.
> When the guest tries to configure the controls, this would trap back to the VMM, as it
> does for any emulated device. The VMM can then make the corresponding change in resctrl.
> 
> This lets the VMM emulate MPAM controls that the host doesn't have, or control MPAM for
> the guest using a different user-space interface.
> 
> This has only been discussed vaguely with the Qemu folk, its all subject to change.
> 
> I would like to be able to allocate closid in the kernel for KVM guests, as this is a step
> towards supporting other in-kernel users. (in particular, the IOMMU).


Thank you very much for this insight into what is being considered.

>> I look forward to learning more about the goals of what needs to be
>> supported and your vision for resctrl to do so.
> 
> Thanks for going through this with such a level of detail. I'm sure we agree on the 'no
> user-visible changes' aspect, so the next pieces is where the split between core code and
> arch code should be.

Agreeing on "no user-visible changes" really helps to guide this initial
work. The split between core and arch may be more flexible and may be
done on an as-needed basis?

Reinette
