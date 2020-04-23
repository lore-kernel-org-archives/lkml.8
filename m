Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC3C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D86220776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587672027;
	bh=0ie8inC6tglepafpuvFlTbDXa6MYOqRwKqq3Y85aAY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cgiy3kflI3LHSvSLhNEtnhw5hS7NgXydIixpZ+eLSZhUDyAjZJyIvA0+7sU3kwp9y
	 Os9FQfFYK0wYb+XcucJx75EjWbozvXQkFG8WlUmzw/TWmX2TLuJjnAc8YN216FIo3j
	 ntwyzqB1QGYgAxpp5Ce4kLiZ7lTw4hUX5aObPOck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDWUA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDWUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:00:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638FC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:00:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h69so3415553pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WNO7NKxkJpAJDOutrLoHzbNSgDH4TOj7e9H6a/yToIs=;
        b=GDpy3Gt5Dwy59orl+GSWU7IVcoSdVcntRMwW14jzXGDkk4y1D7XCaT6NAAk/JyNIFM
         H+K/0KFCU5NpOQcqT/4f42/Kkm2KBKVFl1tkHIjEO6XgaZJTN/sVH0IudLJc+ITFULlG
         82XcYlMkz1OXsnrw+b/5icSWyNJLY32toCTgo6V0LR/sJwbvJaDI1N+eYdIr+dvHDM3Z
         VvJyFFmZ6OUEobZ+qmv8VlvEE+iA3SgXNNPMTBSyjUkrRi9aaZgo5FV29yq7L+sHNNWp
         ILZj90Nf8C7Fj/FjlbS/mUwFYhDvdDSet6oSjy90VRXRHY+LkqOgItlJquqY88+Wp9Dz
         CKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=WNO7NKxkJpAJDOutrLoHzbNSgDH4TOj7e9H6a/yToIs=;
        b=JGbgSZg1iU4hcQw95fOSzjdxAiE5grjAYPpnPhTj3ndCz3D/NhacjSYPexA3kKghA9
         cpThEhXEvJrksq+a4iMCDuFexeQ2r0Xf6m6KJaajWJjLiFY4dEzjKRfwigN7Hei90lug
         9K3x1fk0cOBKLagb4MBt4sfBWc9xFEiDfP1AEMTbH4u6wU+Vu71q9skB+kB2orDIxdXo
         xshYZWC94N5BiyE6SIqhs4BXhT8qdGJfDVCsKRumNjXczb+71UP4+Q8r0heEtHbOFRSz
         zxzQEy3vtoGd4VJr8N+VoNdBlsLcG1c7Xu4iPTNU7EeO35hJma/iiwNnXQi9w6JSJsjp
         CuHg==
X-Gm-Message-State: AGi0PuZwREflIRPONu+YINYZMj2Imfjyy6D/r295RNLkG+M0XPycgWV8
        t7vH52Impxo6g3ujUvkCi7M=
X-Google-Smtp-Source: APiQypIUBi1bulsUMUBfX35K2ovGo4PxfVUAJp0ubvhZ488ydOm6T/ITuQ2kCdnycgDY6Ap6lNHHXg==
X-Received: by 2002:a65:6288:: with SMTP id f8mr5449714pgv.118.1587672023904;
        Thu, 23 Apr 2020 13:00:23 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b29sm3471291pfp.68.2020.04.23.13.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:00:22 -0700 (PDT)
Date:   Thu, 23 Apr 2020 13:00:20 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, mgorman@suse.de,
        m.szyprowski@samsung.com, mina86@mina86.com, shli@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com
Subject: Re: [PATCH v2] mm/vmscan: count layzfree pages and fix nr_isolated_*
 mismatch
Message-ID: <20200423200020.GB46847@google.com>
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
 <20200422084815.21913-1-jaewon31.kim@samsung.com>
 <20200422130751.GD358439@cmpxchg.org>
 <5EA10872.3010500@samsung.com>
 <20200423160546.GA389168@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423160546.GA389168@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:05:46PM -0400, Johannes Weiner wrote:
> On Thu, Apr 23, 2020 at 12:16:02PM +0900, Jaewon Kim wrote:
> > 
> > 
> > On 2020년 04월 22일 22:07, Johannes Weiner wrote:
> > > On Wed, Apr 22, 2020 at 05:48:15PM +0900, Jaewon Kim wrote:
> > >> @@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> > >>  		 */
> > >>  		if (page_mapped(page)) {
> > >>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> > >> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
> > >>  
> > >>  			if (unlikely(PageTransHuge(page)))
> > >>  				flags |= TTU_SPLIT_HUGE_PMD;
> > >> +
> > >>  			if (!try_to_unmap(page, flags)) {
> > >>  				stat->nr_unmap_fail += nr_pages;
> > >> +				if (lazyfree && PageSwapBacked(page))
> > > This looks pretty strange, until you remember that try_to_unmap()
> > > could SetPageSwapbacked again.
> > >
> > > This might be more obvious?
> > >
> > > 			was_swapbacked = PageSwapBacked(page);
> > > 			if (!try_to_unmap(page, flags)) {
> > > 				stat->nr_unmap_fail += nr_pages;
> > > 				if (!was_swapbacked && PageSwapBacked(page))
> > Hello Johannes, thank you for your comment.
> > 
> > The name can changed from layzyfree to was_swapbacked.
> > By the way, did you mean removing PageAnon(page), too? It seems to be OK, though.
> 
> I can't decide whether PageAnon() makes it clearer or not. But it's
> not really needed for correctness. So feel free to keep what you had.

Yub, PageAnon is redundant.

> I would really just at least change bool lazyfree to was_lazyfree,

It's better.
