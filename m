Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E57C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D652467E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fF8nUlC1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jT6c/kBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgFTT7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 15:59:38 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728640AbgFTT7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 15:59:38 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05KJw0a0019307;
        Sat, 20 Jun 2020 12:59:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Somxag+pk5dM1v6F+5wcADAd914YOdA03vVD4opsrl4=;
 b=fF8nUlC1I/tPrv0/x1F+AJSL23KfhJVZe3dt65VRQTkLUsS4XRnHjwRU+Yske7A484uH
 R1MYnI3qKDngMtGlTvIzqEkaaA8RLx1Cw6Z5kLAINrbnEp7EUeaGwKwtJ+EI/rJ+K0Rz
 ls0nMpIdSglYTaKVvfGE9elEydx/IHziF1M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31se4n9pgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 20 Jun 2020 12:59:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 12:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUy60Ogxa/9sAzoMeoLQ5qybnm1aq6V1Q7YSJ5eyzA95w9BZsbiRP8F31djj/Rgv1e2KiEGwfcim/fQnIl2pTN9xYd5exrkOmDs5frfpkWgcXKh+FVmkR65sCoR11BVsy6cGTleGzXGMW0xXYLynK4WJJooikchPPJZQbkjfWJnCND3pgRgzNYDKBkmPmubSzYzhgLuhOvJJS6Brn9jzZlVgaexbB+nvUL6eAVy+a9+bRmrz0aL26ROvdWxBvoBFhoelylTK61hzkrNJOBJCZsgEJ6Vwue9Ao9FCrvd1GOR+M3ec2IQMKgDr6OoOSAIuaMrcE572m6ZKLfeDuG5p1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Somxag+pk5dM1v6F+5wcADAd914YOdA03vVD4opsrl4=;
 b=kb4Hjk7JBpixHnlFU1iPemcJTj6E14l2yzSA7qsFizDLcyFQB7zOrxmc+xi5jKxMAYjx+GNuVHCQWvIC7p/BLjyhlQ/BCfXTeBF/q4qmIP7jYt67lynJ0TxKNUc7Z0Vbx6xu9kUDnUlBU60cfTrEcTd16CQGz7Hn+eNtY12fng2uZKT8BtSpvd2in7XjS87PFJNMO1HH6kUxjN5m5dhk7xNOor/292IWaOi06JJtoDVhSYIEKpyFlwIrBDpK6x+mqkbacaD8BgX+wS6k5KcufYDgmaoSrp3suqcVLqgGa70cWkDEOK48317yXX32neMaexD6nrs6XmEIe5GsCADeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Somxag+pk5dM1v6F+5wcADAd914YOdA03vVD4opsrl4=;
 b=jT6c/kBQhtYFth/G1nTmrBovhpq06b3q/8oBhgJJ+EuQLk/9U/fXlARqVQfS8tBw8FJcp9qRnErOwAP4oo/y6DhTHg9mUo5hWPSgKlwNre53MAUzG63ipTsq43XJ4joJgHvYgn4vuL5tEoA2wnl0AjBYjaHA/tWclKLWQ9X2odM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3158.namprd15.prod.outlook.com (2603:10b6:a03:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 19:59:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 19:59:08 +0000
Date:   Sat, 20 Jun 2020 12:59:05 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, slab: Fix sign conversion problem in
 memcg_uncharge_slab()
Message-ID: <20200620195905.GA286724@carbon.DHCP.thefacebook.com>
References: <20200620184719.10994-1-longman@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620184719.10994-1-longman@redhat.com>
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4a6b) by BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.2 via Frontend Transport; Sat, 20 Jun 2020 19:59:08 +0000
X-Originating-IP: [2620:10d:c090:400::5:4a6b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fae9e8f-457f-411f-0474-08d8155464b8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3158:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3158A3E4E2FB359539298639BE990@BYAPR15MB3158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rtaUze19XWknVJHfVaUGnySArNpZh2Ggm760szJGfm3tgigI+K49qYz7oeQYHlO4Q5Wa9Q4r4UWosZpvmHo9lLU4SZuBQ61d4C1UpkUQdRnhS5K5n1wEpGkz7i5mJ1MEcoz+lj/sqsmtH0AZjHK6bsHq6TnDrR2tqP3ezDxooD/N8EhLN6g8ohN9N2HfMGv/UbofIAIJUKDP10Ay8PCs6BSXVaQvVuYlE3F+ancJpihKUNXplLzmwEUWJ4YKN0giSEX4NcZNHRf9CL0GNqh8caFE1BCug2+ujR4NiSL7L15VSaobZHxiINrrMJbSP+Ub0zLn+vf/9UdU8SNS8X4Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(396003)(39860400002)(52116002)(86362001)(7696005)(5660300002)(6506007)(54906003)(316002)(478600001)(83380400001)(4326008)(2906002)(1076003)(8936002)(186003)(6916009)(16526019)(7416002)(6666004)(9686003)(66946007)(55016002)(66556008)(66476007)(8676002)(33656002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: THsCsynjGOQdYaNf4sDaslpaLS7QReL5zYsiZRUteYWxRd3VDHcb3fECzIiTOfChZ27o2ARH35jh1dy5VxB4xmnpYPK7bGRWRm4qdO5Au2P8BdTcibWvykF+4lVXDoeSixmAkS0vJ9o5udwsVIRc6ZHNVNXEXymUL69O1wuxyFgid/6IRZAN0FZxF6cbgdPndZYgAYi0VxShMwzQGdVjuMa3aghZybEOzMrK8qJQHdQPVavWG7Djil0z+zGFUo2adS8cdwxK0Hg5MyJ+pgrz4BGSDw7EInAD9jVyu+6uq72FE/rYb+XUUfzRmgmHabVppm1USbp3JVa+kKvWSiua+cUjspZubnb4i+piqc2cb1f62rXiXyfeuosHszPbe5BFM/wYYlhpbWdzsKoRUm6lZCEzfIuDlgzv6XX6ZCiAS68FlrUQInRhrtM9vNBMOWWGzfJXprdPoNmphUUWd37C3hekEBUJ0EuYdZhu2re90aY8i8IrgxvvUAhXdaytcnBkXPGBJOx1i9pzs+kUve+1vQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fae9e8f-457f-411f-0474-08d8155464b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 19:59:08.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAeZzY/IbCIhNB6pmQQY1s+PK6s1ayEXvCQVyDk94rUIl+uezANXpJqK3WYDA2dF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3158
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_13:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 02:47:19PM -0400, Waiman Long wrote:
> It was found that running the LTP test on a PowerPC system could produce
> erroneous values in /proc/meminfo, like:
> 
>   MemTotal:       531915072 kB
>   MemFree:        507962176 kB
>   MemAvailable:   1100020596352 kB
> 
> Using bisection, the problem is tracked down to commit 9c315e4d7d8c
> ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
> 
> In memcg_uncharge_slab() with a "int order" argument:
> 
>   unsigned int nr_pages = 1 << order;
>     :
>   mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
> 
> The mod_lruvec_state() function will eventually call the
> __mod_zone_page_state() which accepts a long argument.  Depending on
> the compiler and how inlining is done, "-nr_pages" may be treated as
> a negative number or a very large positive number. Apparently, it was
> treated as a large positive number in that PowerPC system leading to
> incorrect stat counts. This problem hasn't been seen in x86-64 yet,
> perhaps the gcc compiler there has some slight difference in behavior.
> 
> It is fixed by making nr_pages a signed value. For consistency, a
> similar change is applied to memcg_charge_slab() as well.
> 
> Fixes: 9c315e4d7d8c ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
> Signed-off-by: Waiman Long <longman@redhat.com>

Good catch!

Interesting that I haven't seen it on x86-64, but it's reproducible on Power.

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!

> ---
>  mm/slab.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 207c83ef6e06..74f7e09a7cfd 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -348,7 +348,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>  					     gfp_t gfp, int order,
>  					     struct kmem_cache *s)
>  {
> -	unsigned int nr_pages = 1 << order;
> +	int nr_pages = 1 << order;
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  	int ret;
> @@ -388,7 +388,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>  static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>  						struct kmem_cache *s)
>  {
> -	unsigned int nr_pages = 1 << order;
> +	int nr_pages = 1 << order;
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  
> -- 
> 2.18.1
> 
