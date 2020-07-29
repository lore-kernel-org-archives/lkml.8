Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06970C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6851207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wAJv0XWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2Rd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:33:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52770 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Rd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:33:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06THWq3N173710;
        Wed, 29 Jul 2020 17:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=JJUNuxTpEfKxSphfXOUQrWBFW3Caubzknw2AmT6q9+8=;
 b=wAJv0XWR5J39m0gNC3gKShv9vJ/fEL2t1jm5SSuK3kcvA1GtwU8qxz3eybXFgQ3V31QX
 sjwSVCrg2+cEcDrAD7HbHI1JALxD/77QW1grGqwXPvW0cbCQm9EOWEMwd3+AAde2qY0J
 wVIVHgtSQcm3MDVnMYoTGaVErR4/iC9/+NEj1p+xor6PYzgyb+ns5hSQcnEzF8s6lL77
 Qbwnzjl7XlGIg7FZTLHMfsvkOZGDnp5Pn1nZKWZ2FTVTyJjssik+Gv1Mu2iiDWSnwZL7
 mGcg/wMqhLGXkNVGgWhdjN2f2ehrxG5zNQL92i3in9VDG9qgxFY3pBTMfKI3WsMSd+Iy mQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32hu1jf1qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 17:33:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06THMUM7127756;
        Wed, 29 Jul 2020 17:31:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32hu5xhqmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 17:31:13 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06THVBD6015116;
        Wed, 29 Jul 2020 17:31:11 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 10:31:07 -0700
Subject: Re: [PATCH v1 2/6] mm/page_isolation: don't dump_page(NULL) in
 set_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S.Tsirkin" <mst@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-3-david@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6a05470a-75be-e895-dff6-ed494af8d6d9@oracle.com>
Date:   Wed, 29 Jul 2020 10:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200630142639.22770-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 7:26 AM, David Hildenbrand wrote:
> Right now, if we have two isolations racing, we might trigger the
> WARN_ON_ONCE() and to dump_page(NULL), dereferencing NULL. Let's just
> return directly.

Just curious, what call path has the WARN_ON_ONCE()/dump_page(NULL)?

> 
> In the future, we might want to report -EAGAIN to the caller instead, as
> this could indicate a temporary isolation failure only.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Hi David,

That 'return -EAGAIN' was added as a sort of synchronization mechanism.
See commit message for 2c7452a075d4d.  Before adding the 'return -EAGAIN',
I could create races which would abandon isolated pageblocks.  Repeating
those races over and over would result in a good chunk of system memory
being isolated and unusable.

Admittedly, these races are rare and I had to work really hard to produce
them.  I'll try to find my testing mechanism.  My concern is reintroducing
this abandoning of pageblocks.  I have not looked further in your series
to see if this potentially addressed later.  If not, then we should not
remove the return code.

-- 
Mike Kravetz

> ---
>  mm/page_isolation.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index f6d07c5f0d34d..553b49a34cf71 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -29,10 +29,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  	/*
>  	 * We assume the caller intended to SET migrate type to isolate.
>  	 * If it is already set, then someone else must have raced and
> -	 * set it before us.  Return -EBUSY
> +	 * set it before us.
>  	 */
> -	if (is_migrate_isolate_page(page))
> -		goto out;
> +	if (is_migrate_isolate_page(page)) {
> +		spin_unlock_irqrestore(&zone->lock, flags);
> +		return -EBUSY;
> +	}
>  
>  	/*
>  	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
> 
