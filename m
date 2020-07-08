Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77366C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506EF20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNfRXPKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgGHHRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgGHHRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:17:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA1BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:17:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so14712735pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhMuuI5vNcbnBvarMRQMrOcWmQnCGKtCgfJJZCjZZRM=;
        b=gNfRXPKQJZyOCLqMKok3dCryQtTE9/l1IcM0VmU8OFetxR7WB71YQF11TpSSoW4Sn4
         VLCi4m7zC6+cohJpaeELP2a6E4QZRC5WhnTKw4ocvf4xrO8qxLGs01vHRKGPylIOTxKT
         GBrEriUZYwcs4L3N/G0tufYPgknTWKTFexQY0GMBUc48SVZg9Sm5UfvlvPQZ4vwNdQ8+
         KgnsLAcRA5dHScSIYPDN+ZWanVGco7eR8oPkJ+5Z9JswxOPDgbkdy2DiYETxUqdjZ5z/
         IRBf6P/FwXk9KdJn3Kku9ztHVqG16lDk+6spVHaX+cWKSjx8CD6oojvdUQBF79PY63Qx
         4Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhMuuI5vNcbnBvarMRQMrOcWmQnCGKtCgfJJZCjZZRM=;
        b=mxew1qIragskVu4lDt9sxv1xXemPq75r4KXdwtE7AaANM99qHDFDLl3yfrhJdusG6t
         XjEQv6K2zPxQDb5wZourssyqdwPR1uybQ8kWLKLwT+dZf9oYS4tp+uCDnb9A8tMSa7jp
         FbCQ7Ze4LbaikodxVG9u/6o++a0BHCE8EkYMHQgYveQ9Xl2eIZS27Ck9E7yVdx4lodgf
         5jfd25BfIaruaxPKVLMaBidNsa4Hd1kdKK7pJUrfMtZ87AwBnLQrk6rbXLoSjx6W4WHD
         TcVVjPH0ub+qaFBmIfQVJMUVlQbZcCocnhiUOYG7WeT4Tdlg9VZl/OsacOgkx9aSMSMX
         WaWQ==
X-Gm-Message-State: AOAM533gQsbv8HwQ/uuqDyiPU4tmxi8WzV4kl5Ixgi3YPaipLKHQaNkW
        dcwUCCrp54Z3iLmIHKDdVIU=
X-Google-Smtp-Source: ABdhPJyaEcs2L+01gHh1rdVBeWSbBV54fLp/Ma/ouZFhVGdL/DzwfSoHeSyt+K6Q0TCKnYzTiIIjrw==
X-Received: by 2002:a65:5b05:: with SMTP id y5mr47628834pgq.90.1594192632697;
        Wed, 08 Jul 2020 00:17:12 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id a26sm2961234pgm.20.2020.07.08.00.17.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:17:12 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:17:07 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
Message-ID: <20200708071706.GC16543@js1304-desktop>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com>
 <e72709dd-c7e2-ff26-f450-dbd2a719b2e4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e72709dd-c7e2-ff26-f450-dbd2a719b2e4@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 02:17:55PM +0200, Vlastimil Babka wrote:
> On 7/7/20 9:44 AM, js1304@gmail.com wrote:
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
> > 
> > This patch fixes this situation by clearing __GFP_RECLAIM in provided
> > gfp_mask. Note that there are some other THP allocations for migration
> > and they just uses GFP_TRANSHUGE(_LIGHT) directly. This patch would make
> > all THP allocation for migration consistent.
> > 
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/migrate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 02b31fe..ecd7615 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page,
> >  	}
> >  
> >  	if (PageTransHuge(page)) {
> > +		/*
> > +		 * clear __GFP_RECALIM since GFP_TRANSHUGE is the gfp_mask
> > +		 * that chooses the reclaim masks deliberately.
> > +		 */
> > +		gfp_mask &= ~__GFP_RECLAIM;
> >  		gfp_mask |= GFP_TRANSHUGE;
> 
> In addition to what Michal said...
> 
> The mask is not passed to this function, so I would just redefine it, as is done
> in the hugetlb case. We probably don't even need the __GFP_RETRY_MAYFAIL for the
> THP case asi it's just there to prevent OOM kill (per commit 0f55685627d6d ) and
> the costly order of THP is enough for that.

Will check.

Thanks.

