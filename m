Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1892C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9497B20774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="C/0f3tzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgGHFsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGHFsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:48:32 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C60EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 22:48:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so39398371edy.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sH1vNvX+feajcnCsvdAreoIiJv5hsHTyp2OTCZ6kbJY=;
        b=C/0f3tzmRBBx7Vg+YwRX/xLuDoujMD5WD2U9zm6TwnXK7bz3Y0scDy3NrKlGxrt4dt
         CPSXnq85gbf+oan7E6kU8D2KexWrl9DaA/91tbHPSK7w3EMdaaw+idj35XP+k+8JvzwM
         THBkm3zxP/Pir+7MDn2HW5LgkC9NyWTAGyINlouyVCJHV0dthE23lDDwsrbqQLCZ0PW1
         nm/byJb3l0XVvKTqmhMFI7rGXOPFYblzFMMYmzkw+/kpyViR3OopzYYJQgc6pMX6R3/v
         WV5R8XuBqWcrJmqDyOja9AzUxIYm7Skco2oBtv08ExW/YW0HdGSgG4fnpAX9RFpENabo
         RFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sH1vNvX+feajcnCsvdAreoIiJv5hsHTyp2OTCZ6kbJY=;
        b=PU/8/Nq/ClwS6xPiLWDIx0BuODqxqa4fGMPYvhdd2fS8esxMHFTgs8TH+hsyGipjI/
         3qcvTQyZ/QG2d35D/OOEtIXewBaTvMTOjZQhQRcl5RO0a4nYUDAN4vpK2CFEK1WyHXoO
         d71gLaWnAVL3TnggzUlhG2cvwirrPBRux3ptllCOX6V0fzDfqO+RlvpQdr6MDI0cIEWV
         y9iUTTJQxqAty3wUfi+S0tjVqrSKwFhThgrOJJMQy4Pe5O9y2d9wOGmHZVflqexJvmGx
         psQw583TjqRMyg84mB7PTHC9tbc2VwIA/HwnhBEfzY/eSL3HlhZOAH9+5NQCnFbvBUo3
         AnKg==
X-Gm-Message-State: AOAM530/NCJDpGnzfjOfPMWSBFHF2lsc2nVG6yWQ53snpppE4+Al5Ndd
        oGKJsPrO6ENia4uOsH/2icvf4i5rtA+gbiC4tCTkOA==
X-Google-Smtp-Source: ABdhPJx46o9+pkuePT9sA7zg+ZJfHTWmUfr0lvtngh+DBcpmZeXU7z8whxlFETGvWd7DkVFim7svR/m0UBFwiuCyhME=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr68029408edo.123.1594187311235;
 Tue, 07 Jul 2020 22:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com> <20200708053239.GC386073@linux.ibm.com>
In-Reply-To: <20200708053239.GC386073@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jul 2020 22:48:19 -0700
Message-ID: <CAPcyv4i2gnrugO5n715WsDoj+gxV9Mjt-49zNnv+ROMLYy79LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
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

On Tue, Jul 7, 2020 at 10:33 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Tue, Jul 07, 2020 at 08:56:36PM -0700, Dan Williams wrote:
> > On Tue, Jul 7, 2020 at 7:20 PM Justin He <Justin.He@arm.com> wrote:
> > >
> > > Hi Michal and David
> > >
> > > > -----Original Message-----
> > > > From: Michal Hocko <mhocko@kernel.org>
> > > > Sent: Tuesday, July 7, 2020 7:55 PM
> > > > To: Justin He <Justin.He@arm.com>
> > > > Cc: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> > > > <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> > > > <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>; Andrew
> > > > Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>;
> > > > Baoquan He <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-
> > > > arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > > > mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>
> > > > Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid
> > > > as EXPORT_SYMBOL_GPL
> > > >
> > > > On Tue 07-07-20 13:59:15, Jia He wrote:
> > > > > This exports memory_add_physaddr_to_nid() for module driver to use.
> > > > >
> > > > > memory_add_physaddr_to_nid() is a fallback option to get the nid in case
> > > > > NUMA_NO_NID is detected.
> > > > >
> > > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > > Signed-off-by: Jia He <justin.he@arm.com>
> > > > > ---
> > > > >  arch/arm64/mm/numa.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> > > > > index aafcee3e3f7e..7eeb31740248 100644
> > > > > --- a/arch/arm64/mm/numa.c
> > > > > +++ b/arch/arm64/mm/numa.c
> > > > > @@ -464,10 +464,11 @@ void __init arm64_numa_init(void)
> > > > >
> > > > >  /*
> > > > >   * We hope that we will be hotplugging memory on nodes we already know
> > > > about,
> > > > > - * such that acpi_get_node() succeeds and we never fall back to this...
> > > > > + * such that acpi_get_node() succeeds. But when SRAT is not present,
> > > > the node
> > > > > + * id may be probed as NUMA_NO_NODE by acpi, Here provide a fallback
> > > > option.
> > > > >   */
> > > > >  int memory_add_physaddr_to_nid(u64 addr)
> > > > >  {
> > > > > -   pr_warn("Unknown node for memory at 0x%llx, assuming node 0\n",
> > > > addr);
> > > > >     return 0;
> > > > >  }
> > > > > +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > > >
> > > > Does it make sense to export a noop function? Wouldn't make more sense
> > > > to simply make it static inline somewhere in a header? I haven't checked
> > > > whether there is an easy way to do that sanely bu this just hit my eyes.
> > >
> > > Okay, I can make a change in memory_hotplug.h, sth like:
> > > --- a/include/linux/memory_hotplug.h
> > > +++ b/include/linux/memory_hotplug.h
> > > @@ -149,13 +149,13 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
> > >               struct mhp_params *params);
> > >  #endif /* ARCH_HAS_ADD_PAGES */
> > >
> > > -#ifdef CONFIG_NUMA
> > > -extern int memory_add_physaddr_to_nid(u64 start);
> > > -#else
> > > +#if !defined(CONFIG_NUMA) || !defined(memory_add_physaddr_to_nid)
> > >  static inline int memory_add_physaddr_to_nid(u64 start)
> > >  {
> > >         return 0;
> > >  }
> > > +#else
> > > +extern int memory_add_physaddr_to_nid(u64 start);
> > >  #endif
> > >
> > > And then check the memory_add_physaddr_to_nid() helper on all arches,
> > > if it is noop(return 0), I can simply remove it.
> > > if it is not noop, after the helper,
> > > #define memory_add_physaddr_to_nid
> > >
> > > What do you think of this proposal?
> >
> > Especially for architectures that use memblock info for numa info
> > (which seems to be everyone except x86) why not implement a generic
> > memory_add_physaddr_to_nid() that does:
>
> That would be only arm64.
>

Darn, I saw ARCH_KEEP_MEMBLOCK and had delusions of grandeur that it
could solve my numa api woes. At least for x86 the problem is already
solved with reserved numa_meminfo, but now I'm trying to write generic
drivers that use those apis and finding these gaps on other archs.
