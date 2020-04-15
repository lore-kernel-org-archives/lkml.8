Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2BDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC5120775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505724AbgDONCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:02:12 -0400
Received: from foss.arm.com ([217.140.110.172]:45000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503199AbgDOM7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:59:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45CDF1063;
        Wed, 15 Apr 2020 05:59:29 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C98093F6C4;
        Wed, 15 Apr 2020 05:59:27 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/2] x86/resctrl: Start abstraction for a second
 arch
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>
References: <fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <e3e4b142-d6e2-4fa8-be57-e829fc6e48f7@arm.com>
Date:   Wed, 15 Apr 2020 13:59:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

Thanks for taking a look, all great questions!

On 14/04/2020 19:56, Reinette Chatre wrote:
> On 12/31/1969 4:00 PM, James Morse wrote:
>> These two patches are the tip of the MPAM iceberg.
>>
>> Arm have some CPU support for dividing caches into portions, and
>> applying bandwidth limits at various points in the SoC. The collective term
>> for these features is MPAM: Memory Partitioning and Monitoring.
>>
>> MPAM is similar enough to Intel RDT, that it should use the defacto linux
>> interface: resctrl. This filesystem currently lives under arch/x86, and is
>> tightly coupled to the architecture.
>> Ultimately, my plan is to split the existing resctrl code up to have an
>> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
>> MPAM can be wired up.
>>
>> These two patches are step one: Split the two structs that resctrl uses
>> to have an arch<->fs split. These sit on top of the cleanup posted here:
>> lore.kernel.org/r/20200214182401.39008-1-james.morse@arm.com
>>
>> I'm after strong opinions like "No! struct mbm_state is obviously arch
>> specific.". Making the hardware configuration belong to the arch code
>> instead of resctrl is so that it can be scaled on arm64, where MPAM
>> allows terrifyingly large portion bitmaps for the caches.
>>
>>
>>
>> Last time these were posted, the request was for the spec, and to see
>> the whole fully assembled iceberg.
>>
>> The spec is here:
>> https://static.docs.arm.com/ddi0598/ab/DDI0598A_b_MPAM_supp_armv8a.pdf
>>
>> For a slightly dated view of the whole tree:
>> 1. Don peril sensitive sunglasses
>> 2. https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/feb
>>
>> The tree is generally RFC-quality. It gets more ragged once you get out of
>> the x86 code. I anticipate all the arm64 code being rewritten before its
>> considered for merging.
>>
>> (I haven't reposted the CDP origami as before, as I think that series
>> will be clearer if I re-order the patches ... it may even be shorter)
>>
>>
>> Does it all work? Almost. Monitor groups are proving to be a problem, I
>> can't see a way of getting these working without a user-visible change of
>> behaviour.
>> MPAMs counters aren't 1:1 with RMIDs, so supporting MBM_* on
>> any likely hardware will have to be via something other than resctrl.


> Before jumping to the details within the patches of this work ...
> 
> Could you please summarize the salient points from the spec, pointing
> readers to the spec for more information?

Its probably the differences with RDT that are important, so I'll focus on those:

MPAM has has a CPU interface that controls how the CPU tags traffic, and controls that are
scattered through the system, and are accessible via MMIO.

Arm doesn't specify a cache topology, (hence we have funny terms like PoU), so likewise
the controls, and where they are in the address space, are totally up to the implementer.
Linux would have to discover all this from an ACPI-table/DT-node.

MPAM has ~six different types of control, all of which are optional. Cache Portion bitmaps
correspond closely to CAT's behaviour. MBM's behaviour can be approximated with either the
bandwidth bitmap or the bandwidth max/min controls.

MPAM has partid's, which correspond perfectly with closid. It has performance monitors,
but these behave much more like a PMU than RDT's monitors. This is where it gets messy:

RDT has RMIDs as an independent value used for monitoring. There is one monitor per RMID.
MPAM has 'PMG', that subdivide the partid space. There are a number of PMU-like monitors
that can be configured to count for a partid, or a partid-and-pmg. It is very likely that
the number of these counters is much smaller than the number of partid, or partid+pmg.

PMG does not correspond to RMID, even though they look compatible from a distance.
(I can't see a way of fixing this is a compatible way. Supporting it via a different
mechanism is my best bet).

MPAM has something like the CPU interface for tagging traffic in Arm's irqchip and IOMMU.
MPAM has virtualisation support in the CPU, for mapping virtual partids to physical partids.


> A start would be how resctrl is expected to support MPAM.

Exactly as it works on an Intel Xeon today!
User-space should not be able to tell the difference.

I intend to get as much of MPAM going with this constraint as possible. We can then
discuss what needs changing/extending to allow other features to be used. (and what those
features are good for).

Practically this means that systems with MPAM can only use resctrl if they look a bit like
a Xeon. (i.e. bitmap controls on L2 or L3, bandwidth controls on-or-behind L3)


