Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D576C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F0D20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583744796;
	bh=M+pCAFlfSiu03kM4uq2mrW9LaXcgseVHwHVlacuwWfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e7AQw6vkT4wIAC1R/MzhQVuGBkRaGUzbA4EYaHQW7Wx2SiO+s2vA2fHLWpth7fD0q
	 mWEKx8ciKHDdneQay+D3ijbVAv59k0VZRu3F/CW9OMdp4CpvEbYAeKuxlNpJApDSDN
	 joyGq0VYWHk9iQPix9gOe/XrWFsb5Tr6mYmqoKak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCIJGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:06:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46005 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCIJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:06:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id m9so976503wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=advhTaiPpBd3xMDHQ5EkNV5OtDpYm/5MCYtszs2MKcE=;
        b=GX82LCvTQ7q2vFkl1oLBnUSER3OHI0vCscpUfSRcj5g4pJufqar7rcrwEviRfyqoqQ
         vJ5QLMdy7mCR+XimEfritT7xZL23chcQabbs4LQoOr5bY0nCEO4cZlKDTF5ThAw8nWNk
         uQYWo9ESv03pOFZFR1trRF87unLVJtl9hlg+3ZkN05Ts3uAd4L6ZY+LwVfBpD7ozrXX1
         Kkr72/w9sAf2NfIgDvftKXBaZQFJDei/scYsdXDstSyGfHmDiVOP1zsTwalyOb01AMwl
         MqHuHQzdprZV7XS92KLdWbTPh+g7iRIDN6DFi/1dePNCGnZ7A9EPzw/bCaOYxIr18w5q
         mihQ==
X-Gm-Message-State: ANhLgQ2xjN7S+Vh3oE9B/yOQadRS+nh2wkp8d38d17o/ramLXew9/1dU
        kQwk7tw4jVIPSi1ZD1kIeJs=
X-Google-Smtp-Source: ADFU+vuwHtxz+a1BYeGUzK3Wpd1FIviWQ7fbUSfjosvB/Cg4HKU8TP5LGAhdAO8Dnz5SL4yn5zBdKg==
X-Received: by 2002:adf:e911:: with SMTP id f17mr19002170wrm.87.1583744792202;
        Mon, 09 Mar 2020 02:06:32 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q72sm6102065wme.31.2020.03.09.02.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 02:06:31 -0700 (PDT)
Date:   Mon, 9 Mar 2020 10:06:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200309090630.GC8447@dhcp22.suse.cz>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309000820.f37opzmppm67g6et@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-03-20 03:08:20, Kirill A. Shutemov wrote:
> On Fri, Mar 06, 2020 at 05:03:53PM -0800, Cannon Matthews wrote:
> > Reimplement clear_gigantic_page() to clear gigabytes pages using the
> > non-temporal streaming store instructions that bypass the cache
> > (movnti), since an entire 1GiB region will not fit in the cache anyway.
> > 
> > Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
> > average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
> > and optimizing the control flow over the constituent small pages, this
> > can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
> > taking only 34 seconds on average, or 67ms/GiB.
> > 
> > The assembly code for the __clear_page_nt routine is more or less
> > taken directly from the output of gcc with -O3 for this function with
> > some tweaks to support arbitrary sizes and moving memory barriers:
> > 
> > void clear_page_nt_64i (void *page)
> > {
> >   for (int i = 0; i < GiB /sizeof(long long int); ++i)
> >     {
> >       _mm_stream_si64 (((long long int*)page) + i, 0);
> >     }
> >   sfence();
> > }
> > 
> > Tested:
> > 	Time to `mlock()` a 512GiB region on broadwell CPU
> > 				AVG time (s)	% imp.	ms/page
> > 	clear_page_erms		133.584		-	261
> > 	clear_page_nt		34.154		74.43%	67
> 
> Some macrobenchmark would be great too.
> 
> > An earlier version of this code was sent as an RFC patch ~July 2018
> > https://patchwork.kernel.org/patch/10543193/ but never merged.
> 
> Andi and I tried to use MOVNTI for large/gigantic page clearing back in
> 2012[1]. Maybe it can be useful.
> 
> That patchset is somewhat more complex trying to keep the memory around
> the fault address hot in cache. In theory it should help to reduce latency
> on the first access to the memory.
> 
> I was not able to get convincing numbers back then for the hardware of the
> time. Maybe it's better now.
> 
> https://lore.kernel.org/r/1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com

Thanks for the reminder. I've had only a very vague recollection. Your
series had a much wider scope indeed. Since then we have gained
process_huge_page which tries to optimize normal huge pages.

Gigantic huge pages are a bit different. They are much less dynamic from
the usage POV in my experience. Micro-optimizations for the first access
tends to not matter at all as it is usually pre-allocation scenario. On
the other hand, speeding up the initialization sounds like a good thing
in general. It will be a single time benefit but if the additional code
is not hard to maintain then I would be inclined to take it even with
"artificial" numbers state above. There really shouldn't be other downsides
except for the code maintenance, right?
-- 
Michal Hocko
SUSE Labs
