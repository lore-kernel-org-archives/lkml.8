Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11005C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB6F206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yf2xWWvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgIAPDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgIAPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:03:07 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6FEC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:03:06 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b13so650686qvl.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7hamU6hh70qynnTiDqdZnxkwA4lZpFog+JwYUlEr/IU=;
        b=yf2xWWvk1xRfdDfp5/KDnPzVZmvLVynwUatxUyczMxvoo5qoWCz2qKcQxQU5mFSpxw
         NhRb12uOylBNsJ1CMLYVSQXaAGWHeX/eo1nS6nEmcUx2UPP93DWSblcZlbXuOZxRW1hQ
         mHo5vzXl8FzCyzcogsYpiwRXSh5mq4UzkHPeThfBd8DZnkJ8FI+IEPw7F9doDbu0QrIO
         HR9BQOYBpg2EwPDUPn8el3O4u6N+g7GCcfWVuHk0h1ZFaSA23RnMd7gHXjL3EwbRcCSL
         RikWYHtdni0MdsfqEjfbdfQ7AqmNItT8xlpt3hJYb4MyUNt07Je4rKAOSAMSAHYaS54p
         rVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7hamU6hh70qynnTiDqdZnxkwA4lZpFog+JwYUlEr/IU=;
        b=SH8My7rMv/TvhBh6tZtf66BaoYwLMduWolM8KKu36wYYZWXKFPp5PFjrJpGamuacmr
         g+r1Y8PnbOIvwGcroSwv81CEVyZnKu16RolkRHSaaioqv80mg4lvhQPNNXVVFzYvG6GZ
         ymsetNQ4ZGvHW7l5LQOaDHhZh0Uz2McHTlgodvT6vQS9k7BeeuQwT8Psmadl2f1ECWGr
         cbpl29mDeCRSBYkTgk64XLZuGgomaWZCnbLaF1WiInM7XFvjrxNbwU33+ieTdkQW5ThF
         kFvmDCtLdxMU0Y4BaZJCt2x0hBrnWeJCoW1LkkVcHxO+rEaYL+Kj6KN/WI/hqbt7WQrF
         cKCA==
X-Gm-Message-State: AOAM532wgAcHynCne3rZrP70Fj10ENsH2nZj4yXutr8ZqAtTHtmVFtGz
        y7Ewnz1L2gZ0Rs/KaLLWHwf0mQ==
X-Google-Smtp-Source: ABdhPJwtD/7grvATMu4/sg0JKKjoDM+Eqq34lDdwy3HkegafTZWNtmYCYMELv86LJoXc8FcgmDD6gQ==
X-Received: by 2002:a0c:e04e:: with SMTP id y14mr2200632qvk.117.1598972585297;
        Tue, 01 Sep 2020 08:03:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:fc60])
        by smtp.gmail.com with ESMTPSA id s20sm1850047qkg.65.2020.09.01.08.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:03:04 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:01:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/5] ksm: reinstate memcg charge on copied pages
Message-ID: <20200901150149.GA45118@cmpxchg.org>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
 <alpine.LSU.2.11.2008301358020.5954@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008301358020.5954@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 01:59:35PM -0700, Hugh Dickins wrote:
> In 5.8 some instances of memcg charging in do_swap_page() and unuse_pte()
> were removed, on the understanding that swap cache is now already charged
> at those points; but a case was missed, when ksm_might_need_to_copy() has
> decided it must allocate a substitute page: such pages were never charged.
> Fix it inside ksm_might_need_to_copy().
> 
> This was discovered by Alex Shi's prospective commit "mm/memcg: warning
> on !memcg after readahead page charged".
> 
> But there is a another surprise: this also fixes some rarer uncharged
> PageAnon cases, when KSM is configured in, but has never been activated.
> ksm_might_need_to_copy()'s anon_vma->root and linear_page_index() check
> sometimes catches a case which would need to have been copied if KSM
> were turned on.  Or that's my optimistic interpretation (of my own old
> code), but it leaves some doubt as to whether everything is working as
> intended there - might it hint at rare anon ptes which rmap cannot find?
> A question not easily answered: put in the fix for missed memcg charges.
> 
> Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # v5.8

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
