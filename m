Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70335C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5172520732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wFQ7tZQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgFVS2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:28:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51102 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgFVS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:28:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MILc9B144111;
        Mon, 22 Jun 2020 18:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sgW/H7+7InoJElD4DUBdt2N3zRFgiP2cpkGrzmHIfyM=;
 b=wFQ7tZQ7zt1gIo71K2Pd18f1G1G4rON3C4PWBUge478EnZpRC4V5FIPMGmwLKmqe3oOF
 pS+1Wuf5QAlr3D6u65cwJuq/jYBkpmuA0Bd1Bqq/Ncc3XmTxVd8l67pD0y/EgvwNe6IA
 fDxlpFLE2BPjfEmfJo3BuGRzgirRYYsS06eyJ+h8eBJR3xDGe9TeIRVLXQgOCVRD5MOs
 ABTH0TfTPg0ozuGmddO3xLGmbp//X6Cuqzd6SSSsTJRVNbI/vKsOSz/3vpIC/C+hJxln
 YmDLbMvQT+zhqBHKlu82/ebTjI1vxhAB6sUTvtTsG3zJ9SNCVvVPymZ2sSjFZEHTj5eP bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31sebb9197-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 18:28:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MII5BJ099672;
        Mon, 22 Jun 2020 18:28:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31sv7qhqkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 18:28:30 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05MISPIO005978;
        Mon, 22 Jun 2020 18:28:25 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 18:28:24 +0000
Date:   Mon, 22 Jun 2020 21:28:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mm/zswap: fix a couple of memory leaks and rework
 kzalloc failure check
Message-ID: <20200622182816.GF4151@kadam>
References: <20200622153546.49880-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622153546.49880-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:35:46PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> kzalloc failures return NULL on out of memory errors, so replace the
> IS_ERR_OR_NULL check with the usual null pointer check.  Fix two memory
> leaks with on acomp and acomp_ctx by ensuring these objects are free'd
> on the error return path.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: d4f86abd6e35 ("mm/zswap: move to use crypto_acomp API for hardware acceleration")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  mm/zswap.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0d914ba6b4a0..14839cbac7ff 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -433,23 +433,23 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>  		return 0;
>  
>  	acomp_ctx = kzalloc(sizeof(*acomp_ctx), GFP_KERNEL);
> -	if (IS_ERR_OR_NULL(acomp_ctx)) {
> +	if (!acomp_ctx) {
>  		pr_err("Could not initialize acomp_ctx\n");
>  		return -ENOMEM;
>  	}
>  	acomp = crypto_alloc_acomp(pool->tfm_name, 0, 0);
> -	if (IS_ERR_OR_NULL(acomp)) {
> +	if (!acomp) {

This should be IS_ERR(acomp).  Please preserve the error code.

>  		pr_err("could not alloc crypto acomp %s : %ld\n",
>  				pool->tfm_name, PTR_ERR(acomp));
> -		return -ENOMEM;
> +		goto free_acomp_ctx;
>  	}
>  	acomp_ctx->acomp = acomp;
>  
>  	req = acomp_request_alloc(acomp_ctx->acomp);
> -	if (IS_ERR_OR_NULL(req)) {
> +	if (!req) {
>  		pr_err("could not alloc crypto acomp %s : %ld\n",
>  		       pool->tfm_name, PTR_ERR(acomp));
> -		return -ENOMEM;
> +		goto free_acomp;
>  	}
>  	acomp_ctx->req = req;
>  
> @@ -462,6 +462,12 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>  	*per_cpu_ptr(pool->acomp_ctx, cpu) = acomp_ctx;
>  
>  	return 0;
> +
> +free_acomp:
> +	kfree(acomp);

The kfree() isn't correct.  It needs to be:

	crypto_free_acomp(acomp);

> +free_acomp_ctx:
> +	kfree(acomp_ctx);
> +	return -ENOMEM;

regards,
dan carpenter

