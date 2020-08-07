Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E813C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28E122D2A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0nstuNHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgHGOyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgHGOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:54:03 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72BC061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 07:54:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x24so1132481lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 07:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EhqPU9vWVpaA19B5hOI3DtxeE4J1DHZLeRH6HorTN2k=;
        b=0nstuNHhYMgfY/orfSpzHFq9xSMghGYwKNvoqpHTmlGuf1+bvwhkdREx5aAzdsYv6W
         +P2x/mL5pILuLdrOIfRZgGIhLMFG5BjuL1QwYaJxTxY57Vi5wxbi/JGCMRfGlHFg3Nw6
         3TNC7cZobl3BLJNkDcgPHNVuqPI8ZrXKIeWD2qZEweHzOIvVS4k8xBFtNDQa9jJtEVOz
         pSOQs27jLzd83asI5InZ6ktWNNzFZzbuepa13q4TZ3M2oMZXYjLZEYK0A16NBrxtaoy3
         cs/FgaM8+sCnB44MvVLiPCq5qX+imgGMMjEjVD7v4TxNJ7hhToOnxIyvKSPn2ffMAa0O
         uhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EhqPU9vWVpaA19B5hOI3DtxeE4J1DHZLeRH6HorTN2k=;
        b=MhKZPYXYXaefiVr1TPUGPMQJbueoxNdzqRLJ9gsjTfUaMiIearfPggFMiA9OUShnr7
         CQyjDda0Gs0vzaVQ8pED4V3TlNvwRjMMdhahQwvZX4TEVA3wv3HnjuDYbPa7QMxdNdng
         1IF9sLLjtgkI3D4T0zkAKkW64hxEjJofEh4iejiOBSn1MsJ+4C/JzdiHni7vtoQFgRXO
         mCh4926FoDEfwXdBGaOtRBV5B1Ts/gK+gZexZzf7RCC8sENVIvyI+fyga4NuQnmUZeA2
         uxeQOu8gaRmMJ8hTEoX/iL5EPdlapDnnu+/o8zEHvTAlYKdpEey5pYRomVeIW1aBBgIo
         78CQ==
X-Gm-Message-State: AOAM532nwUcui5rAcBJPgsCZYdN4NZTk4n2NuU9sEVy7UnGkj7d8bHJ4
        FtHB68iemFqdhIFlvJmweMfW2ukCBi4=
X-Google-Smtp-Source: ABdhPJz0PaGBgHUnaHhHDhvMK0ArvOeo4nmIZjUqx2Ip48fnzdNpgeNV9kmE1uUfcXQxBd/hK71dSw==
X-Received: by 2002:a19:fc14:: with SMTP id a20mr6658335lfi.0.1596812039975;
        Fri, 07 Aug 2020 07:53:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s2sm4340929lfs.4.2020.08.07.07.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 07:53:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 33495102FA7; Fri,  7 Aug 2020 17:53:59 +0300 (+03)
Date:   Fri, 7 Aug 2020 17:53:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        cai@lca.pw, rppt@linux.ibm.com, william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
Message-ID: <20200807145359.oxwzjkhv5pqinam5@box>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
 <20200806134851.GN23808@casper.infradead.org>
 <790ae9a4-6874-ac34-d2a2-28a2137335cb@suse.cz>
 <20200806153938.GO23808@casper.infradead.org>
 <da00f435-a867-0108-8855-872019d85d44@suse.cz>
 <20200806171500.GA17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806171500.GA17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:15:00PM +0100, Matthew Wilcox wrote:
> On Thu, Aug 06, 2020 at 05:53:10PM +0200, Vlastimil Babka wrote:
> > On 8/6/20 5:39 PM, Matthew Wilcox wrote:
> > >> >> +++ b/mm/huge_memory.c
> > >> >> @@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
> > >> >>  	 * Set PG_double_map before dropping compound_mapcount to avoid
> > >> >>  	 * false-negative page_mapped().
> > >> >>  	 */
> > >> >> -	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> > >> >> +	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> > >> > 
> > >> > I'm a little nervous about this one.  The page does actually come from
> > >> > pmd_page(), and today that's guaranteed to be a head page.  But I'm
> > >> > not convinced that's going to still be true in twenty years.  With the
> > >> > current THP patchset, I won't allocate pages larger than PMD order, but
> > >> > I can see there being interest in tracking pages in chunks larger than
> > >> > 2MB in the future.  And then pmd_page() might well return a tail page.
> > >> > So it might be a good idea to not convert this one.
> > >> 
> > >> Hmm the function converts the compound mapcount of the whole page to a
> > >> HPAGE_PMD_NR of base pages. If suddenly the compound page was bigger than a pmd,
> > >> then I guess this wouldn't work properly anymore without changes anyway?
> > >> Maybe we could stick something like VM_BUG_ON(PageTransHuge(page)) there as
> > >> "enforced documentation" for now?
> > > 
> > > I think it would work as-is.  But also I may have totally misunderstood it.
> > > I'll write this declaratively and specifically for x86 (PMD order is 9)
> > > ... tell me when I've made a mistake ;-)
> > > 
> > > This function is for splitting the PMD.  We're leaving the underlying
> > > page intact and just changing the page table.  So if, say, we have an
> > > underlying 4MB page (and maybe the pages are mapped as PMDs in this
> > > process), we might get subpage number 512 of this order-10 page.  We'd
> > > need to check the DoubleMap bit on subpage 1, and the compound_mapcount
> > > also stored in page 1, but we'd only want to spread the mapcount out
> > > over the 512 subpages from 512-1023; we wouldn't want to spread it out
> > > over 0-511 because they aren't affected by this particular PMD.
> > 
> > Yeah, and then we decrease the compound mapcount, which is a counter of "how
> > many times is this compound page mapped as a whole". But we only removed (the
> > second) half of the compound mapping, so imho that would be wrong?
> 
> I'd expect that count to be incremented by 1 for each PMD that it's
> mapped to?  ie change the definition of that counter slightly.
> 
> > > Having to reason about stuff like this is why I limited the THP code to
> > > stop at PMD order ... I don't want to make my life even more complicated
> > > than I have to!
> > 
> > Kirill might correct me but I'd expect the THP code right now has baked in many
> > assumptions about THP pages being exactly HPAGE_PMD_ORDER large?

That will be true for PMD-mapped THP pages after applying Matthew's
patchset.

> There are somewhat fewer places that make that assumption after applying
> the ~80 patches here ... http://git.infradead.org/users/willy/pagecache.git

The patchset allows for THP to be anywhere between order-2 and
order-9 (on x86-64).

> I have mostly not touched the anonymous THPs (obviously some of the code
> paths are shared), although both Kirill & I think there's a win to be
> had there too.

Yeah. Reducing LRU handling overhead alone should be enough to justify the
effort. But we still would need to have numbers.

-- 
 Kirill A. Shutemov
