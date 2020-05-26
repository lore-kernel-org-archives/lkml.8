Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B3EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4973120849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ToK6Y5EG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="G1E38BvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgEZRxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:53:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5362 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388586AbgEZRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:53:45 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QHnGXh017622;
        Tue, 26 May 2020 10:53:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rgFPxXMqRmr5p+Ji4rbndo3j1Danu19YpQM0QcRwe5M=;
 b=ToK6Y5EGZ1WBlpPFSv5BJ94jZgkLjKELqXn1pEt7WDZpXDz2HIxjMRTM/dh3DjI/ktwI
 p7o9uCrpun13GCPx3l0vI3g3L/xnkn8GAl4O2G4yAes6u5pdJgK7eBULPRAz55hScEJa
 hiDbst4bidLKKHmPXJXfSo1URJEORzTKQB4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3171jpjheb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 May 2020 10:53:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 26 May 2020 10:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHc4hPszKi7RmKVCreJxDjQR63tl5i0w9hTWGMZ90sRyyNEwtWlOV5ebgzRNr1xMHMxxSwWSQfCvW+vwKKxAMytgLxrAfr5LyAsUnqeB5ELvOMdVetzytd0X9+riNzIAecwkGFLious2t/VbFfyS39gEHg7h39XaZ+4K+O3uqdLIOP+cDlJIEhdEmeQFJ2rDIsDK1I22X0bzEtEdSjaorQFrVgJZhMJBYslJM5Si/lRi6tmlyo42ku+IXAaXQG34skvw4w9o9dJRPltDyiz/d6hi2XmmgjqPYTUKDjFb2gRP6IVmjzRAD+faoFcSNyOrUH1drx6IXU+U5amn7FR4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgFPxXMqRmr5p+Ji4rbndo3j1Danu19YpQM0QcRwe5M=;
 b=K57pSO/gbnWA6A2T6TajxiKLCDhNbTwp4F2JXjpkbTyp9y44zjNoqKZZa9ciJu/dqMx+vrkOwKG4EWI9Tg+rGGggVTWQc6dcRn3rTSoalZGy5dcXyRyJIIrVicNn2uJ85MvOlvAKhQjimr9vf6YC87ClNXTYNmnUmyXtxFC5GKGwvLb7BmH2ts1SaFx889/fPpsO6aWvpt2+Wc8fdUJIvUCm19653PlMB+xw7mFKUD8sziGObbOsITcyApbjC5bg1CsU7kibAO+9uPudomiZEvORvET4qZD7pVI3G0LYFsRhqWOAlPZ7J4MUsELVoNFnXeqZyxWAdK+ZLynKi05Hgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgFPxXMqRmr5p+Ji4rbndo3j1Danu19YpQM0QcRwe5M=;
 b=G1E38BvZ5416PSl/QBcJ9e3zAMxEdMNeAi8r2z5VRdEjJe7ZiqMOpABS3LReyAVOO9eTakBz1SCL91B6FI2U04euaV6SjCBDwZLA+qkcmWfNuBYj5+QJRI0k8KevrKECH9+oGaKHXgNhuAecSgr5tGh0IUfJyIHT0RGOkmDakV4=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB2030.namprd15.prod.outlook.com
 (2603:10b6:805:3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Tue, 26 May
 2020 17:53:34 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::3046:2fa:5da3:73be%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 17:53:34 +0000
Date:   Tue, 26 May 2020 10:53:30 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/19] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
Message-ID: <20200526175330.GB377498@carbon.DHCP.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-9-guro@fb.com>
 <3e02b3c6-2bf5-bddb-d855-83a1a1a54034@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e02b3c6-2bf5-bddb-d855-83a1a1a54034@suse.cz>
