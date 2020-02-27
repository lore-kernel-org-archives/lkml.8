Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C5DC34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44ED2468F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="l8/0wecZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgB0OoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:44:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36443 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbgB0NsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id f3so3147308qkh.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gd7SzCH0Y53mfN+8nDt/akmk+wPgbeU2gPKEM6406QE=;
        b=l8/0wecZUrPy4qn64vPqTvmCnSFsytJpDahlldno9sHr7Vzm/KRgoiXjlCSqL0zKRH
         iDs1opn7lLwsMSJr5nQxpGmolXWzegiYkknBGHkkMqF4gvHvmW0VtNX3ke5pPpGPDAoL
         FUO//W6bmL1+8OlsQxqmUjMu2ppsdAC26B1KP48zFlxPEh6njwAiIiZjjFfqtsiyt4QO
         ha7gaAcGCgJOjl2nNLb0fluFBOpFd+440yHwY3/uz1yNg07YFz1/Oc63eqJzJG6LqmBV
         VFmxjTJssdgspc30YR8CaQYtLb/MnYo0rtEhratYPp1oipGj0tpDsBm5t67y/1U+XuBn
         yHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gd7SzCH0Y53mfN+8nDt/akmk+wPgbeU2gPKEM6406QE=;
        b=QMLIXZEU2Zq4NOq0G7FzH14EH2BuzX0emkHrP4eRp03ejYG2qwym/szZmvVl+KdfYT
         vTzux83HRCMf2AgdjI6g0tRk+lHWusTEzr+jGiby0QRLTlUXQ0SLGzxKqDeaoazExXWF
         nfI0RZrFFyg6a9VPXhOoWMiUYWSmkrYw2KOrmxSbGOigfZ8oFMLz9zguMsRp8Mbt6tan
         4YknJcf2tboe24swHSSFFQkLhI51I6GuIe9hwkpaH/37h+pl/OOM+wCdCCRMQ5RHlwWv
         WCu0edE+Z319UTd/1vJ95MvZObgi8DG9IDAwXw4lWLmu38Nyydh6pX/+5eDjo5KlVxqH
         MsUg==
X-Gm-Message-State: APjAAAVovKTX6v1HLsABjznUV77zsRqkNuEkKlMfLz0RF7HNv9tenUQR
        NNTvMycpGaqau8FgPdLJymZngg==
X-Google-Smtp-Source: APXvYqxEInE9QJTJeApSvrQy8nbO2rR2GV3M51/1s9gxI8qF3u18H/D/oDUoV2CDkRZGOsiQRosyBg==
X-Received: by 2002:ae9:d887:: with SMTP id u129mr5666875qkf.357.1582811288534;
        Thu, 27 Feb 2020 05:48:08 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id t37sm3264299qth.0.2020.02.27.05.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:48:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 08:48:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     js1304@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200227134806.GC39625@cmpxchg.org>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> On Thu, 20 Feb 2020 14:11:44 +0900 js1304@gmail.com wrote:
> 
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > Hello,
> > 
> > This patchset implements workingset protection and detection on
> > the anonymous LRU list.
> 
> The test robot measurement got my attention!
> 
> http://lkml.kernel.org/r/20200227022905.GH6548@shao2-debian
> 
> > * Changes on v2
> > - fix a critical bug that uses out of index lru list in
> > workingset_refault()
> > - fix a bug that reuses the rotate value for previous page
> > 
> > * SUBJECT
> > workingset protection
> > 
> > * PROBLEM
> > In current implementation, newly created or swap-in anonymous page is
> > started on the active list. Growing the active list results in rebalancing
> > active/inactive list so old pages on the active list are demoted to the
> > inactive list. Hence, hot page on the active list isn't protected at all.
> > 
> > Following is an example of this situation.
> > 
> > Assume that 50 hot pages on active list and system can contain total
> > 100 pages. Numbers denote the number of pages on active/inactive
> > list (active | inactive). (h) stands for hot pages and (uo) stands for
> > used-once pages.
> > 
> > 1. 50 hot pages on active list
> > 50(h) | 0
> > 
> > 2. workload: 50 newly created (used-once) pages
> > 50(uo) | 50(h)
> > 
> > 3. workload: another 50 newly created (used-once) pages
> > 50(uo) | 50(uo), swap-out 50(h)
> > 
> > As we can see, hot pages are swapped-out and it would cause swap-in later.
> > 
> > * SOLUTION
> > Since this is what we want to avoid, this patchset implements workingset
> > protection. Like as the file LRU list, newly created or swap-in anonymous
> > page is started on the inactive list. Also, like as the file LRU list,
> > if enough reference happens, the page will be promoted. This simple
> > modification changes the above example as following.
> 
> One wonders why on earth we weren't doing these things in the first
> place?
>
> > * SUBJECT
> > workingset detection
> 
> It sounds like the above simple aging changes provide most of the
> improvement, and that the workingset changes are less beneficial and a
> bit more risky/speculative?
> 
> If so, would it be best for us to concentrate on the aging changes
> first, let that settle in and spread out and then turn attention to the
> workingset changes?

Those two patches work well for some workloads (like the benchmark),
but not for others. The full patchset makes sure both types work well.

Specifically, the existing aging strategy for anon assumes that most
anon pages allocated are hot. That's why they all start active and we
then do second-chance with the small inactive LRU to filter out the
few cold ones to swap out. This is true for many common workloads.

The benchmark creates a larger-than-memory set of anon pages with a
flat access profile - to the VM a flood of one-off pages. Joonsoo's
first two patches allow the VM to usher those pages in and out of
memory very quickly, which explains the throughput boost. But it comes
at the cost of reducing space available to hot anon pages, which will
regress others.

Joonsoo's full patchset makes the VM support both types of workloads
well: by putting everything on the inactive list first, one-off pages
can move through the system without disturbing the hot pages. And by
supplementing the inactive list with non-resident information, he can
keep it tiny without the risk of one-off pages drowning out new hot
pages. He can retain today's level of active page protection and
detection, while allowing one-off pages to move through quickly.
