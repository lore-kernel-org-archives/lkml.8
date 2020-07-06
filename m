Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D145C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D553A206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGFWOT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:14:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2535 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbgGFWOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:14:19 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 2A032ACAB1B20B52FFF3;
        Tue,  7 Jul 2020 06:14:17 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Tue, 7 Jul 2020 06:14:10 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Roman Gushchin <guro@fb.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: RE: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is
 reserved
Thread-Topic: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is
 reserved
Thread-Index: AQHWU3HjjsPjy1jnSk6RkQtfiUWhe6j6kUUAgACKkEA=
Date:   Mon, 6 Jul 2020 22:14:10 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25596AE@DGGEMI525-MBS.china.huawei.com>
References: <20200706084405.14236-1-song.bao.hua@hisilicon.com>
 <20200706214808.GB152560@carbon.lan>
In-Reply-To: <20200706214808.GB152560@carbon.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Roman Gushchin [mailto:guro@fb.com]
> Sent: Tuesday, July 7, 2020 9:48 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: akpm@linux-foundation.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Mike
> Kravetz <mike.kravetz@oracle.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: Re: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is
> reserved
> 
> On Mon, Jul 06, 2020 at 08:44:05PM +1200, Barry Song wrote:
> 
> Hello, Barry!
> 
> > hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
> > no memory. Thus, NULL hugetlb_cma[0] doesn't necessarily mean cma is not
> > enabled. gigantic pages might have been reserved on other nodes.
> 
> Just curious, is it a real-life problem you've seen? If so, I wonder how
> you're using the hugetlb_cma option, and what's the outcome?

Yes. It is kind of stupid but I once got a board on which node0 has no DDR
though node1 and node3 have memory.

I actually prefer we get cma size of per node by:
cma size of one node = hugetlb_cma/ (nodes with memory)
rather than:
cma size of one node = hugetlb_cma/ (all online nodes)

but unfortunately, or the N_MEMORY infrastructures are not ready yet. I mean:

for_each_node_state(nid, N_MEMORY) {
		int res;

		size = min(per_node, hugetlb_cma_size - reserved);
		size = round_up(size, PAGE_SIZE << order);

		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
						 0, false, "hugetlb",
						 &hugetlb_cma[nid], nid);
		...
	}

> 
> >
> > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages
> using cma")
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  mm/hugetlb.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 57ece74e3aae..603aa854aa89 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2571,9 +2571,21 @@ static void __init
> hugetlb_hstate_alloc_pages(struct hstate *h)
> >
> >  	for (i = 0; i < h->max_huge_pages; ++i) {
> >  		if (hstate_is_gigantic(h)) {
> > -			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > -				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip
> boot time allocation\n");
> > -				break;
> > +			if (IS_ENABLED(CONFIG_CMA)) {
> > +				int nid;
> > +				bool cma_reserved = false;
> > +
> > +				for_each_node_state(nid, N_ONLINE) {
> > +					if (hugetlb_cma[nid]) {
> > +						pr_warn_once("HugeTLB: hugetlb_cma is
> reserved,"
> > +								"skip boot time allocation\n");
> > +						cma_reserved = true;
> > +						break;
> > +					}
> > +				}
> > +
> > +				if (cma_reserved)
> > +					break;
> 
> It's a valid problem, and I like to see it fixed. But I wonder if it would be better
> to introduce a new helper bool hugetlb_cma_enabled()? And move both
> IS_ENABLED(CONFIG_CMA)
> and hugetlb_cma[nid] checks there?

Yep. that would be more readable.

> 
> Thank you!

Thanks
Barry

