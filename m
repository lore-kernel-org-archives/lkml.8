Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFBDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A142053B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TqP+6RWm";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lLiPyjGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgEZSFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:05:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbgEZSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:05:12 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QI0sVq025685;
        Tue, 26 May 2020 11:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=saMmhNXTzABhBhhUPL6UUnmKm+zB8u3K6zEDmruxDHU=;
 b=TqP+6RWmQw3+rZzHobi9qtg9ZX5n6iU9DrbXfbux8EJ7wU/4XXtWMtYNxSrylzhXQrT1
 pYTMe7z+dioc1Qp6khUrV0qN3j0oHU98PMb15ONea4m8bnzzYvoOPzCPa/Ss1h0BpfOV
 aQ3C+cGtGyiORK7wn9zdC5VodwyI5b5sri4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 317m3pvghn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 11:05:05 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 11:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+gmD8V4y21Ch24pbhrOJDu7jl6NQ8R0ZHuwW1SOkU69AhR0b+uh4qk36rCKdkYmgY8FYk9mjD2KthsxB/HjR+giDWOgo0qHmISFq/VsXJz8mfaeC2hlqy5nVuq3Fx8oO2NCkyG5dCWsCND2De+OVOJqoXObQkAYqg6XnAqxJ+BNeXhGovbEBX3jh453HvgQBIWvykhRslaYF9C1Bjzr/uOt/xBJW0yL2AW/xiy+b3iY7j7ohRIwmx4AlkEP1oR1ZAGXaKEiFrGGB297xipJHIQ0+LlodDhqk1klv20dAW6NBsgK51zrQXvc/MzNQFjJwbgYHVy4/mkVeJkzNaHzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saMmhNXTzABhBhhUPL6UUnmKm+zB8u3K6zEDmruxDHU=;
 b=mmetqUwe6DbgChEH8hOtW/9onpy3E+ui8nfOKGEoZa6+dICFapVKAu74clQN3CGkFGtOeKqYAQ7JoluoD/j5vXKeQyEPD61NzrVzYShhMo0qHUFkpMHf+ACQqyyDaFs0ibWptajk3OdkCRAzU25ybRMh/ZFfHrJZG67L88mr3fgj/TOKlcivwi21dv8NgOj5sDMpH8R/+G6mkaiVbtP3qVOHaQ1qnzq0ICM/IkeA7zcfjeD4QgUdWQr4iDMCiDhkPnBWLGajC0ZrwevZ4Z1NVItFFefF91fmJYB3UMjazGt1UZXyoP5Wt5HmNvpbFU50JQ30mN6jJNKJF3YLJeloBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saMmhNXTzABhBhhUPL6UUnmKm+zB8u3K6zEDmruxDHU=;
 b=lLiPyjGohj5H64314hOOpNJjmwfVNc6riwPyO6eG5XPIqyLa5Kv+9Mswjf0dqOG1P9kaF0Fa0povNDhkUlcyiKynJf1TvmQKm52K4OumPZ2J/Dg/ioMGLYmqMzP1OD/OLbIX8U/xvUZCC9lho9Wlu7t/hF1jZPlK/3NGYHUeihQ=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB1982.namprd15.prod.outlook.com
 (2603:10b6:805:d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Tue, 26 May
 2020 18:05:00 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 18:05:00 +0000
Date:   Tue, 26 May 2020 11:04:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/19] mm: memcg/slab: charge individual slab objects
 instead of pages
Message-ID: <20200526180456.GC377498@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-10-guro@fb.com>
 <75328f78-117b-5042-f42e-5ef01dd93086@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75328f78-117b-5042-f42e-5ef01dd93086@suse.cz>
