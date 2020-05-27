Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA088C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F6D20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pTJE0ddM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hfnbnhGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391188AbgE0QaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:30:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390102AbgE0QaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:30:18 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RGPfw3022296;
        Wed, 27 May 2020 09:30:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=I3/4bIpazbXbt82gceOhn2TPYFzYBya4We87w2nI3kc=;
 b=pTJE0ddMxPFcgkiCYAX/AUyYk2piDsd+kZccHYW4cgwlqKxtYNVYSjrcrKV5uk1J/8lx
 8HUwA1f8TuohsMM6SoUEuruOGtKd5ht0hD/jBZrAqBiQmlgtHwFYd5+8sHobOTlx7k1i
 9m7ZhzRXeFSfDSVX2ERNNHCwkpDtQaEosJY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 317khdxcp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 May 2020 09:30:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 09:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW25c5powYfjfTrmZ0VzNJs5sQxVgr6hw58PnGA3IL0KorX1+isuPI24JQ8jPisDZvIDSkjZTJzd24griNFi5OP28IQhyLDSlN8oL2JIsvVNaAwrbzOWOHJWl7eWpNATTBgkzJKhMwBVhGaCIufDFiwV+VygjgjhpJXvjY6YIj18MjMAeQ3wLw0vc81q4Yq2PawZqUPowwDbFTdXi2wnLnfvt51lW2HbVnX5zRsjxJbjO2TBFz8x7W8Yg2ezb+a0Z96/P0X7wQzgBAkc3MuDBqM2LsTgN5fX4568eBKSsswG6CcV9i1gIbo/sW5Aa6AmnuMgpHjufpK1xGxxE/Aj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3/4bIpazbXbt82gceOhn2TPYFzYBya4We87w2nI3kc=;
 b=BRBDeRyPAKG3yuFbEAc77qxa1zjyQ8gKF80Y7+/5Ybq4M+oV5XCq3OmRq3V78YOX6T71ugOmj7CD2Zp93ApSyfENtUIuEljZuZ22OeUltAtawrEUyZvph+zyxAr7ObAVPvldHdFhO6Aj/PzstI5QFqyrkcz7TFNSGUPmBuqY8s+dxfXIWQb1rx3TjH1efqR0HwHQTHtwz8v04njlrywq4CSuDVibga5COPp2Y0H6RP7u1VuVyp7zR4K67seA2U7ZQVGoziiaSFPDrac1QvgPfGJOSqjaBvS//QozLHltrBT8go2jrqN+SrGTwa/SOtlMKpF8fWnd5xdswqqip6npZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3/4bIpazbXbt82gceOhn2TPYFzYBya4We87w2nI3kc=;
 b=hfnbnhGH/WG7X7XLF6ivfpSnDHO+y+KuHafslbehbaxK0x9lzktw6v/xcKYjy56SrziW/+udxqCI1aDEARe9f36KSvQ6jOUE4Xl7UP3B+dGKLiLGP1vNxBc/KPMWo+WbZKp8AytX8H45A26bKCDRkz//WEYjyyJMiCQEYoiJHFY=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 16:30:00 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 16:30:00 +0000
Date:   Wed, 27 May 2020 09:29:56 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 12/19] mm: memcg/slab: use a single set of kmem_caches
 for all accounted allocations
Message-ID: <20200527162956.GC396660@carbon.dhcp.thefacebook.com>
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-13-guro@fb.com>
 <9a7726c8-ac3c-df5c-7409-16e6be22a923@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a7726c8-ac3c-df5c-7409-16e6be22a923@suse.cz>
