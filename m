Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD7820720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594107463;
	bh=BF/9d7raiGWUHJ5VCEYHildUE4Bc46UC4HFzLOSAoDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ZWFw3Em6KBqxTN3lMNTcMpPObH+md6StHQwlisrC1e0gcTZ1DjcD64dNf+cP7Sc4
	 4kGj8s+9Ttk4fnMHsplb/M5oq0qpyBRuG3Cf8YKa3xUqeIgMVD6HQhxI2mHVA49XS6
	 oWU6L1tvoIhzDaicxU4IZji+9SdoB9GqbNFQ57vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGGHhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgGGHhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:37:41 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2286206E2;
        Tue,  7 Jul 2020 07:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594107460;
        bh=BF/9d7raiGWUHJ5VCEYHildUE4Bc46UC4HFzLOSAoDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiyY7dVThrJzbTOWbbKMgtRYXguD5FReKSYQajzHKozoRHrziwsBDkEkSDkf7ExXJ
         C3Y9jrDr4Q//FWhZVVoz56Vlv+2LB52CWofjh/aB+Mu+AsLsIS4YCf3QMVlZrfezNP
         zv+AVhV1bcd66K4falGbYYyghdvOImy7emAw6nr8=
Date:   Tue, 7 Jul 2020 10:37:35 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2] mm/hugetlb: avoid hardcoding while checking if cma is
 enable
Message-ID: <20200707073735.GB9449@kernel.org>
References: <20200707031156.29932-1-song.bao.hua@hisilicon.com>
 <20200707033631.GA164297@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707033631.GA164297@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 08:36:31PM -0700, Roman Gushchin wrote:
> On Tue, Jul 07, 2020 at 03:11:56PM +1200, Barry Song wrote:
> > hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> > no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> > enabled. gigantic pages might have been reserved on other nodes.
> > 
> > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  -v2: add hugetlb_cma_enabled() helper to improve readability according to Roman
> > 
> >  mm/hugetlb.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 57ece74e3aae..d5e98ed86bb9 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2546,6 +2546,20 @@ static void __init gather_bootmem_prealloc(void)
> >  	}
> >  }
> >  
> > +bool __init hugetlb_cma_enabled(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_CMA)) {
> > +		int node;
> > +
> > +		for_each_online_node(node) {
> > +			if (hugetlb_cma[node])
> > +				return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> 
> Can you, please, change it to a more canonical
> 
> #ifdef CONFIG_CMA
> bool __init hugetlb_cma_enabled(void)
> {
> 	int node;
> 
> 	for_each_online_node(node)
> 		if (hugetlb_cma[node])
> 			return true;
> 
> 	return false;
> }
> #else
> bool __init hugetlb_cma_enabled(void)
> {
> 	return false;
> }
> #endif
> 
> or maybe just 
> 
> bool __init hugetlb_cma_enabled(void)
> {
> #ifdef CONFIG_CMA
> 	int node;
> 
> 	for_each_online_node(node)
> 		if (hugetlb_cma[node])
> 			return true;
> #endif
> 	return false;
> }

This one please.

> ?
> 
> Please, feel free to add
> Acked-by: Roman Gushchin <guro@fb.com> after that.
> 
> Thank you!
> 

-- 
Sincerely yours,
Mike.
