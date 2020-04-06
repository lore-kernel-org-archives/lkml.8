Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C07C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F326D20678
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNOH+k8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgDFKqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:46:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56812 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFKqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:46:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036Ahpbk171975;
        Mon, 6 Apr 2020 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0ZlPWVkYRVCozqYJTFdUyWBFeoRAi1Fmbngpdi2INOk=;
 b=XNOH+k8XPlBNYkcARuaq8rKfhIT3CzOerQi8RV/2LDRX8Wk1mHs01ESA6dKqhJT74tHi
 HKpnhTw0+iXvMc/piNoqqrN7z3I0wEOvpLpR6yFxZ5fwLKq/o5Kd/GMv76rpOZlcSu8w
 j5N73gp+swY/lsVRGGuC3I+iVDwGBL7EQfGmLMjKnGz4qkB8hZ4bNBSAIGraL0EeFgaU
 LFZ94AHFJJa6XTeBT4i0wgxzLjeIucZIbtOpUr3EM11+kSwx+RBh/ikqPrqRc2vISGRS
 5lVTSsZbG/s0dwIkRAhFtbRpgEVDmL5F3ngbTaUHZFwPt8k7Gxs+0CaIXjdL7uDEgwpn Gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 306j6m62gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 10:45:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 036AgPwf010217;
        Mon, 6 Apr 2020 10:43:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3073xvxbka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Apr 2020 10:43:57 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 036Ahscm004286;
        Mon, 6 Apr 2020 10:43:54 GMT
Received: from [10.175.175.249] (/10.175.175.249)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Apr 2020 03:43:54 -0700
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-mm@kvack.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <23742bb8-831f-29ff-1463-75427eec57c7@oracle.com>
Date:   Mon, 6 Apr 2020 11:43:51 +0100
MIME-Version: 1.0
In-Reply-To: <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 11:55 PM, Dan Williams wrote:

[...]

>  static ssize_t dev_dax_resize(struct dax_region *dax_region,
>  		struct dev_dax *dev_dax, resource_size_t size)
>  {
>  	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
> -	resource_size_t dev_size = range_len(&dev_dax->range);
> +	resource_size_t dev_size = dev_dax_size(dev_dax);
>  	struct resource *region_res = &dax_region->res;
>  	struct device *dev = &dev_dax->dev;
> -	const char *name = dev_name(dev);
>  	struct resource *res, *first;
> +	resource_size_t alloc = 0;
> +	int rc;
>  
>  	if (dev->driver)
>  		return -EBUSY;
> @@ -684,38 +766,47 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
>  	 * allocating a new resource.
>  	 */
>  	first = region_res->child;
> -	if (!first)
> -		return __alloc_dev_dax_range(dev_dax, dax_region->res.start,
> -				to_alloc);
> -	for (res = first; to_alloc && res; res = res->sibling) {
> +retry:
> +	rc = -ENOSPC;
> +	for (res = first; res; res = res->sibling) {
>  		struct resource *next = res->sibling;
> -		resource_size_t free;
>  
>  		/* space at the beginning of the region */
> -		free = 0;
> -		if (res == first && res->start > dax_region->res.start)
> -			free = res->start - dax_region->res.start;
> -		if (free >= to_alloc && dev_size == 0)
> -			return __alloc_dev_dax_range(dev_dax,
> -					dax_region->res.start, to_alloc);
> -
> -		free = 0;
> +		if (res == first && res->start > dax_region->res.start) {
> +			alloc = min(res->start - dax_region->res.start,
> +					to_alloc);
> +			rc = __alloc_dev_dax_range(dev_dax,
> +					dax_region->res.start, alloc);

You might be missing:

	first = region_res->child;

(...) right after returning from __alloc_dev_dax_range(). Alternatively, perhaps
even moving the 'retry' label to right before the @first initialization.

In the case that you pick space from the beginning, the child resource of the
dax region will point to first occupied region, and that changes after you pick
this space. So, IIUC, you want to adjust where you start searching free space
otherwise you end up wrongly picking that same space twice.

If it helps, the bug can be reproduced in this unit test below, see
daxctl_test3() test:

https://lore.kernel.org/linux-nvdimm/20200403205900.18035-11-joao.m.martins@oracle.com/

> +			break;
> +		}
> +

[...]
