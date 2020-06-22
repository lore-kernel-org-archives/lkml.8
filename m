Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D627EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAE12076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgFVTzW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:55:22 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728469AbgFVTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:55:21 -0400
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 2A294B9ADE7E2F007BED;
        Tue, 23 Jun 2020 03:55:18 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Tue, 23 Jun 2020 03:55:14 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] mm/zswap: fix a couple of memory leaks and rework
 kzalloc failure check
Thread-Topic: [PATCH][next] mm/zswap: fix a couple of memory leaks and
 rework kzalloc failure check
Thread-Index: AQHWSKrZL+ewyBWBGU2y0eVQs72K+KjkblmAgACdXuA=
Date:   Mon, 22 Jun 2020 19:55:14 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2514C4B@DGGEMI525-MBS.china.huawei.com>
References: <20200622153546.49880-1-colin.king@canonical.com>
 <20200622182816.GF4151@kadam>
In-Reply-To: <20200622182816.GF4151@kadam>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, June 23, 2020 6:28 AM
> To: Colin King <colin.king@canonical.com>
> Cc: Seth Jennings <sjenning@redhat.com>; Dan Streetman
> <ddstreet@ieee.org>; Vitaly Wool <vitaly.wool@konsulko.com>; Andrew
> Morton <akpm@linux-foundation.org>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; Stephen Rothwell <sfr@canb.auug.org.au>;
> linux-mm@kvack.org; kernel-janitors@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH][next] mm/zswap: fix a couple of memory leaks and
> rework kzalloc failure check
> 
> On Mon, Jun 22, 2020 at 04:35:46PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > kzalloc failures return NULL on out of memory errors, so replace the
> > IS_ERR_OR_NULL check with the usual null pointer check.  Fix two memory
> > leaks with on acomp and acomp_ctx by ensuring these objects are free'd
> > on the error return path.
> >
> > Addresses-Coverity: ("Resource leak")
> > Fixes: d4f86abd6e35 ("mm/zswap: move to use crypto_acomp API for
> hardware acceleration")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>


Colin, thanks for your patch. I am sorry I did the same thing with you here:
https://lkml.org/lkml/2020/6/22/347


> > ---
> >  mm/zswap.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 0d914ba6b4a0..14839cbac7ff 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -433,23 +433,23 @@ static int zswap_cpu_comp_prepare(unsigned int
> cpu, struct hlist_node *node)
> >  		return 0;
> >
> >  	acomp_ctx = kzalloc(sizeof(*acomp_ctx), GFP_KERNEL);
> > -	if (IS_ERR_OR_NULL(acomp_ctx)) {
> > +	if (!acomp_ctx) {
> >  		pr_err("Could not initialize acomp_ctx\n");
> >  		return -ENOMEM;
> >  	}
> >  	acomp = crypto_alloc_acomp(pool->tfm_name, 0, 0);
> > -	if (IS_ERR_OR_NULL(acomp)) {
> > +	if (!acomp) {
> 
> This should be IS_ERR(acomp).  Please preserve the error code.
> 
> >  		pr_err("could not alloc crypto acomp %s : %ld\n",
> >  				pool->tfm_name, PTR_ERR(acomp));
> > -		return -ENOMEM;
> > +		goto free_acomp_ctx;
> >  	}
> >  	acomp_ctx->acomp = acomp;
> >
> >  	req = acomp_request_alloc(acomp_ctx->acomp);
> > -	if (IS_ERR_OR_NULL(req)) {
> > +	if (!req) {
> >  		pr_err("could not alloc crypto acomp %s : %ld\n",
> >  		       pool->tfm_name, PTR_ERR(acomp));
> > -		return -ENOMEM;
> > +		goto free_acomp;
> >  	}
> >  	acomp_ctx->req = req;
> >
> > @@ -462,6 +462,12 @@ static int zswap_cpu_comp_prepare(unsigned int
> cpu, struct hlist_node *node)
> >  	*per_cpu_ptr(pool->acomp_ctx, cpu) = acomp_ctx;
> >
> >  	return 0;
> > +
> > +free_acomp:
> > +	kfree(acomp);
> 
> The kfree() isn't correct.  It needs to be:
> 
> 	crypto_free_acomp(acomp);
> 
> > +free_acomp_ctx:
> > +	kfree(acomp_ctx);
> > +	return -ENOMEM;
> 
> regards,
> dan carpenter

