Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F916C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA4A20829
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Rn5qthIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgIDO0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgIDOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:25:45 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BACC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 07:25:40 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so6321803edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyk7CHt5bTCTjZ7EhyIfL9NYG87K4gl68GKaA7iV2V8=;
        b=Rn5qthIaDvzwFjhhXEEk9a0ckRXKPetzFqHyFCMSmJ8zIntPq6DN7Qn7EtPUyngR88
         P37FqKENw04smcg+k9HBl5GLKyWbcT/iAUwsfDhYSu7W7AtDe1TZun8rfsn8cG+bt5sv
         1i7gjuvUAy1R2X4bP9OfI81neqhAnC0xzBFiwUWDP24/RsAmAv1JbpEaRiGfgotjcXSj
         xR4WwaDN/ER7jmjn/h7goGDrIZPJyaY/dpwrNAz+mBp4B5YtxP3NgUn2ryJydxuq23Lz
         NgKdCMrPRcpkychU0PnC3S9UTrm6aDG7cE287ILgfjMDaZBy1AGTqyZhsUhxKyWnGapx
         BsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyk7CHt5bTCTjZ7EhyIfL9NYG87K4gl68GKaA7iV2V8=;
        b=A67hee8WgQz9IOiRZetzw5EMAIAfrGwZNpG7JbVCthY2KyrPWTDjoidpGNjH4qWC/t
         LNktWYRCngdug/dC24d6b/GCjnNXx/npQGtWMeJ3ift4k520MknD9AhbMKHRQu4AyRW+
         VImXzWBXxcP/KQxpUQtzTuySW4AG9jmll7hBc4x8kHM9T1LgmIjPCV69CmjOeMuGsd1v
         pKlm+7d1W8ZtIxG5pFUI462+d0Y+CLNw/UqeyOiBBdoriFINce/8zfS0otbxhy6sBn0v
         x7ZEBAriF6UTLvhdGlWWWtIYVWw80F5pPp+f//nB/J6rRPEDxln+mftKna0s4eaw9+QZ
         AChg==
X-Gm-Message-State: AOAM531JNhPTNphAhQ35yDh0NMSepolctYkTXxBveUF/o5Db5dlez0Is
        IPuUFaf4FQ3OQSXJhkbTX8k9ohpTGSCQUBRftRcVdw==
X-Google-Smtp-Source: ABdhPJysfnaP8HEjzDvtjD+Y2aV+Obj8YyKPtfutRyAPfLvQQAnyIsL4ylug10Xad5ayI7NRXdv4tos0CdWBQRLsepY=
X-Received: by 2002:a05:6402:1544:: with SMTP id p4mr8572340edx.346.1599229538615;
 Fri, 04 Sep 2020 07:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz> <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz> <20200902151306.GL4617@dhcp22.suse.cz>
 <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz> <20200903063806.GM4617@dhcp22.suse.cz>
 <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com> <CA+CK2bBTfmhTWNRrxnVKi=iknqq-iZxNZSnwNA9C9tWAJzRxmw@mail.gmail.com>
 <d89510b1-a6a2-a874-7ffc-ba7a37d4212d@redhat.com> <20200904070235.GA15277@dhcp22.suse.cz>
In-Reply-To: <20200904070235.GA15277@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Sep 2020 10:25:02 -0400
Message-ID: <CA+CK2bDON8A5AmKqPFWOytP-B29U-YAc9maQAvV-oGffaek6Yg@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Another alternative would be to enable/disable static branch only from
> users who really care but this is quite tricky because how do you tell
> you need or not? It seems that alloc_contig_range would be just fine
> with a weaker semantic because it would "only" to a spurious failure.
> Memory hotplug on the other hand really needs to have a point where
> nobody interferes with the offlined memory so it could ask for a
> stronger semantic.
>
> Yet another option would be to make draining stronger and actually
> guarantee there are no in-flight pages to be freed to the pcp list.
> One way would be to tweak pcp->high and implement a strong barrier
> (IPI?) to sync with all CPUs. Quite expensive, especially when there are
> many draining requests (read cma users because hotplug doesn't really
> matter much as it happens seldom).
>
> So no nice&cheap solution I can think of...

I think start_isolate_page_range() should not be doing page draining
at all. It should isolate ranges, meaning set appropriate flags, but
draining should be performed by the users when appropriate: next to
lru_add_drain_all() calls both in CMA and hotplug.
Currently, the way start_isolate_page_range() drains pages is very
inefficient. It calls drain_all_pages() for every valid page block,
which is a slow call as it starts a thread per cpu, and waits for
those threads to finish before returning.

We could optimize by moving the drain_all_pages() calls from
set_migratetype_isolate() to start_isolate_page_range() and call it
once for every different zone, but both current users of this
interface guarantee that all pfns [start_pfn, end_pfn] are within the
same zone, and I think we should keep it this way, so again the extra
traversal is going to be overhead overhead.

This way we will have on average only a single drain per hot-remove
(instead of one per block), and also it is going to be symmetric only
in one place. Faster hot-remove and cma alloc, and no race, imo
win-win.

Pasha
