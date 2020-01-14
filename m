Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FA3C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A71F24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="D8dS1CwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgANKlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:41:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37443 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANKlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:41:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id o13so13748775ljg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ciknfppj1LCOHQAPNZhrYGHRrM+p8c24oaVfpOlu9CU=;
        b=D8dS1CwRdv4R6AuTAzh6R3DnDJF22Y3FxbdHfLb2409DLsWz8gAfHlk428NSgrdgLO
         NjdxkwAKeY5Kur60odrJ+vowBJOF690oPx3CzOV13Zs42tu00UlKvGCJCf2bomxCsyLG
         AUibM1WEOWuvhj7akWItw2LSu31aihjZxdMs5UTLicQc1SiFHWAoOpdgVK0sBFHOPkQC
         9fdeHzmoVx2GUbE1NaI3qT8Z8EYUek5pEvW9cajGNwkU3X6SLvP/g2FWhbaRBsaazU0L
         fbSjgeECYGGRB01cbRFxqBuAai8OuSSU/9eRsTYVvsx1cHkrVVynNu6JekAACW6aZaE9
         qRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ciknfppj1LCOHQAPNZhrYGHRrM+p8c24oaVfpOlu9CU=;
        b=iZZp2vHKRmNB6QxI3kTrDfvRvqDYVd+wp4MmomljDnksK8BnXoMLN7/fFgQyLA8w6q
         GqSKvXvWn9hdKmFtvWZTW76yYqpuCaeG5r3/Y7dGXd3eSd1t6/cks2Zmvl679Jtqcni5
         S7dqedoSUmN21ziMeOhZ1NYkOSipqpNO7XMEGaE44lJxl6kde5A2hMxAZJEk2UbRydH8
         6HtwdUe5nTd8FyVL1++sfPw27oj1jINmDzN0OrGFt9iml/Y6JXfgAEzvBzZ6MgmosMv+
         ht3nFulH007rs0jaJG986m9Ny7SBIYjbJxo25kAsZEstv4LO45z05yKnGG3MawcAmzv4
         gg0A==
X-Gm-Message-State: APjAAAUQ12J9CJ6Ferm53e/6dx9o1t+qlfDiJfhcZt3vwVrDIFttcaN/
        nSrlaDCVGbhv0aDj9236+2g4bQ==
X-Google-Smtp-Source: APXvYqxWzh95I3QAQNvY5+6K/3YoTBogFK1CQsi8v8vBUONaYxTq4v11GUzTxzshYKjUICr3d5c7og==
X-Received: by 2002:a2e:8188:: with SMTP id e8mr12524747ljg.57.1578998475904;
        Tue, 14 Jan 2020 02:41:15 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r21sm7346380ljn.64.2020.01.14.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 02:41:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 496BF100823; Tue, 14 Jan 2020 13:41:19 +0300 (+03)
Date:   Tue, 14 Jan 2020 13:41:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1 2/2] mm: factor out next_present_section_nr()
Message-ID: <20200114104119.pybggnb4b2mq45wr@box>
References: <0B77E39C-BD38-4A61-AB28-3578B519952F@redhat.com>
 <C40ACB72-F8C7-4F9B-B3F3-00FBC0C44406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C40ACB72-F8C7-4F9B-B3F3-00FBC0C44406@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:02:00AM +0100, David Hildenbrand wrote:
> 
> 
> > Am 13.01.2020 um 23:57 schrieb David Hildenbrand <dhildenb@redhat.com>:
> > 
> > ﻿
> > 
> >>> Am 13.01.2020 um 23:41 schrieb Kirill A. Shutemov <kirill@shutemov.name>:
> >>> 
> >>> ﻿On Mon, Jan 13, 2020 at 03:40:35PM +0100, David Hildenbrand wrote:
> >>> Let's move it to the header and use the shorter variant from
> >>> mm/page_alloc.c (the original one will also check
> >>> "__highest_present_section_nr + 1", which is not necessary). While at it,
> >>> make the section_nr in next_pfn() const.
> >>> 
> >>> In next_pfn(), we now return section_nr_to_pfn(-1) instead of -1 once
> >>> we exceed __highest_present_section_nr, which doesn't make a difference in
> >>> the caller as it is big enough (>= all sane end_pfn).
> >>> 
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Michal Hocko <mhocko@kernel.org>
> >>> Cc: Oscar Salvador <osalvador@suse.de>
> >>> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>> include/linux/mmzone.h | 10 ++++++++++
> >>> mm/page_alloc.c        | 11 ++---------
> >>> mm/sparse.c            | 10 ----------
> >>> 3 files changed, 12 insertions(+), 19 deletions(-)
> >>> 
> >>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>> index c2bc309d1634..462f6873905a 100644
> >>> --- a/include/linux/mmzone.h
> >>> +++ b/include/linux/mmzone.h
> >>> @@ -1379,6 +1379,16 @@ static inline int pfn_present(unsigned long pfn)
> >>>   return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
> >>> }
> >>> 
> >>> +static inline unsigned long next_present_section_nr(unsigned long section_nr)
> >>> +{
> >>> +    while (++section_nr <= __highest_present_section_nr) {
> >>> +        if (present_section_nr(section_nr))
> >>> +            return section_nr;
> >>> +    }
> >>> +
> >>> +    return -1;
> >>> +}
> >>> +
> >>> /*
> >>> * These are _only_ used during initialisation, therefore they
> >>> * can use __initdata ...  They could have names to indicate
> >>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >>> index a92791512077..26e8044e9848 100644
> >>> --- a/mm/page_alloc.c
> >>> +++ b/mm/page_alloc.c
> >>> @@ -5852,18 +5852,11 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
> >>> /* Skip PFNs that belong to non-present sections */
> >>> static inline __meminit unsigned long next_pfn(unsigned long pfn)
> >>> {
> >>> -    unsigned long section_nr;
> >>> +    const unsigned long section_nr = pfn_to_section_nr(++pfn);
> >>> 
> >>> -    section_nr = pfn_to_section_nr(++pfn);
> >>>   if (present_section_nr(section_nr))
> >>>       return pfn;
> >>> -
> >>> -    while (++section_nr <= __highest_present_section_nr) {
> >>> -        if (present_section_nr(section_nr))
> >>> -            return section_nr_to_pfn(section_nr);
> >>> -    }
> >>> -
> >>> -    return -1;
> >>> +    return section_nr_to_pfn(next_present_section_nr(section_nr));
> >> 
> >> This changes behaviour in the corner case: if next_present_section_nr()
> >> returns -1, we call section_nr_to_pfn() for it. It's unlikely would give
> >> any valid pfn, but I can't say for sure for all archs. I guess the worst
> >> case scenrio would be endless loop over the same secitons/pfns.
> >> 
> >> Have you considered the case?
> > 
> > Yes, see the patch description. We return -1 << PFN_SECTION_SHIFT, so a number close to the end of the address space (0xfff...000). (Will double check tomorrow if any 32bit arch could be problematic here)
> 
> ... but thinking again, 0xfff... is certainly an invalid PFN, so this should work just fine.
> 
> (biggest possible pfn is -1 >> PFN_SHIFT)
> 
> But it‘s late in Germany, will double check tomorrow :)

If the end_pfn happens the be more than -1UL << PFN_SECTION_SHIFT we are
screwed: the pfn is invalid, next_present_section_nr() returns -1, the
next iterartion is on the same pfn and we have endless loop.

The question is whether we can prove end_pfn is always less than
-1UL << PFN_SECTION_SHIFT in any configuration of any arch.

It is not obvious for me.

-- 
 Kirill A. Shutemov
