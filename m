Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE55C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F982074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504517AbgDNS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:57:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:56824 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504506AbgDNS4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:56:53 -0400
IronPort-SDR: XKRUMzP2ZUuR01+PDeGHlM8UEzYAhRXanBGl9PpguoWY/fZMHWS2R22UQcOwe0YjKjm9DTwt/X
 pIbX8GjuunSA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:56:52 -0700
IronPort-SDR: UvQ/6ztvx0TCdplr43il0ubV3TgVSB9HK70EVXAFQGacC/VD68NiP7tpbEUWfOhxxsG2vqe09c
 L4Ihwya5KPEA==
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="427167435"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.230.158]) ([10.255.230.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:56:51 -0700
Subject: Re: [RFC PATCH v2 0/2] x86/resctrl: Start abstraction for a second
 arch
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fa703609-4eed-7266-c389-a5dbba14d2ce@intel.com>
Date:   Tue, 14 Apr 2020 11:56:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 12/31/1969 4:00 PM, James Morse wrote:
> Hi folks,
> 
> These two patches are the tip of the MPAM iceberg.
> 
> Arm have some CPU support for dividing caches into portions, and
> applying bandwidth limits at various points in the SoC. The collective term
> for these features is MPAM: Memory Partitioning and Monitoring.
> 
> MPAM is similar enough to Intel RDT, that it should use the defacto linux
> interface: resctrl. This filesystem currently lives under arch/x86, and is
> tightly coupled to the architecture.
> Ultimately, my plan is to split the existing resctrl code up to have an
> arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
> MPAM can be wired up.
> 
> These two patches are step one: Split the two structs that resctrl uses
> to have an arch<->fs split. These sit on top of the cleanup posted here:
> lore.kernel.org/r/20200214182401.39008-1-james.morse@arm.com
> 
> I'm after strong opinions like "No! struct mbm_state is obviously arch
> specific.". Making the hardware configuration belong to the arch code
> instead of resctrl is so that it can be scaled on arm64, where MPAM
> allows terrifyingly large portion bitmaps for the caches.
> 
> 
> 
> Last time these were posted, the request was for the spec, and to see
> the whole fully assembled iceberg.
> 
> The spec is here:
> https://static.docs.arm.com/ddi0598/ab/DDI0598A_b_MPAM_supp_armv8a.pdf
> 
> For a slightly dated view of the whole tree:
> 1. Don peril sensitive sunglasses
> 2. https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/feb
> 
> The tree is generally RFC-quality. It gets more ragged once you get out of
> the x86 code. I anticipate all the arm64 code being rewritten before its
> considered for merging.
> 
> (I haven't reposted the CDP origami as before, as I think that series
> will be clearer if I re-order the patches ... it may even be shorter)
> 
> 
> Does it all work? Almost. Monitor groups are proving to be a problem, I
> can't see a way of getting these working without a user-visible change of
> behaviour.
> MPAMs counters aren't 1:1 with RMIDs, so supporting MBM_* on
> any likely hardware will have to be via something other than resctrl.
> 

Before jumping to the details within the patches of this work ...

Could you please summarize the salient points from the spec, pointing
readers to the spec for more information? A start would be how resctrl
is expected to support MPAM. Could you highlight where does resctrl
interface or assumptions currently fall short? How is the planned MPAM
integration addressing these shortcomings?

Some higher level questions I have after scanning the spec and patches are:

* The spec contains many details of how MPAM supports virtualization. Is
it expected that all of this would be supported with resctrl? For
example, while some registers may be abstracted it seems some interface
may be needed to configure the virt to phy PARTID mappings. Information
about how resctrl is envisioned to support MPAM's virtualization would
help a lot.

* Looking at the commits (1385052cce87a8aed5dc0e96967cedd9e74a17e0 -
"x86/resctrl: Group staged configuration into a separate struct") I
found mention of a change in the schemata. Highlighting any planned
resctrl interface changes would be very helpful.

* Apart from actual interface changes, highlighting planned behavior
changes and motivation for them would also be helpful … for example
force enabling of CDP on all cache levels is a red flag to me.

* I am curious about how the configurability of MPAM will be handled. It
seems as though MPAM is highly configurable, how is this expected to be
handled in resctrl? For example, this message and KNOWN_ISSUES among the
patches mentions an ABI issue that RMID is independent from CLOSID in
RDT but PMG (like RMID) is dependent on PARTID (like CLOSID) in MPAM.
There is a MATCH_PARTID configuration option in MPAM that makes PMG not
depend on PARTID and thus seem to bring closer to RDT. I am surely not
indicating that MPAM should be made to behave like RDT but it does seem
that MPAM is very configurable. Is it the intention to support all ways
in which MPAM can be used and if so is the plan for resctrl so support
making these configuration changes and then support them? For example,
would you want resctrl to support all variations where MATCH_PARTID ==
[0|1] and MATCH_PMG == [0|1]? My intention here is not to delve into
these details in particular, instead I hope to use it as an example of
what I mean when curious about how (if at all) resctrl is envisioned to
support the configurability of MPAM.

It seems to me that MPAM may need more than what is currently available
from resctrl but it is hard for me to digest a 276 page spec and 150
patch series to fully understand what needs to be support and how to do
so. I look forward to learning more about the goals of what needs to be
supported and your vision for resctrl to do so.

Thank you

Reinette
