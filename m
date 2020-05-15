Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40F620756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObJOxnud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEOXva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 19:51:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44010 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEOXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 19:51:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FNlN2Q060060;
        Fri, 15 May 2020 23:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B9+GbjZgTfqxHZAQxS9ajQ2uNuabfkl4tT4flbW15t8=;
 b=ObJOxnudU9RpkkIsP0neuKYidlqzXwl5g/pceDKnel7b9t/+wraNSbMML857q61paN2w
 oeTX3Clw1LDvkCXjqFMlGJPg5NdARajKjDhPnT6NdbJsZTQBMzYffl5cUB4ma5pDCrjA
 CS96Q1QLN3bwvLP9nSxAFsXSvB9CXCnIdjX96AHj6AHah5D59Zv/edLs5DhNI2nufKWS
 GT/7lvpcVuCavNx1yRBBUsMyYqjKpAz5k3KSp4FPq+wdOezJg8GwN6RBH7810xTkHqEZ
 0KBoC7Qlvbia2fzAGL1SkIvPx0G10t5W9hIOYijG4xLpbgwlnGeCkyr6CahTgnK7m+/m IA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 311nu5pg16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 23:51:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FNmlJ4137904;
        Fri, 15 May 2020 23:51:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 310vjxrx4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 23:51:17 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04FNpGEB026746;
        Fri, 15 May 2020 23:51:16 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 16:51:16 -0700
Date:   Fri, 15 May 2020 19:51:40 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] swap: Add percpu cluster_next to reduce lock contention
 on swap cache
Message-ID: <20200515235140.xkznql332xmqvuf2@ca-dmjordan1.us.oracle.com>
References: <20200514070424.16017-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514070424.16017-1-ying.huang@intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150199
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9622 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 cotscore=-2147483648
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005150199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:04:24PM +0800, Huang Ying wrote:
> And the pmbench score increases 15.9%.

What metric is that, and how long did you run the benchmark for?

Given that this thing is probabilistic, did you notice much variance from run
to run?

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 35be7a7271f4..9f1343b066c1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -746,7 +746,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  	 */
>  
>  	si->flags += SWP_SCANNING;
> -	scan_base = offset = si->cluster_next;
> +	/*
> +	 * Use percpu scan base for SSD to reduce lock contention on
> +	 * cluster and swap cache.  For HDD, sequential access is more
> +	 * important.
> +	 */
> +	if (si->flags & SWP_SOLIDSTATE)
> +		scan_base = this_cpu_read(*si->cluster_next_cpu);
> +	else
> +		scan_base = si->cluster_next;
> +	offset = scan_base;
>  
>  	/* SSD algorithm */
>  	if (si->cluster_info) {

It's just a nit but SWP_SOLIDSTATE and 'if (si->cluster_info)' are two ways to
check the same thing and I'd stick with the one that's already there.

> @@ -2962,6 +2979,8 @@ static unsigned long read_swap_header(struct swap_info_struct *p,
>  
>  	p->lowest_bit  = 1;
>  	p->cluster_next = 1;
> +	for_each_possible_cpu(i)
> +		per_cpu(*p->cluster_next_cpu, i) = 1;

These are later overwritten if the device is an SSD which seems to be the only
case where these are used, so why have this?

>  	p->cluster_nr = 0;
>  
>  	maxpages = max_swapfile_size();
> @@ -3204,6 +3223,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		 * SSD
>  		 */
>  		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
> +		for_each_possible_cpu(cpu) {
> +			per_cpu(*p->cluster_next_cpu, cpu) =
> +				1 + prandom_u32_max(p->highest_bit);
> +		}

Is there a reason for adding one?  The history didn't enlighten me about why
cluster_next does it.
