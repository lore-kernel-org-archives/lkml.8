Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339E1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BCB0206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="QSlvYWiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIAPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIAPDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:03:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649ACC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:03:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so1112333qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mAaL6U+iakwGOs+fKr9GVAdl6EHOJaIxZ7vvSFP7iy4=;
        b=QSlvYWiApz3Il7TzqFB1RZN0q7RWIwkf5QFz7RNkzlO+xImve52k6f+ehFMq4/w1+2
         zGfYq/J/yn1WLm1/nerm9ZFIcBt9/aMtnrc4is0GNCBmR1gLKui/4PSJTm+KF8St48kS
         kCpHlHeOQf+F+xrvfkYYAFeZDgUosGYBaSkSeZWXRVKKIp+E7vgt8D6VzlxFKpXBkCi5
         6vokKRH5obxIM3wov/h7MeIAyGdI4EWOPPyLFoG0YFf8JrTfshxGr7viaB/R/Gi12gKQ
         VzPDKb7+RQkpyvxykXHJ/rcMXnf28rZVX0VUzRl7OdcwNyphjQ5LxOwG7fT3tbz9hDnU
         GgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mAaL6U+iakwGOs+fKr9GVAdl6EHOJaIxZ7vvSFP7iy4=;
        b=gu0tHS9VQjaSHtrHExS2qwX0FU09A5IS842qMhigH2TJH5ZwkwevD/IxbnuKK1xI6U
         M0IKMxBCwmrg5ioBBZ01nMxTuManIS/ut+kfXPoz4MC53tIJZjXJw6MA80WDzGu+f6FV
         a5CJnk+YJ50tP/hfjGXXSs6TDl3df6tt87NYrQ5zPeSJOEiAZadEWlQ3ch0rJRBvVqR1
         cfdMxTnXHK4D4jzbLyFg9YcBHRjnv9F20ku1Q6MJ/yl3z9wfmCoaAOaJYuWYEWq7+Y5N
         rIcHZiwtGXS+FvT239GmufWTN1+pGOUmakAzh925+mCLWDL01QInIeHycow+Y4GJIGXl
         xSuQ==
X-Gm-Message-State: AOAM5314AOngUSO43MFlkqQGtJDDcLBLnIn7AGqR1Dyi8gz1GIEawBtN
        4VmSzhiBzd9YefNYM3b5UA4isw==
X-Google-Smtp-Source: ABdhPJyJ/mmJ7wKiwiGfXg73+aLX68eKTyDwVHU8p4OwQPU3PwpkwjigQ67x+5KcBMyhz0Rfo3liRA==
X-Received: by 2002:aed:362a:: with SMTP id e39mr2192152qtb.121.1598972628686;
        Tue, 01 Sep 2020 08:03:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:fc60])
        by smtp.gmail.com with ESMTPSA id s20sm1852279qkg.65.2020.09.01.08.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:03:48 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:02:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/5] mm: migration of hugetlbfs page skip memcg
Message-ID: <20200901150232.GB45118@cmpxchg.org>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
 <alpine.LSU.2.11.2008301359460.5954@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008301359460.5954@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 02:01:30PM -0700, Hugh Dickins wrote:
> hugetlbfs pages do not participate in memcg: so although they do find
> most of migrate_page_states() useful, it would be better if they did
> not call into mem_cgroup_migrate() - where Qian Cai reported that LTP's
> move_pages12 triggers the warning in Alex Shi's prospective commit
> "mm/memcg: warning on !memcg after readahead page charged".
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Johannes Weiner <hannes@cmpxch.org>
