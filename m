Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AFCC2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5D92075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgDMN1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:27:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35810 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgDMN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:27:03 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jNz76-0003Pg-VI
        for linux-kernel@vger.kernel.org; Mon, 13 Apr 2020 13:27:01 +0000
Received: by mail-wr1-f70.google.com with SMTP id h95so6665349wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 06:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8+a15+2Tn0eUrhKMyhOqb9Aptpj40p6nDpz6wADNeys=;
        b=HLWpZ9SlKSqJZwj23adgjPQ8FYWugKuj8WmmSg2Gu2flAIzf0yfvV/bF+n1IEfZAxd
         j7Eq/nAnGqEI93AxWSDCozmZgdJlhsXT+/k8WL4Yw1Epw7NVVzw6Gy6WdpderdGoNxLd
         w+rfTFAD1dlGr5oHyzWHHx5PQHhLEaCy8DMCKydg5bEWAR8e/coHa3m0d5wzJUmnibdL
         7J+G/rwQC1tbiX7QJIH6+G0cMBQlxye4tnRHUAc8uXsTSlWL5b74Hm9+e82qKLrwc4Ra
         eeXOJDLnVOQWqz3zMrus3mT4z2wj6FcZaJBG6ZHpBAhgOjwmWm7nHCqikI87wVLN9kB/
         8Lrw==
X-Gm-Message-State: AGi0PuZgDomv1zm5QfFpwUJ16FmkSZiX+IJNMMmxww1BMCRstb+wVMnr
        cB/38BOH9fEtoYj9FwpOpr3/NddZq/YQlLBi4eB0CQ3+eT241AuJ88rjx8N7qC0J/dy0nfPHerP
        5QT/xKYunEiS9zuhfhe5mJUcR2bum8spyPjQnzST2dA==
X-Received: by 2002:a1c:ba82:: with SMTP id k124mr19595748wmf.66.1586784420587;
        Mon, 13 Apr 2020 06:27:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypL1t64aMjzac+EttdBS3JKOOcE28EqF+BPRTU+l/HHGCxHjq+/gz6DzIjRh92m4ivlLeo6/Cw==
X-Received: by 2002:a1c:ba82:: with SMTP id k124mr19595727wmf.66.1586784420259;
        Mon, 13 Apr 2020 06:27:00 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id w12sm201227wrk.56.2020.04.13.06.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:26:59 -0700 (PDT)
Date:   Mon, 13 Apr 2020 15:26:58 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
Message-ID: <20200413132658.GB801367@xps-13>
References: <20200413111810.GA801367@xps-13>
 <875ze37cle.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ze37cle.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:13:33PM +0800, Huang, Ying wrote:
> Andrea Righi <andrea.righi@canonical.com> writes:
> 
> > The global swap-in readahead policy takes in account the previous access
> > patterns, using a scaling heuristic to determine the optimal readahead
> > chunk dynamically.
> >
> > This works pretty well in most cases, but like any heuristic there are
> > specific cases when this approach is not ideal, for example the swapoff
> > scenario.
> >
> > During swapoff we just want to load back into memory all the swapped-out
> > pages and for this specific use case a fixed-size readahead is more
> > efficient.
> >
> > The specific use case this patch is addressing is to improve swapoff
> > performance when a VM has been hibernated, resumed and all memory needs
> > to be forced back to RAM by disabling swap (see the test case below).
> 
> Why do you need to swapoff after resuming?  The swap device isn't used
> except hibernation?  I guess the process is,
> 
> 1) add swap device to VM
> 2) hibernate
> 3) resume
> 4) swapoff

Correct, the swap device is used only for hibernation, when the system
is resumed the swap is disabled (swapoff).

> 
> Some pages are swapped out in step 2?  If os, can we just set
> /proc/sys/vm/swappiness to 0 to avoid swapping in step 2?

Sorry, can you elaborate more on this? All anonymous pages are swapped
out during step 2, it doesn't matter if we set swappiness to 0, they are
swapped out anyway, because we need save them somewhere in order to
hibernate, shutting down the system.

Thanks,
-Andrea
