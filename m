Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6A9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XlQ2+Mjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE1BhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:37:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1BhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:37:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S17lbu108284;
        Thu, 28 May 2020 01:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jByIt/ggnF9IVs532CwG7I62p3pF0p5atl3iefXUuAE=;
 b=XlQ2+MjmLPQtReSPAYaeZhujLTuHMviFqj6duv71J6KdLiaw830rSNn8q4veoYOT8HhA
 i0bnML/o/swd/aIq2c0q/XnQDALFwlPfNcVJvjmEw+I2OEK8IyBmX/Kidy4oV1H5dpSU
 GxQ8USXLRI6Xt4+5wZJfqMCpOV1/RnH1BivKpcnzY7IYxOjHJBtl+z35RX40XdGVk6LW
 UDQSiJCH42R0zlwpxFXE9hgBxJN02ZWKexnltypL/qY/g+Y4MGpDAZEQoaR0t949tPvI
 vgTDjkG11lXRWbvmEnzImpEnpvaw8f9q7X5Gmfc37xa9z1yplIYu+Ujhf8Lj4NGmDO6X Aw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 318xbk2f2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 01:37:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04S17dUK150094;
        Thu, 28 May 2020 01:37:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 317dkvhjhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 01:37:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04S1b0sI030365;
        Thu, 28 May 2020 01:37:00 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 18:36:59 -0700
Date:   Wed, 27 May 2020 21:37:24 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] swap: Reduce lock contention on swap cache from swap
 slots allocation
Message-ID: <20200528013724.flx6pwcmaazpek32@ca-dmjordan1.us.oracle.com>
References: <20200525002648.336325-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525002648.336325-1-ying.huang@intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=2 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9634 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=2 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 08:26:48AM +0800, Huang Ying wrote:
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 423c234aca15..0abd93d2a4fc 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -615,7 +615,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>  			 * discarding, do discard now and reclaim them
>  			 */
>  			swap_do_scheduled_discard(si);
> -			*scan_base = *offset = si->cluster_next;
> +			*scan_base = this_cpu_read(*si->cluster_next_cpu);
> +			*offset = *scan_base;
>  			goto new_cluster;

Why is this done?  As far as I can tell, the values always get overwritten at
the end of the function with tmp and tmp isn't derived from them.  Seems
ebc2a1a69111 moved some logic that used to make sense but doesn't have any
effect now.

>  		} else
>  			return false;
> @@ -721,6 +722,34 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  	}
>  }
>  
> +static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
> +{
> +	unsigned long prev;
> +
> +	if (!(si->flags & SWP_SOLIDSTATE)) {
> +		si->cluster_next = next;
> +		return;
> +	}
> +
> +	prev = this_cpu_read(*si->cluster_next_cpu);
> +	/*
> +	 * Cross the swap address space size aligned trunk, choose
> +	 * another trunk randomly to avoid lock contention on swap
> +	 * address space if possible.
> +	 */
> +	if ((prev >> SWAP_ADDRESS_SPACE_SHIFT) !=
> +	    (next >> SWAP_ADDRESS_SPACE_SHIFT)) {
> +		/* No free swap slots available */
> +		if (si->highest_bit <= si->lowest_bit)
> +			return;
> +		next = si->lowest_bit +
> +			prandom_u32_max(si->highest_bit - si->lowest_bit + 1);
> +		next = ALIGN(next, SWAP_ADDRESS_SPACE_PAGES);
> +		next = max_t(unsigned int, next, si->lowest_bit);

next is always greater than lowest_bit because it's aligned up.  I think the
intent of the max_t line is to handle when next is aligned outside the valid
range, so it'd have to be ALIGN_DOWN instead?


These aside, patch looks good to me.
