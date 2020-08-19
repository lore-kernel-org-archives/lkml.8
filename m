Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608CB2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLIfSR7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHSXjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSXjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:39:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BDFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:39:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s2so540193ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m4rVil/+BbCJUuTNwOMLbJlYA+TW6cPNzlaZT6ijW5A=;
        b=sLIfSR7eZvFjgKSgew6xoITS6aRH/TGBeFWD14D5ilcTkdapcrGn5yYceeXLf/xtpk
         vKFRHKYWD6dYP+aSUxNcnaoCdeAEDwY4HoGHUhk/VYzhqnPrOPZk+cesdV1gu8N5LOiV
         T37x+a5HZ8RREy16jMqs4I9SxxlQbvA4EyahEtfk0I3SOj3kBGnIVpGY0As84/hTfJ8W
         zhSFdzf7kVlvGICF/r5Bw3cLHDt/sEYa1cphUh3OaFXRr86pruO/NElZfPGe97KZWRsC
         BJd3v6k9jyi3SkCXsuhL/bumNA+wrVz6Sj++vJnQ2fYsS3t+Tdpp2LRSDw+VwSwzAAxL
         7MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4rVil/+BbCJUuTNwOMLbJlYA+TW6cPNzlaZT6ijW5A=;
        b=OmtXpPBd8Ed98n47VBUKrsqka8DiKN9wzoAKF9FnP4OZdubs3d/xWyK6RB73+Lu2bP
         aRTCU3ZOfu6ZjpQL6UswGOqRUvD28ZfvHuR0fRYK0YVGp19ge+DISQA5kUPTmy1yS9Ra
         iZPyOxitHYwJRWRb1UyWyDYvyr+EDE6xc2G9Mzoqp78viM0PWnm/7Yef08OS2JRq6e94
         O8DL2UR4nHvHFsgz6OHXtL6z9Py2np61pnCFhncdRFQfTMEDWdjyTCAZan21ZgcLW2N9
         8JGBQuGu6yKDhtMAwiMAdlRY/qjdAnVSqJSqFDMkaetF94u32TKBtS6zv8Pp1Hs7osN2
         /pLA==
X-Gm-Message-State: AOAM532lTXErgTP/PQiMyn478Xu8IYEPHvfUPdB5Lm610HBOAN8S4IZd
        0/wPtiKT/FhiSD8aaFkMDhVsdw==
X-Google-Smtp-Source: ABdhPJwl9UuZYqWa4keqdy8S8v+a7xvgLMO8aOmJLjnjXoH8lmQjKvGVZDrWAI9CHWEfsdFidc/0ig==
X-Received: by 2002:a02:a302:: with SMTP id q2mr741415jai.102.1597880361716;
        Wed, 19 Aug 2020 16:39:21 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id o1sm366203ils.1.2020.08.19.16.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 16:39:20 -0700 (PDT)
Date:   Wed, 19 Aug 2020 17:39:16 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 3/3] mm: remove superfluous __ClearPageWaiters()
Message-ID: <20200819233916.GA2021304@google.com>
References: <20200818184704.3625199-1-yuzhao@google.com>
 <20200818184704.3625199-3-yuzhao@google.com>
 <CAHbLzkr7oPFtUog1zJWs54dsS8dhwkWp6ET_Zk71nXmRMtGvDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkr7oPFtUog1zJWs54dsS8dhwkWp6ET_Zk71nXmRMtGvDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 04:06:32PM -0700, Yang Shi wrote:
> On Tue, Aug 18, 2020 at 11:47 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Presumably __ClearPageWaiters() was added to follow the previously
> > removed __ClearPageActive() pattern.
> >
> > Only flags that are in PAGE_FLAGS_CHECK_AT_FREE needs to be properly
> > cleared because otherwise we think there may be some kind of leak.
> > PG_waiters is not one of those flags and leaving the clearing to
> > PAGE_FLAGS_CHECK_AT_PREP is more appropriate.
> 
> Actually TBH I'm not very keen to this change, it seems the clearing
> is just moved around and the allocation side pays for that instead of
> free side.

I'll assume you are referring to the overhead from clearing
PG_waiters. First of all, there is no overhead -- we should have a
serious talk with the hardware team who makes word-size bitwise AND
more than one instruction. And the clearing is done in
free_pages_prepare(), which has nothing to do with allocations.
