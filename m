Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55989206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nyedowuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390955AbgDCNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:44:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42398 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390900AbgDCNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:44:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033DhqW9011059;
        Fri, 3 Apr 2020 13:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Q5MuqANtg1zQPv6GuHLVRWoR9rnF6W2CzJ3VxupBfPQ=;
 b=nyedowuOsKcoh/xPxMabamnVOU7rdnbAEW1I1wOT8ypFwAy+J+Mbwo0T8J7+9WDg/fxd
 82nW7YM4wuAJ/zI1Si+kyiktesmk+V0QzuRf/4ZEAW/UIBv7ibA3d4JTsd3/wgc/zbko
 G4uiJ9qlWjWhmTVAWY3V0JWJYkuHGKNilCcP3J5X8okmMldzHAExXkZcZ9hLHoO75Ho0
 8sO849vXdxpv5KC2dZJkrQT3fJeETXdmOW2w9aiUSM0WMmmXrxdeZObMDwrLgaEELSZI
 H5qcuANSu9h+3bvcAPPx9zR42O9lC43ypl78ot+uzwrfvfqH3Id9VPFFr0KN1PYtiw0q EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303cevh4a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 13:44:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033Dh2Sq191915;
        Fri, 3 Apr 2020 13:44:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 302g2n1r88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 13:44:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033DiLS4017280;
        Fri, 3 Apr 2020 13:44:21 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 06:44:20 -0700
Date:   Fri, 3 Apr 2020 09:44:39 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org, vbabka@suse.cz
Subject: Re: [PATCH v3 3/3] mm: call cond_resched() from
 deferred_init_memmap()
Message-ID: <20200403134439.li6i635dnur5jdha@ca-dmjordan1.us.oracle.com>
References: <20200403133549.14338-1-pasha.tatashin@soleen.com>
 <20200403133549.14338-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403133549.14338-4-pasha.tatashin@soleen.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:35:49AM -0400, Pavel Tatashin wrote:
> Now that deferred pages are initialized with interrupts enabled we can
> replace touch_nmi_watchdog() with cond_resched(), as it was before
> 3a2d7fa8a3d5.
...
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4a60f2427eb0..445f74358997 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1816,7 +1816,7 @@ static int __init deferred_init_memmap(void *data)
>  	 */
>  	while (spfn < epfn) {
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> -		touch_nmi_watchdog();
> +		sched_clock();

I think you meant cond_resched()?

With that,
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