> Could you highlight where does resctrl interface or assumptions currently fall short?
> How is the planned MPAM integration addressing these shortcomings?

(shortcomings -> Design decisions that make sense for resctrl to support RDT.)

The resctrl monitor code implicitly assumes 'this' CPU all over the place. For MPAM any
'this' CPU may be a set of CPUs, which make this code tricky to work with.

tangent: (what! why? ... Reported by more than one of Arm's partners, is that part of
their system is made up of slices, which act as one component when integrated together. I
assume this helps scale the design, or improve the yield. There is one set of MPAM
controls per slice, which means each of the controls needs to be configured the same to
give one behaviour for the component. The MPAM controls may only be accessible from the
local CPUs if this slice thing contains CPUs... Arm's software model does exactly this
with its L3).


resctrl doesn't have the concept of having to allocate a counter for an RMID, because for
RDT these things are 1:1. Because the bandwidth counters are left running, and accessible
via the filesystem, MPAM cannot let resctrl use the bandwidth counters unless there are as
many PMU-like monitors as there are partid+pmg, which isn't likely.

My plan here is to add a 'resctrl_pmu' to perf. (I know there is some history with perf
here). This would allow perf to read the values that are already exposed via resctrl.
For MPAM this should give us the schedule-in/out hooks we need to allocate the PMU-like
counter when its actually being used.

I'd expect this to be done in the core /fs/ code, so that it uses a common interface to
resctrl, and works in exactly the same way with RDT. (no additional arch code means it
works on the next architecture to support resctrl too)


The rdt_resources_all array, and these alloc_enabled, alloc_capable flags are a really
neat trick to implement CDP on RDT. But this looks very much like an array of every SoC
that has been built, which is tricky if the topology is discovered at boot. It also leaves
properties of the user visible schemata file in the hands of the arch code.
I want it to be, very difficult, for Arm to invent new schemata without discussing whether
the interface is abstract enough to support on other architectures.
A good chunk of the MPAM tree is moving all the user-visible CDP behaviour into the code
that moves to /fs. This lets the arch code only deal with L2 or L3, and CDP becomes a
property of the configuration.

(this is probably one of the stranger looking changes. Secondary motivations are to avoid
emulating CDP under arch/arm64, and avoiding the nightmare SoC topology where there are
more MPAM controls to be configured, because of this slicing, in L2 than there are in
L2CODE....)


> Some higher level questions I have after scanning the spec and patches are:
> 
> * The spec contains many details of how MPAM supports virtualization. Is
> it expected that all of this would be supported with resctrl?

For now, that is totally out of scope.


> For
> example, while some registers may be abstracted it seems some interface
> may be needed to configure the virt to phy PARTID mappings. Information
> about how resctrl is envisioned to support MPAM's virtualization would
> help a lot.

As you asked!
The principle here is not to change the user-visible bits of resctrl at all.

We only need to support KVM, and the definition of KVM's virtual machine (memory layout,
number of CPUs etc) comes from its user-space virtual-machine-manager, which is typically
Qemu.
KVM only needs to support the CPU-interface parts of MPAM. The controls, configured via
MMIO could be emulated by the VMM. (this lets it give an accurate model of the machine it
is emulating)
The VMM would need to allocate a number of control groups via resctrl, then pass their
names (or preferably closid) to KVM to set up the mapping. The MPAM hardware performs the
mapping when the guest uses a partid.
When the guest tries to configure the controls, this would trap back to the VMM, as it
does for any emulated device. The VMM can then make the corresponding change in resctrl.

This lets the VMM emulate MPAM controls that the host doesn't have, or control MPAM for
the guest using a different user-space interface.

This has only been discussed vaguely with the Qemu folk, its all subject to change.

I would like to be able to allocate closid in the kernel for KVM guests, as this is a step
towards supporting other in-kernel users. (in particular, the IOMMU).


> * Looking at the commits (1385052cce87a8aed5dc0e96967cedd9e74a17e0 -
> "x86/resctrl: Group staged configuration into a separate struct") I
> found mention of a change in the schemata. Highlighting any planned
> resctrl interface changes would be very helpful.

No changes to the schemata! That would cause variation between RDT and MPAM, and fragment
user-space software.

The commit message is certainly terrible. That patch is part of the chunk that folds the
L3CODE, L3DATA and L3 resources together so that the arch code is only dealing with L3,
(or L2 or MBM). This is so that the CODE/DATA schema behaviour lives in the core /fs/
code, so that its much harder for it to behave differently on systems with MPAM.


> * Apart from actual interface changes, highlighting planned behavior
> changes and motivation for them would also be helpful … for example
> force enabling of CDP on all cache levels is a red flag to me.

Interesting. This is the change that makes the CDP on/off global, instead of per cache.
Its still controlled by user-space. (so nothing is forced).
Do you have systems that support CAT at L3 and L2, but only CDP at L3, not L2?
(I was under the impression the L2 stuff was all Atom, and the L3+MBM was all Xeon).

