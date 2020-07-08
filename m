Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B740F20760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SACF4faT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgGHHET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbgGHHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:04:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:04:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so49224218ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8DJkdquRNNePQZNFg7Hkhjp0N1sn7vgJTtn21OuChM=;
        b=SACF4faTk3zv/4UtH39KJpY1EyVX+rh7ao155Gc/PXjG8TrgshGBUjBtrUqQ+9gs7i
         L5vmTlibESrKgbfMTCGhiWtgPrAMhhcnkOHRM2Ia2Y8Jc9V+3LCyG/yJumUkViP3L7Pb
         a2I7dIXDDdaZ0Cuyka9u74Vv9AS609TdrAwDEKA4Wo08zzzHJdpen+IvOXLWzV+1McID
         uEfP5IZ8K/A1vsTLrUkqSpWu6J8+YyNaxkI3zkQBXIxOdEJ349cAM/R1VYOnd962N5Or
         Sr3whbUU5C6EZxDmca1o0Y6BVT+YPiq8mhQFC+bo3h9VIMzxObom+Gcbl8Fv4uHNxRxt
         MfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8DJkdquRNNePQZNFg7Hkhjp0N1sn7vgJTtn21OuChM=;
        b=uZ2fx6CxiN9iUkhWLicxqF/0PupFS+dXOGlF49QkBukHmqMRBCur3kUhd2gnf73Mke
         efdcDDuMeimgxZQES4chp2JccIpe23xkCgFIEnAtj/Qg7/10/4CEW5P+2/0HKRnmuBBI
         GlpNYGMFwPJIcKvOkO3ZKQqQ2GXWt3iA9winZ/xw4XHDLq2o126fm6xM+V0Dyb6ZsvO+
         njfKDuisVltiYVcIQFcUZTzwl6bvbud/Bmoh8NP6Ts8/vwjF7Z+7MObXi4TqXQ+JWpDw
         LF8Zs/J6yuOJHoULXCEOFPHvn3dt1TawN9GseNV/9CDuxweFESbJBbZyopg8MMArikh0
         zlOA==
X-Gm-Message-State: AOAM5312cs1CtNdwnri6AkR31TTNVN+mEFgCXXurPxqvOPRzJC2p4CZF
        +qPP5E8XiyYXxYI0r6p+eYgBT2+F8L3e2clSKIsCVQ==
X-Google-Smtp-Source: ABdhPJyRGR0MQswLR49lOWdnIujwwLeu+bZjq5kGBbvha0J5qEn/N4WpOBb/iGUCPM+O4K8cgy9DfyN1wDvRoKcTF84=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr50016102ejb.124.1594191857256;
 Wed, 08 Jul 2020 00:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ivyJsyzcbkBWcqBYZMx3VdJF7+VPCNs177DU2rYqtz_A@mail.gmail.com>
 <20200708062217.GE386073@linux.ibm.com> <c4ee0a94-c980-80ca-c43d-15729e1a3663@redhat.com>
In-Reply-To: <c4ee0a94-c980-80ca-c43d-15729e1a3663@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 00:04:06 -0700
Message-ID: <CAPcyv4inaZgmv=S36_DofA9prKhWg4KBNPkTvzSALO6Vtb9ddw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Justin He <Justin.He@arm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 11:59 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.07.20 08:22, Mike Rapoport wrote:
> > On Tue, Jul 07, 2020 at 09:27:43PM -0700, Dan Williams wrote:
> >> On Tue, Jul 7, 2020 at 9:08 PM Justin He <Justin.He@arm.com> wrote:
> >> [..]
> >>>> Especially for architectures that use memblock info for numa info
> >>>> (which seems to be everyone except x86) why not implement a generic
> >>>> memory_add_physaddr_to_nid() that does:
> >>>>
> >>>> int memory_add_physaddr_to_nid(u64 addr)
> >>>> {
> >>>>         unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> >>>>         int nid;
> >>>>
> >>>>         for_each_online_node(nid) {
> >>>>                 get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >>>>                 if (pfn >= start_pfn && pfn <= end_pfn)
> >>>>                         return nid;
> >>>>         }
> >>>>         return NUMA_NO_NODE;
> >>>> }
> >>>
> >>> Thanks for your suggestion,
> >>> Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
> >>> phys_to_target_node()?
> >>
> >> I think it needs to be the reverse. phys_to_target_node() should call
> >> memory_add_physaddr_to_nid() by default, but fall back to searching
> >> reserved memory address ranges in memblock. See phys_to_target_node()
> >> in arch/x86/mm/numa.c. That one uses numa_meminfo instead of memblock,
> >> but the principle is the same i.e. that a target node may not be
> >> represented in memblock.memory, but memblock.reserved. I'm working on
> >> a patch to provide a function similar to get_pfn_range_for_nid() that
> >> operates on reserved memory.
> >
> > Do we really need yet another memblock iterator?
> > I think only x86 has memory that is not in memblock.memory but only in
> > memblock.reserved.
>
> Reading about abusing the memblock allcoator once again in memory
> hotplug paths makes me shiver.

Technical reasoning please?

arm64 numa information is established from memblock data. It seems
counterproductive to ignore that fact if we're already touching
memory_add_physaddr_to_nid() and have a use case for a driver to call
it.
