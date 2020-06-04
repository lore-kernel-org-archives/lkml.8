Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F359DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E312072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dYZAOgRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgFDPGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgFDPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:06:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5DFC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:06:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so6333076qkh.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8aPHmuODMNkghiNSE3FdfFPpmjgGhzU0Gw0NdaYDftw=;
        b=dYZAOgRvOawHCH9hHdcGZK5ZHU37Dhdgzh27m0DwVQ4dfKmcit1D18TBIc6Rr2g43d
         iJw8MgAlXFeV0dF+lAtfu/y/YLXG7zS7PY53Q8FSmI9aijc0cdRb5uQ5uYIj84XsTs5N
         C+wRfBif6fInRFL5EKH2nW7QTN0S8SaeY46DD/wXZaSr7h1xd9ZB+/vRj8WPhlVP1n1S
         BIFel6UfM0eHZtBrMzDLRB0Dv7s90mpYSn9N83e3PqJUiu5ZsnMlkEDKgCjz4eJQBmFG
         4WgE/AsOlisf14X+rlo3ihlPQ4mpfRmxwrx/FHktx9AyILnkKU0m8SNS2385/75OaeS1
         jyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8aPHmuODMNkghiNSE3FdfFPpmjgGhzU0Gw0NdaYDftw=;
        b=UCOhnCd5VuwKPu0GWCsBuIfx1k7SZBqVejSqyzIrNSoImVG/UFykYSQmx7ND1HZCer
         WmgvywW4nDIEcTV+PWJ4AlHo5ILhOgwvG32JYDImlB7qVxGu30yF0E7lbWrvmRSWbbUf
         3Q6VG/YZzJbVjMdWIqqqkbetqKkXzSOT/FhNb7fGXMtcsqgFPAOpyHEiFe0WRusVHCl6
         Pr8M1gyrqW/CrW/dQ49UHQaN3UJK1sFACYXDBLA+SiHnVjAMsAfmwjB0UqQhm76KqnoD
         X6LfR7OzO9lyYLRBkOtzLr5pM/B1CtePspPm2EEk6vEcQG8twG4eu42iVikWWjUD4nHz
         sGsg==
X-Gm-Message-State: AOAM530wamsdqCWW712upfICiK38ETHL26f3yJ5J6dnRwu084iVgdrPp
        3AB47FnBILXJR/KZCSqJsLCguQ==
X-Google-Smtp-Source: ABdhPJyzJcBQ0/65g0lhQRVZCPcGMBRt5vJr00mYqj8YRM+nqFMA/Rf49F9deE955CHjWRGqJW/7uw==
X-Received: by 2002:a05:620a:2110:: with SMTP id l16mr5097811qkl.290.1591283176962;
        Thu, 04 Jun 2020 08:06:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e83c])
        by smtp.gmail.com with ESMTPSA id x13sm3678505qtq.60.2020.06.04.08.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 08:06:15 -0700 (PDT)
Date:   Thu, 4 Jun 2020 11:05:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
Message-ID: <20200604150539.GA322130@cmpxchg.org>
References: <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
 <20200527134333.GF6781@cmpxchg.org>
 <CAAmzW4NW+cv7VnNApWKJr4r9=QKaufK3y5apyNXo-M-y=q0dgg@mail.gmail.com>
 <20200528170155.GA69521@cmpxchg.org>
 <CAAmzW4NEPZRWL5PBXEWwg9kBOL9fYUNqTTzh3WRDWbaSPLv=CQ@mail.gmail.com>
 <20200529151228.GA92892@cmpxchg.org>
 <CAAmzW4Pccc4UcBThhKyqbtY=kK83Fz7k4vYR4eJN4te2E25=_A@mail.gmail.com>
 <20200601155615.GA131075@cmpxchg.org>
 <20200601204424.GA212944@cmpxchg.org>
 <561b79e8-48c7-f2eb-6081-cd82ad7e6010@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561b79e8-48c7-f2eb-6081-cd82ad7e6010@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:35:27PM +0200, Vlastimil Babka wrote:
> On 6/1/20 10:44 PM, Johannes Weiner wrote:
> > From a8faceabc1454dfd878caee2a8422493d937a394 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Mon, 1 Jun 2020 14:04:09 -0400
> > Subject: [PATCH] mm: workingset: let cache workingset challenge anon fix
> 
> Looks like the whole series is now in mainline (that was quick!) without this
> followup? As such it won't be squashed so perhaps the subject should be more
> "standalone" now, description referencing commit 34e58cac6d8f ("mm: workingset:
> let cache workingset challenge anon"), possibly with Fixes: tag etc...

Yep, I'll send a stand-alone version of this. It was a bit fat to get
squashed last minute anyway, and I don't mind having a bit of extra
time to quantify the actual impact of this delta.

Thanks Vlastimil!
