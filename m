Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE167C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E692075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HfohxZ2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406906AbgE2Ctk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406751AbgE2Cth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:49:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6423C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:49:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c12so925557qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bOT31TWiypZmJObYsygEhpXLQD/+7tvvPPQzjH2iK+4=;
        b=HfohxZ2GIu5+oSUPEPf/k32GpfCruq17SI6d356N61VFNYWJF7rv7vAleBaSQ4mpQz
         Ez+myrFifwvsEUyqPFS2BmS3ZHET2Oal9C6dHhaizKRmKivLz8HDqglQi/8gIg1Qa0Vi
         PLZ5HKzFMeGgpAswmoaxuf5dZz3ewOWmGEfqx1m2eP7NpoMk3FxEhwoohTqx3AXCMhzi
         gjVHzD5vzaW7EBBXYK+HvqbmCrAqDTUpnrhsCKC9pi86zHKqgkeyWe7XzLBsIAc43swa
         dTeWA7zG4yUzGm44EG+pcq1GGwdZBGdprgizT3/JEZ98hnCy4mnb4kauExl3LLefBGOE
         2FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bOT31TWiypZmJObYsygEhpXLQD/+7tvvPPQzjH2iK+4=;
        b=Sc/OXCHAHttZ84glc5VIquw4/nmjFXWwWn3LB7mHLuGnqArliTn4LCVQbKqSbs1Trx
         zS1dJ+3VKwDnOzsQKjX2TBp2dg8ve+/VEUI08E+rTXGzrftlpDEjrnxm23WEDX/WA30Y
         WHpxtyRfZDQw6xllVlXqRHDADJ4woEdyU/9AXOgPDN/OHqQXlLlGO8fAMM90EUw2BIYz
         8CsKz1huACOL6Kl2S0UCp3zdN5rBbTkNUjUjGhC38DEpqlNBMDsD6Cmp8WiOMFnEMwhP
         rrRR8JwFMGHsXPEh9J0Gzs8p93XtdhZ/FqkKotrSuNofU6J/QKxgqQbwoApc00Hp2U6K
         RCcw==
X-Gm-Message-State: AOAM533t0jm0Cs8pb5xjdrzkEE26duKr9+OYHpY/YAzT0JWHcDYWjyy0
        1tD/XWnk9lr6ujG2cPAra74fKQ==
X-Google-Smtp-Source: ABdhPJx2xge27p3v7EEKQbDhMTCGr7fnY6FaebGQuk8Xn7nGHqq0hgZ+nDqxhhRf3YEz8M9ySlW1OA==
X-Received: by 2002:a37:688e:: with SMTP id d136mr5134004qkc.486.1590720576927;
        Thu, 28 May 2020 19:49:36 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a7sm6907664qth.61.2020.05.28.19.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:49:36 -0700 (PDT)
Date:   Thu, 28 May 2020 22:49:28 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for
 vm_committed_as underflow check
Message-ID: <20200529024928.GA4566@lca.pw>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590714370-67182-4-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:06:09AM +0800, Feng Tang wrote:
> As is explained by Michal Hocko:
> 
> : Looking at the history, this has been added by 82f71ae4a2b8
> : ("mm: catch memory commitment underflow") to have a safety check
> : for issues which have been fixed. There doesn't seem to be any bug
> : reports mentioning this splat since then so it is likely just
> : spending cycles for a hot path (yes many people run with DEBUG_VM)
> : without a strong reason.

Hmm, it looks like the warning is still useful to catch issues in,

https://lore.kernel.org/linux-mm/20140624201606.18273.44270.stgit@zurg
https://lore.kernel.org/linux-mm/54BB9A32.7080703@oracle.com/

After read the whole discussion in that thread, I actually disagree with
Michal. In order to get ride of this existing warning, it is rather
someone needs a strong reason that could prove the performance hit is
noticeable with some data.

> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> ---
>  mm/util.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 3c7a08c..fe63271 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -814,14 +814,6 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  {
>  	long allowed;
>  
> -	/*
> -	 * A transient decrease in the value is unlikely, so no need
> -	 * READ_ONCE() for vm_committed_as.count.
> -	 */
> -	VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as) <
> -			-(s64)vm_committed_as_batch * num_online_cpus()),
> -			"memory commitment underflow");
> -
>  	vm_acct_memory(pages);
>  
>  	/*
> -- 
> 2.7.4
> 
