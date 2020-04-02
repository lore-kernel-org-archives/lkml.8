Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0590FC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9C92074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="LhmJEj2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbgDBPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:14:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45326 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388813AbgDBPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:14:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id o18so1437369qko.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6V8MAk4CYER6oFWyosg5mJivoo0UdSsXpVob3p2WcUA=;
        b=LhmJEj2+GFCFSn734TVbt4q8S+EnMVyq+aGwTZxgIJ7rMCzKGPFaOXro2rI/R8Jca4
         xl5Lwphom5321zVvWuEqXxgsEqfCPgoU8+W40FM/m1KzHWFXOZFqZwAPVS5ArHoA0rt/
         HGV4UHzmjo7hyT25K0DhY6eqidbUfdC+5glHUc8fDMfO2v9Iiyi0wqVj+ZL2nc2kL7WO
         6S56NiRMmYvYL/lL02BDY8yTQtB0TZ9ZkqwTRHQNbXwcLTQNz+OvNTeg/yTDw+hJp/Le
         NJAz7e8i6Vrh4BiFxPWH03E4c17X4kD3msqGzZHxe1zBhSzlazbubV+eMxQI25Dxxvuv
         16uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6V8MAk4CYER6oFWyosg5mJivoo0UdSsXpVob3p2WcUA=;
        b=oa0s11K7HnVMPJmxlUFUDEn7vit+qq6EO8qoM3baPkrolthCBPLvsCTBYP60A8uqj6
         tMsvh4Uq1V/hyqj/p8PKAxYXzmAsi0zTCFSQdWEkW9Bl8LOZ/KdTBY5H9IEDfQ0fHK/M
         ILagh9RBMXUN8weeiYkRp1dhz6rX7YnVOoGdNNkn1KjTNvdSK0l+2Ile4lgBC7YUy9g5
         hvskU50VJGjlF0dYlQe/H4EZERnd4BDfYG8Zg75/YR2ybAD9VrlMzNFmljtcBoy98zXN
         N8UiKQOoqVpl98W+o57GsEpdqdy7CCUKr4yyM3cRCUIXQbHtxgbyt8+4/Zi3p91gnBqr
         XHXg==
X-Gm-Message-State: AGi0PuYiZtfgOY78RiAe+rtM6kh8mD5Fp2v/t3OVXgyOJYT24WwtMnTw
        CC37DtrHeYlBtbdPWJAzX1wRUw==
X-Google-Smtp-Source: APiQypKPkLo7ddzwHeHCVfkAO70BWQ9FTcD4R/8meF875/CrwJY2zZWMhqG6DvbGAW5qAqDry8qRLA==
X-Received: by 2002:a37:d244:: with SMTP id f65mr4075727qkj.373.1585840454760;
        Thu, 02 Apr 2020 08:14:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::11c9])
        by smtp.gmail.com with ESMTPSA id 124sm3765499qkl.31.2020.04.02.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:14:14 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:14:13 -0400
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
Subject: Re: [PATCH v4 6/8] mm/swap: implement workingset detection for
 anonymous LRU
Message-ID: <20200402151413.GC2089@cmpxchg.org>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-7-git-send-email-iamjoonsoo.kim@lge.com>
 <20200323171744.GD204561@cmpxchg.org>
 <CAAmzW4OCofhyOX8-5yrMhUrP-ncUQ_JGzZuNp76GWtqef9DpjQ@mail.gmail.com>
 <CAAmzW4OGThMZk2sRrboZt6nx82CiphKVFpxLGaXFXLB7WYfd3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4OGThMZk2sRrboZt6nx82CiphKVFpxLGaXFXLB7WYfd3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:50:28PM +0900, Joonsoo Kim wrote:
> 2020년 3월 24일 (화) 오후 3:25, Joonsoo Kim <js1304@gmail.com>님이 작성:
> > The problem looks not that easy. Hmm...
> >
> > In current code, there is a large time gap between the shadow entries
> > are poped up and the page is charged to the memcg, especially,
> > for readahead-ed pages. We cannot maintain the shadow entries of
> > the readahead-ed pages until the pages are charged.
> >
> > My plan to solve this problem is propagating the charged mm to
> > __read_swap_cache_async(), like as file cache, charging when
> > the page is added on to the swap cache and calling workingset_refault()
> > there. Charging will only occur if:
> >
> > 1. faulted page
> > 2. readahead-ed page with the shadow entry for the same memcg
> >
> > Also, readahead only happens when shadow entry's memcg is the same
> > with the charged memcg. If not the same, it's mostly not ours so
> > readahead isn't needed.
> >
> > Please let me know how you think of the feasibility of this idea.
> 
> Hello, Johannes.
> 
> Could you let me know your opinion about the idea above?
> In fact, since your reply is delayed, I completed the solution about the
> above idea. If you want, I will submit it first. Then, we could discuss
> the solution more easily.

It's probably easiest if you send out your implementation and we
discuss it over the code.

Thanks!
