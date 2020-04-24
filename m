Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C1C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51DB21569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Atr43ao9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgDXNSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgDXNR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:17:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343AC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:17:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so7811434qth.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nPp4Fkp75TEBfpm7cKyWA2kvnH2hSlbLU+MVnWcfyh4=;
        b=Atr43ao974R+BMIZNb+OYcLhlfo2zsmdf5y8BiIjcAT4NgliMSPjCqtW53rdUo1Bfr
         QUehpUJHHnFx/44L33TQwvEXxxSu4pJ+PiOaO88lorAdbGctTUs5smsKPNa3e2KgGoLf
         Wrp6F6NmcmMRpyOy2p4u5LCSbZSGJsIs82ESaULj7aSwELcrmNVGCeu0Ygd7lCqhm2I3
         4zbtAbQYKa/UetOEYUwZDU0EwJoj5bEvEvkGweCu0k2C4ytz4uoF8lZW2ESTVYmMrgL1
         HF2k5/r6tpkoB6i8tKMTghBMnaluRjJxJylojQZcr5IeGIKv3yWfIk1d5QFv6/poOQcp
         8u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nPp4Fkp75TEBfpm7cKyWA2kvnH2hSlbLU+MVnWcfyh4=;
        b=qX4zK7/mgb+iecEyPlEdDjpY/G0zBawKuGkJ5MK/4QvXI/RJQX9OcQzGNwMxEK8qZP
         x9j3n3V0jPYANVujFA7PhnFuyHtiN2UgrR8yr7dJ9A7a658j9oeaM/8lDaF75IBRE3Ku
         S4CRnT/9969uvNW1n3tMhw8nxoANA5GYjdip9afztpbR43xn76u+7UlenNQQ1hU9TsII
         aQROU9dziotTNgN+DAB2+1Dc33o3xCENYjbApdeAlXSkxm5E+0ug6oMo4qNOLm8czoxb
         cinvBnrDTew/UEUpJikFB4tdwy8ixPKMXLurfCdTTlkDMwqP2lgKMSY60ZlCFXj/b6GU
         RO6w==
X-Gm-Message-State: AGi0PuYhUSnpqUYjzfoCOgUyIeawVfRGqFmzBbrB5c9YCGw4o//FjgDs
        Z4YFJzZ5bN2uF5yJ/qb0oOuRbA==
X-Google-Smtp-Source: APiQypIaOU3r9sSpQ63KRoznZRszewbWG2bEIFd8BVzRWG+tqdTnyVZ217DUzAiiebhRkQ6JwItjiQ==
X-Received: by 2002:aed:37c4:: with SMTP id j62mr9343733qtb.279.1587734278297;
        Fri, 24 Apr 2020 06:17:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id z65sm3772291qka.60.2020.04.24.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 06:17:57 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:17:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Minchan Kim <minchan@kernel.org>, mgorman@suse.de,
        m.szyprowski@samsung.com, mina86@mina86.com, shli@fb.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com
Subject: Re: [PATCH v2] mm/vmscan: count layzfree pages and fix nr_isolated_*
 mismatch
Message-ID: <20200424131756.GB495720@cmpxchg.org>
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
 <20200422084815.21913-1-jaewon31.kim@samsung.com>
 <20200422130751.GD358439@cmpxchg.org>
 <5EA10872.3010500@samsung.com>
 <20200423160546.GA389168@cmpxchg.org>
 <20200423200020.GB46847@google.com>
 <5EA2682D.7010307@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EA2682D.7010307@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:16:45PM +0900, Jaewon Kim wrote:
> 
> 
> On 2020년 04월 24일 05:00, Minchan Kim wrote:
> > On Thu, Apr 23, 2020 at 12:05:46PM -0400, Johannes Weiner wrote:
> >> On Thu, Apr 23, 2020 at 12:16:02PM +0900, Jaewon Kim wrote:
> >>>
> >>> On 2020년 04월 22일 22:07, Johannes Weiner wrote:
> >>>> On Wed, Apr 22, 2020 at 05:48:15PM +0900, Jaewon Kim wrote:
> >>>>> @@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >>>>>  		 */
> >>>>>  		if (page_mapped(page)) {
> >>>>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> >>>>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
> >>>>>  
> >>>>>  			if (unlikely(PageTransHuge(page)))
> >>>>>  				flags |= TTU_SPLIT_HUGE_PMD;
> >>>>> +
> >>>>>  			if (!try_to_unmap(page, flags)) {
> >>>>>  				stat->nr_unmap_fail += nr_pages;
> >>>>> +				if (lazyfree && PageSwapBacked(page))
> >>>> This looks pretty strange, until you remember that try_to_unmap()
> >>>> could SetPageSwapbacked again.
> >>>>
> >>>> This might be more obvious?
> >>>>
> >>>> 			was_swapbacked = PageSwapBacked(page);
> >>>> 			if (!try_to_unmap(page, flags)) {
> >>>> 				stat->nr_unmap_fail += nr_pages;
> >>>> 				if (!was_swapbacked && PageSwapBacked(page))
> >>> Hello Johannes, thank you for your comment.
> >>>
> >>> The name can changed from layzyfree to was_swapbacked.
> >>> By the way, did you mean removing PageAnon(page), too? It seems to be OK, though.
> >> I can't decide whether PageAnon() makes it clearer or not. But it's
> >> not really needed for correctness. So feel free to keep what you had.
> > Yub, PageAnon is redundant.
> >
> >> I would really just at least change bool lazyfree to was_lazyfree,
> > It's better.
> Thank you both.
> 
> Sorry but let me ask again.
> 
> Because PageAnon is redundant, let me remove it on checking lazyfree.
> Then, I think, was_swapbacked (first suggestion) is better then was_lazyfree (second suggestion),
> because it just checks PageSwapBacked(page). And we knows was_swapbacked is used for lazyfree on stat->nr_lazyfree_fail.
> 
> If you don't mind let me pick was_swapbacked instead of was_lazyfree

That sounds good to me. Thanks Jaewon!
