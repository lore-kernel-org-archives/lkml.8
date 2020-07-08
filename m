Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0D4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30E3206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eNptn699"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgGHPuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:50:16 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C725C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:50:16 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a1so51075741ejg.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EiYlSj53kAa10Re22X7U17L3JibixRtXdcfzQAF4RI=;
        b=eNptn699SYep16X4CoHPkgiGM5zR/mQnI3Mzfc9eEIY75pcRdSypj0pJntEDR4CHvS
         AogyjaLxg5b7iP5tvNUzz/jAPzLjWzHgZoJOeYZCaJYfJsP54+JncPgdDwCXaNdf5kDH
         K1mIGvj60uqPjUQAobqbGoJIlXdqdUK/+fD1DMteEv5JNXCo5U65YhxhYzb+IlmrLu27
         E3IX7kZcsTEMvjr4RRH6V4KWQ0rfrgXmeEmYl93SiTjzlboiF4oiFV3u04EJoo9Su1be
         U4kIpVOKeOQn52xh78cieCUwmNTeMkzDU3sr3r03UQCxfqxMjQyf2Q76ItzqDLCVZDbq
         Bqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EiYlSj53kAa10Re22X7U17L3JibixRtXdcfzQAF4RI=;
        b=JmHZTD6CVi6IHSRQFgBsl/PwFp3ujU3/puTaRngRTyRCTiFUMSktu6f2AAOx++8OcD
         exoDJ8tFYw4FJFYeAKPVAb/es2fU4VrcLrmvtXxY1DhszXVF28kDkrWqT7mXRwmWaNaH
         FFhQG8Ys/i9ecVdce/OT8mTNThRTIISdfH26rBYdM/p5PRH1gcAqOrZ0Q1vdtFvuYHmg
         0pN/BDjpwyfdu7ZsM3AquEwB+BgJ7B9vV2/KGhGtni9lCkEUEVfG9AtJfVTUj82iJDEr
         nwO9n2owy7WLFSReRkQpfGD8+SJXIXuY126JnUsF8Mj7Tmw6EhUi/eCe2TJhfqj2qzCg
         VJQQ==
X-Gm-Message-State: AOAM5339qM7Q5vu8KezyhtgBc0kTxC9Bw8Bf60BNAsH75QxAkjHSjpAI
        0FvFPlRP66HLjUPz8HsYdbivX+L8QqPsKXkRk0wbvWb5
X-Google-Smtp-Source: ABdhPJw/8Kbx1/bdnv7iOEbWdknY8BbvvUvThRPw7aqvnIeHYlAeIqwGVHirPg4m6UtNvCENnXVgYQiwBwoexLKostU=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr51820947ejb.124.1594223414714;
 Wed, 08 Jul 2020 08:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180043.GA386073@linux.ibm.com> <CAPcyv4iB-vP8U4pH_3jptfODbiNqJZXoTmA6+7EHoddk9jBgEQ@mail.gmail.com>
 <20200708052626.GB386073@linux.ibm.com> <9a009cf6-6c30-91ca-a1a5-9aa090c66631@redhat.com>
 <CAPcyv4jyk_tkDRewTVvRAv0g4LwemEyKYQyuJBXkF4VuYrBdrw@mail.gmail.com>
 <999ea296-4695-1219-6a4d-a027718f61e5@redhat.com> <20200708083951.GH386073@linux.ibm.com>
 <cdb0510e-4271-1c97-4305-5fd52da282dc@redhat.com> <20200708091520.GE128651@kernel.org>
 <df0e5f64-10bc-4c3c-a515-288a6f501065@redhat.com> <20200708094549.GA781326@linux.ibm.com>
 <98166184-3aaf-479e-bfb3-fc737f4ac98d@redhat.com>
In-Reply-To: <98166184-3aaf-479e-bfb3-fc737f4ac98d@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 08:50:03 -0700
Message-ID: <CAPcyv4guv2wjLDNJ4VN+4ZKiSC-FDvxoRxy5_OvUJ5C1tJsAGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
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

On Wed, Jul 8, 2020 at 3:04 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 08.07.20 11:45, Mike Rapoport wrote:
> > On Wed, Jul 08, 2020 at 11:25:36AM +0200, David Hildenbrand wrote:
> >> On 08.07.20 11:15, Mike Rapoport wrote:
> >>>>>>>>
> >>>>> But on more theoretical/fundmanetal level, I think we lack a generic
> >>>>> abstraction similar to e.g. x86 'struct numa_meminfo' that serves as
> >>>>> translaton of firmware supplied information into data that can be used
> >>>>> by the generic mm without need to reimplement it for each and every
> >>>>> arch.
> >>>>
> >>>> Right. As I expressed, I am not a friend of using memblock for that, and
> >>>> the pgdat node span is tricky.
> >>>>
> >>>> Maybe abstracting that x86 concept is possible in some way (and we could
> >>>> restrict the information to boot-time properties, so we don't have to
> >>>> mess with memory hot(un)plug - just as done for numa_meminfo AFAIKS).
> >>>
> >>> I agree with pgdat part and disagree about memblock. It already has
> >>> non-init physmap, why won't we add memblock.memory to the mix? ;-)
> >>
> >> Can we generalize and tweak physmap to contain node info? That's all we
> >> need, no? (the special mem= parameter handling should not matter for our
> >> use case, where "physmap" and "memory" would differ)
> >
> > TBH, I have only random vague thoughts at the moment. This might be an
> > option. But then we need to enable physmap on !s390, right?
>
> Yes, looks like it.
>
> >
> >>> Now, seriously, memblock already has all the necessary information about
> >>> the coldplug memory for several architectures. x86 being an exception
> >>> because for some reason the reserved memory is not considered memory
> >>> there. The infrastructure for quiering and iterating memory regions is
> >>> already there. We just need to leave out the irrelevant parts, like
> >>> memblock.reserved and allocation funcions.
> >>
> >> I *really* don't want to mess with memblocks on memory hot(un)plug on
> >> x86 and s390x (+other architectures in the future). I also thought about
> >> stopping to create memblocks for hotplugged memory on arm64, by tweaking
> >> pfn_valid() to query memblocks only for early sections.
> >>
> >> If "physmem" is not an option, can we at least introduce something like
> >> ARCH_UPDTAE_MEMBLOCK_ON_HOTPLUG to avoid doing that on x86 and s390x for
> >> now (and later maybe for others)?
> >
> > I have to do more memory hotplug howework to answer that ;-)
> >
> > My general point is that we don't have to reinvent the wheel to have
> > coldplug memory representation, it's already there. We just need a way
> > to use it properly.
>
> Yes, I tend to agree. Details to be clarified :)

I'm not quite understanding the concern, or requirement about
"updating memblock" in the hotplug path. The routines
memory_add_physaddr_to_nid() and phys_to_target_node() are helpers to
interrogate platform-firmware numa info through a common abstraction.
They place no burden on the memory hotplug code they're just used to
see if a hot-added range lies within an existing node span when
platform-firmware otherwise fails to communicate a node. x86 can
continue to back those helpers with numa_meminfo, arm64 can use a
generic memblock implementation and other archs can follow the arm64
example if they want better numa answers for drivers.