X-ClientProxiedBy: BYAPR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:a03:40::47) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:d3cb) by BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Tue, 26 May 2020 17:53:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:d3cb]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4b79537-6bfc-475b-1be3-08d8019db5c0
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2030166E70531BA448F104E6BEB00@SN6PR1501MB2030.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tycTnNg6sgHZWkXVS3auKmx4ZK6+S38+C3TowZTstGyh+tOmeBn/Yvm806igB/xfkUZnY7mxwQ2Dc6pyEUZQRV7GqRFxQXPBWxJ23sDcARonV/ZnDHAs4x9Ht4DvUQYHVn+UFVk0h8qyvkHaypq8jY7uNorMz+Z5FVvAP8TQraN5VPZQCjCR6hRDipnQQhg4wlQXGdV2T8ZELldmHh+pNpRoTeRywBrk8ZOGGYjTgMM/FFRUWAQFHIcjL9N955kEVbdgBKoP9p6y0kulwgSuuWwRRH7kguDCCd1tjHPxDzWL+t4tTSzGqZeuKXfy33RWjJ40puugnoxCaXQbG00WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(39860400002)(396003)(346002)(8936002)(54906003)(33656002)(8676002)(316002)(86362001)(4326008)(2906002)(1076003)(478600001)(9686003)(6916009)(66556008)(66476007)(55016002)(66946007)(52116002)(7696005)(5660300002)(53546011)(16526019)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: x7V6ovSUlk538fuj+1rSL9UHFobsE4l5SIbOD0r9tHHvznJzNfcwiqCK91/WIUYdQuU2SdeHLVswgabe/3HhYashFpV1N8t+XRtQJMvwmMewJEmdOaA7FHWCXUF06pKwbBeE3eyGcNdF4R+6h9zvSxFwLVkTnrQX7HqNpdmD790C8VYyytezO7MNqoz3NAxaRj7lEMhfdp7NdiY5LNBCiLc7o8DJ4AEHRw7SZ1nrSDhID3LC4bM/7ErZHshueXileY3NXC81u+hcc1FNXD0L//UKx74rEqtDD3E6O2qDgywS3iz394ub5vQ9a7GSUX3PvOJJJbPGqRTl1a4y5n89YwT3eYqP3m2HFkFhImKp7KI6aJFTEkFDtZ2TtBGYrO64gI+lQ/S5wshf1RvlAEoNIa9AqYEghGWNx8EHilUN+iJXlM5NFj8DPufEKK71dvay/xjSMlgVfATJ93tLr2erf1NFFooEREJ5XTz+tbqrSwJoQFQxseeaxG0ygDpzNZBAdEvgQfEhVMcoz1cRbYPtzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b79537-6bfc-475b-1be3-08d8019db5c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 17:53:34.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+yW3iDNhQB+Okr0yf4Zb1E7nEuMwAhdWNBJHAw1p3O/9ubg8F4QJi7zUWL7pwSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2030
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 suspectscore=1 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 cotscore=-2147483648 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:07:22PM +0200, Vlastimil Babka wrote:
> On 4/22/20 10:46 PM, Roman Gushchin wrote:
> > Store the obj_cgroup pointer in the corresponding place of
> > page->obj_cgroups for each allocated non-root slab object.
> > Make sure that each allocated object holds a reference to obj_cgroup.
> > 
> > Objcg pointer is obtained from the memcg->objcg dereferencing
> > in memcg_kmem_get_cache() and passed from pre_alloc_hook to
> > post_alloc_hook. Then in case of successful allocation(s) it's
> > getting stored in the page->obj_cgroups vector.
> > 
> > The objcg obtaining part look a bit bulky now, but it will be simplified
> > by next commits in the series.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit below:
> 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 44def57f050e..525e09e05743 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> ...
> > @@ -636,8 +684,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
> >  					 s->flags, flags);
> >  	}
> >  
> > -	if (memcg_kmem_enabled())
> > -		memcg_kmem_put_cache(s);
> > +	if (!is_root_cache(s))
> > +		memcg_slab_post_alloc_hook(s, objcg, size, p);
> >  }
> >  
> >  #ifndef CONFIG_SLOB
> 
> Keep also the memcg_kmem_enabled() static key check, like elsewhere?
> 

Ok, will add, it can speed things up a little bit. My only concern is that
the code is not ready for memcg_kmem_enabled() turning negative after being positive.
But it's not a concern, right?

Actually, we can simplify memcg_kmem_enabled() mechanics and enable it
only once as soon as the first memcg is fully initialized. I don't think there
is any value in tracking the actual number of active memcgs.

Thanks!
