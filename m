Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA68F21BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhhLv7aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGNApH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgGNApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:45:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:45:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so742509pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBTyfKNSoOOAA6vthAh0GUlk56zoCc5lLvp+bO9Vv3E=;
        b=BhhLv7aR3XvHyj0G9jQ/atdmxZQs2oDAmIf8x862jazgWBT0pROFNWSOzrzCPokV6u
         COYzMdGczxuZIbvAj0P3dkFiMDon6yIGGGjAVY4Mh91qpfKMPsyeYh3XALr28LcWp6Fd
         CLScefcYAWwIEPxaBorme5WcNyghNuijC0BEfDpesrvwqe/Qe1j25ixQOuHAGSNeQsbN
         W2dSEww9mvjeRE1qo6MVs4nUg16/49mGnzjqKeh8p3f6JC4eVpTf1n6wFvYcrRvFRBsk
         Dg/dr3OhH0X4AfETba4MczpQIHWhkmsQqNHZnf5k3uqZ2fxwMgTskZEGnR81arLauJfJ
         k3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBTyfKNSoOOAA6vthAh0GUlk56zoCc5lLvp+bO9Vv3E=;
        b=p0lZaJI5IcorQAZ1p3rBEwlDbHTjnfhHlUHrolGh7qhr0xAYDHvo08dUakjTSHsdTL
         n7KS1iFfk0jtQtgQ6113WzceQsTsYYhMlixBWQ0rnQIR6/Y2l42yqexRmHJWYjTxIRy2
         s40Yw54hPo7RMLyb/9rhR2TQvpcfN0U18QLiljgvtO2AdWypiDv7dEIoRBTKFLTkSGCi
         OQpzQWoSNLHkFTQ2uVVAUqo+R0tU8ykHP856lo25U4blU8RCbvyoNa6DZNl3xdHYVUVi
         VWM+Mquhgh8IutMpktKBA1SB4+U3GJEJDQuhcFfOF+Xi5rleEX22eFGVj07y+/svtVic
         VxBQ==
X-Gm-Message-State: AOAM533LU6Z1daoPlyyp2o8YZcsefFnTAndJ/qv0w7TIh6+zURwmpksZ
        wZaVcnd33yvddDG3ChLk1/Y=
X-Google-Smtp-Source: ABdhPJyqusT08COj1lT1I30BN2LIw0I5TAtC0c9JQlwzwNXf1PCndFazNtTjOMjj8N0ychbGGlddBw==
X-Received: by 2002:a17:90a:ff16:: with SMTP id ce22mr2075545pjb.160.1594687506391;
        Mon, 13 Jul 2020 17:45:06 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x13sm9663755pfj.122.2020.07.13.17.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 17:45:05 -0700 (PDT)
Date:   Tue, 14 Jul 2020 09:44:59 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v5 4/9] mm/migrate: clear __GFP_RECLAIM to make the
 migration callback consistent with regular THP allocations
Message-ID: <20200714004446.GA7891@js1304-desktop>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594622517-20681-5-git-send-email-iamjoonsoo.kim@lge.com>
 <367ca602-1112-f87f-7d2a-b0a75cce7269@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367ca602-1112-f87f-7d2a-b0a75cce7269@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:52:20AM +0200, Vlastimil Babka wrote:
> On 7/13/20 8:41 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > new_page_nodemask is a migration callback and it tries to use a common
> > gfp flags for the target page allocation whether it is a base page or a
> > THP. The later only adds GFP_TRANSHUGE to the given mask. This results
> > in the allocation being slightly more aggressive than necessary because
> > the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
> > allocations usually exclude this flag to reduce over eager background
> > reclaim during a high THP allocation load which has been seen during
> > large mmaps initialization. There is no indication that this is a
> > problem for migration as well but theoretically the same might happen
> > when migrating large mappings to a different node. Make the migration
> > callback consistent with regular THP allocations.
> > 
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Thanks!
> 
> Typo below (I assume Andrew will fix it)
> 
> > ---
> >  mm/migrate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 3b3d918..1cfc965 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
> >  	}
> >  
> >  	if (PageTransHuge(page)) {
> > +		/*
> > +		 * clear __GFP_RECALIM to make the migration callback
> 
>                          __GFP_RECLAIM
> 

Okay. Here goes a fixed version.

Thanks!


---------------------->8-----------------------------
From 6273f02fd8b8ef066c10c4a8ba54ea9efe6e70cd Mon Sep 17 00:00:00 2001
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date: Mon, 6 Jul 2020 14:34:04 +0900
Subject: [PATCH v5 4/9] mm/migrate: clear __GFP_RECLAIM to make the migration
 callback consistent with regular THP allocations

new_page_nodemask is a migration callback and it tries to use a common
gfp flags for the target page allocation whether it is a base page or a
THP. The later only adds GFP_TRANSHUGE to the given mask. This results
in the allocation being slightly more aggressive than necessary because
the resulting gfp mask will contain also __GFP_RECLAIM_KSWAPD. THP
allocations usually exclude this flag to reduce over eager background
reclaim during a high THP allocation load which has been seen during
large mmaps initialization. There is no indication that this is a
problem for migration as well but theoretically the same might happen
when migrating large mappings to a different node. Make the migration
callback consistent with regular THP allocations.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/migrate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 3b3d918..faabb2e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
 	}
 
 	if (PageTransHuge(page)) {
+		/*
+		 * clear __GFP_RECLAIM to make the migration callback
+		 * consistent with regular THP allocations.
+		 */
+		gfp_mask &= ~__GFP_RECLAIM;
 		gfp_mask |= GFP_TRANSHUGE;
 		order = HPAGE_PMD_ORDER;
 	}
-- 
2.7.4

