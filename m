Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A441E20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585204121;
	bh=vEC6cpzlCGeaaoUGPiblz9Ur0MvQS4I21AK+wjIDvYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5G/JMov1YWi4OGutQmEk4wlajhjL8OET6Yr7vXrjk6PSZQZxXVmNiQsLvzvIqGeF
	 pzG3JnKUf4G0MvejqJoKhN/QLAPLYAt4PZutmpQOr3hCLZHAKZF86qds0aX0rvO8qk
	 DgncLPZ2VkueD5qEIW0n4dzJQcbGyARR0s2uql3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCZG2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:28:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37846 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgCZG2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:28:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so2291311pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PA3/3R7GyDUnj2HGZlTnhj3P72eysdi3llJ4jAsE114=;
        b=gvNotwav6vxy1fS8i7s44J6g835MNY+ce2xziiZcWg18HmizwvWRm8wSXDLPxtQcNK
         2VhbnlGDYnfL3JGRNROSB0Z4J8tuZiNinK2rnv7MkWeYce5NMmqd9EcSqVFf+rNKxPDc
         nazvsgSyrsnLPrmI/FlISIjewiW5G5D8OycoHMKc2KbvvcYhXwznaiQ9b9104iq+8h21
         UQAW/WcRnJzKAzzDlvbUU/3djM1JqF043uP18sBFCCGrKgpvIrwNN1Vpa0h2sibK35Sv
         PHTyJqbgwLH+0yTOt1Wnsb4yMTEK+uvO1JATKwcNAItbynFDCUi4a9Fu1XsONM8Srqh8
         1mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PA3/3R7GyDUnj2HGZlTnhj3P72eysdi3llJ4jAsE114=;
        b=cxH/gl26BSS16rXcrY7JYevUtlBT479MBqH6qjTezB1U6uedMo5Sc0Wn0WGyHSudym
         a9EMtSGiLCvvKFnkylmO4ossbvepGnFcdoidSacLEheA43JskQTkG96cOhce3T/NJj07
         mUMs/R8zpGhX5cRA+aA+9xT2wYz/o+W7Q9TgCyBhS2PWBYD5JLCqmhzXj9pRbYZlpUYS
         WnzFr+P/Ss9ecoRMhinOLwrOt3teGMYs6PyUekh+YRXJTC3PeMo2czebf96QvIz7OXMw
         RqEcLAjh5n6fJH/uDFSqYogQCf8S9HHai0uvWLiOO7BzbsJ/mxQ6ZjKa035HvAmiej0S
         Sb2A==
X-Gm-Message-State: ANhLgQ3ae9zN7NTsHukYKMuhkqZptRu9qLfJmPohpPgnKD+lmOwdvpFS
        HoRluH1Su44/sGL6TJ/obts=
X-Google-Smtp-Source: ADFU+vvBsV97CVRYdqZMjD1zWrRk4aVNAbLDjYaqDMKpDSvB3zLPBRX8HMKXAC7cIL4RnzVjAFrftg==
X-Received: by 2002:a63:70e:: with SMTP id 14mr6900392pgh.290.1585204119223;
        Wed, 25 Mar 2020 23:28:39 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id y29sm805006pge.22.2020.03.25.23.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 23:28:37 -0700 (PDT)
Date:   Wed, 25 Mar 2020 23:28:35 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jannh@google.com,
        vbabka@suse.cz, dancol@google.com, joel@joelfernandes.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/2] mm/madvise: skip MADV_PAGEOUT on shared swap cache
 pages
Message-ID: <20200326062835.GB110624@google.com>
References: <20200323234147.558EBA81@viggo.jf.intel.com>
 <20200323234151.10AF5617@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323234151.10AF5617@viggo.jf.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:41:51PM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> MADV_PAGEOUT might interfere with other processes if it is
> allowed to reclaim pages shared with other processses.  A
> previous patch tried to avoid this for anonymous pages
> which were shared by a fork().  It did this by checking
> page_mapcount().
> 
> That works great for mapped pages.  But, it can not detect
> unmapped swap cache pages.  This has not been a problem,
> until the previous patch which added the ability for
> MADV_PAGEOUT to *find* swap cache pages.
> 
> A process doing MADV_PAGEOUT which finds an unmapped swap
> cache page and evicts it might interfere with another process
> which had the same page mapped.  But, such a page would have
> a page_mapcount() of 1 since the page is only actually mapped
> in the *other* process.  The page_mapcount() test would fail
> to detect the situation.
> 
> Thankfully, there is a reference count for swap entries.
> To fix this, simply consult both page_mapcount() and the swap
> reference count via page_swapcount().
> 
> I rigged up a little test program to try to create these
> situations.  Basically, if the parent "reader" RSS changes
> in response to MADV_PAGEOUT actions in the child, there is
> a problem.
> 
> 	https://www.sr71.net/~dave/intel/madv-pageout.c
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  b/mm/madvise.c |   37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff -puN mm/madvise.c~madv-pageout-ignore-shared-swap-cache mm/madvise.c
> --- a/mm/madvise.c~madv-pageout-ignore-shared-swap-cache	2020-03-23 16:30:52.022385888 -0700
> +++ b/mm/madvise.c	2020-03-23 16:41:15.448384333 -0700
> @@ -261,6 +261,7 @@ static struct page *pte_get_reclaim_page
>  {
>  	swp_entry_t entry;
>  	struct page *page;
> +	int nr_page_references = 0;

nit: just 'referenced' would be enough.

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks, Dave!

_
