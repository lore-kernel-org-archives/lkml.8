Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65921C38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8DE22209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDRIvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:51:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39046 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgDRIvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:51:49 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jPjCW-00076H-1U
        for linux-kernel@vger.kernel.org; Sat, 18 Apr 2020 08:51:48 +0000
Received: by mail-wr1-f71.google.com with SMTP id r17so2365344wrg.19
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l865sM20dUV5dn9goNLRc6hzgJt0NJq8dymVntQWufM=;
        b=BPOG61I1AFmMPoiEFA4bqHQlpQdJlacJLkTtfj7OejhkJ6WM8WeGcUHiPa4YlNwimG
         asB8PY3SiU1b1usM7X+KO2f48peIOVNgov+vUuOvj1Sp6tWZWlQn4IfLWd3HIvJ/Gfo9
         pQVcDpx9UlyJ6V9y67giG4Qm2YXLrdTjRWBF1ROkWTkttftF87itcUmiNg/4ZgLF98SM
         W1Pfc5VJFThs2r0/SfT6RqzijSV6d75ZNy2fSsDUxICJ7eQlMOsAWj+3k46Tnia9hzWd
         47KCXGcR/St07n3YuLJWF2qvqSh3DUJE8Nqke5+QP1U7eU9wfERHbIA4TMVDsnrQif/m
         0Jqw==
X-Gm-Message-State: AGi0Puaz6zTWJUphLxCLx1olJFX9HImnlm8Y6Wc6bhhI/zAJs/+5rnJE
        lT6fcsbR6rJWBa8DoLyhj0AELlXJbmND31L6LrWcNvkXsYqgLHIwZ/MYb074KYj2YVhXtMr/nlj
        AUUVaNozD1kZpBEH6q+83gernFsWQHBEi1GiE4R/qGA==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr8262391wrw.104.1587199907684;
        Sat, 18 Apr 2020 01:51:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLv1ZraJ0vX3wBvGgtLOoNjxem2hSJ1DucR2xU+S8+PGnbBOimyc7wWOjg6UpfYkXbhAiuB/g==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr8262370wrw.104.1587199907386;
        Sat, 18 Apr 2020 01:51:47 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id t2sm10854409wmt.15.2020.04.18.01.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:51:46 -0700 (PDT)
Date:   Sat, 18 Apr 2020 10:51:45 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: swap: properly update readahead statistics in
 unuse_pte_range()
Message-ID: <20200418085145.GA147473@xps-13>
References: <20200416180132.GB3352@xps-13>
 <871romvmrh.fsf@yhuang-dev.intel.com>
 <20200416210646.774bae8c321e3a44d6ffa8c3@linux-foundation.org>
 <87sgh2u1ua.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgh2u1ua.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:18:37PM +0800, Huang, Ying wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Fri, 17 Apr 2020 11:01:22 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:
> >
> >> Andrea Righi <andrea.righi@canonical.com> writes:
> >> 
> >> > In unuse_pte_range() we blindly swap-in pages without checking if the
> >> > swap entry is already present in the swap cache.
> >> >
> >> > By doing this, the hit/miss ratio used by the swap readahead heuristic
> >> > is not properly updated and this leads to non-optimal performance during
> >> > swapoff.
> >> 
> >> It's more important to describe why we need this patch in the patch
> >> description.  So, please add some information about your use case.  And
> >> please focus on the technical part instead of the business part.
> >
> > Confused.  I thought the changelog was quite good.  If "business part"
> > means "end user effect of the patch" then that's a very important
> > thing.
> 
> Previously, Andrea has described their use case in the cloud environment
> to hiberate the guest and swapoff after resuming.  So swapoff
> performance is important for them.  I think that should be included.
> For the business part, I mean something like "Ubuntu used in AWS EC2", I
> think that isn't important for the patch description.

I just sent a v4 of this patch adding "conclusion" section in the
description to better explain the purpose of this patch. Let me know if
you have any comment on that.

Thanks,
-Andrea
