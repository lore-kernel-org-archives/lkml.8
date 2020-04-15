Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AD8C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1990520768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895307AbgDOJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:20:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54967 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895317AbgDOJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:19:52 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jOeD0-0006T8-PL
        for linux-kernel@vger.kernel.org; Wed, 15 Apr 2020 09:19:50 +0000
Received: by mail-wr1-f72.google.com with SMTP id m5so7141812wru.15
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hJDx2/Ye85WrB55AQggZQs08fhv4a4xuGB8LKsw6eUc=;
        b=n1Vu0549MAm2KAXygRpbubp0/gO4yLioSSvg4qyYEXphX4egWn0YSDTJ3OxaURICsn
         7ZBEs6vu0tKH83Wgl2+AI7skmuWS4VMU/8Ozn//QPhtDYXYExrzQRHH3yL4yxNOPu22y
         Sm5VqpmP2+SrIlAvi144/JFcrPF5POWujX/i85HWozRugWj7gJSqjFPmHTv6FozZoQU1
         0LG2zs6EWXBDlPKAmilvEOiU6SHVJY2kwiahefpYyExvJ1/Gx80yYpfo4D7CD2v9eE0B
         q5pOPGfU94y5a6stjAV7SiGq5/uYljHlFuhfs668XzIeHQcFTMfSZMiUJaAkyuliHtXt
         Iklg==
X-Gm-Message-State: AGi0PuZrLMY6M3mq5+zq3cGIUaC4aubUZ+i0IElbvacmzQGdqVqqf3N/
        bzWX3Vr9hsYPJm4LhMnBracUGF0UuhRqyfTrLoi1Zpyimru/yNNjF40wP9XTXbNpKDvOWcv7Gj7
        Vxh/qT5OeOxnQNMMd1t4OhlBwKH38L6EpOr/4HZX4QQ==
X-Received: by 2002:a5d:53c4:: with SMTP id a4mr26991560wrw.47.1586942390435;
        Wed, 15 Apr 2020 02:19:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypK7iUWDzwMIf51BDDe6l9FVw8BQAkj/x+gwYLCQ0szj/ZD5wHQVdUC1pshF2WFlzkQLQaq12Q==
X-Received: by 2002:a5d:53c4:: with SMTP id a4mr26991543wrw.47.1586942390161;
        Wed, 15 Apr 2020 02:19:50 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id j124sm21831962wmb.25.2020.04.15.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:19:49 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:19:48 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
Message-ID: <20200415091948.GH810380@xps-13>
References: <20200413111810.GA801367@xps-13>
 <87a73f7d71.fsf@yhuang-dev.intel.com>
 <20200413133150.GA810380@xps-13>
 <87wo6i6efn.fsf@yhuang-dev.intel.com>
 <20200414130520.GF810380@xps-13>
 <87v9m1zd83.fsf@yhuang-dev.intel.com>
 <20200415073239.GG810380@xps-13>
 <87imi1yz07.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imi1yz07.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 03:44:08PM +0800, Huang, Ying wrote:
> Andrea Righi <andrea.righi@canonical.com> writes:
> 
> >  mm/swapfile.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 9fd47e6f7a86..cb9eb517178d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1944,7 +1944,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> >  		vmf.pmd = pmd;
> >  		last_ra = atomic_read(&last_readahead_pages);
> >  		atomic_set(&swapin_readahead_hits, last_ra);
> 
> You need to remove the above 2 lines firstly.

Meh... too much enthusiasm, and I definitely need more coffee this
morning. Here's the right patch applied:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5871a2aa86a5..8b38441b66fa 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1940,7 +1940,9 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		vmf.vma = vma;
 		vmf.address = addr;
 		vmf.pmd = pmd;
-		page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
+		page = lookup_swap_cache(entry, vma, addr);
+		if (!page)
+			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, &vmf);
 		if (!page) {
 			if (*swap_map == 0 || *swap_map == SWAP_MAP_BAD)
 				goto try_next;

And following the right results:

r::swapin_nr_pages(unsigned long offset):unsigned long:$retval
	COUNT      EVENT
	1618       $retval = 1
	4960       $retval = 2
	41315      $retval = 4
	103521     $retval = 8

swapoff time: 12.19s

So, not as good as the fixed-size readahead, but it's definitely an
improvement, considering that the swapoff time is ~22s without this
patch applied.

I think this change can be a simple and reasonable compromise.

Thanks again and sorry for the noise,
-Andrea
