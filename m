Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D37C20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594199733;
	bh=1P3BCibtQ27BJR4HH94/+rxqEdbIvNz2+VLbK4bFC5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fTXm0nNVRhasbwDLxaIBoHbyOE85tj/wr5pBzyMk7BrqiG0+9s2n4Y58no7pmuUw4
	 F3BBquVIydIP1X5mHnJmZUSpa+shV+J2ESyYeSb9oev27pfcyjLN0SpMnxY3W74U49
	 JlwiwoZgytY7A5EW+AtSpJtrGxSp/gBYzY5Di5fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgGHJPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgGHJPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:15:31 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE9292063A;
        Wed,  8 Jul 2020 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594199730;
        bh=1P3BCibtQ27BJR4HH94/+rxqEdbIvNz2+VLbK4bFC5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JpMvnDS0sU0t8bLM4FA3w1+3DXw2v19WPhpIaJ+Bh+QhCuRE6GcLUPwkSeMR3lL9x
         u9T7XOCbfiKI5mq0gZkFjKcECE7YizAF2NyOleKpCYCoUKL+sjFQZ3pkzkBfDwuzyG
         vnZkmXHB5LWE6FOFDo5ku6TGgB1ggCmXDLKbZoJU=
Date:   Wed, 8 Jul 2020 12:15:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>, Jia He <justin.he@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as
 EXPORT_SYMBOL_GPL
Message-ID: <20200708091520.GE128651@kernel.org>
References: <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com>
 <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com>
 <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
 <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com>
 <20200708083951.GH386073@linux.ibm.com>
 <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:45:17AM +0200, David Hildenbrand wrote:
> On 08.07.20 10:39, Mike Rapoport wrote:
> > On Wed, Jul 08, 2020 at 10:26:41AM +0200, David Hildenbrand wrote:
> >> On 08.07.20 09:50, Dan Williams wrote:
> >>> On Wed, Jul 8, 2020 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
> >>>>
> >>>>>>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>>>>>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>>>>>>>>>
> >>>>>>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>>>>>>>>>> NUMA_NO_NID is detected.
> >>>>>>>>>>>
> >>>>>>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>>  arch/arm64/mm/numa.c | 5 +++--
> >>>>>>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>>>>>>>> index aafcee3e3f7e..7eeb31740248 100644
> >>>>>>>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>>>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>>>>>>>>>
> >>>>>>>>>>>  /*
> >>>>>>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>>>>>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>>>>>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>>>>>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>>>>>>>>>   */
> >>>>>>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>>>>>>>>>  {
> >>>>>>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>>>>>>>>>   return 0;
> >>>>>>>>>>>  }
> >>>>>>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>>>>>>>>>
> >>>>>>>>>> Does it make sense to export a noop function? Wouldn't make more sense
> >>>>>>>>>> to simply make it static inline somewhere in a header? I haven't checked
> >>>>>>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.
> > 
> >> I'd be curious if what we are trying to optimize here is actually worth
> >> optimizing. IOW, is there a well-known scenario where the dummy value on
> >> arm64 would be problematic and is worth the effort?
> > 
> > Well, it started with Michal's comment above that EXPORT_SYMBOL_GPL()
> > for a stub might be an overkill.
> > 
> > I think Jia's suggestion [1] with addition of a comment that explains
> > why and when the stub will be used, can work for both
> > memory_add_physaddr_to_nid() and phys_to_target_node().
> 
> Agreed.
> 
> > 
> > But on more theoretical/fundmanetal level, I think we lack a generic
> > abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
> > translaton of firmware supplied information into data that can be used
> > by the generic mm without need to reimplement it for each and every
> > arch.
> 
> Right. As I expressed, I am not a friend of using memblock for that, and
> the pgdat node span is tricky.
>
> Maybe abstracting that x86 concept is possible in some way (and we could
> restrict the information to boot-time properties, so we don't have to
> mess with memory hot(un)plug - just as done for numa_meminfo AFAIKS).

I agree with pgdat part and disagree about memblock. It already has
non-init physmap, why won't we add memblock.memory to the mix? ;-)

Now, seriously, memblock already has all the necessary information about
the coldplug memory for several architectures. x86 being an exception
because for some reason the reserved memory is not considered memory
there. The infrastructure for quiering and iterating memory regions is
already there. We just need to leave out the irrelevant parts, like
memblock.reserved and allocation funcions.

Otherwise we'll add yet another 'struct { start, end }', a horde of
covnersion and re-initialization functions that will do more or less the
same things as current memblock APIs.

> -- 
> Thanks,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.
