Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22811C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF16205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589533707;
	bh=CppYqC9xASQBBV5hYCGtUNU8fCEozttVX3L8qNW3r6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xn50ryxB1Rj5axIixt6etCpbmdb0EF8F7qjvJnbDYXjMwBC+mrl4h67ZXrgMkc1Nr
	 zPvI+MwMu/4PoUZnVEi95e23g9I8MsP5phMoxy/r6jmvBu0Z8zB3YPko6DJ8CFKVVg
	 UdbA63qm/ss0XXKIx5arlb04ZtwbKmgohASQQJPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEOJI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:08:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44148 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEOJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:08:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id 50so2582070wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J28ctCQPdtuyBJRgZtHzD140QCC+2jwNn3ZnYypquyw=;
        b=jqPYQ6GT3bveSQlucNajYxEMuiRRPSiCAl8gSIfDoC4RfUMjtfAGFSdriXERSpnUCb
         0pqkTDKndezcNfA+ErPqMus5oDJQNLHqO/vPW2ZkHgRnALbfBlSQrexNKzMLrGionUQf
         ais7lW05ha3Yasb1+xaiPHSkwtYluhMy+G1mgW+BNqtiMOsgQYf16ECn6IcxaSFTNqFl
         Dkr155XWt/6hey74UellxKu1ejvkkDVRj3Nz/a6+qwu2KhjC7ySiwyihJsqjVI6JSs98
         wtj+KyvrZoUwoc/c6GKUTLJbOSmJ3u/2GqxAl0UXN4qxrEDG/VSGoUE635AOFu2h6Cmw
         iRmQ==
X-Gm-Message-State: AOAM5310IZtnqJFSDHUFFjOV0Yml59WNUrTRncFlENAeMPOqZJraEBvg
        b7n8uFVriTVo/WDxg0106vU=
X-Google-Smtp-Source: ABdhPJx52WtvVOeMhy79X8+1BQZbsLlO7skCUfOYdMSwb8omCOfuZ6kNO9SujbtzJKeho92KCscVgQ==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr3315478wrw.16.1589533703612;
        Fri, 15 May 2020 02:08:23 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id r11sm2760862wro.15.2020.05.15.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 02:08:22 -0700 (PDT)
Date:   Fri, 15 May 2020 11:08:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200515090821.GO29153@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
 <20200515074125.GH29153@dhcp22.suse.cz>
 <20200515080210.GC69177@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515080210.GC69177@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-05-20 16:02:10, Feng Tang wrote:
> Hi Michal,
> 
> Thanks for the thorough reviews for these 3 patches!
> 
> On Fri, May 15, 2020 at 03:41:25PM +0800, Michal Hocko wrote:
> > On Fri 08-05-20 15:25:17, Feng Tang wrote:
> > > When checking a performance change for will-it-scale scalability
> > > mmap test [1], we found very high lock contention for spinlock of
> > > percpu counter 'vm_committed_as':
> > > 
> > >     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
> > >     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
> > >     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> > > 
> > > Actually this heavy lock contention is not always necessary. The
> > > 'vm_committed_as' needs to be very precise when the strict
> > > OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> > > number for the percpu counter.
> > > 
> > > So lift the batch number to 16X for OVERCOMMIT_ALWAYS and
> > > OVERCOMMIT_GUESS policies, and add a sysctl handler to adjust it
> > > when the policy is reconfigured.
> > 
> > Increasing the batch size for weaker overcommit modes makes sense. But
> > your patch is also tuning OVERCOMMIT_NEVER without any explanation why
> > that is still "small enough to be precise".
> 
> Actually, it keeps the batch algorithm for "OVERCOMMIT_NEVER", but
> change the other 2 policies, which I should set it clear in the
> commit log.

Yeah, I have misread that part. Sorry about that.

[...]
> > > +void mm_compute_batch(void)
> > >  {
> > >  	u64 memsized_batch;
> > >  	s32 nr = num_present_cpus();
> > >  	s32 batch = max_t(s32, nr*2, 32);
> > > -
> > > -	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
> > > -	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
> > > +	unsigned long ram_pages = totalram_pages();
> > > +
> > > +	/*
> > > +	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
> > > +	 * of (total memory/#cpus), and lift it to 6.25% for other
> > > +	 * policies to easy the possible lock contention for percpu_counter
> > > +	 * vm_committed_as, while the max limit is INT_MAX
> > > +	 */
> > > +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> > > +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> > > +	else
> > > +		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);
> 
> Also as you mentioned there are real-world work loads with big mmap
> size and multi-threading, can we lift it even further ?
> 	memsized_batch = min_t(u64, ram_pages/nr/4, INT_MAX)

Try to measure those and see what numbers look like.
-- 
Michal Hocko
SUSE Labs
