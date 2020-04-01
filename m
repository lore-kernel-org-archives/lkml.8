Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D998C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45272063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E7aSmuxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgDAUAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:00:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47426 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:00:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031JvZMf026385;
        Wed, 1 Apr 2020 20:00:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6Lisy5JqAUMhcNAqHk7WzznsvWNCqHCUiK3gIeMP4ag=;
 b=E7aSmuxoN1vvVxR9h17oyRcp4TRcqsPfSNoOcfm5pOEQ7oU5HmUNbOLmLEHx0xPk41K2
 fD0LnahBSTw4A/+/XfCi8ipyEEx+SINVKUJBvD9uTVhQkCGRIOz1EEMTgVFpJhepnKRG
 jBqnKj3za9VnyiMFqgVJNmjePyP/7g9bfdABoEk6gyVEpJvOh+d+uw3djXmbE8FoSTJw
 fOdpeKXfoPHx2005OGrOaiU+gGVHFc2ilgnHADMUCTUPzr3rOXDOFlc6s7qf99BzwOaN
 vqXGRy5BAi6uOjzubnLAfhRYrgbasPbxlRCszy5bZqDHglk0FaT90eDHXj2dGRSHUhq4 KQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yuna7ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 20:00:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031Jv5FC050777;
        Wed, 1 Apr 2020 20:00:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjm8epm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 20:00:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 031K08em029395;
        Wed, 1 Apr 2020 20:00:08 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 13:00:07 -0700
Date:   Wed, 1 Apr 2020 16:00:27 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
Message-ID: <20200401200027.vsm5roobllewniea@ca-dmjordan1.us.oracle.com>
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401193238.22544-1-pasha.tatashin@soleen.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:32:38PM -0400, Pavel Tatashin wrote:
> Initializing struct pages is a long task and keeping interrupts disabled
> for the duration of this operation introduces a number of problems.
> 
> 1. jiffies are not updated for long period of time, and thus incorrect time
>    is reported. See proposed solution and discussion here:
>    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> 2. It prevents farther improving deferred page initialization by allowing

                                                                   not allowing
>    inter-node multi-threading.

     intra-node

...
> After:
> [    1.632580] node 0 initialised, 12051227 pages in 436ms

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
Reported-by: Shile Zhang <shile.zhang@linux.alibaba.com>

> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Freezing jiffies for a while during boot sounds like stable to me, so

Cc: <stable@vger.kernel.org>    [4.17.x+]


Can you please add a comment to mmzone.h above node_size_lock, something like

         * Must be held any time you expect node_start_pfn,
         * node_present_pages, node_spanned_pages or nr_zones to stay constant.
+        * Also synchronizes pgdat->first_deferred_pfn during deferred page
+        * init.
         ...
        spinlock_t node_size_lock;

> @@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  		return false;
>  
>  	pgdat_resize_lock(pgdat, &flags);
> -
> -	/*
> -	 * If deferred pages have been initialized while we were waiting for
> -	 * the lock, return true, as the zone was grown.  The caller will retry
> -	 * this zone.  We won't return to this function since the caller also
> -	 * has this static branch.
> -	 */
> -	if (!static_branch_unlikely(&deferred_pages)) {
> -		pgdat_resize_unlock(pgdat, &flags);
> -		return true;
> -	}
> -

Huh, looks like this wasn't needed even before this change.


The rest looks fine.

Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
