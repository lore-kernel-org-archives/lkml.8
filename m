Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4EC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CF2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YRuMaL7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgAQQ6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:58:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35133 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgAQQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:58:04 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so23122725oto.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVdmKszNnhoaHDNeCmKwKg+oKUWstdwrLDQTNGyOrtg=;
        b=YRuMaL7fGyr27X1i82sHIbXhAORF5u2Ym2ug9SABWZbWxeWrsckjPfMR7nQSgBasws
         wonoYfYIfFS1mntoWdBSNrrkhYxkdQaruSKny15ufforyO0fUntf8yJhURCop8gYv0RK
         RItVhTIaa8EJ9a0bFB57G0/17NoTea9XXE9yjT2DRg+XvUaNGeCYr4csHKZUTmX2h0Dv
         u+vm201ZbxReZC2ebgQFg4B3vZ0t29B6IkMhDtOyGtxMmYsT/T5UBFO1VGqYp4kjbWGA
         29f0cmYunZuedtDvxKjeXShJuVELAvafbVdbHdA4kNpupDWzpMFMNFVtXJON18R9heCj
         dIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVdmKszNnhoaHDNeCmKwKg+oKUWstdwrLDQTNGyOrtg=;
        b=uCjqyfufIKxeQMjK2mZzXWv32W3ovbFg99Sd5Dlif8RvId57ObaQ79kLateklcHB2Y
         qm+cK9EQHhfn3ItfPvpxJnk6DoOqpSdeIomd+siWcB9CCTkaTg/S/Mn/6VFeiCpCb8IB
         Zk51Mvh/jYSrK/VbG6v+/w8Z1spoeuvmnQDrLqgcz8GiEo1uEJsnNInhUldzrRpq9kst
         mDdWmp6vJeMmce8u77Zx2Yt6mkkQ70NLpNN88oJN8ps83IQRXBJQqptMZpuRcmXUwEt3
         mktgrGSP7GtzhZLN3FkAnePb88upym0xgUpwwAgyhTAesZcN94rDrNT5pQs5/NFRYYe/
         Pvig==
X-Gm-Message-State: APjAAAXgm325bWEMXjyRwceOjZCaY7D+BYkFAyFuPCxJttBsEAaBgsQD
        Aemo0lZMUGFIjmi0o6QJBU+RfkIWwRrZkPAI0kjgtw==
X-Google-Smtp-Source: APXvYqxgOgqv3ymmNMR4Qi8eZqfarlt0GXyxGWemoSfAqaNgr6Z1q23zsOW9tFkDz0e186QlkX0vwUXqICR3gNOvyhQ=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr6744052oto.207.1579280282992;
 Fri, 17 Jan 2020 08:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20200117105759.27905-1-david@redhat.com> <20200117113353.GT19428@dhcp22.suse.cz>
 <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com> <20200117145233.GB19428@dhcp22.suse.cz>
 <65606e2e-1cf7-de3b-10b1-33653cb41a52@redhat.com> <20200117152947.GK19428@dhcp22.suse.cz>
 <CAPcyv4hHHzdPp4SQ0sePzx7XEvD7U_B+vZDT00O6VbFY8kJqjw@mail.gmail.com> <25a94f61-46a1-59a6-6b54-8cc6b35790d2@redhat.com>
