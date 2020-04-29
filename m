Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFACAC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA4C2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588160615;
	bh=Vptt1UPaXGgg60ik9YIZYYTweSPZHUiIzyKRufAMwew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oKRDfGhIMGB5Ga/3vCnhkgYUGh5sPDTqVx1fXiXCf6JtcCvCjQEL8rmsC1/mHYHxL
	 EmqLta2FhCZ9Z0cqwIwg5nki4Pdj1GMtnLpkaQheImNfJRkKcC3JH21fG5hntGAjq4
	 VliZmhUY6jDaxcfb7rnzy5AosshIY7pMdgEhosUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD2Lne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:43:34 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36459 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2Lne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:43:34 -0400
Received: by mail-wm1-f44.google.com with SMTP id u127so1669222wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vevoXjwrhXkj2nIiMSFHvSIkFN/LcgtuZhtgDAeX9Ho=;
        b=YMefvzWk97A6u3K0L0ZVr8W7vE1ogxWJV94aa9KTKzTmYc8kGi53tZh71ZVXR/so+M
         OjpcXJpHk507wGrlLpBodmKK6gGbb3lpjjmOu1GbRvURBGhfEf51HLUlaehb/HEqskD9
         LU+4dvg4OXFGx+JnElb/a3nb4n7rpLCyFM0T5zB+XoNjNaRQoIamiRhUX8H7kBpkM+I2
         EjCC4rnvLrY3gxYcCPZ/Vgs6j3urVL2gLUb7Zi/Y3Cr2fAL91a4/fMBlqRuAGE9DmxpS
         LX+hKkAgl4NEn+gHbdJ2xISIZKam0hUmIGgcfCXa0i9j9/gNW3ohre59WrVGt9l+1rH5
         5f5A==
X-Gm-Message-State: AGi0PuZIhJ6LDpyp8lKj4y+frsMHJ/asUVrBIWRrqXh6QenqT/H5RBJk
        qCGqGcNeJDMHLxRVz87EyjoeVVtn
X-Google-Smtp-Source: APiQypJQvLdxuHCouxvtvxUtGgJlISAl5jQQE/s/6hextuemczADwYjrAHODiBlHWhpH8mpep7fiaA==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr2815015wmd.148.1588160612267;
        Wed, 29 Apr 2020 04:43:32 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id z10sm30564879wrg.69.2020.04.29.04.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:43:31 -0700 (PDT)
Date:   Wed, 29 Apr 2020 13:43:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-ID: <20200429114329.GB28637@dhcp22.suse.cz>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
 <alpine.DEB.2.22.394.2004281436280.131129@chino.kir.corp.google.com>
 <31f1f84d-c5fe-824b-3c28-1a9ad69fcae5@suse.cz>
 <20200429090437.GX28637@dhcp22.suse.cz>
 <bcf6d15f-cbdb-8c45-6087-a0f2aab737c6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcf6d15f-cbdb-8c45-6087-a0f2aab737c6@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 19:45:07, Tetsuo Handa wrote:
> On 2020/04/29 18:04, Michal Hocko wrote:
> > Completely agreed! The in kernel OOM killer is to deal with situations
> > when memory is desperately depleted without any sign of a forward
> > progress. If there is a reclaimable memory then we are not there yet.
> > If a workload can benefit from early oom killing based on response time
> > then we have facilities to achieve that (e.g. PSI).
> 
> Can PSI work even if userspace process cannot avoid reclaimable memory
> allocations (e.g. page fault, file read) is already stalling?

The userspace itself would have to be careful and use mlock of course.
But collecting the psi information itself should be pretty independent
on memory allocations as monitoring the system memory state is one of
the main usecases.

> I'm not sure
> whether PSI allows responding quickly enough to "keep reclaimable memory
> allocations not to reclaim" despite there is still reclaimable memory...

PSI is supposed to monitor time spent in the memory allocator (among
other things) and report the tendency. This should be a sufficient
metric to judge that a large part of the userspace is not making forward
progress.
-- 
Michal Hocko
SUSE Labs
