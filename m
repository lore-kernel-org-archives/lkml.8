Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D79C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 01:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8917820823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 01:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sa30/haj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbgEXBCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388205AbgEXBCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 21:02:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E7C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 18:02:01 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 63so11303353oto.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lckzd2g6ev5WFX+2ZuARdb2/JkLKDhqzAV7nJO+L26I=;
        b=Sa30/hajgh4o4fS7KhKcL3pMuzRjCPFZmrsqanTMFbi5hIGIp3uII1LMtGUy+qUejR
         2MIoiTvizcNP7Ee5L3eHCMUalS+SBaSB4cpaK+9HI26GaajAdx0lXkLbPyF4pkUrJSyT
         9SksU9p8JTLTRpqZkfT/ZKzHvk4iy/x0ezhBBDJnYDFFnR3I1ir/HLSwnf2k3NxiACNN
         OirbxjmYWL9K/6RaZ28d6RZ/jBdHPOra/eFLGlboJdX5jand57BJS2KZAWflcTLJLOUS
         kFRXbzLAmdEWQ9+y6Nw/Ox7Rw+pEZrpgBq5TRuLkQzzWib/ZqoYrmF7VThh/3nHpKrUL
         j59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lckzd2g6ev5WFX+2ZuARdb2/JkLKDhqzAV7nJO+L26I=;
        b=RZcRLVNLMkuCxJ0XTKkbKzkrsvqA4xQMXynXZJt+101UhGS0nrzzs0X42FMomVNoPS
         ykfyrWYgfaQyu/PZwZamThk26DtvxoqArQKlT/wvpudw6TB9lWrT+qS3lVC9omIRkqg2
         a8Y1l51JumzXYjEjPvOB4Q/leZhgy5TLbEhREGCZD9VljnqVhTYpeATKs/YLX+vkUxms
         V+BArcr7OcMJlIOg/0F1zdnsLi38DMehTHJMBTuhT49Ubu640WsFveM+CK/dE4IESw8J
         glcAhuJPT/WseE0U+6h79KTAADfwKoNnuTUzhnCvGY+KkftU9JR+StLim27TZ0+moG7r
         zm0A==
X-Gm-Message-State: AOAM531N9Ev/dmyBu/ya0hqNK7rFtQAb3KZAvZ8w4AUCb1gLEr0bgZmo
        4isui0t614rg3aUPl10PNXsgxQ==
X-Google-Smtp-Source: ABdhPJzTd839/rUSHI/fjXEqjesjh3GE1l1gRFfkHcODzqv+YhweZe/NX7T9fwQYiowlp5LRhvbtjQ==
X-Received: by 2002:a9d:7a47:: with SMTP id z7mr16447449otm.3.1590282120704;
        Sat, 23 May 2020 18:02:00 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q68sm3761777ooa.29.2020.05.23.18.01.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 23 May 2020 18:01:59 -0700 (PDT)
Date:   Sat, 23 May 2020 18:01:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
In-Reply-To: <158937872515.474360.5066096871639561424.stgit@buzz>
Message-ID: <alpine.LSU.2.11.2005231650070.1171@eggly.anvils>
References: <158937872515.474360.5066096871639561424.stgit@buzz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020, Konstantin Khlebnikov wrote:

> Function isolate_migratepages_block() runs some checks out of lru_lock
> when choose pages for migration. After checking PageLRU() it checks extra
> page references by comparing page_count() and page_mapcount(). Between
> these two checks page could be removed from lru, freed and taken by slab.
> 
> As a result this race triggers VM_BUG_ON(PageSlab()) in page_mapcount().
> Race window is tiny. For certain workload this happens around once a year.

Around once a year, that was my guess too. I have no record of us ever
hitting this, but yes it could happen when you have CONFIG_DEBUG_VM=y
(which I too like to run with, but would not recommend for users).

