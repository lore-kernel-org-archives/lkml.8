Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A58206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PvJrMUxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbgDAUK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:10:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57758 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbgDAUK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:10:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031K9bp3134452;
        Wed, 1 Apr 2020 20:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=wJinjoLAQHZMEzBy4iU8Y9RdUeANodmk/HVw8SZfl+E=;
 b=PvJrMUxn6vPAXstz4sGR1kKaY3s31uGIFMhupzZPnzAm95W/D95sD0dFQSHcnSQmEn3e
 1VgtN9scgbNgA0A8pDX8kVeInZUv45tHzCaX0OdAKReZC/UGs0Qxg+jF7+uckJ/Q0Mc1
 KoZL3T1WqufEeHt4ack67vBDXZVGES9xndln6Fgnb8cCSFXunnZ98/ex+m5H0L4Imyn/
 usNR51PqID0ja7N7UwG1M2AWIw95xl7eiP0g9YzvX5xcsMOkJK8Ai3TPMetoPQCPHCHT
 vTuvBcE7s9GfDwXMm5WmXrBTgTl7lt2tbBl8LZmZhMQXlpVNchUbZFBFmt83Smmvztug nQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yuna8yu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 20:10:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031K8NtF062120;
        Wed, 1 Apr 2020 20:08:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 302g4uac7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 20:08:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 031K8ak1022986;
        Wed, 1 Apr 2020 20:08:36 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 13:08:35 -0700
Date:   Wed, 1 Apr 2020 16:08:55 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
Message-ID: <20200401200855.d23xcwznr5cm67p2@ca-dmjordan1.us.oracle.com>
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
 <20200401200027.vsm5roobllewniea@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401200027.vsm5roobllewniea@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=2
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=2 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:00:27PM -0400, Daniel Jordan wrote:
> On Wed, Apr 01, 2020 at 03:32:38PM -0400, Pavel Tatashin wrote:
> > Initializing struct pages is a long task and keeping interrupts disabled
> > for the duration of this operation introduces a number of problems.
> > 
> > 1. jiffies are not updated for long period of time, and thus incorrect time
> >    is reported. See proposed solution and discussion here:
> >    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> > 2. It prevents farther improving deferred page initialization by allowing
> 
>                                                                    not allowing
> >    inter-node multi-threading.
> 
>      intra-node
> 
> ...
> > After:
> > [    1.632580] node 0 initialised, 12051227 pages in 436ms
> 
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Reported-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Freezing jiffies for a while during boot sounds like stable to me, so
> 
> Cc: <stable@vger.kernel.org>    [4.17.x+]
> 
> 
> Can you please add a comment to mmzone.h above node_size_lock, something like
> 
>          * Must be held any time you expect node_start_pfn,
>          * node_present_pages, node_spanned_pages or nr_zones to stay constant.
> +        * Also synchronizes pgdat->first_deferred_pfn during deferred page
> +        * init.
>          ...
>         spinlock_t node_size_lock;
> 
> > @@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
> >  		return false;
> >  
> >  	pgdat_resize_lock(pgdat, &flags);
> > -
> > -	/*
> > -	 * If deferred pages have been initialized while we were waiting for
> > -	 * the lock, return true, as the zone was grown.  The caller will retry
> > -	 * this zone.  We won't return to this function since the caller also
> > -	 * has this static branch.
> > -	 */
> > -	if (!static_branch_unlikely(&deferred_pages)) {
> > -		pgdat_resize_unlock(pgdat, &flags);
> > -		return true;
> > -	}
> > -
> 
> Huh, looks like this wasn't needed even before this change.
> 
> 
> The rest looks fine.
> 
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

...except for I forgot about the touch_nmi_watchdog() calls.  I think you'd
need something kind of like this before your patch.

---8<---

From: Daniel Jordan <daniel.m.jordan@oracle.com>
Date: Fri, 27 Mar 2020 17:29:05 -0400
Subject: [PATCH] mm: call touch_nmi_watchdog() on max order boundaries in
 deferred init

deferred_init_memmap() disables interrupts the entire time, so it calls
touch_nmi_watchdog() periodically to avoid soft lockup splats.  Soon it
will run with interrupts enabled, at which point cond_resched() should
be used instead.

deferred_grow_zone() makes the same watchdog calls through code shared
with deferred init but will continue to run with interrupts disabled, so
it can't call cond_resched().

Pull the watchdog calls up to these two places to allow the first to be
changed later, independently of the second.  The frequency reduces from
twice per pageblock (init and free) to once per max order block.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/page_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 212734c4f8b0..4cf18c534233 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1639,7 +1639,6 @@ static void __init deferred_free_pages(unsigned long pfn,
 		} else if (!(pfn & nr_pgmask)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 1;
-			touch_nmi_watchdog();
 		} else {
 			nr_free++;
 		}
@@ -1669,7 +1668,6 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 			continue;
 		} else if (!page || !(pfn & nr_pgmask)) {
 			page = pfn_to_page(pfn);
-			touch_nmi_watchdog();
 		} else {
 			page++;
 		}
@@ -1813,8 +1811,10 @@ static int __init deferred_init_memmap(void *data)
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
+	}
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
@@ -1908,6 +1908,7 @@ deferred_grow_zone_locked(pg_data_t *pgdat, struct zone *zone,
 		first_deferred_pfn = spfn;
 
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		touch_nmi_watchdog();
 
 		/* We should only stop along section boundaries */
 		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
-- 
2.25.0

