Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D0FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1205E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Hyyvv8vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBMVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:20:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33829 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgBMVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:20:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so7079367otl.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdeMRXcHv3gdD6qpW26HbSbVWn9VbRyn5M5xWNM2dDM=;
        b=Hyyvv8vojMc3YBTypTl8uC2uiKKtwZNhOmrxbaeG1vuEwpYOBWtUCtYYg0lYEql4zN
         iQhsW++w/ZAYQx4DWEAHt6KFC1Osk7+fnv+N10orqg0hMBpJ5upOM9vYaC6HThBEWUo4
         x8lSTdVsID1n9sDXHKjdP0wZOyi3I5KgZohTPQEZ6SvZkK0KIraYfFXgJWT7EBHym7lD
         qHWVKcYmF/3JOR5hSfhX8LfGU7oXROkRyuZ7d8fCAITSP1r0DKZPxtU1HZtwQKrg56ck
         601ueLi8jx80f5FnP/FCE4wz5IyUxhpnFTQRgZhpic+9EvNZpOXw2+FeDBsFcyVW+NQO
         iecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdeMRXcHv3gdD6qpW26HbSbVWn9VbRyn5M5xWNM2dDM=;
        b=dIXsf43tymzTwOEYwSw3TLASwts6XTIJxk3+VKFwEOsHJfTxlD6odhFlfqT/3k90tB
         U+26Yr6nCCFKdpRh4Mgcgmou1Bh+d55Un2x1QeSrv7PFruqEoUTWRvBxKczsFFMWRM2A
         YIHYBtySf8pa/tUXs5IaXrsTzk83MaXBlJ7bWhEtgL92RmTEQwkSqdVpQPa4V4N4b20r
         tiQpNlt9fSd6Pzkfmi+QGamCBiNHubMGNpBPo2RVohdfRJ23PXDFjkH14BaHNt0yDety
         ZdGBcYQv+Ha2y1O4EegjaaYBXEG6gfqczB/j+d2+T6vML8GziBAYCklCEV92GWJgyxn4
         RNIA==
X-Gm-Message-State: APjAAAUcwubC1O640MoVIildf3aI1Ke7kOywn75vdz1rQcxKQB3pnTvt
        3f7EKptQJbEjNRnqmOpgWrL3MKCZMGuxLrZfgPfbFg==
X-Google-Smtp-Source: APXvYqy/JTMiaK1YjeSUIRUgCDXzbRBoIVRbwxDW+6bmRuwC7016knDFFU+BtSvxGFlv/jMxkwnEe8Gedri67BtzpDA=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr14235067otm.247.1581628802976;
 Thu, 13 Feb 2020 13:20:02 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200213093227.GA90266@gmail.com>
In-Reply-To: <20200213093227.GA90266@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Feb 2020 13:19:51 -0800
Message-ID: <CAPcyv4hXpqrZ4jmgmjy9fH=3oHg0UDDU6xLGX2TVCgSS_xkq4w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 1:32 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Currently x86 numa_meminfo is marked __initdata in the
> > CONFIG_MEMORY_HOTPLUG=n case. In support of a new facility to allow
> > drivers to map reserved memory to a 'target_node'
> > (phys_to_target_node()), add support for removing the __initdata
> > designation for those users. Both memory hotplug and
> > phys_to_target_node() users select CONFIG_KEEP_NUMA to tell the arch to
> > maintain its physical address to numa mapping infrastructure post init.
> >
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/mm/numa.c   |    6 +-----
> >  include/linux/numa.h |    6 ++++++
> >  mm/Kconfig           |    5 +++++
> >  3 files changed, 12 insertions(+), 5 deletions(-)
>
> The concept and the x86 portions look sane, just a few minor nits:
>
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 99f7a68738f0..5289d9d6799a 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -25,11 +25,7 @@ nodemask_t numa_nodes_parsed __initdata;
> >  struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
> >  EXPORT_SYMBOL(node_data);
> >
> > -static struct numa_meminfo numa_meminfo
> > -#ifndef CONFIG_MEMORY_HOTPLUG
> > -__initdata
> > -#endif
> > -;
> > +static struct numa_meminfo numa_meminfo __initdata_numa;
> >
> >  static int numa_distance_cnt;
> >  static u8 *numa_distance;
> > diff --git a/include/linux/numa.h b/include/linux/numa.h
> > index 20f4e44b186c..c005ed6b807b 100644
> > --- a/include/linux/numa.h
> > +++ b/include/linux/numa.h
> > @@ -13,6 +13,12 @@
> >
> >  #define      NUMA_NO_NODE    (-1)
> >
> > +#ifdef CONFIG_KEEP_NUMA
> > +#define __initdata_numa
> > +#else
> > +#define __initdata_numa __initdata
> > +#endif
> > +
> >  #ifdef CONFIG_NUMA
> >  int numa_map_to_online_node(int node);
> >  #else
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ab80933be65f..001f1185eadf 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -139,6 +139,10 @@ config HAVE_FAST_GUP
> >  config ARCH_KEEP_MEMBLOCK
> >       bool
> >
> > +# Keep arch numa mapping infrastructure post-init.
>
> s/numa/NUMA
>
> Please also capitalize consistently in the rest of the series.
>
> > +config KEEP_NUMA
> > +     bool
>
>
> So most of our recent new NUMA options followed the naming pattern of:
>
>   CONFIG_NUMA_*
>
> Such as CONFIG_NUMA_BALANCING or CONFIG_NUMA_EMU.
>
> So I'd suggesting naming it to CONFIG_NUMA_KEEP, or, a bit more
> descriptively, such as CONFIG_NUMA_KEEP_MAPPING or such?
>
> 'Keeping NUMA' is kind of lame - of course we keep NUMA. ;-)

Ok, I settled on CONFIG_NUMA_KEEP_MEMINFO, and will fix up the
lowercase "numa" instances in the set.
