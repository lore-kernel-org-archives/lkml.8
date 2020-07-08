Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0269C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7519820708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apFA7dSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbgGHHTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbgGHHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:19:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:19:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so788893pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFOVZ8llBA1PgLKUIDneSWIoZA40NU6uhJVcRvUFfcA=;
        b=apFA7dSWMCjTRVY2tkyx+bUl72ZjDR7vr+ej/cUKcjNFxAuUW/miBWS/ga6KJb7688
         DwXh9TneTrra7aPoVZOfdUa5QQ7G9TnN4WHTdYmvPZriVTtAQwojJHFoqYnpMzuuIdi2
         6Y8fiKP7CBqNChi7a/ipMT6cmAaoPCKBMUP9unFh+Waygt3Bm0UmNdLdx9GOYlLzgdyj
         LhQ3WhCkUx11g1yGNO+JlVq8G4zYow8XIR3as/19Gp8DUhWsKhKOXpQmg3wZI763qDmB
         CgTXC6ePXMrz4rYjg2vZEf3JbUL5Piia9SZmqEsdNYt7Q7g8TQQAO4Ecae4jpl9fu90P
         fKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFOVZ8llBA1PgLKUIDneSWIoZA40NU6uhJVcRvUFfcA=;
        b=EvkeqeXsUEGUnGkSazYA2/yvEcn6GZX5UmWCrq5JVhE1GQNV0cbPjdL2VHApihrFzc
         qrRSZnF05TxXxMr4fulZ/AJ2XiOllNaxG7XyuTEXlS3bYXdxZmhm8e8U+11x4/PJbr0e
         0BYpaEYTfgLFlVo+dRcSjkJ48gLHo2QhAyyZlcZpmDkRmDVoOjNIpzVLIqb+oG3S1HUC
         kkdYhtgQunfcITeZRE8PM2ZqSNadr0eeXfMJOk8OKdG0DVVfzCSCx4gll1IL6wEjT9go
         KxYBYyiq8TLCQ3pRAi6hBs3HsYAwplCqButK/1d8d/IdAF4zux36QFPClMH2acHYbI/Q
         qysQ==
X-Gm-Message-State: AOAM531LbU4kdMoNAmbR/LWcrly6YQWww7zljPBHa49rVtD7FHTI1NP3
        W4GINNsE9qjgvTIYC97l0pU=
X-Google-Smtp-Source: ABdhPJxM5kKF0jbQAF7FHiH5dzyao7PwJJQfdQVJFxAJkxLVB7xIBzvyBLf/3j6LOnb4ucUl+LCmDg==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr8342219pju.193.1594192763212;
        Wed, 08 Jul 2020 00:19:23 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m9sm2667941pgq.61.2020.07.08.00.19.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:19:22 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:19:17 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
Message-ID: <20200708071916.GD16543@js1304-desktop>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707114019.GI5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114019.GI5913@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:40:19PM +0200, Michal Hocko wrote:
> On Tue 07-07-20 16:44:43, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > In mm/migrate.c, THP allocation for migration is called with the provided
> > gfp_mask | GFP_TRANSHUGE. This gfp_mask contains __GFP_RECLAIM and it
> > would be conflict with the intention of the GFP_TRANSHUGE.
> > 
> > GFP_TRANSHUGE/GFP_TRANSHUGE_LIGHT is introduced to control the reclaim
> > behaviour by well defined manner since overhead of THP allocation is
> > quite large and the whole system could suffer from it. So, they deals
> > with __GFP_RECLAIM mask deliberately. If gfp_mask contains __GFP_RECLAIM
> > and uses gfp_mask | GFP_TRANSHUGE(_LIGHT) for THP allocation, it means
> > that it breaks the purpose of the GFP_TRANSHUGE(_LIGHT).
> 
> GFP_TRANSHUGE* is not a carved in stone design. Their primary reason to
> exist is to control how hard to try for different allocation
> paths/configurations because their latency expectations might be
> largerly different. It is mostly the #PF path which aims to be as
> lightweight as possible I believe nobody simply considered migration to be
> very significant to even care. And I am still not sure it matters but
> I would tend to agree that a consistency here is probably a very minor
> plus.
> 
> Your changelog is slightly misleading in that regard because it suggests
> that this is a real problem while it doesn't present any actual data.
> It would be really nice to make the effective change really stand out.
> We are only talking about __GFP_RECLAIM_KSWAPD here. So the only
> difference is that the migration won't wake up kswapd now.
> 
> All that being said the changelog should be probably more explicit about
> the fact that this is solely done for consistency and be honest that the
> runtime effect is not really clear. This would help people reading it in
> future.

Okay. How about following changelog?

Thanks.

----------->8--------------------
Subject: [PATCH] mm/migrate: clear __GFP_RECLAIM for THP allocation for
 migration

In migration target allocation functions, THP allocations uses different
gfp_mask, especially, in regard to the reclaim gfp_mask. There is no
reason to use different reclaim gfp_mask for each cases and it is
an obstacle to make a common function in order to clean-up migration
target allocation functions. This patch fixes this situation by using
common reclaim gfp_mask for THP allocation.
