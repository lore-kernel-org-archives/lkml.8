Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A388D2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="alrI9Yks";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="M/a6rhSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbgEZRuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:50:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgEZRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:50:44 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QHfSNe024703;
        Tue, 26 May 2020 10:50:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AZaHoiDkoq3qXupC4HJ/IUWvitre6gKIra3/cmB5RLY=;
 b=alrI9YksvXvB72na2H55mMcTXXG5BQtrJXKh9Nvc10P4sJybMZPncnBrwUzbmjYMrWdd
 EcdWc42E8+pgAf7ILVrb4rchxet5uyThM5L8nbUTybvybP0vt5EjGO1/EwnX6Djaw+PM
 jOQophZNyYnk04Gdc2+8VIb20zHVQhovEIM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 317khdm4sw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 10:50:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 10:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R88x8XOYs9TM4At6YuSomrsnL6X40xi8pwdHbPLKhRksiy2BSJEEu+PSvyrsL26TIKljWxtN7grFingrm+t0/2jTjGREp4VA3H5i48C+xEbX4u2253Ez0GYWJeJ5TLZkTmCpuCbJgqAGMgAh6BLpZ5APwXAg1fgR7rx1JQhTOQbTDM7UEFjjSRC2aP9zhiARerl5lx8zK9BarS0L465xJyNlROw9tgM86FRIG8LVwP5/Bk1xDp2G46uCuwlw4FsWwpW7uIgPDcy85BLnEJ7P10DyXu4F6tlzWUa393SXhNtSja4S2Jh/FfrQk2+RKSz5JVaP2epjZGN3c0FOUUhqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZaHoiDkoq3qXupC4HJ/IUWvitre6gKIra3/cmB5RLY=;
 b=nOLeS9Sl+1uANhapbnTNY5mOB1tD7xNDffqmZIJf22SK4wfuAlPX1m1t+ZI5VKk82s9M7i0PvOHhiOLfqBcQ9Vg0E4td0owdPt6CQ2SSrLwHLkz+qamDMwe8UAgW4UbKsQF5yqarnlUAPfFgXye3Mxz2mdTG+gDvXuvS2O41FX98QsuFILUKKQwNKw1tw3aId8xOV7bPeNTJI537S5x2RARX36kxSXStKFmqr/s1P0TSWwewx9ICE00jaPJC24aUkm/ZJyK4XZr+3cTmkaM3u3iKn6Ch9fEhfKHEA6fcs2DqKjshwhE4I5f197HvlyUDboWh1rMD4KgxQzUBci5Paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZaHoiDkoq3qXupC4HJ/IUWvitre6gKIra3/cmB5RLY=;
 b=M/a6rhSkeOHNGX+VvWgmQ95m7adSlqLU/vpjCBlEoe3vOPqFAxIpU8BSw/jEyTBOyeeGLbnFrfOQ9LbZo+dCf+1qIelooTkIPidQ5s18DdQQMw/8ra+B8sxw2MjvX27/LPmJ+Ry/TKDDr0dWjYMe6t5MoOWqKQ/5oiJWCxbevZA=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB2047.namprd15.prod.outlook.com
 (2603:10b6:805:11::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 17:50:33 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 17:50:33 +0000
Date:   Tue, 26 May 2020 10:50:29 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200526175029.GA377498@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-8-guro@fb.com>
 <930fb5f4-0666-5db0-0fcf-a78171bf29be@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <930fb5f4-0666-5db0-0fcf-a78171bf29be@suse.cz>
X-ClientProxiedBy: BYAPR07CA0101.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::42) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:d139) by BYAPR07CA0101.namprd07.prod.outlook.com (2603:10b6:a03:12b::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 26 May 2020 17:50:32 +0000
X-Originating-IP: [2620:10d:c090:400::5:d139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 329a478f-e347-477f-c3f8-08d8019d49ba
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2047CA84496C3ED51E34CA49BEB00@SN6PR1501MB2047.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ED+Ql8/DFPcB7QJxTZNxSlS9mgLFdaIzg9S3SScaBoU9fJTRo7UV1ek9jJVj2A/czALhNePnocc8XjdkmDJ+Soi6XmLUcuzuN4hCfBhHhnvr8DxqsVqerXyhE3HJfTfIoVXLWjWFyv8fy0jIUj4HNH4skowtysW3MP/oDDyJNcNRCz84eoKGkP0yDzQMHoKF5vrxhE5rPZAa46PRFVojH0WOJ+G6uludJrwI/F1QARrQYSan5UhSDvPgxfh6l54WcfeRS77pX114sbkwAM/Og+XhPPF2DBbX7WEkGbTRCOBvEggaJDkXf56WXmv7shZD269F/OULQNRacd0UQisBaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(4326008)(6506007)(53546011)(2906002)(54906003)(316002)(52116002)(16526019)(186003)(86362001)(7696005)(66556008)(9686003)(6916009)(66946007)(66476007)(33656002)(6666004)(8676002)(8936002)(478600001)(5660300002)(1076003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: biVWdxgj6q+WeDkVHI4AZZ+jLHEBvm4EP4rE1yQuSYWG28kNSkuyOnAaOwZe6GvUwh8oPjG1uGYrk4dBogJ3yd/jhcBg50tnI3fSX27s8zf2W+UsbIgHFA60vj7czrwX0PxMYePh7YCPQ0BOcJzYUkwXot38CzPKI4mA7hUri8wjck3VwK1IQsKKE5BXMDjIIbQrgrLrJwqdwnycRQUHAcoOnt1UaN8aGl8v3OACyptdawam1Ml5YhysP8rCiRlKuTz8YBF2cARvp+lQJ8xgtqwoemECSD5NBHVj8qVpwGzfoRxd6sRCRejWogE+k2WH6ao4FnlgHd1DmbM/lzKqylZady0Ez5Y7mmn0L7paoz1h+tyu0XPBOtSkDr7D/TCPbxb7wFDGMaXmpHDbfA18TEHx0ja/tQ7NBd3RvjlHZO2di45n6Z1Amis8NDsrxbSpgF/Mm+LbzGJx9U7CEZMvAfhjn75N4x5FxOKgzVkQ13Ac+UmpvnqdrYPjwVIbKfWJAAsPcikgwjOi8WWqj2hjpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 329a478f-e347-477f-c3f8-08d8019d49ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 17:50:33.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp2jCP0exxfX7OR6Jb2NNHudCGXs94SfL5y77Mk+Uov6LsjvaGiOgTqnrA3svFPi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2047
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 cotscore=-2147483648 malwarescore=0 spamscore=0 suspectscore=1
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260137
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

Good idea! I'll do this in the next version. Thanks!
