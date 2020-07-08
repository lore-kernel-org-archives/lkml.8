Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7471E20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="NuIWqyja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGHE15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgGHE14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:27:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FDC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 21:27:56 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so48924066ejj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dNw96B96eIbQP472P+15i/r4t0gFAYtc8zARUaecF0=;
        b=NuIWqyjaegQ19QFyhYTJ0y36/0eMyFNfJBL+jmN/1SvmxqjSyG5lJHJdWcy9wXyg4M
         zy7lOCo2bw1cinVxH1l3+0WrbURYr2eYuQNJEMnxBG3T4CgExMU46UqZQixd1aj78OUM
         78/CptqirWWbUEI84ihTiqSnnw6yzzVair+mKB6+l4zzftMrRjKpPkMugswhpdluXKgJ
         aoVSiSO57Cu3iMf+t6CNs56lDskou5ghNPRZMbdiMiQ41mUM5Re5Cw+4/KfHHF7dgIxH
         /pgQXq91bIOxcuCa3VaYk2y7noic6S7FI7vxllIz77rUivHIylJMRIgHQ2C2LMe1MUQQ
         J9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dNw96B96eIbQP472P+15i/r4t0gFAYtc8zARUaecF0=;
        b=KEeze/+LZavv0qFuvvRmxeSQjh/mv922TvqBj2Y5yI3VEEF556Lu0cUw1PiFA/rrof
         zwQ2eGL3SSJQVHrVieTiReik9+h17AxYjYIyrSdVl2n9GpAOHN6BtCXrUVQ7T9NRUyQV
         gRsG5yqTmdwF6iCYmyCYJwJcYTs+jTYpdVNLLjLXsRYQeEy5hobkHorDmpiBVU/oOI4l
         9sACZKuzDYMcujresBs2CaVi3eE3JSU/B2aGeGh1WkdaeKPVwwljZhErVP7/9JT0TmLZ
         qQyry2wvLCZXyIxemBeEC1ZEoPSEj2VPC8rIVqvdiIo6hbmMTwVGF4O+AmXWUuL+U/Vy
         LBkw==
X-Gm-Message-State: AOAM530UjGQWDidEKPd4D9XCPPSIvUOyFZcU9kJdtYQPtYXP3k0/OHD0
        r2p3Nt1R3ihtzIw5Lxj1P5+xfKyhmbu9vJ6vk/f2lA==
X-Google-Smtp-Source: ABdhPJxJ12SOUFRzJMHcuTFgGn9kWF+1e1N3sSWVya5gGxKC/lxUJ29HEPrjNkOM8G1dgLBXhTdyibVCZ2vfYDKLGIg=
X-Received: by 2002:a17:906:da0f:: with SMTP id fi15mr48990019ejb.237.1594182475031;
 Tue, 07 Jul 2020 21:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com> <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jul 2020 21:27:43 -0700
Message-ID: <CAPcyv4ivyJsyzcbkBWcqBYZMx3VdJF7+VPCNs177DU2rYqtz_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     Justin He <Justin.He@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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

On Tue, Jul 7, 2020 at 9:08 PM Justin He <Justin.He@arm.com> wrote:
[..]
> > Especially for architectures that use memblock info for numa info
> > (which seems to be everyone except x86) why not implement a generic
> > memory_add_physaddr_to_nid() that does:
> >
> > int memory_add_physaddr_to_nid(u64 addr)
> > {
> >         unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
> >         int nid;
> >
> >         for_each_online_node(nid) {
> >                 get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >                 if (pfn >= start_pfn && pfn <= end_pfn)
> >                         return nid;
> >         }
> >         return NUMA_NO_NODE;
> > }
>
> Thanks for your suggestion,
> Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
> phys_to_target_node()?

I think it needs to be the reverse. phys_to_target_node() should call
memory_add_physaddr_to_nid() by default, but fall back to searching
reserved memory address ranges in memblock. See phys_to_target_node()
in arch/x86/mm/numa.c. That one uses numa_meminfo instead of memblock,
but the principle is the same i.e. that a target node may not be
represented in memblock.memory, but memblock.reserved. I'm working on
a patch to provide a function similar to get_pfn_range_for_nid() that
operates on reserved memory.
