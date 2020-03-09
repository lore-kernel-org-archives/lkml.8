Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51775C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254ED2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YiksY24H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCILhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:37:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42568 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCILhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:37:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id q19so9522697ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/aMSPlostkmdxGH/3yMwhsI26X6tSyOaeOB9N+bnu0w=;
        b=YiksY24Hf6CbZMTM1Xlp9fv5Cm8Uh6RF7A8rZZ2VTVnufTIHR6WFo3DrtmJ/1mzUPR
         4C0W0t0xznGDvQgvZKRUn82mFUTT3251+WG55wsayobknGpg4Dj+WPjO3M3TuGikLKI5
         qIbD7PGDvji+qm/OON+9MrS2CbW98u+b0jgk2BUQtJ7xw2R0jnBSx9sMf5qAVFrzRccG
         esQQ0P09uxtwOCKP6fUMV8uYH4g/UI7s6NNwEHCcaP5vARQbgPCNIG6CPGm/yqB9UytF
         4BiWj/Qpuys//SiUy5+NGtHsD5ajG0U4mBr4DJZ8MTVOo4oqQBUL+Y4W7dlljHAuowii
         rIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/aMSPlostkmdxGH/3yMwhsI26X6tSyOaeOB9N+bnu0w=;
        b=tmDY16oh+ezwCheDS/yZVasce+1gUoOM0pyRyAGzY1rA7eccz+ToYjcoHL7wxplijP
         PltXjc0vwLu6zB3OUI1dZthtfztUZOjsmj2wjs8QWxfsVYZqjaKmOIbeU1cb+J0Jkrz0
         UXDaR6ggLkHUqKnTqdrt29ZGCR8Xq02VxPfYYWahiq7kyu93PQNP/ahtEAcFKIzd6CrS
         iClJ6R0HvLsldoLWt+xv4ddW5UuyARhpHKLQmx5t2EtG087iLozMmiTRaJkbC2xbBsJg
         5xCv6z9mcmdd0vj6IzgrPyybQ0Qqy+D+6mJLykrCBrK1NmWRNz4QYR6axCXH/P8ILlqq
         DHYg==
X-Gm-Message-State: ANhLgQ1N1FsROIJAONOBr7hqRcajUo7a0yTuPViMdNxLv3Bh54EJtFHm
        qwc3SgmK1WZFol9HRFmOmxcOWg==
X-Google-Smtp-Source: ADFU+vvptPI1QZuzd2iAjjc4m8WroGOgfKk9tfO+k+gdAb/Hn8Woh+qus5dg/cid271ZSA//0SgT9g==
X-Received: by 2002:a2e:7018:: with SMTP id l24mr9424557ljc.128.1583753819134;
        Mon, 09 Mar 2020 04:36:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t78sm4319720lff.27.2020.03.09.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:36:58 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 14BAA10258B; Mon,  9 Mar 2020 14:36:58 +0300 (+03)
Date:   Mon, 9 Mar 2020 14:36:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200309113658.bctbw35e73ahhgbu@box>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309090630.GC8447@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 10:06:30AM +0100, Michal Hocko wrote:
> On Mon 09-03-20 03:08:20, Kirill A. Shutemov wrote:
> > On Fri, Mar 06, 2020 at 05:03:53PM -0800, Cannon Matthews wrote:
> > > Reimplement clear_gigantic_page() to clear gigabytes pages using the
> > > non-temporal streaming store instructions that bypass the cache
> > > (movnti), since an entire 1GiB region will not fit in the cache anyway.
> > > 
> > > Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
> > > average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
> > > and optimizing the control flow over the constituent small pages, this
> > > can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
> > > taking only 34 seconds on average, or 67ms/GiB.
> > > 
> > > The assembly code for the __clear_page_nt routine is more or less
> > > taken directly from the output of gcc with -O3 for this function with
> > > some tweaks to support arbitrary sizes and moving memory barriers:
> > > 
> > > void clear_page_nt_64i (void *page)
> > > {
> > >   for (int i = 0; i < GiB /sizeof(long long int); ++i)
> > >     {
> > >       _mm_stream_si64 (((long long int*)page) + i, 0);
> > >     }
> > >   sfence();
> > > }
> > > 
> > > Tested:
> > > 	Time to `mlock()` a 512GiB region on broadwell CPU
> > > 				AVG time (s)	% imp.	ms/page
> > > 	clear_page_erms		133.584		-	261
> > > 	clear_page_nt		34.154		74.43%	67
> > 
> > Some macrobenchmark would be great too.
> > 
> > > An earlier version of this code was sent as an RFC patch ~July 2018
> > > https://patchwork.kernel.org/patch/10543193/ but never merged.
> > 
> > Andi and I tried to use MOVNTI for large/gigantic page clearing back in
> > 2012[1]. Maybe it can be useful.
> > 
> > That patchset is somewhat more complex trying to keep the memory around
> > the fault address hot in cache. In theory it should help to reduce latency
> > on the first access to the memory.
> > 
> > I was not able to get convincing numbers back then for the hardware of the
> > time. Maybe it's better now.
> > 
> > https://lore.kernel.org/r/1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com
> 
> Thanks for the reminder. I've had only a very vague recollection. Your
> series had a much wider scope indeed. Since then we have gained
> process_huge_page which tries to optimize normal huge pages.
> 
> Gigantic huge pages are a bit different. They are much less dynamic from
> the usage POV in my experience. Micro-optimizations for the first access
> tends to not matter at all as it is usually pre-allocation scenario.

The page got cleared not on reservation, but on allocation, including page
fault time. Keeping the page around the fault address can still be
beneficial.

-- 
 Kirill A. Shutemov
