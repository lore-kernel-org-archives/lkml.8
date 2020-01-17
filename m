Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C361C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DB12176D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579272758;
	bh=PxodZKugEqVgst3OaYqU4MaD+YOJoml7FY8M9gNk4z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6JwHn0R71C+mMJNkXS/N4DqRZW0p15AVgM7n/5o7xzBwgcwC14vu4FEqkSVlv5cX
	 YiiqkU0O/OMC1uxJB2Ksegqd+t7dvOHNIneDEXJZ4+SxcvGJKNiR6P/WwbnK6ty1zV
	 g4MYAW+Ruzsd8daGGHz51/6psye0emV9BTIeO7oI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAQOwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:52:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38078 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:52:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so7901577wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AkURUQJ+DBuKMDSx+itAbwtb7hBHyuXsOO2uXs2DdgU=;
        b=GMOpssqt2NOx1kJWhaPaqf4fGOKu9YQ7W1oOfCaVDggrrmESYo5qnS5HzgM/vbSQv/
         HA22dvuMObuBqXEp934zs7434VxudbvawpGbiy4oT9ExjWBYbtdjK0nW27Z/3HFKgY6v
         UCvfcSzxH3Oaih2va8cqLLZyQnXNlVAMenfdXXh5i0LtK1u7BT4r7fcNQhE4t61XaTLs
         4kb1ZJhOSpPljW3J+5fR4Z9UQOxly/h98jx4HRkwuOwV0sx6dBAmyMpREB3Y5xqdB0bq
         CJViCMuBs8o9De9RPhVVq4G2IrmHkUHwEgZADpfqOXZh96InRz50g6Ny35eL8CQaxHB/
         +c/Q==
X-Gm-Message-State: APjAAAUd+7XGcWZqNto2gCRV4FK/9DqB0XCPCYYjqVllSZe5MpYz9DUq
        FFpmt6lDvZLtiUP/QKwHLuM=
X-Google-Smtp-Source: APXvYqx6QdFP6CoZLoNRt4b0Ti6hyVkI0oAXyG8bSOgUtIHhWTQMk4sw68ciudP9UEYs0HOMMg2GPg==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr5039901wmf.93.1579272755115;
        Fri, 17 Jan 2020 06:52:35 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n8sm34315771wrx.42.2020.01.17.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:52:34 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:52:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200117145233.GB19428@dhcp22.suse.cz>
References: <20200117105759.27905-1-david@redhat.com>
 <20200117113353.GT19428@dhcp22.suse.cz>
 <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 14:08:06, David Hildenbrand wrote:
> On 17.01.20 12:33, Michal Hocko wrote:
> > On Fri 17-01-20 11:57:59, David Hildenbrand wrote:
> >> Let's refactor that code. We want to check if we can offline memory
> >> blocks. Add a new function is_mem_section_offlineable() for that and
> >> make it call is_mem_section_offlineable() for each contained section.
> >> Within is_mem_section_offlineable(), add some more sanity checks and
> >> directly bail out if the section contains holes or if it spans multiple
> >> zones.
> > 
> > I didn't read the patch (yet) but I am wondering. If we want to touch
> > this code, can we simply always return true there? I mean whoever
> > depends on this check is racy and the failure can happen even after
> > the sysfs says good to go, right? The check is essentially as expensive
> > as calling the offlining code itself. So the only usecase I can think of
> > is a dumb driver to crawl over blocks and check which is removable and
> > try to hotremove it. But just trying to offline one block after another
> > is essentially going to achieve the same.
> 
> Some thoughts:
> 
> 1. It allows you to check if memory is likely to be offlineable without
> doing expensive locking and trying to isolate pages (meaning:
> zone->lock, mem_hotplug_lock. but also, calling drain_all_pages()
> when isolating)
> 
> 2. There are use cases that want to identify a memory block/DIMM to
> unplug. One example is PPC DLPAR code (see this patch). Going over all
> memory block trying to offline them is an expensive operation.
> 
> 3. powerpc-utils (https://github.com/ibm-power-utilities/powerpc-utils)
> makes use of /sys/.../removable to speed up the search AFAIK.

Well, while I do see those points I am not really sure they are worth
having a broken (by-definition) interface.
 
> 4. lsmem displays/groups by "removable".

Is anybody really using that?

> 5. If "removable=false" then it usually really is not offlineable.
> Of course, there could also be races (free the last unmovable page),
> but it means "don't even try". OTOH, "removable=true" is more racy,
> and gives less guarantees. ("looks okay, feel free to try")

Yeah, but you could be already pessimistic and try movable zones before
other kernel zones.

> > Or does anybody see any reasonable usecase that would break if we did
> > that unconditional behavior?
> 
> If we would return always "true", then the whole reason the
> interface originally was introduced would be "broken" (meaning, less
> performant as you would try to offline any memory block).

I would argue that the whole interface is broken ;). Not the first time
in the kernel development history and not the last time either. What I
am trying to say here is that unless there are _real_ usecases depending
on knowing that something surely is _not_ offlineable then I would just
try to drop the functionality while preserving the interface and see
what happens.
-- 
Michal Hocko
SUSE Labs
