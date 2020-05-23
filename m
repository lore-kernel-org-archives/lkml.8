Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEF5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99AC206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q4Xt6LBU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="U/YLC21Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgEWBc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:32:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53598 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387418AbgEWBc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:32:27 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04N1VB0n006096;
        Fri, 22 May 2020 18:32:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=98ZgZVR5A47n8AEHE7ESHW4pSdnJ7s2QaUrOS0X0a+g=;
 b=Q4Xt6LBUUbC14nWzpwXOAEnWgdl7vb8smG5VDJzbuxwZ6IxBzEJRS2gnrzyUvWxOM4/c
 kuy3VO2UNdBkk1ztPoniFlPsdTaHjEaxPcrSojqx8HdWG1+fd2yNYlBTED4BBbnaYBAr
 1XinsqIDtVQJ/OjwwR0HHyz4IyGtQKK8YQc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 314e9u1s5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 May 2020 18:32:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 22 May 2020 18:32:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EG2myRohfdhOZrd8ynnHBuNdHJ0OqLkUsaP/VkfH6W5Iacfa8ULKYwFnAWvLQc0fn0sgvmDp9ZdoPS7jx1ZwNgL1Z3kvIISinltaeVKEOr5hPia/0L/fuDjnp8Ij8a1IPLu8s6/Zn2pYaB/XumzBy5lVPgaviAdGapbxCglkwt6swIsHBUvM4O+SiOIWThz1Ixeac+VXegmezFO2+a8bturc/yOaVX080123NLOLozNDFA4NQ4YvXwOSKMrlFjkHwIctDHaFfN2pXK6CQbukGtsClQJPDrTpFCP9JmVCivuuDGJ0cOA+7IGOXV+HbUR6ElEtbxIfXcQ1YSt5cMt5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98ZgZVR5A47n8AEHE7ESHW4pSdnJ7s2QaUrOS0X0a+g=;
 b=UFHTvQeZv2NOk6Z2JHOu8thnWuV+ZYcqlhFdQ+d//h+jpKMYd+SokE3FxA+nCwA3+ZVeuI6cgVAyI0njiUlS1np0OcDm0C5vHphSt53UuptIXjmEX0olBPkX8M92VBaj59EoaEVhDZ6F1T7qf3dCPY3GsOCKzrNDfg0HHzphDZPbeX5lzW7o5+l5rwAJI8u74vepXZ5FRk2D3SQcMipOAZb0zHkQBGTTUXmQ59ov9KGhcOwfISsnMr1MT8RUpmDT/Tsrk7PQfy/Za0A+AC/tKIBWHyNLyclHAOPQ3mesdG+zRiy3YYyrR2ZFO0I0VfSSwoOvrbYu+qz48Z8pvGMeLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98ZgZVR5A47n8AEHE7ESHW4pSdnJ7s2QaUrOS0X0a+g=;
 b=U/YLC21YK3YDZDgKVzWKwvsLAo+y8gX/QQYz+kOGklOi7MnB1pVfK/wg7FKbJNdlou6tQFLXvtTl5BIdD6QJ74fzWu9IFfH+10KzQjyc9KXAyxwiHJ4DyojXlAgY2xeGR+JBJk3w51Dbh0Pd8kjnPA+yS7j8kfsFhz86Z4nB0cg=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3429.namprd15.prod.outlook.com (2603:10b6:a03:10c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Sat, 23 May
 2020 01:32:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.3021.020; Sat, 23 May 2020
 01:32:04 +0000
Date:   Fri, 22 May 2020 18:32:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200523013200.GA356168@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-8-guro@fb.com>
 <930fb5f4-0666-5db0-0fcf-a78171bf29be@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930fb5f4-0666-5db0-0fcf-a78171bf29be@suse.cz>
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:8195) by BYAPR08CA0061.namprd08.prod.outlook.com (2603:10b6:a03:117::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Sat, 23 May 2020 01:32:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:8195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 567fac9e-9a11-4e79-5e95-08d7feb91902
X-MS-TrafficTypeDiagnostic: BYAPR15MB3429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3429CBD923EB3E18526A58D6BEB50@BYAPR15MB3429.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0412A98A59
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgpJlUlKV2Bm0rBcTyp+ZxIsluqYvHt1PdswWPMufsk0AK1ojZRI3G48CvC+Q5BT0EE7L1rbqNg4VWnxGfFNv8HlPFN6xhDrOCkc0o1Kf5S+BPNJv38tpulheTXVq2ybe+2OMzidXSWAZQfUeKSg1r+S2zr1Ua4dxGYvbZcRgfS1qdB500sTt9XVrN5eT5mxv0XEPW0qtd/kmdAoEz6prmaG8M0Nv0p0R8jyO+89iWfH3VUuaMqbojfAPiP3LaqkuLEjwFxJPj2M7OFPKIkGUkguUKXM5OsiNvKXCdejD5UNM3EdMBe6rNC5Lyl1xqtvvxfcyRzjORNFx7HJlIiLxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(66556008)(53546011)(6506007)(7696005)(8676002)(86362001)(2906002)(52116002)(66946007)(55016002)(16526019)(6916009)(9686003)(186003)(8936002)(33656002)(66476007)(54906003)(316002)(5660300002)(4326008)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +8/8qguiKa+dq7uvewKGrvLQAQwu4B2h71TyaiwmXkNzHafwHDz2xuVYq/VySY+n17UlR0eXsn8WLdjQDaMLUUkEveO7XcRcLCbDTWOxTvDTridKKFHwmtIeeRssEay1ylbV5zCueKgN59WZNheM6PuOOcKV0cKI8hetaHVAnNOWjJXO+kxP699eiJT1vJBf+mU9+LRbM6ereixlwmwcQ3ms2z9Rp586zwz+nlmmX6vrntlFc5rCxBVqUoI9aDrfDAkCdd2pJ06py07aq6kGsCr0osXHWh/oxwnFvqOZMNXFOyMcZqh06RcgxWEYZhHqtXoOlt827gCOFLoqUH87/9/qWv2l7HE4lVfCGXGPnGZ6RPHKJdPiMCi3MhZXJS7khzGppZHfCMKImk13dg58fLFWlM1RetHEO4EWThd1L/jGyUeuUonYcfuwLh2yKVFlSgmGK3G6KnDw58dDVA7GNz6Bb1m892WKj+kasSEqlH/HeWHhkn+bV3oahDkJ8zyzid6vobbMI/a7aq6FahPCLw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 567fac9e-9a11-4e79-5e95-08d7feb91902
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2020 01:32:04.0883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ow3u14IgjE/GPMv4VInIV/zccvXdvmTYuZYF9G/xjjbY8G0mrEoCz6YuWD1JRCIy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3429
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-22_12:2020-05-22,2020-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 priorityscore=1501
 cotscore=-2147483648 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=1 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005230010
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:27:15PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:46 PM, Roman Gushchin wrote:
> > Allocate and release memory to store obj_cgroup pointers for each
> > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > to the allocated space.
> > 
> > To distinguish between obj_cgroups and memcg pointers in case
> > when it's not obvious which one is used (as in page_cgroup_ino()),
> > let's always set the lowest bit in the obj_cgroup case.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thank you!

> 
> But I have a suggestion:
> 
> ...
> 
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -191,4 +191,6 @@ static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> >  				 cache->reciprocal_size);
> >  }
> >  
> > +extern int objs_per_slab(struct kmem_cache *cache);
> > +
> >  #endif /* _LINUX_SLUB_DEF_H */
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 7f87a0eeafec..63826e460b3f 100644
> 
> ...
> 
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5992,4 +5992,9 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
> >  {
> >  	return -EIO;
> >  }
> > +
> > +int objs_per_slab(struct kmem_cache *cache)
> > +{
> > +	return oo_objects(cache->oo);
> > +}
> >  #endif /* CONFIG_SLUB_DEBUG */
> > 
> 
> It's somewhat unfortunate to function call just for this. Although perhaps
> compiler can be smart enough as charge_slab_page() (that callse objs_per_slab())
> is inline and called from alloc_slab_page() which is also in mm/slub.c.
> 
> But it might be also a bit wasteful in case SLUB doesn't manage to allocate its
> desired order, but smaller. The actual number of objects is then in page->objects.
> 
> So ideally this should use something like objs_per_slab_page(cache, page) where
> SLAB supplies cache->num and SLUB page->objects, both implementations inline,
> and ignoring the other parameter?

Yeah, good point, makes total sense to me. I'll implement it in the next version
of the patchset.

Thank you!
