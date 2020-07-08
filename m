Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C19EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446282067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BjxvWffe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGHHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGHHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:51:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22988C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:51:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so35410295ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdB28ZI7SOp5ABXL8AmMn/U84IJpt8dmXOT5xybidAg=;
        b=BjxvWffeCf5PXDrtXE8h3palNn15R0do8NHLaSbPbHUjDpkYUrELgy20BbtGeIABPY
         kl9r3qxcaeeKpc/+mhEPQm4ZduJNNKXZWHHvwBa26w0t8WYctuN7VAYiJLhk1MqFlafV
         psBUb4xEwyOw7YLosN48f65Tp3XhspKy0p/EpmpfNNvGv/7XMvCW5s3lDNJP1twiGQlV
         WbSDFhrSwAxSg+uBGqUTCJTgNTnbmTTFF/xcL6KmEy4Cc3G2bSuqS7P/kpoBvd0XoVIM
         Nv7LE1Gh7MM5YF2rK4XBfn+ObjhbOoZLlzb1LUAk4vnLCV6tFyI31aA+LEn5JNI5zgxf
         ipUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdB28ZI7SOp5ABXL8AmMn/U84IJpt8dmXOT5xybidAg=;
        b=aoCqHqBPty/a8KuIhG7DWHtWNaGPIFHv6pVJ8MVAhK7ptt9K83/QYnfl0CirRb4dOA
         6yLyIDr9gzRszC2pjWLXBDoHVu2RPuq5k2fFRlAHzhzZOuqZcLyWx8WsZ0i7pwAS7+uK
         88t9XHGlzBBmbBoIq1T88vqgi/zlivztu/Nrn9A+XqlHQDy7Ka4hUKlKcYBH5+uyMEW3
         QQgOZnlsRl4scrmxstF0GIjFgUYuDWdkOhr/0rAYAbT6aZQuGg+0WR4gTHjGIG9+f3cI
         thXtonvSTdNS8Y8o2V5kv4qPisQwi1Z0znYDGg64UT/eB1/fjXpchdvi4ouWSUyYQvyv
         eTlw==
X-Gm-Message-State: AOAM532XxGyhQ/0qhAPgfVVxTF3fSyG6fvSdLkz47dPJrAmdRNuoQn90
        VtjCm+YsCKnIt8tfN2ESeFgID+dEnbJhGuUABBYyvg==
X-Google-Smtp-Source: ABdhPJxTO+TBaGOUp0dajU8scS3zSaoUWnLpzKeEDNORKl5f+9ig/G7GMHAS4653XxC7hyczsTzT0ufohb1efEgi1JM=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr49837175ejf.455.1594194661844;
 Wed, 08 Jul 2020 00:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <20200707121302.GB9411@linux.ibm.com>
 <474f93e7-c709-1a13-5418-29f1777f614c@redhat.com> <20200707180043.GA386073@linux.ibm.com>
 <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com> <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
In-Reply-To: <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 00:50:50 -0700
Message-ID: <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 12:22 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.07.20 07:27, Mike Rapoport wrote:
> > On Tue, Jul 07, 2020 at 03:05:48PM -0700, Dan Williams wrote:
> >> On Tue, Jul 7, 2020 at 11:01 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>>
> >>> On Tue, Jul 07, 2020 at 02:26:08PM +0200, David Hildenbrand wrote:
> >>>> On 07.07.20 14:13, Mike Rapoport wrote:
> >>>>> On Tue, Jul 07, 2020 at 01:54:54PM +0200, Michal Hocko wrote:
> >>>>>> On Tue 07-07-20 13:59:15, Jia He wrote:
> >>>>>>> This exports memory_add_physaddr_to_nid() for module driver to use.
> >>>>>>>
> >>>>>>> memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> >>>>>>> NUMA_NO_NID is detected.
> >>>>>>>
> >>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
> >>>>>>> Signed-off-by: Jia He <justin.he@arm.com>
> >>>>>>> ---
> >>>>>>>  arch/arm64/mm/numa.c | 5 +++--
> >>>>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >>>>>>> index aafcee3e3f7e..7eeb31740248 100644
> >>>>>>> --- a/arch/arm64/mm/numa.c
> >>>>>>> +++ b/arch/arm64/mm/numa.c
> >>>>>>> @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> >>>>>>>
> >>>>>>>  /*
> >>>>>>>   * We hope that we will be hotplugging memory on nodes we already know about,
> >>>>>>> - * such that acpi_get_node() succeeds and we never fall back to this...
> >>>>>>> + * such that acpi_get_node() succeeds. But when SRAT is not present, the node
> >>>>>>> + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback option.
> >>>>>>>   */
> >>>>>>>  int memory_add_physaddr_to_nid(u64 addr)
> >>>>>>>  {
> >>>>>>> - pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n", addr);
> >>>>>>>   return 0;
> >>>>>>>  }
> >>>>>>> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >>>>>>
> >>>>>> Does it make sense to export a noop function? Wouldn't make more sense
> >>>>>> to simply make it static inline somewhere in a header? I haven't checked
> >>>>>> whether there is an easy way to do that sanely bu this just hit my eyes.
> >>>>>
> >>>>> We'll need to either add a CONFIG_ option or arch specific callback to
> >>>>> make both non-empty (x86, powerpc, ia64) and empty (arm64, sh)
> >>>>> implementations coexist ...
> >>>>
> >>>> Note: I have a similar dummy (return 0) patch for s390x lying around here.
> >>>
> >>> Then we'll call it a tie - 3:3 ;-)
> >>
> >> So I'd be happy to jump on the train of people wanting to export the
> >> ARM stub for this (and add a new ARM stub for phys_to_target_node()),
> >> but Will did have a plausibly better idea that I have been meaning to
> >> circle back to:
> >>
> >> http://lore.kernel.org/r/20200325111039.GA32109@willie-the-truck
> >>
> >> ...i.e. iterate over node data to do the lookup. This would seem to
> >> work generically for multiple archs unless I am missing something?
>
> IIRC, only memory assigned to/onlined to a ZONE is represented in the
> pgdat node span. E.g., not offline memory blocks.

So this dovetails somewhat with Will's idea. What if we populated
node_data for "offline" ranges? I started there, but then saw
ARCH_KEEP_MEMBLOCK and thought it would be safer to just teach
phys_to_target_node() to use that rather than update other code paths
to expect node_data might not always reflect online data.

> Esp., when hotplugging + onlining consecutive memory, there won't really
> be any intersections in most cases if I am not wrong. It would not be
> "intersection" but rather "closest fit".
>
> With overlapping nodes it's even more unclear. Which one to pick?

In the overlap case you get what you get. Some signal is better than
the noise of a dummy function. The consequences of picking the wrong
node might be that the kernel can't properly associate a memory range
to its performance data tables in firmware, but then again firmware
messed up with an overlapping node definition in the first instance.
