Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20557C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C2B206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594117722;
	bh=eIcQ5nPQOJJhqn6Wn4AnVmICbfSxezRxkLQbN3Z4mCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I/Jr53D213Y/ex32JWwAk86tnsKjXNC3BRRm25FfbZMp7G0SWIIqmS7i9Mt0KH4KQ
	 +M2Q+HJT/kFmPJxjgOgXAixHXS+dCyY5vo6TySrxRI9BqlwmcmZYHfstc1mT3I9+qY
	 2pBozmiyN9MhC/gazGbY/dwLd1pToLze997MREiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGK2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:28:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51103 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGGK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:28:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id l17so42726061wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xEHe53nkOvtQEtBBQA2XJt6Y8h12NwG7k86WiRp378=;
        b=Agzgy4tGUYX3M0w0wkFOtiZttjm1GDsOPfMd6nRns+YM3FSFV6fXLsF6xwf+orZAGW
         mON8EXispiL1iAAp5udzrjYPgpCXW+zd+XZ4iwescyWMpyn9x7U4cbLm3bwOvlMMaCxz
         Atfy8l7pbIOMqvB6ca4lEqFSIW32qGTgWB8kvHuyLpZjg6vFFsR+Gahtwzxnr9c3jnQI
         eClpCDULvFPpVs9uE4dKmqOo68NDPUvmPMCVvtAJgBeCvw3y0l0dKMH5gB88cygvNn4s
         zKog7H4fxZQTbYNEWtYH8gAaEfEnMTgtu0A3qgtrqpGpj1fcYfHRyM1Gn1HrcFF2zKvj
         176A==
X-Gm-Message-State: AOAM533OTLMFXMvkwahGRFAd5u+KOJtpBgXDR4RkTLVp6mRkJQH35+r2
        exSLBPeHKm6i/A9ggh4f39ZNPIs+
X-Google-Smtp-Source: ABdhPJxSRv/Jy+YzjF1IdFV7nYK/ayucM1zWbPivKXkRs7+doAYqRFDABnC4xnZ8WeDm1/U7v1CgqA==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr3745590wmd.152.1594117718227;
        Tue, 07 Jul 2020 03:28:38 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id g13sm385407wro.84.2020.07.07.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:28:37 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:28:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200707102835.GE5913@dhcp22.suse.cz>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705155232.GA608@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 05-07-20 11:52:32, Qian Cai wrote:
> On Sun, Jul 05, 2020 at 08:58:54PM +0800, Feng Tang wrote:
> > On Sun, Jul 05, 2020 at 08:15:03AM -0400, Qian Cai wrote:
> > > 
> > > 
> > > > On Jul 5, 2020, at 12:45 AM, Feng Tang <feng.tang@intel.com> wrote:
> > > > 
> > > > I did reproduce the problem, and from the debugging, this should
> > > > be the same root cause as lore.kernel.org/lkml/20200526181459.GD991@lca.pw/
> > > > that loosing the batch cause some accuracy problem, and the solution of
> > > > adding some sync is still needed, which is dicussed in
> > > 
> > > Well, before taking any of those patches now to fix the regression,
> > > we will need some performance data first. If it turned out the
> > > original performance gain is no longer relevant anymore due to this
> > > regression fix on top, it is best to drop this patchset and restore
> > > that VM_WARN_ONCE, so you can retry later once you found a better
> > > way to optimize.
> > 
> > The fix of adding sync only happens when the memory policy is being
> > changed to OVERCOMMIT_NEVER, which is not a frequent operation in
> > normal cases.
> > 
> > For the performance improvment data both in commit log and 0day report
> > https://lore.kernel.org/lkml/20200622132548.GS5535@shao2-debian/
> > it is for the will-it-scale's mmap testcase, which will not runtime
> > change memory overcommit policy, so the data should be still valid
> > with this fix.
> 
> Well, I would expect people are perfectly reasonable to use
> OVERCOMMIT_NEVER for some workloads making it more frequent operations.

Would you have any examples? Because I find this highly unlikely.
OVERCOMMIT_NEVER only works when virtual memory is not largerly
overcommited wrt to real memory demand. And that tends to be more of
an exception rather than a rule. "Modern" userspace (whatever that
means) tends to be really hungry with virtual memory which is only used
very sparsely.

I would argue that either somebody is running an "OVERCOMMIT_NEVER"
friendly SW and this is a permanent setting or this is not used at all.
At least this is my experience.

So I strongly suspect that LTP test failure is not something we should
really lose sleep over. It would be nice to find a way to flush existing
batches but I would rather see a real workload that would suffer from
this imprecision.

On the other hand perf. boost with larger batches with defualt overcommit
setting sounds like a nice improvement to have.
-- 
Michal Hocko
SUSE Labs
