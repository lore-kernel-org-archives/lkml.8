Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F07C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF0920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="IvrsAU1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgGHD4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGHD4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:56:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3C1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 20:56:49 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d18so34823245edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTn2jvAGhNEebX/31coeKRgrATf42VwRs1IekEU/wXY=;
        b=IvrsAU1XjAgKBxDdSMgPJ+oYemeR6oDH6pX66ZmNmiZU44vQoOWODIYN2eHWUIyLXe
         UuVyPRljljj0LRyhYbgQt1WN/QXw7EsZMi1Jk1hFbg4BvfiGXKD9fAaMW/zC07paErB5
         S9jvB+SYSzWCQRqViLX58i/kNbTyi9kFaozTSWMRD+Lfz0vBJCuaqApnYldg5SEk7aE9
         ErmtS2BuhfpxZOaNbMAZ9U+3n2opU/xUPnebTc7qaecBFIRC820qr/uNOU6kewfpctqc
         bNpaH4SoMJxAfRnDHXeifKcni3JNtLlTflaLn/r9LxxJsFq23VujziihbTvG3BhyHixZ
         0BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTn2jvAGhNEebX/31coeKRgrATf42VwRs1IekEU/wXY=;
        b=F5lUHO2sMod54VEmDl8MU96Wkj+zHYyI0avkQvYvQp8daQtTIoF3SoqtKxyFW2aonk
         5gvM6/C1pW9GgwQdB3UjsklQgHbcDB9lvUctFmJ3O8jNqC7Nzrpzs/ChldI+mPw0gIh9
         NewaZawEyZIn5zH8XfzpwEw3IDLDsR+hsGMxvKkp4qeJXl1mHnddk/a/YHoKVXW7kAaw
         UObfu1FAvoXW7PbcCpqJnX0kzaXOqrSHQQ/Pk5vSnjUNZQjOYs+yxmogiz2NURn6+EtL
         4XufSslOuXQo6aAln/4l1oZZrKF1qZeiLboF77xIUFCRHO8V1w4+TBlRwQ7vtQKp7V1m
         4rog==
X-Gm-Message-State: AOAM530FLxnblHpDXL9SK2G00Xlo583ld6JoXPEleAitOf0TluOxrXnI
        kIZV7qXuna58Yo6d/gKz6tjEC6yywywBnvIkQKtPZ1lCUfY=
X-Google-Smtp-Source: ABdhPJz9cJ6Qq3Vxkoam4dKJq6AdNY7Fw9Oa6InR0v2bOalI2tEHRvWbG4COa7ovxq4MW9UNDDuaSdNEj5xAhsCfVyk=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr63116438edk.165.1594180607875;
 Tue, 07 Jul 2020 20:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jul 2020 20:56:36 -0700
Message-ID: <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
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

On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
>
> Hi Michal and David
>
> > -----Original Message-----
> > From: Michal Hocko <mhocko@kernel.org>
> > Sent: Tuesday, July 7, 2020 7:55 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> > Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>;
> > Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-
> > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> > Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> > as EXPORT_SYMBOL_GPL
> >
> > On Tue 07-07-20 13:59:15, Jia He wrote:
> > > This exports memory_add_physaddr_to_nid() for module driver to use.
> > >
> > > memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > > NUMA_NO_NID is detected.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  arch/arm64/mm/numa.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > index aafcee3e3f7e..7eeb31740248 100644
> > > --- a/arch/arm64/mm/numa.c
> > > +++ b/arch/arm64/mm/numa.c
> > > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > >
> > >  /*
> > >   * We hope that we will be hotplugging memory on nodes we already know
> > about,
> > > - * such that acpi_get_node() succeeds and we never fall back to this...
> > > + * such that acpi_get_node() succeeds. But when SRAT is not present,
> > the node
> > > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback
> > option.
> > >   */
> > >  int memory_add_physaddr_to_nid(u64 addr)
> > >  {
> > > -   pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n",
> > addr);
> > >     return 0;
> > >  }
> > > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> >
> > Does it make sense to export a noop function? Wouldn't make more sense
> > to simply make it static inline somewhere in a header? I haven't checked
> > whether there is an easy way to do that sanely bu this just hit my eyes.
>
> Okay, I can make a change in memory_hotplug.h, sth like:
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>               struct mhp_params *params);
>  #endif /* ARCH_HAS_ADD_PAGES */
>
> -#ifdef CONFIG_NUMA
> -extern int memory_add_physaddr_to_nid(u64 start);
> -#else
> +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
>  static inline int memory_add_physaddr_to_nid(u64 start)
>  {
>         return 0;
>  }
> +#else
> +extern int memory_add_physaddr_to_nid(u64 start);
>  #endif
>
> And then check the memory_add_physaddr_to_nid() helper on all arches,
> if it is noop(return 0), I can simply remove it.
> if it is not noop, after the helper,
> #define memory_add_physaddr_to_nid
>
> What do you think of this proposal?

Especially for architectures that use memblock info for numa info
(which seems to be everyone except x86) why not implement a generic
memory_add_physaddr_to_nid() that does:

int memory_add_physaddr_to_nid(u64 addr)
{
        unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
        int nid;

        for_each_online_node(nid) {
                get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
                if (pfn >= start_pfn && pfn <= end_pfn)
                        return nid;
        }
        return NUMA_NO_NODE;
}