X-ClientProxiedBy: BYAPR06CA0039.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:bffd) by BYAPR06CA0039.namprd06.prod.outlook.com (2603:10b6:a03:14b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 16:29:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:bffd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d255478-9273-40b4-6670-08d8025b3354
X-MS-TrafficTypeDiagnostic: BYAPR15MB2999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB299917472BD2449B258DE7D1BEB10@BYAPR15MB2999.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zAte4guMjEpHOdCilvC/XTrV2nib1uoj1Q30kNJvpvZHtTiJLn4WeB4zTjSkLZmye0ur2+9pAk6FvTLiGjVHcMPTKF/LET7c+0wnKYBG4/FBagktg9goVvABrERdgAPCxOmzpqFnA5AA0FQDptGBahFr1P2GswjqHDxM9pdLcW7hP3qdC0Axdnh4St0EqLtbuCd1XBxghLH4KKDrKcUfeYqmlUkcReGOQb7xGn5Jvwp0Q/O9OyFJtnLX7Nv7y1Ev5ut0eSb/MVWNPl/QIwpxRY1pVyv1QcoCyyr4qcwq1YQXO3NW+ogo+N88rnPsmw2d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(7696005)(66946007)(6666004)(1076003)(186003)(9686003)(53546011)(16526019)(6506007)(86362001)(316002)(54906003)(4326008)(8936002)(5660300002)(55016002)(52116002)(8676002)(6916009)(66556008)(478600001)(66476007)(33656002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8CNdk6W/6cTUgDP78RX94KgDdpRDhzGsfZ0fOtywIORZrLte/Uc3FsIIgpCvNmlBGdPJwYh7HKCDKMh0yzC1ilC63rPKQlBj78WnXpvkZNrT+gbohQHoXwGh+1bFGIdMBwnPiOioXAUqqHak3aEGOn13Uik6Ra7+eW6V9fGZMxWOrP6RMpig+YJRfxqmpnUQEchk6d+Fy9FAAGvYoxfE7BPSwM+b8Jm8KM1iIZFsXOmZ1JaB1fbVMLys4bsHvqUXkF3MO7DWdwKdgyB+23q2V3JDMMyDrp4x4QNk18dviASZBtfTy+gzpNXzHmVoOedwjIJeWpz2IKWiKXMI06sx7Z4XYLuJ2aqcjEGu5pv4AVqqfnH35S7PfB5ZaUf6JA0bp7+dOy8hQIVz8LAgriN1LTIvsosf5qDAzdTO1Daac3CLg3PWqlY/JLp0qs2cX1/EuGtu6pwvsQFCFR54SvJUetmIXs7LqA5PjdgjuhmScdYEpfSX5fJsge4i0EfWWRsOjFy5I0hVGOhHMR+cAKxb3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d255478-9273-40b4-6670-08d8025b3354
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 16:30:00.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMhO3aJ8o3lpT0Xde5WhhisxB7FB0WPgVdbhUDAQ30HcSnKj8yvp9/mFM4Q+Wms+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=966
 cotscore=-2147483648 malwarescore=0 spamscore=0 suspectscore=5
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270127
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:01:20PM +0200, Vlastimil Babka wrote:
> On 5/26/20 11:42 PM, Roman Gushchin wrote:
> 
> > @@ -549,17 +503,14 @@ static __always_inline int charge_slab_page(struct page *page,
> >  					    gfp_t gfp, int order,
> >  					    struct kmem_cache *s)
> >  {
> > -#ifdef CONFIG_MEMCG_KMEM
> >  	if (memcg_kmem_enabled() && !is_root_cache(s)) {
> >  		int ret;
> >  
> >  		ret = memcg_alloc_page_obj_cgroups(page, s, gfp);
> >  		if (ret)
> >  			return ret;
> > -
> > -		percpu_ref_get_many(&s->memcg_params.refcnt, 1 << order);
> >  	}
> > -#endif
> > +
> >  	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> >  			    PAGE_SIZE << order);
> >  	return 0;
> > @@ -568,12 +519,9 @@ static __always_inline int charge_slab_page(struct page *page,
> >  static __always_inline void uncharge_slab_page(struct page *page, int order,
> >  					       struct kmem_cache *s)
> >  {
> > -#ifdef CONFIG_MEMCG_KMEM
> >  	if (memcg_kmem_enabled() && !is_root_cache(s)) {
> >  		memcg_free_page_obj_cgroups(page);
> > -		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
> > -	}
> 
> This now leaves the { bracket unterminated, breaking compilation.

Ah, indeed, thank you for noticing!
It's fixed by later patches in the patchset, so this is how I missed it.

Let me fix the build, add yours and Johannes's acks and send v5.

Thanks!
