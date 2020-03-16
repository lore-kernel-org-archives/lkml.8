Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F00C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3746D2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="w8j9Cvld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgCPQMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:12:15 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:44914 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbgCPQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:12:14 -0400
Received: by mail-qt1-f169.google.com with SMTP id h16so14647804qtr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dey7Nfe81uVrTNj3sIdJJjvqn+aY0k6NabLHjTXVQgc=;
        b=w8j9CvldLZ2D7h6Ij54OQbDHCt4dvW1qlF2jFOU6bKJC+FWYhlg4pTSX2slDSgpvaY
         v78RUSDf9i+oNhlrhP0t1jL20swq1QNObDXZgS27P0G87/LXhxi6DXwEkiLexmjT+qrz
         lFyhVr0W8yXnSMKFS4O/g1Fufe6olDpN5SGzmT3Nbgg3mG2iSNUSflfnduUKv1qDduuD
         Djsge/vuQ7qKZxohkayCmlUM209dzagcpISs2anbZ4Z5/juz+ipkV0+ORpBdJPNBTo6O
         60Z6lguM1f39zHp3lQWFG2BTu4UPgpXXYVJeSD+N5dhyHDBIcK3iaDnSoRhiYb5frEOg
         FAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dey7Nfe81uVrTNj3sIdJJjvqn+aY0k6NabLHjTXVQgc=;
        b=EZnxXDaKiN67D4aDi42777CNpK5UnZJ2AFntzNeMwEe7U6lxVaHazzI+0ykCXLEoR7
         rY/weo/N7uqkWyzPf85//qvVqfO8hmxGK84Z0tUoaqgcprDx3P1XSBQ3hLPguEXC6243
         lgqbucZPjiWYifwovIwi9NXSq16XIEQcUKtcJ6nbUT+5Np+VIthy+ybs6N3IJLocWZLV
         OSxOLiyNCWuvCKwL+8HfEHTS6BYwX+KjzO+oghNHR2s1zDzMoU8qCXgaCXaYgP9ii2Sy
         mlZyB0mHemhRqXaLO5n+TSqryxm1xtbjrgFwOjRktWAJbQB0MIyZJUzSZpLIVt+uNjOp
         jCZQ==
X-Gm-Message-State: ANhLgQ3v9/2dwjCb0pDVrT88YuGK59sS6tpsq56eXyQRc0GzT5qqQOeV
        wOpCNXFk6cMdhbV2x3tIUKVKE2uiXlo=
X-Google-Smtp-Source: ADFU+vtkMxGQKCmWB2/JNmoCNAEOloHf3syOC+7yPP+yULjcDrHJba/ilgc3LIO7BVd33CSzKVEpXQ==
X-Received: by 2002:aed:2284:: with SMTP id p4mr763287qtc.329.1584375130425;
        Mon, 16 Mar 2020 09:12:10 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u51sm105580qth.46.2020.03.16.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:12:09 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:12:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 2/9] mm/vmscan: protect the workingset on anonymous LRU
Message-ID: <20200316161208.GB67986@cmpxchg.org>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1582175513-22601-3-git-send-email-iamjoonsoo.kim@lge.com>
 <20200312151423.GH29835@cmpxchg.org>
 <CAAmzW4Mpm6PyZp1jXUo__S-OZ2=MKPuyTA+gpL0X8cW+H0ps4Q@mail.gmail.com>
 <20200313195510.GA67986@cmpxchg.org>
 <CAAmzW4PgTeRsr6jZZpvgb85e1xVBa8g17kvVFQGm7=WPXwHK_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4PgTeRsr6jZZpvgb85e1xVBa8g17kvVFQGm7=WPXwHK_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:05:30PM +0900, Joonsoo Kim wrote:
> 2020년 3월 14일 (토) 오전 4:55, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> > The problem with executables is that when they are referenced, they
> > get a *lot* of references compared to data pages. Think about an
> > instruction stream and how many of those instructions result in data
> > references. So when you see an executable page that is being accessed,
> > it's likely being accessed at a high rate. They're much hotter, and
> > that's why reference bits from VM_EXEC mappings carry more weight.
> 
> Sound reasonable.
> 
> But, now, I have another thought about it. I think that the root of the reason
> of this check is that there are two different reference tracking models
> on file LRU. If we assume that all file pages are mapped ones, this special
> check isn't needed. If executable pages are accessed more frequently than
> others, reference can be found more for them at LRU cycle. No need for this
> special check.
> 
> However, file pages includes syscall-ed pages and mapped pages, and,
> reference tracking models for mapped page has a disadvantage to
> one for syscall-ed page. Several references for mapped page would be
> considered as one at LRU cycle. I think that this check is to mitigate
> this disadvantage, at least, for executable file mapped page.

Hm, I don't quite understand this reasoning. Yes, there are two models
for unmapped and mapped file pages. But both types of pages get
activated with two or more references: for unmapped it's tracked
through mark_page_accessed(), and for mapped it's the two LRU cycles
with the referenced bit set (unmapped pages don't get that extra trip
around the LRU with one reference). With that alone, mapped pages and
unmapped pages should have equal chances, no?

> > IMO this applies to executable file and anon equally.
> 
> anon LRU consist of all mapped pages, so, IMHO,  there is no need for
> special handling for executable pages on anon LRU. Although reference
> is just checked at LRU cycle, it would correctly approximate reference
> frequency.
> 
> Moreover, there is one comment in shrink_active_list() that explains one
> reason about omission of this check for anon pages.
> 
> "Anon pages are not likely to be evicted by use-once streaming IO, plus JVM
> can create lots of anon VM_EXEC pages, so we ignore them here."
>
> Lastly, as I said before, at least, it is done separately with appropriate
> investigation.

You do have a point here, though.

The VM_EXEC protection is a heuristic that I think was added for one
specific case. Instead of adopting it straight-away for anon pages, it
may be good to wait until a usecase materializes. If it never does,
all the better - one less heuristic to carry around.

> Now, I plan to make a next version applied all your comments except
> VM_EXEC case. As I said above, fundamental difference between
> file mapped page and anon mapped page is that file LRU where file mapped
> pages are managed uses two reference tracking model but anon LRU uses
> just one. File LRU needs some heuristic to adjust the difference of two models,
> but, anon LRU doesn't need at all. And, I think VM_EXEC check is for this case.
> 
> Please let me know your opinion about VM_EXEC case. I will start to rework
> if you agree with my thought.

That sounds like a good plan. I'm looking forward to the next version!

Johannes
