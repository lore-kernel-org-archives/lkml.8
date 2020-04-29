Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EFBC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A566820775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588150850;
	bh=yEzxrstK5dzNT/VLNG968kTNhLrCVF/DhgbUdAc0LcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LJqrNx2tNqwxKMSYoZg1EYNTO/Od1tMW1uMsmrP0M8tkTnacGzIqbY4aMe64pjVLt
	 x747XV7m43FLRbBhFyr1dpe3o7/ReWXVah8dtjSczoUCOchfBBE+0ak11QGut5sQLV
	 dWF+Pbj7KxbleqMaP9ntHIWiLyRkvWFqfBqfvBks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD2JAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:00:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54239 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2JAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:00:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id k12so1127191wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 02:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFWKpwDYdj0bi9LcW9uHrGndjd6KiGSzaHWUYSzaL0w=;
        b=JuHaPUsUJSqfwOkV+mfWaQKlysaa5MdfQoFmoJgoWIdEJqeFMK0ubO1WGHDFf6WKX8
         5UEIPcSWcIhiT918fpVb6VMfXS5VR4n9spMvxePeybWJ971Ttg6PeM5DX9k8F9zNppY2
         gx/nV/yXQyKd76xsC98M5RIbotGD6Ic93/rqi27PXYvwH2Nua5s0I9EOsJn3cJ6mPa7i
         daJEW6v1LurX56m15ZEK6lZPK6WEmJEm+JZYTfhZEamhqTldPmdUQ5HSz5FbJlKVQmEl
         ynugf7HhHZHkga1EOUCTG0H3bfMWAtKwXGJzQcM79YXnCvPDZX9hxNyaO3mbxCoi8uJG
         xcfA==
X-Gm-Message-State: AGi0PuY7bFW9e+nnELmIzJsnGrQfkjThLuG+GZI18sEdv8Yp/eABMo7s
        d5mC6csVEAQ0qmZI+wG8o2M=
X-Google-Smtp-Source: APiQypKhm2pknR3kic67AlinqfHRhuuiLKc2SzzCco52awaQIbhagtaRRCfaA9cGxv1D/yNJfeFWxQ==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr2024417wmd.95.1588150847575;
        Wed, 29 Apr 2020 02:00:47 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id f18sm32723955wrq.29.2020.04.29.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 02:00:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:00:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-ID: <20200429090045.GW28637@dhcp22.suse.cz>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <alpine.DEB.2.22.394.2004271558540.248401@chino.kir.corp.google.com>
 <20200427163558.5b08487d63da3cc7a89bf50b@linux-foundation.org>
 <20200428074301.GK28637@dhcp22.suse.cz>
 <94f9b716-b251-79d8-2c8c-70d63a255496@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f9b716-b251-79d8-2c8c-70d63a255496@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 10:31:41, peter enderborg wrote:
> On 4/28/20 9:43 AM, Michal Hocko wrote:
> > On Mon 27-04-20 16:35:58, Andrew Morton wrote:
> > [...]
> >> No consumer of GFP_ATOMIC memory should consume an unbounded amount of
> >> it.
> >> Subsystems such as networking will consume a certain amount and
> >> will then start recycling it.  The total amount in-flight will vary
> >> over the longer term as workloads change.  A dynamically tuning
> >> threshold system will need to adapt rapidly enough to sudden load
> >> shifts, which might require unreasonable amounts of headroom.
> > I do agree. __GFP_HIGH/__GFP_ATOMIC are bound by the size of the
> > reserves under memory pressure. Then allocatios start failing very
> > quickly and users have to cope with that, usually by deferring to a
> > sleepable context. Tuning reserves dynamically for heavy reserves
> > consumers would be possible but I am worried that this is far from
> > trivial.
> >
> > We definitely need to understand what is going on here.  Why doesn't
> > kswapd + N*direct reclaimers do not provide enough memory to satisfy
> > both N threads + reserves consumers? How many times those direct
> > reclaimers have to retry?
> 
> Was this not supposed to be avoided with PSI, user-space should
> a fair change to take actions before it goes bad in user-space?

Yes, PSI is certainly a tool to help userspace make actions on heavy
reclaim. And I agree that if there is a desire to trigger the oom killer
early as David states elsewhere in the thread then this approach should
be considered.
-- 
Michal Hocko
SUSE Labs