MPAM's equivalent to CDP is just part of the CPU interface. Its always on.
To support 'CDP on L2 but not L3', (neither of which exist), we'd need to have extra code:
"was I asked to pretend CDP is enabled on this cache".

As CDP affects the way you allocate closid, (that odd/even thing), which is global, it
makes sense that this is either on or off. (doing this let me support CDP without the arch
code doing anything special!)

Existence of hardware that does this would obviously change this.


> * I am curious about how the configurability of MPAM will be handled. It
> seems as though MPAM is highly configurable, how is this expected to be
> handled in resctrl?

ACPI-tables/DT to describe the topology, and then code to 'pick' which MPAM features map
best onto resctrl.
Its likely that there will be systems that have MPAM, but can't use resctrl without
user-visible changes. Discussing user-visible changes can happen at that point.


> For example, this message and KNOWN_ISSUES among the
> patches mentions an ABI issue that RMID is independent from CLOSID in
> RDT but PMG (like RMID) is dependent on PARTID (like CLOSID) in MPAM.

Indeed. Because there is nothing quite like RMID, there is nothing I can expose as
num_rmid. Whatever value I expose there will cause user-space to detect some breakage.


> There is a MATCH_PARTID configuration option in MPAM that makes PMG not
> depend on PARTID and thus seem to bring closer to RDT.

(crumbs, you've dug into this in some detail!)

... Welcome to the wonderful world of Arm specifications:

On page 234 of [0], it describes the CSU controls:
| If MATCH_PMG == 1 and MATCH_PARTID == 0, it is CONSTRAINED-UNPREDICTABLE whether the
| monitor instance:
| * Measures the storage used with matching PMG and with any PARTID.
| * Measures no storage usage, that is, MSMON_CSU.VALUE is zero.
| * Measures the storage used with matching PMG and PARTID, that is, treats
|   MATCH_PARTID as == 1.

Whenever you see something all-caps (CONSTRAINED-UNPREDICTABLE in this case), it means
this is pretty useless to general purpose software. We would need per-platform quirks for
which of these behaviours the implementer built.
"Measures the storage used with matching PMG and with any PARTID." is the one we wanted,
but the spec people made it optional, and its not discoverable.

Curiously, the text describing the bandwidth controls doesn't describe this as
unpredictable... I'll check that isn't an oversight. Being able to do this with the
bandwidth controls doesn't help, as we can't support those unless we have enough monitors
for the free-running files in resctrl.

Even if we could rely on this, we'd still have the problem that MPAM expects PMG to extend
the partid space. There may be very few PMG because they are expected to be used
per-partid. If there are fewer PMG than partid, we are straight back to square-one: 'no
monitor support'.


> I am surely not
> indicating that MPAM should be made to behave like RDT but it does seem
> that MPAM is very configurable.

> Is it the intention to support all ways in which MPAM can be used and
Today, no. Only those that map in a usable way to what resctrl already exposes to user-space.


> if so is the plan for resctrl so support
> making these configuration changes and then support them?

If someone comes up with a use-case that benefits from one of the the extra controls, we
can discuss how that could be abstracted to work on multiple architectures.


> For example,
> would you want resctrl to support all variations where MATCH_PARTID ==
> [0|1] and MATCH_PMG == [0|1]? My intention here is not to delve into
> these details in particular, instead I hope to use it as an example of
> what I mean when curious about how (if at all) resctrl is envisioned to
> support the configurability of MPAM.

I think not-at-all is the answer here. Resctrl's ABI is a ship that has sailed. Where at
all possible I intend to map what MPAM has to what resctrl exposes.

The num_rmid issue has me painted into a corner. No value there reflects the behaviour.
The only option may be not to expose any of the counters via the resctrl filesystem,
instead making them accessible via perf.
I think that would only fly if I can make it work on x86 too.


> It seems to me that MPAM may need more than what is currently available
> from resctrl

Ultimately yes, but the aim here isn't to support all of MPAM.
Its just to support what maps nicely. We can then discuss what to do next.


> but it is hard for me to digest a 276 page spec and 150
> patch series to fully understand what needs to be support and how to do
> so.

Yeah! Me to. But this is what Fenghua asked to see:
https://lore.kernel.org/lkml/20180827142204.GA223688@romley-ivt3.sc.intel.com/

You'll be glad to know I have no intention of posting all that in one go (obvious, but
worth saying).


> I look forward to learning more about the goals of what needs to be
> supported and your vision for resctrl to do so.

Thanks for going through this with such a level of detail. I'm sure we agree on the 'no
user-visible changes' aspect, so the next pieces is where the split between core code and
arch code should be.


Thanks,

James

[0] https://static.docs.arm.com/ddi0598/ba/DDI0598B_a_MPAM_supp_armv8ba.pdf
