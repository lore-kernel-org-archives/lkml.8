Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D316EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75AF2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBr3I9+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgCSTFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:05:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCSTFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:05:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JJ3xZp159748;
        Thu, 19 Mar 2020 19:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=q7UqnzNKhtfOpZaaMZSusBoFgJtFV72rL8iVG93biAM=;
 b=hBr3I9+5kubyCJHns8JiRQIxcCZg7Q/iQXqW7IaSvIErHY4WsSGy5c0hs/fahfXk3Yjp
 AD7eSLGlNjLurYd8WGWbvpIND5UTTvEwPoUnfLtC22QK4/xTr//Ov/AN1n2jWxCaRUav
 FCinEhreK+fvY2KN+JJT8xZPiqfqYpG40GQZfVRbqDrIZAcxK0zi/6mA5sQrClnCXj79
 MlrSLewxYN4Lt99xv0rRODankDTRzKyWEeKIY/CIxuBbS+G/2EnVk5NFtqRD9/kuwdAA
 sL4Xg5ifBAUG/LVSGcN57Roo63eugjpDtDYqF861yAP920YpRGrGidFeTN/Gi6jh0YYd qg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yub27a166-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 19:04:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JJ2elY128202;
        Thu, 19 Mar 2020 19:04:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ys8rmvema-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 19:04:55 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02JJ4r8E020080;
        Thu, 19 Mar 2020 19:04:53 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 12:04:53 -0700
Date:   Thu, 19 Mar 2020 15:05:12 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200319190512.cwnvgvv3upzcchkm@ca-dmjordan1.us.oracle.com>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9565 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:38:48PM +0800, Shile Zhang wrote:

Sorry, I'm late to this.

I don't have a better solution, but I did try to find a way to stop holding the
resize lock during (most of) page init, which would make this fix unnecessary
and the deferred_init_memmap context less strange.  Here are some ideas that
didn't work out in case someone sees a different way forward.

One thought is to unify the common parts of deferred_init_memmap and
deferred_grow_zone and have callers grab chunks of pages to initialize and note
the next available page to initialize for the next caller.  Interrupt handlers
participate in page init while it's happening rather than having to wait until
it's finished.  But what if a partially completed chunk is interrupted midway
through and the interrupt handler needs to allocate those in-progress pages?
May be possible to guarantee some memory is available if some minimum number of
chunks have been completed already, but it's hard to say what that number is if
the amount of memory handlers might allocate is unbounded.

Given that large allocations from interrupt handlers is a theoretical issue,
another thought is to reserve one section for deferred_grow_zone, should it be
called during page init, and if not then the pgdatinit thread could initialize
it with the resize lock held after the rest of page init is finished.
Meanwhile regular page init need not hold the resize lock.  If interrupt
handlers try to allocate more than a section during this time, trigger a
warning so we know the issue isn't theoretical.  The downside is that it's
possible this may not fix it for good.

> @@ -1811,9 +1816,23 @@ static int __init deferred_init_memmap(v
>  	 * that we can avoid introducing any issues with the buddy
>  	 * allocator.
>  	 */
> -	while (spfn < epfn)
> +	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		/*
> +		 * Release the interrupts for every TICK_PAGE_COUNT pages
> +		 * (128MB) to give tick timer the chance to update the
> +		 * system jiffies.
> +		 */
> +		if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
> +			prev_nr_pages = nr_pages;
> +			pgdat->first_deferred_pfn = spfn;
> +			pgdat_resize_unlock(pgdat, &flags);
> +			goto again;
> +		}
> +	}
> +

Nits only:

 - s/Release the interrupts/Enable interrupts/
 - take out 128MB, that assumes PAGE_SIZE is 4k

I considered saving i, spfn, and epfn in pgdat to avoid having to rerun
deferred_init_mem_pfn_range_in_zone every retry, but it'd enlarge pgdat for
short-lived data and the function probably isn't expensive.

Regardless,
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
