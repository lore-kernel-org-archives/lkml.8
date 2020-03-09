Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB7C10F28
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCE320863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nD8dxEsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCIJfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:35:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39253 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIJfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:35:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id j15so7086185lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6vp+uOPfGV5PottVUADGfyb04JPl4nxuBitQ+YXoxTk=;
        b=nD8dxEsLtaNoSBXqTop3csKAfCgv2k0sfPIYz2JAIXkZ2Dddd/QOy6YT2QlGHnV0cZ
         BJZ9XE6WHeNwCYUmKns7mhFvkYuM2hyaOGMEG2DE7CTP39Qqlx64f7DqAOSAyDziUzq9
         Ogiw89RrJMyISm26U9O4tni/Zc8ghFzpsWpsyqpw7WNGeSk3DdjNuUoo7ex3y2G3ePgx
         GrRIVU740FhNnRNCGtBdAYUpdrQ+SLccSIsUxqAtQR/XMIOGk2sw42iNG/688j9unnTd
         uATh61wHF9hKwiHNnVA+50MxrglzNfnFMEuP3zkLYB7hsMRLeaK5El11HbD811tQBUqo
         nR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6vp+uOPfGV5PottVUADGfyb04JPl4nxuBitQ+YXoxTk=;
        b=nw9dPboHkBUs7fLpffhrhc09+mZlM9kZyBJuoTdGsU1t8M7DEpW2qPtVVPq40VHBOo
         xSNqy5LzWa2JeGzJLiTmRlnTVGxj0vHoVU5n//To6G1nkIycNQEA+321p3M7Q3Wl7+lf
         IAYsxGVwMSqHSlVfSXip/ZHeBEaia8w+ZC/sfg770grbUkb48+6cjpQ5LcqHxAh7BscO
         3BNnJLMM5C0cFmCqiSAbwKZgMi0sRO0tIxvRjJxTnVAEwottSPZAwk0UeYicZXfVRjKx
         sBnSiHigGQhBp7JSgn6sRl90qhC+rJteKwtdUUbaQa5zNow24iqjrfkX0Pj+HJ+1+iTZ
         EtGQ==
X-Gm-Message-State: ANhLgQ3K6qRhdOX6zCH+BHxYjSmmSxCoMjUuD0/x5YRgGasQ1es/03Tu
        2wZA46FXfFHHiKkWBH7u1Xh2lA==
X-Google-Smtp-Source: ADFU+vtzy6JVTWt5uAdUpHEv653vp2rorfWaPrDxG49qqjCnBrxeOOmL4AomHuX7ZOJyhe18Td9zTA==
X-Received: by 2002:ac2:4652:: with SMTP id s18mr9065505lfo.162.1583746534703;
        Mon, 09 Mar 2020 02:35:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y14sm1682191lfl.94.2020.03.09.02.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 02:35:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8EE3310258B; Mon,  9 Mar 2020 12:35:33 +0300 (+03)
Date:   Mon, 9 Mar 2020 12:35:33 +0300
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
Message-ID: <20200309093533.qj255nrgyofmtiqz@box>
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
> tends to not matter at all as it is usually pre-allocation scenario. On
> the other hand, speeding up the initialization sounds like a good thing
> in general. It will be a single time benefit but if the additional code
> is not hard to maintain then I would be inclined to take it even with
> "artificial" numbers state above. There really shouldn't be other downsides
> except for the code maintenance, right?

I cannot think of any, no.

-- 
 Kirill A. Shutemov