X-ClientProxiedBy: BYAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::19) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:d421) by BYAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:c0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.9 via Frontend Transport; Tue, 26 May 2020 18:04:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:d421]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee809332-7895-4f1f-fff6-08d8019f4e58
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1982:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19828FD1F26E55B925043376BEB00@SN6PR1501MB1982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy1bVPVekA8NuuZ9sj6sN/aix8jtE69KY5xC3DrAjM3dKJNShUoFcktbk5xW2DvvSjv5NiLTrXfP4jnHYJ4uAoNOUHM2WWTLwkyypLQFHDT9cRa5EaeMqPomk9vuBqJNt9nl8hODZKeiS6mkupsbMFbTGpZNiDGaxIwegfLggjwywqMpQd0bRYVyhGC7I1TWXL1nZNXvBNE2SnizeKbu54EJsXHkSPPz2o01lUZuw2KhOs9JJbD/JqUDFHBy2ucw+FyGG+Ryni6jQzXfXvvMN1wN90mm6M0p5Zn/w81usnrMuYMxNr6cyh3cGR4lSOrY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(54906003)(8936002)(33656002)(8676002)(1076003)(316002)(4326008)(478600001)(2906002)(86362001)(66946007)(9686003)(6916009)(6666004)(66556008)(66476007)(55016002)(7696005)(52116002)(5660300002)(186003)(16526019)(53546011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dScEuifzDtQwHI/IfcaJNCcuizXyJ3eCaEZ4ZP7gEZLgPrMF1RqIGaeBxFGAwII3MLSgScgBkAVAOf3YXf4KPUGLOCE3mCEOMinJnqHd82lMsC3n4kxEQboa+BgtEjfFi60uxxj1eSxFr0EhOzvggVISp5BUd18QSC3DqZDyunekabxe5q0ubwTbU9IrW8bWwOdOQdlw9k9jVwR7sN7clkHVAhBaduNg4EJBZdk/dHrj/ehA6qASmFxW3K+z324Z6g1GOX/6eSqSb/rZfXWTsGwwHKpozWnk3oYGQiAfGO574QWWqkbxIBsypX0hoPBMzGGWtIOSseuEIvrZge9I15CCQ744s+ZO9weI85w09WTgI4YiGFphyfPPvAHu2Ewj4cwP8LVwRT9iZV/RAJeqqaG+q2D9TxIpfbsXeJtYzCvJ+WH3aTYSficls4IrnVHd0SbbT3quLmpgQNmy5+DJj5t5khD8s4lwkVaP4aBlmhhgqNofcsuzXmBwQSjFtwYvKR5xpwZoH29+flhz3A70ZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ee809332-7895-4f1f-fff6-08d8019f4e58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 18:04:59.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffYAyLVQeC04C/D+BB4ETi66rtelWA0Z06SY3ascOhKP4xZuRX5OP0kwywX5OKzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1982
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=5 impostorscore=0 cotscore=-2147483648
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260140
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 06:10:55PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:46 PM, Roman Gushchin wrote:
> > Switch to per-object accounting of non-root slab objects.
> > 
> > Charging is performed using obj_cgroup API in the pre_alloc hook.
> > Obj_cgroup is charged with the size of the object and the size
> > of metadata: as now it's the size of an obj_cgroup pointer.
> > If the amount of memory has been charged successfully, the actual
> > allocation code is executed. Otherwise, -ENOMEM is returned.
> > 
> > In the post_alloc hook if the actual allocation succeeded,
> > corresponding vmstats are bumped and the obj_cgroup pointer is saved.
> > Otherwise, the charge is canceled.
> > 
> > On the free path obj_cgroup pointer is obtained and used to uncharge
> > the size of the releasing object.
> > 
> > Memcg and lruvec counters are now representing only memory used
> > by active slab objects and do not include the free space. The free
> > space is shared and doesn't belong to any specific cgroup.
> > 
> > Global per-node slab vmstats are still modified from (un)charge_slab_page()
> > functions. The idea is to keep all slab pages accounted as slab pages
> > on system level.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Suggestion below:
> 
> > @@ -568,32 +548,33 @@ static __always_inline int charge_slab_page(struct page *page,
> >  					    gfp_t gfp, int order,
> >  					    struct kmem_cache *s)
> >  {
> > -	int ret;
> > -
> > -	if (is_root_cache(s)) {
> > -		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> > -				    PAGE_SIZE << order);
> > -		return 0;
> > -	}
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	if (!is_root_cache(s)) {
> 
> This could also benefit from memcg_kmem_enabled() static key test AFAICS. Maybe
> even have a wrapper for both tests together?

Added.

> 
> > +		int ret;
> >  
> > -	ret = memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
> > -	if (ret)
> > -		return ret;
> > +		ret = memcg_alloc_page_obj_cgroups(page, gfp, objs_per_slab(s));
> 
> You created memcg_alloc_page_obj_cgroups() empty variant for !CONFIG_MEMCG_KMEM
> but now the only caller is under CONFIG_MEMCG_KMEM.

Good catch, thanks!

> 
> > +		if (ret)
> > +			return ret;
> >  
> > -	return memcg_charge_slab(page, gfp, order, s);
> > +		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
> 
> Perhaps moving this refcount into memcg_alloc_page_obj_cgroups() (maybe the name
> should be different then) will allow you to not add #ifdef CONFIG_MEMCG_KMEM in
> this function.

The reference counter bumping is not related to obj_cgroups,
we just bump a counter for each slab page belonging to the kmem_cache.
And it will go away later in the patchset with the rest of slab caches
refcounting.

> 
> Maybe this is all moot after patch 12/19, will find out :)
> 
> > +	}
> > +#endif
> > +	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> > +			    PAGE_SIZE << order);
> > +	return 0;
> >  }
> >  
> >  static __always_inline void uncharge_slab_page(struct page *page, int order,
> >  					       struct kmem_cache *s)
> >  {
> > -	if (is_root_cache(s)) {
> > -		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> > -				    -(PAGE_SIZE << order));
> > -		return;
> > +#ifdef CONFIG_MEMCG_KMEM
> > +	if (!is_root_cache(s)) {
> 
> Everything from above also applies here.

Done.
Thanks!

> 
> > +		memcg_free_page_obj_cgroups(page);
> > +		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
> >  	}
> > -
> > -	memcg_free_page_obj_cgroups(page);
> > -	memcg_uncharge_slab(page, order, s);
> > +#endif
> > +	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> > +			    -(PAGE_SIZE << order));
> >  }
> >  
> >  static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
> 
> 