In-Reply-To: <25a94f61-46a1-59a6-6b54-8cc6b35790d2@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 Jan 2020 08:57:51 -0800
Message-ID: <CAPcyv4jvmYRbX9i+1_LvHoTDGABadHbYH3NVkqczKsQ4fsf74g@mail.gmail.com>
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 8:11 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 17.01.20 16:54, Dan Williams wrote:
> > On Fri, Jan 17, 2020 at 7:30 AM Michal Hocko <mhocko@kernel.org> wrote:
> >>
> >> On Fri 17-01-20 15:58:26, David Hildenbrand wrote:
> >>> On 17.01.20 15:52, Michal Hocko wrote:
> >>>> On Fri 17-01-20 14:08:06, David Hildenbrand wrote:
> >>>>> On 17.01.20 12:33, Michal Hocko wrote:
> >>>>>> On Fri 17-01-20 11:57:59, David Hildenbrand wrote:
> >>>>>>> Let's refactor that code. We want to check if we can offline memory
> >>>>>>> blocks. Add a new function is_mem_section_offlineable() for that and
> >>>>>>> make it call is_mem_section_offlineable() for each contained section.
> >>>>>>> Within is_mem_section_offlineable(), add some more sanity checks and
> >>>>>>> directly bail out if the section contains holes or if it spans multiple
> >>>>>>> zones.
> >>>>>>
> >>>>>> I didn't read the patch (yet) but I am wondering. If we want to touch
> >>>>>> this code, can we simply always return true there? I mean whoever
> >>>>>> depends on this check is racy and the failure can happen even after
> >>>>>> the sysfs says good to go, right? The check is essentially as expensive
> >>>>>> as calling the offlining code itself. So the only usecase I can think of
> >>>>>> is a dumb driver to crawl over blocks and check which is removable and
> >>>>>> try to hotremove it. But just trying to offline one block after another
> >>>>>> is essentially going to achieve the same.
> >>>>>
> >>>>> Some thoughts:
> >>>>>
> >>>>> 1. It allows you to check if memory is likely to be offlineable without
> >>>>> doing expensive locking and trying to isolate pages (meaning:
> >>>>> zone->lock, mem_hotplug_lock. but also, calling drain_all_pages()
> >>>>> when isolating)
> >>>>>
> >>>>> 2. There are use cases that want to identify a memory block/DIMM to
> >>>>> unplug. One example is PPC DLPAR code (see this patch). Going over all
> >>>>> memory block trying to offline them is an expensive operation.
> >>>>>
> >>>>> 3. powerpc-utils (https://github.com/ibm-power-utilities/powerpc-utils)
> >>>>> makes use of /sys/.../removable to speed up the search AFAIK.
> >>>>
> >>>> Well, while I do see those points I am not really sure they are worth
> >>>> having a broken (by-definition) interface.
> >>>
> >>> It's a pure speedup. And for that, the interface has been working
> >>> perfectly fine for years?
> >>>
> >>>>
> >>>>> 4. lsmem displays/groups by "removable".
> >>>>
> >>>> Is anybody really using that?
> >>>
> >>> Well at least I am using that when testing to identify which
> >>> (ZONE_NORMAL!) block I can easily offline/re-online (e.g., to validate
> >>> all the zone shrinking stuff I have been fixing)
> >>>
> >>> So there is at least one user ;)
> >>
> >> Fair enough. But I would argue that there are better ways to do the same
> >> solely for testing purposes. Rather than having a subtly broken code to
> >> maintain.
> >>
> >>>>
> >>>>>> Or does anybody see any reasonable usecase that would break if we did
> >>>>>> that unconditional behavior?
> >>>>>
> >>>>> If we would return always "true", then the whole reason the
> >>>>> interface originally was introduced would be "broken" (meaning, less
> >>>>> performant as you would try to offline any memory block).
> >>>>
> >>>> I would argue that the whole interface is broken ;). Not the first time
> >>>> in the kernel development history and not the last time either. What I
> >>>> am trying to say here is that unless there are _real_ usecases depending
> >>>> on knowing that something surely is _not_ offlineable then I would just
> >>>> try to drop the functionality while preserving the interface and see
> >>>> what happens.
> >>>
> >>> I can see that, but I can perfectly well understand why - especially
> >>> powerpc - wants a fast way to sense which blocks actually sense to try
> >>> to online.
> >>>
> >>> The original patch correctly states
> >>>    "which sections of
> >>>     memory are likely to be removable before attempting the potentially
> >>>     expensive operation."
> >>>
> >>> It works as designed I would say.
> >>
> >> Then I would just keep it crippled the same way it has been for years
> >> without anybody noticing.
> >
> > I tend to agree. At least the kmem driver that wants to unplug memory
> > could not use an interface that does not give stable answers. It just
> > relies on remove_memory() to return a definitive error.
> >
>
> Just because kmem cannot reuse such an interface doesn't mean we should
> not touch it (or I am not getting your point). Especially, this
> interface is about "can it be likely be offlined and then eventually be
> removed (if there is a HW interface for that)" (as documented), not
> about "will remove_memory()" work.

Unless the user is willing to hold the device_hotplug_lock over the
evaluation then the result is unreliable. For example the changes to
removable_show() are no better than they were previously because the
result is invalidated as soon as the lock is dropped.

> We do have users and if we agree to keep it (what I think we should as I
> expressed) then I think we should un-cripple and fix it. After all we
> have to maintain it. The current interface provides what was documented
> - "likely to be offlineable". (the chosen name was just horribly bad -
> as I expressed a while ago already :) )

Are there users that misbehave because they try to offline a section
with holes? I brought up kmem because it's an unplug user that does
not care whether the failure was due to pinned pages or holes in
sections. Do others care about that precision in a meaningful way?
