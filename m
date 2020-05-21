Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB56EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685E820721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mELKqfIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgEUNif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:38:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgEUNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:38:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LDRXYL158375;
        Thu, 21 May 2020 13:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1H9r5JbwrbyVDc6gEnRR1i+kqMeSEbJU8Fh66Zw0Ono=;
 b=mELKqfIb/VLF3nLhd60AqlujPMbFxbC3kUlOfRV/D7eKxsNAFSSAoVneSVb3ryyxoTx+
 LJqqlKXFxyqgplXsMeiRKdU8UynF5UbShCLb/dkYTe1IPpUPo210UzKdPqA5gnLHPA3v
 n3IddseeQeByBqPTp0dIeCB4tBms07f0adn0ugf3XMmYtBewkGtqIGHKxE5NxCHJSB8x
 ilHgqKskhSw6v/+IXOooWx4Ou7xAY3jK7ePcK/u8Cl7Wdf8pNz56YudAbQFK+OvAxt3W
 rj+giVZfBog++TMnfF3FutpsHfuyVC3deNuLiUf5c5C9Vh+/0U+wixIh60eTTmfM2MpV 3Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31501rf221-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 13:37:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LDXFgJ026782;
        Thu, 21 May 2020 13:35:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 312t3b5xpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 13:35:14 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04LDZCMw016629;
        Thu, 21 May 2020 13:35:12 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 06:35:12 -0700
Date:   Thu, 21 May 2020 09:35:32 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] swap: Reduce lock contention on swap cache from swap
 slots allocation
Message-ID: <20200521133532.psckytr456eevs5j@ca-dmjordan1.us.oracle.com>
References: <20200520031502.175659-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520031502.175659-1-ying.huang@intel.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=2 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 11:15:02AM +0800, Huang Ying wrote:
> @@ -2827,6 +2865,11 @@ static struct swap_info_struct *alloc_swap_info(void)
>  	p = kvzalloc(struct_size(p, avail_lists, nr_node_ids), GFP_KERNEL);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
> +	p->cluster_next_cpu = alloc_percpu(unsigned int);
> +	if (!p->cluster_next_cpu) {
> +		kvfree(p);
> +		return ERR_PTR(-ENOMEM);
> +	}

There should be free_percpu()s at two places after this, but I think the
allocation really belongs right...

> @@ -3202,7 +3245,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  		 * select a random position to start with to help wear leveling
>  		 * SSD
>  		 */
> -		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);

...here because then it's only allocated when it's actually used.

> +		for_each_possible_cpu(cpu) {
> +			per_cpu(*p->cluster_next_cpu, cpu) =
> +				1 + prandom_u32_max(p->highest_bit);
> +		}
>  		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>  
>  		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
> -- 
> 2.26.2
> 
> 
