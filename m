Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93245C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6225D2084C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="o+tw60Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgGEPwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgGEPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:52:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF6C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 08:52:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w27so4220933qtb.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TgpAD18UbHNoiwEgaJKuKvKVqh48LFxBCoez9AKzX9A=;
        b=o+tw60Zjl0m06kgAYW3V0nL3dUIgC7FQERNmT/2lvYJXj32GXnARzXuIHbeqaCDtdr
         DZkSFmpPkdVCCajPE8J3H5oWRju5Mumt03tGmHz5DgiIsh7cny53ai3aHTojZnN4OQ5t
         c+1ArRxiiphkDVbk3XLQqYp1ghkuDHiAyO85s6E7GgrebH+8s7GW90HIkUfmijmlir5O
         8wTZ4KE9oaLvb35UvC4Af28/Y9Re2Qqguu0/fIjaZEVtXDLH13x8QqZUOXQkYhOjCup0
         amdNPSuakV0KxbYDGRCtqG9Z8v55LhEUS22NbqKhdMxfDsN8xvWZRpym5889RFCyWx/J
         h7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TgpAD18UbHNoiwEgaJKuKvKVqh48LFxBCoez9AKzX9A=;
        b=CbSZIA56wWWaTXOjcfzgJ9T0ztHRZC1rsrf1fuqAetV8pe+sz0UddEDcddNcG4/8pK
         1lcFgKcjWKq4BptVg3m1lo3b7YqdEyPH9/rN3+qvhGRDdUAUJBmvACQw/tU7lZRxHryN
         qmy9hNjOOUSmmmt2LBPVtR6KrBn50keVAOiXgAI/LBy7kDkywmXBia5TOX55jD0UtTgs
         eYMoWxD92UcMrLIXiBBPp0E23vcDqKEtPiXuWGGD84kFPRpZ7VP4Gg0+Cngmwym39FHc
         1cCju7o9kqlf4lSW193Vf303Z2ripWoH4pnBwA4aHzCZ7Lo5lI2UxEy+Az4xQxwhv1DT
         r9+A==
X-Gm-Message-State: AOAM533wZ9j/Afiasf/W5xFZeoMdglJ6IEgEb2pegGlNyIDm9T6pKJni
        +Fc8foZO6e6R94g1WwHqFs2gjQ==
X-Google-Smtp-Source: ABdhPJxCLVt7C51JiCX3AUjZYrW97O2OrQzyS3GUCDAkbCDVY1maGgowf05vqlzV0Agu2cwVR1C1PA==
X-Received: by 2002:aed:239b:: with SMTP id j27mr46404352qtc.183.1593964359245;
        Sun, 05 Jul 2020 08:52:39 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x4sm14390623qkl.130.2020.07.05.08.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 08:52:38 -0700 (PDT)
Date:   Sun, 5 Jul 2020 11:52:32 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200705155232.GA608@lca.pw>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705125854.GA66252@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 08:58:54PM +0800, Feng Tang wrote:
> On Sun, Jul 05, 2020 at 08:15:03AM -0400, Qian Cai wrote:
> > 
> > 
> > > On Jul 5, 2020, at 12:45 AM, Feng Tang <feng.tang@intel.com> wrote:
> > > 
> > > I did reproduce the problem, and from the debugging, this should
> > > be the same root cause as lore.kernel.org/lkml/20200526181459.GD991@lca.pw/
> > > that loosing the batch cause some accuracy problem, and the solution of
> > > adding some sync is still needed, which is dicussed in
> > 
> > Well, before taking any of those patches now to fix the regression,
> > we will need some performance data first. If it turned out the
> > original performance gain is no longer relevant anymore due to this
> > regression fix on top, it is best to drop this patchset and restore
> > that VM_WARN_ONCE, so you can retry later once you found a better
> > way to optimize.
> 
> The fix of adding sync only happens when the memory policy is being
> changed to OVERCOMMIT_NEVER, which is not a frequent operation in
> normal cases.
> 
> For the performance improvment data both in commit log and 0day report
> https://lore.kernel.org/lkml/20200622132548.GS5535@shao2-debian/
> it is for the will-it-scale's mmap testcase, which will not runtime
> change memory overcommit policy, so the data should be still valid
> with this fix.

Well, I would expect people are perfectly reasonable to use
OVERCOMMIT_NEVER for some workloads making it more frequent operations.
The question is now if any of those regression fixes would now regress
performance of OVERCOMMIT_NEVER workloads or just in-par with the data
before the patchset?

Given now this patchset has had so much churn recently, I would think
"should be still valid" is not really the answer we are looking for.

> 
> Thanks,
> Feng
> 
> 
