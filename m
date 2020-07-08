Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B38C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A272078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAqV25Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgGHHVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730410AbgGHHVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:21:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D994DC061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:21:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id k27so5158258pgm.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ogE4o4WvozDyfT3UOGRAcLiOplwqpD6nSKH21zq1lM8=;
        b=kAqV25AjWwvyshU6McP4HVGr65hx8/Op0fGWcZQqPVJylcSASp+dRZP961RdArQbu7
         Y3ATp7t5QSVVH1fQDEOcHyYQ9MQHzcDnAcp2Hhzn4tW/CO4gKza0v6cQ/H3JND9zN8Rp
         K5TvTMSldPNMCIUxlCmRO6xs7jSUXNXcIPgE5sWeWPiQP0cLXrGiiC6GYf/qYuBlZp99
         X5+wsArr5oaRRRwtZQ2WAyPt6ppKcgQwoURXbCF+y63+//38amRsA715cHNQXyFJD2Lz
         +EuK+pwgl7cQwqnzWh9mY2K3JBWYDtcsGo/o1gCE3ccbalCPKuTC+6iqNpopYctuf0Dv
         mRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ogE4o4WvozDyfT3UOGRAcLiOplwqpD6nSKH21zq1lM8=;
        b=gI/3IBqr3wZgwfF/tJV0h45N0QQ4Kv/IU1OYPR+wtqUXojJfXClhqEuSrvdTJAQ9dI
         m0MPP1q6RSFAnF4WP9ErjuXfoeWpQHxeIMZpkA6sCPdVgj889BABmIFpoVUTWPyCbHw9
         rzqObovtvYySpr1+8zRWIubrYum9gsKQLlNm996T3m1uc+W42gu4GU1x+3vbFz/kWFOr
         aPUzvGAwp+hOINLo7COlPh2KkLdhGE38VLQIjUWJ8utJSo6gN+ebYWQv+W2+IDakMNjN
         PH8LsSDw19Bf2Re5Ebt8PvfmJLzppwXTXSxV08hDccBjahvY6YH3JvRc4Wu+fGjAnwXF
         buKw==
X-Gm-Message-State: AOAM530NcsLdUD41RvRhUmI/aZ6/JA266feFms7DgndZ5hcM47HSX7Ho
        jUMmJ/JE3qgWolk+rEHxpfQ=
X-Google-Smtp-Source: ABdhPJwrlbUsS7TeV9hM3LoBNXqKgo9gOcQwCKsO/qWe2aHmCDEm2vYvUkIhJFFrYMBZX76HoZx8Qg==
X-Received: by 2002:a65:4149:: with SMTP id x9mr49796092pgp.424.1594192898437;
        Wed, 08 Jul 2020 00:21:38 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id mu17sm4886807pjb.53.2020.07.08.00.21.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:21:38 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:21:33 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v4 07/11] mm/gup: use a standard migration target
 allocation callback
Message-ID: <20200708072132.GE16543@js1304-desktop>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-8-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707114614.GK5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114614.GK5913@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 01:46:14PM +0200, Michal Hocko wrote:
> On Tue 07-07-20 16:44:45, Joonsoo Kim wrote:
> [...]
> > @@ -1551,9 +1552,12 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> >  
> >  		gfp_mask |= htlb_alloc_mask(h);
> >  		return alloc_huge_page_nodemask(h, nid, mtc->nmask,
> > -						gfp_mask, false);
> > +						gfp_mask, mtc->skip_cma);
> >  	}
> >  
> > +	if (mtc->skip_cma)
> > +		flags = memalloc_nocma_save();
> > +
> 
> As already mentioned in previous email this is a completely wrong usage
> of the scope API. The scope should be defined by the caller and this
> should be all transparent by the allocator layer.

Okay. Like as newly sent patch for 04/11, this patch will also be changed.

Thanks.