> 
> 
>  page:ffffea0105ca9380 count:1 mapcount:0 mapping:ffff88ff7712c180 index:0x0 compound_mapcount: 0
>  flags: 0x500000000008100(slab|head)
>  raw: 0500000000008100 dead000000000100 dead000000000200 ffff88ff7712c180
>  raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
>  page dumped because: VM_BUG_ON_PAGE(PageSlab(page))
>  ------------[ cut here ]------------
>  kernel BUG at ./include/linux/mm.h:628!
>  invalid opcode: 0000 [#1] SMP NOPTI
>  CPU: 77 PID: 504 Comm: kcompactd1 Tainted: G        W         4.19.109-27 #1
>  Hardware name: Yandex T175-N41-Y3N/MY81-EX0-Y3N, BIOS R05 06/20/2019
>  RIP: 0010:isolate_migratepages_block+0x986/0x9b0
> 
> 
> To fix just opencode page_mapcount() in racy check for 0-order case and
> recheck carefully under lru_lock when page cannot escape from lru.
> 
> Also add checking extra references for file pages and swap cache.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 119d6d59dcc0 ("mm, compaction: avoid isolating pinned pages")

Not really, that commit was correct at the time it went in.

> Fixes: 1d148e218a0d ("mm: add VM_BUG_ON_PAGE() to page_mapcount()")

Exactly, that commit was well-intentioned, but did not allow for this
(admittedly very exceptional) usage.  How many developers actually
make the mistake of applying page_mapcount() to their slab pages?
None, I expect.  That VM_BUG_ON_PAGE() is there for documentation,
and could just be replaced by a comment - and Linus would be happy
with that.

> ---
>  mm/compaction.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 46f0fcc93081..91bb87fd9420 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -935,12 +935,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		}
>  
>  		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> +		 * Migration will fail if an page is pinned in memory,
>  		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * admittedly racy check simplest case for 0-order pages.
> +		 *
> +		 * Open code page_mapcount() to avoid VM_BUG_ON(PageSlab(page)).

But open coding page_mapcount() is not all that you did.  You have
(understandably) chosen to avoid calling page_mapping(page), but...

> +		 * Page could have extra reference from mapping or swap cache.
>  		 */
> -		if (!page_mapping(page) &&
> -		    page_count(page) > page_mapcount(page))
> +		if (!PageCompound(page) &&
> +		    page_count(page) > atomic_read(&page->_mapcount) + 1 +
> +				(!PageAnon(page) || PageSwapCache(page)))
>  			goto isolate_fail;

Isn't that test going to send all the file cache pages with buffer heads
in page->private, off to isolate_fail when they're actually great
candidates for migration?

Given that the actual bug spotted was with the VM_BUG_ON_PAGE(PageSlab),
and nobody has reported any crash from the use of page_mapping() there
(and we only need the test to be right most of the time: all of this 
knowingly racy, as you explain in other mail): I'd go for just replacing
the VM_BUG_ON_PAGE in page_mapcount() by a comment about this case.

But if you think developers are really in danger of coding page_mapcount()
on their slab pages, then you could add a _page_mapcount() to linux/mm.h,
which omits the VM_BUG_ON_PAGE, for use here only.

Then we wouldn't have to think so hard about the counting above!

>  
>  		/*
> @@ -975,6 +979,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  				low_pfn += compound_nr(page) - 1;
>  				goto isolate_fail;
>  			}
> +
> +			/* Recheck page extra references under lock */
> +			if (page_count(page) > page_mapcount(page) +
> +				    (!PageAnon(page) || PageSwapCache(page)))
> +				goto isolate_fail;

Well, that lru_lock (and the intervening PageLRU check after getting it)
may restrict PageAnon and PageSwapCache transitions to some extent, but
it certainly has no effect on page_count and page_mapcount: so I think
such an additional check here is rather superfluous, and we should just
rely on the final checks in migrate_page_move_mapping(), as before.

>  		}
>  
>  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
