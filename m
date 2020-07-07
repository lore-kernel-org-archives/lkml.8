Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF29CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E1F2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgGGICB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:02:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:52652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgGGICB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:02:01 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 0237E19AA39B59FC9F90;
        Tue,  7 Jul 2020 16:01:59 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Tue, 7 Jul 2020 16:01:53 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Rapoport <rppt@kernel.org>, Roman Gushchin <guro@fb.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v2] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Thread-Topic: [PATCH v2] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Thread-Index: AQHWVAymBZ1xGYd9mEm2J3l6HgJP0Kj68WaAgABDWoCAAIvS8A==
Date:   Tue, 7 Jul 2020 08:01:52 +0000
Message-ID: <B926444035E5E2439431908E3842AFD255A513@DGGEMI525-MBS.china.huawei.com>
References: <20200707031156.29932-1-song.bao.hua@hisilicon.com>
 <20200707033631.GA164297@carbon.dhcp.thefacebook.com>
 <20200707073735.GB9449@kernel.org>
In-Reply-To: <20200707073735.GB9449@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.119]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Rapoport [mailto:rppt@kernel.org]
> Sent: Tuesday, July 7, 2020 7:38 PM
> To: Roman Gushchin <guro@fb.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> akpm@linux-foundation.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Mike
> Kravetz <mike.kravetz@oracle.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: Re: [PATCH v2] mm/hugetlb: avoid hardcoding while checking if cma
> is enable
> 
> On Mon, Jul 06, 2020 at 08:36:31PM -0700, Roman Gushchin wrote:
> > On Tue, Jul 07, 2020 at 03:11:56PM +1200, Barry Song wrote:
> > > hugetlb_cma[0] can be NULL due to various reasons, for example, node0
> has
> > > no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> > > enabled. gigantic pages might have been reserved on other nodes.
> > >
> > > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages
> using cma")
> > > Cc: Roman Gushchin <guro@fb.com>
> > > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > ---
> > >  -v2: add hugetlb_cma_enabled() helper to improve readability according
> to Roman
> > >
> > >  mm/hugetlb.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 57ece74e3aae..d5e98ed86bb9 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -2546,6 +2546,20 @@ static void __init
> gather_bootmem_prealloc(void)
> > >  	}
> > >  }
> > >
> > > +bool __init hugetlb_cma_enabled(void)
> > > +{
> > > +	if (IS_ENABLED(CONFIG_CMA)) {
> > > +		int node;
> > > +
> > > +		for_each_online_node(node) {
> > > +			if (hugetlb_cma[node])
> > > +				return true;
> > > +		}
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> >
> > Can you, please, change it to a more canonical
> >
> > #ifdef CONFIG_CMA
> > bool __init hugetlb_cma_enabled(void)
> > {
> > 	int node;
> >
> > 	for_each_online_node(node)
> > 		if (hugetlb_cma[node])
> > 			return true;
> >
> > 	return false;
> > }
> > #else
> > bool __init hugetlb_cma_enabled(void)
> > {
> > 	return false;
> > }
> > #endif
> >
> > or maybe just
> >
> > bool __init hugetlb_cma_enabled(void)
> > {
> > #ifdef CONFIG_CMA
> > 	int node;
> >
> > 	for_each_online_node(node)
> > 		if (hugetlb_cma[node])
> > 			return true;
> > #endif
> > 	return false;
> > }
> 
> This one please.

Yep. Patch v3 is just the one you prefer:
https://marc.info/?l=linux-mm&m=159409465228477&w=2

> 
> > ?
> >
> > Please, feel free to add
> > Acked-by: Roman Gushchin <guro@fb.com> after that.
> >
> > Thank you!
> >
> 
> --
> Sincerely yours,
> Mike.

Thanks
Barry

