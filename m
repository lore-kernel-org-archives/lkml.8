Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E172073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgDMNb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:31:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgDMNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:31:55 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jNzBo-0003if-SJ
        for linux-kernel@vger.kernel.org; Mon, 13 Apr 2020 13:31:53 +0000
Received: by mail-wm1-f72.google.com with SMTP id h22so1147809wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 06:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QaapbS3AwpMQJO1PlO7vQLfoDd/t8Pv7NCHZnFtR9R8=;
        b=LDpcY0SHRN54MQX1X8AwMrYsgg+sSUCtgRKkt+ap34wfwLbeRacgzxMAT8Zjio7kC4
         ZAriknCkgoRvCVHWlTHRmAmuM51Cz3YLE0OUIHVbE8sBLpkJWAQrkh4yXZuEXgRWrCqx
         bkx564XK6AaN1L+kEfBQZe7tOEV6er5dLmj9fOImKFJlrmF5B7EmFju7dQiFoF5bBHOu
         7oqxX/bWWByebxUvitRDIWi8KR/4MWxHphq7Qm6xJCKX8CRE+b1sOj7KiqYaODCuS9vN
         cRH2hd1OsbuR9xqxHtn1gJkrITWZ6tyxZw/yPX/Th+oEEwQl30FMcfCBd22+GDUt//29
         CSZg==
X-Gm-Message-State: AGi0PuY4LSwRhxjtb0OeduQsjvEkMYAIi4+vq0Rsjlpjjij+aayyQ8lW
        PqfyIIunovh9MM6NzPrRbjiu8owoR/RUd5fzE/Wt1f2SfxlpXJT/2c1Tn715ahyePrwPCIRgkWG
        iQMRIYGoZa6Z3SdunbgVZVoRoCoGFylgTkQYhuzQ0pg==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr18717041wmj.35.1586784712514;
        Mon, 13 Apr 2020 06:31:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbHqcshOES1POOpbSkrd5awhLm8EajB366CYNGu2GARJYA8cZtN4ZuoZfz+7mcb6QHwtl+7A==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr18717027wmj.35.1586784712276;
        Mon, 13 Apr 2020 06:31:52 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id h17sm3289803wmm.6.2020.04.13.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:31:51 -0700 (PDT)
Date:   Mon, 13 Apr 2020 15:31:50 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
Message-ID: <20200413133150.GA810380@xps-13>
References: <20200413111810.GA801367@xps-13>
 <87a73f7d71.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a73f7d71.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:00:34PM +0800, Huang, Ying wrote:
> Andrea Righi <andrea.righi@canonical.com> writes:
> 
> [snip]
> 
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index ebed37bbf7a3..c71abc8df304 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/migrate.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/swap_slots.h>
> > +#include <linux/oom.h>
> >  #include <linux/huge_mm.h>
> >  
> >  #include <asm/pgtable.h>
> > @@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
> >  	max_pages = 1 << READ_ONCE(page_cluster);
> >  	if (max_pages <= 1)
> >  		return 1;
> > +	/*
> > +	 * If current task is using too much memory or swapoff is running
> > +	 * simply use the max readahead size. Since we likely want to load a
> > +	 * lot of pages back into memory, using a fixed-size max readhaead can
> > +	 * give better performance in this case.
> > +	 */
> > +	if (oom_task_origin(current))
> > +		return max_pages;
> >  
> >  	hits = atomic_xchg(&swapin_readahead_hits, 0);
> >  	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
> 
> Thinks this again.  If my understanding were correct, the accessing
> pattern during swapoff is sequential, why swap readahead doesn't work?
> If so, can you root cause that firstly?

Theoretically if the pattern is sequential the current heuristic should
already select a big readahead size, but apparently it's not doing that.

I'll repeat my tests tracing the readahead size during swapoff to see
exactly what's going on here.

Thanks,
-Andrea
