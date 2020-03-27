Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E54C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ED620663
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585291372;
	bh=sUTlTK/2MwlAYRYzqrRAmiPP3DebP7QM3ekTY0xHMDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vqaLGPQUtR3cLQEaguSl6Ab0jATdJQu1PJF4regUpx84bozmYozTmHn8rZ2NAPFyh
	 E8ZxFzuN8p/0tsF7Igzf02bboJX8skaM3zO+GoWqWYgVgu5pCRq4ZPlJPhk8h8KL+K
	 F9ZRoZ2HkrvtSUUCxy0ZMzxNzN+iIZCCCHAXRHXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0Gmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:42:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42473 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgC0Gmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:42:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id 22so4038498pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PkRhNpOnvQxE4pcW0f7SvrEzU2zD1AjbAVIx6bUtn3U=;
        b=I+jugDkD/0uYJp5TsLj8ZjaQaKfAXcIk/9AtNNywqV9Fnur/jkEWaizBtIOBOILncX
         sO3CDinbfo0H3o95U8I4zZdajcktuG3SbgUibKjaaN13sLnOrqDvEumUnR7O0mtYNUZK
         6m+NK5kUVpjex5YDFh+xLmkrOijXkqkYRHabKjAeFzOWEjsndp0wr/ZjK08TJTRFyt87
         GoTRWsrap0prqFTLjp9rs3XA7n8LCXBJ7oSEbboax3ye6rmXFodcvCWx/gdtQTqdepgI
         y/N1EjDbGMbNWXCbQqowLGPEUm6jTkpImbCObCNrpYe2sO3aVlv1iK36/W3TCYMJNLn4
         msoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkRhNpOnvQxE4pcW0f7SvrEzU2zD1AjbAVIx6bUtn3U=;
        b=KMMakEMYoLWY50QA863rFkumQQA9Ql/MrUFb0iBBlE2mJ9TG6Ey5Z8a8r8d2Lab5WS
         aTTDXnE/sCxa1gjLe+5EWDCJL9JERD+lvu4ork1LM8RXxOKzRl6RVlM4iONN/YxfTQCz
         b7aZMvFh9pDHoNOrjWpFwZqiZ7qufDulCvf7jmJOEHXHSgP+PXr/5STihUpKM+5l6wPI
         1acxvHe0Qgc5nuC8kVZDo7PQzkDX0hYWxlRii5HPbAd1Fj51qqLDf15GPtbH9VE8iFa1
         fSl/0dh7DgIdzGd+aoqVSffLsTFOEOPXvBicJBRNQdyB/Evaz3++37lq6En2eAszv55x
         aSCQ==
X-Gm-Message-State: ANhLgQ3Cr4n6bT2KPlEiuov64tMibPn0PZgJ3PX7U0MLn0WspKaF63Gy
        1KbYUekM2cVcp6G3iR5fUVA=
X-Google-Smtp-Source: ADFU+vsrSI/RocIqDqStiTUViRqfB9qAOl0R+thh0DYqBDxTR/dCUQJHLmYKdmvGv9NvzRmkbEFpIg==
X-Received: by 2002:a65:64cb:: with SMTP id t11mr11375064pgv.62.1585291368211;
        Thu, 26 Mar 2020 23:42:48 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::50e3])
        by smtp.gmail.com with ESMTPSA id g81sm3266786pfb.188.2020.03.26.23.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 23:42:46 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:42:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, mhocko@suse.com, jannh@google.com,
        vbabka@suse.cz, dancol@google.com, joel@joelfernandes.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/2] mm/madvise: skip MADV_PAGEOUT on shared swap cache
 pages
Message-ID: <20200327064244.GA80572@google.com>
References: <20200323234147.558EBA81@viggo.jf.intel.com>
 <20200323234151.10AF5617@viggo.jf.intel.com>
 <20200326062835.GB110624@google.com>
 <23ed6b05-3dd4-5683-a1d3-57d67a180c77@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ed6b05-3dd4-5683-a1d3-57d67a180c77@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:00:09PM -0700, Dave Hansen wrote:
> On 3/25/20 11:28 PM, Minchan Kim wrote:
> >> diff -puN mm/madvise.c~madv-pageout-ignore-shared-swap-cache mm/madvise.c
> >> --- a/mm/madvise.c~madv-pageout-ignore-shared-swap-cache	2020-03-23 16:30:52.022385888 -0700
> >> +++ b/mm/madvise.c	2020-03-23 16:41:15.448384333 -0700
> >> @@ -261,6 +261,7 @@ static struct page *pte_get_reclaim_page
> >>  {
> >>  	swp_entry_t entry;
> >>  	struct page *page;
> >> +	int nr_page_references = 0;
> > nit: just 'referenced' would be enough.
> 
> I guess I could track one bit like that.  But, it would require checking
> both page_mapcount() and page_swapcount() for being >1.  This way, I
> just accumulate the count and have a check at a single place.
> 
> I think it ends up much simpler this way.

I meant the variable name. 'referenced' would be enough for indication
like rmap.c and khugepaged.c. Anyway, it's up to you.
