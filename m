Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F8CC10F25
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A42146E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEFO+g1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgCJAp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:45:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43344 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgCJAp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:45:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id c144so5622104pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=26QsCB8W83s8I0/JuIlZZ4BURVVZW5a1bWPwo7lVEF8=;
        b=YEFO+g1Fryj2bQJ1ggse9nsi1GsB+dcble75kP3KrLOHB2uV1mhRnz3bbx8H0KXz0K
         hSmZYyyRhqMvE63wtsDTtiokcjRjaM5YMUez6F1TzKTSTJfJBEklrRSR6XJa1cak/XOO
         lV567K0ydDBlO23NRF98f4M2Eh3T2ETgN98JNKe9BGzBnHBkuSPxtcX2opWCzulaSxom
         u94se0Dd9DOJ7jGkafF62sKsj3YA92lGFL4gQO15+SURUjjSxFEFt8KeEyXNST4QNT2R
         UoeBxtNtfYMjxnwqViEHMXPsAnfW0vTmC/LBqGRMd1zQ2miSbcJNePX95apqglmRu8bs
         1M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=26QsCB8W83s8I0/JuIlZZ4BURVVZW5a1bWPwo7lVEF8=;
        b=ILxoUenP441Ihfig3tvnMfH+lh8te3Gf8w/Ceeki6emwbTyhjFGAHF18CduLITlKyI
         RCdArD1Cw0l9ChrE0nGIDyXqSEoH7fybrbnCuheKxRnPlq2Yw62L6K6NIOwstbt24TD9
         9N1gi39o5fnLRqUluwo20BE316KWYxG0ml410b8kC5qUnUUA1hd4dH1XqSNqWnxZpaVy
         CUb8SD8mjwK7+sbk3fwUP+sfw36F40fD8Q2svIWLeikw/4iNNaUBSdb9H+s21bj/HJ55
         X6wp3qSoG3TYk+v95qIOn4XuSUFOdCnXjyDJueWZkpraxr4EbT9pCDhTbUfvnLT8jU9d
         CM+Q==
X-Gm-Message-State: ANhLgQ0EOoovaeO4fb2F7sRoYIq+SiP4w4zMpKtCRiunthWG9qKIi8iL
        tNGihwWnFN58SwGfuvFM8T9fiw==
X-Google-Smtp-Source: ADFU+vuwuJ8ePui0lmm2cyIBXH4Y6kAbKWJ1cgus8VGl1+v9lo4BIUf7qJuZJuj9WNhaTzlkrNSTlQ==
X-Received: by 2002:a65:6495:: with SMTP id e21mr18198524pgv.420.1583801156413;
        Mon, 09 Mar 2020 17:45:56 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g7sm650857pjl.17.2020.03.09.17.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 17:45:55 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:45:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Hildenbrand <david@redhat.com>
cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] mm: Add PageLayzyFree() helper functions for
 MADV_FREE
In-Reply-To: <23076072-7875-cabf-768f-ce27cba3480d@redhat.com>
Message-ID: <alpine.DEB.2.21.2003091745340.156701@chino.kir.corp.google.com>
References: <20200309021744.1309482-1-ying.huang@intel.com> <68360241-eb18-b3d8-bf6f-4dbbed258ee6@redhat.com> <87r1y1yjll.fsf@yhuang-dev.intel.com> <23076072-7875-cabf-768f-ce27cba3480d@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020, David Hildenbrand wrote:

> >> I still prefer something like
> >>
> >> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >> index fd6d4670ccc3..7538501230bd 100644
> >> --- a/include/linux/page-flags.h
> >> +++ b/include/linux/page-flags.h
> >> @@ -63,6 +63,10 @@
> >>   * page_waitqueue(page) is a wait queue of all tasks waiting for the page
> >>   * to become unlocked.
> >>   *
> >> + * PG_swapbacked used with anonymous pages (PageAnon()) indicates that a
> >> + * page is backed by swap. Anonymous pages without PG_swapbacked are
> >> + * pages that can be lazily freed (e.g., MADV_FREE) on demand.
> >> + *
> >>   * PG_uptodate tells whether the page's contents is valid.  When a read
> >>   * completes, the page becomes uptodate, unless a disk I/O error happened.
> >>   *
> > 
> > Why not just send a formal patch?  So Andrew can just pick anything he
> > likes.  I am totally OK with that.
> 
> Because you're working on cleaning this up.
> 
> > 
> >> and really don't like the use of !__PageLazyFree() instead of PageSwapBacked().
> > 
> > If adopted, !__PageLazyFree() should only be used in the context where
> > we really want to check whether pages are freed lazily.  Otherwise,
> > PageSwapBacked() should be used.
> > 
> 
> Yeah, and once again, personally, I don't like this approach. E.g.,
> ClearPageLazyFree() sets PG_swapbacked. You already have to be aware
> that this is a single flag being used in the background and what the
> implications are. IMHO, in no way better than the current approach. I
> prefer better documentation instead.
> 

Fully agreed.
