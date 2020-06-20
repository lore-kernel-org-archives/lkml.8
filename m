Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7A92137B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GyaDbSri";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f440MGAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgFTBaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:30:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14538 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730293AbgFTBa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:30:28 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05K1TUQN031439;
        Fri, 19 Jun 2020 18:29:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=E0jNQLzU24UL7AbvYpmzkmiL7LIy8+lAPrVnIJThW/E=;
 b=GyaDbSribsJYjNiHCV891e/JhhJkEYTzsX58zi6cbUHTuUa2EBeP2o/bTvPQa89MF42e
 TE6IhvkB/HJTgsBY8kM7jymjUm/yCZ1sfd97e452waxT2RQ1qBMmsTYmhrLHda0Liyki
 Lw3fp8nNdpFgZi8p24kRO+OaZousGy7lE9g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rvjccsk7-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 18:29:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 18:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVfId1V1d4cq2RjkSfhU5E5w4t2W1isX/SUiLg5ZaGgsNk0Fx4jTq2KaBVQkYqa2bqwBN/UDLU1D7QVL1MA1357HuaVxV+TYNDjzmH4KL6Qc6G/g/o3JWF4cfJXhbYH1xHjHxR7eNIyy9ik2nKG8IQEP8j2a9QhdAzWbWoIPDdVvpytFwhe1B5+DKVx7QwT6iYAzWiPWx9js4zoZnfoMHAzKWKhBYS/JhrI6vcU60dAVaNZhM8g48sCVvMUx1RBoci6UBC+nDCUDpdhOYQFVVIiXgyN7aJoXc3lf3tH1qBCa7Y5CUTQqvpFFCFc1h6XxkbQEjGHe6WgTlKqRmy9rkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0jNQLzU24UL7AbvYpmzkmiL7LIy8+lAPrVnIJThW/E=;
 b=d5vklCuAn0KHf+5UNBKTBGFjiiZb1YqOPcaBgKCKe1uHKcCRUyAwivroEFkkZrL94KRxAaYguF6OEvU8vLhXhz2p+xhkMj2tWeC/achLN987HLcFc+Pk7KhbCkRnwvysPfE9Wt52jCOj8hkwOtyN0sL231vj64gQJbdGWq/LnmqLSu00ukCiPfnNxBl2wBx0w3aTMtDdsVCY6NhgykAjlSxsae8i2NvNKNiJaWpUTMZBsM9B8lNpOHNRHdl1P/F27CSSpli4W4Uk7dLmlHbl/E8dO2FSqjovYfIqhNatrdjbQ7sHl+YSl1vLfp2yvcBHNa1+xZ/yaCpLxlHhVMzDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0jNQLzU24UL7AbvYpmzkmiL7LIy8+lAPrVnIJThW/E=;
 b=f440MGARFqON2rWVmdyATieI2aY3lpg2sI8IDpSttarQROoP2H3NIDhgno1xwmd3HlhWx/B3I4uMYyxlDJJcBLoEGHmDzCPWn/9kS6DpCFxzMLRFZXZHMF55ih4ytvqSRWqOPjlce+w1pd6/w4U//JF4S/HxJyRAPTZBkU9ZpCU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3556.namprd15.prod.outlook.com (2603:10b6:a03:1ff::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sat, 20 Jun
 2020 01:29:26 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 01:29:25 +0000
Date:   Fri, 19 Jun 2020 18:29:22 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 09/19] mm: memcg/slab: charge individual slab objects
 instead of pages
Message-ID: <20200620012922.GI237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-10-guro@fb.com>
 <CALvZod5z0vRMXdHZPK=j3hDdqvcHjKy6wF=DaU9=2YKOuQ5kUg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5z0vRMXdHZPK=j3hDdqvcHjKy6wF=DaU9=2YKOuQ5kUg@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2b5d) by BYAPR07CA0061.namprd07.prod.outlook.com (2603:10b6:a03:60::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 01:29:24 +0000
X-Originating-IP: [2620:10d:c090:400::5:2b5d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db8569a2-2ec2-4e88-e209-08d814b95dfa
X-MS-TrafficTypeDiagnostic: BY5PR15MB3556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB355654317D30FB72F9B6734ABE990@BY5PR15MB3556.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zqRiUqDrnE9Amf+aIehRya8pWx1W7zuAKHJjb66/MJdWUwmjO9kWMd9Kq6Xj90Fqxkac3cX8+TwjcIMwrCcgLW8jQXyRF51vT2UN+cvWs6DyVw013rUHsL1UNiq/K+8yauT3fGhEHzghz051Cr13tSiFASxZcs3gj7u8T45ZgeSDOPajwUQsf1M/wQmoA8ckGHQ65HUtw3TqIUR5Bqemmp6jyb8uhrYx3z9+na5eckZEFfDuDsc7Fy+/fN4Rb9qSLPs0rJEhNjaqod8yubBbb2gDNyL151Vbhjnwb4oUKeGwamD2qEWyvw81x/TMLcS3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(4326008)(53546011)(6506007)(316002)(33656002)(6916009)(9686003)(86362001)(8936002)(8676002)(83380400001)(55016002)(16526019)(186003)(66556008)(52116002)(478600001)(5660300002)(2906002)(7696005)(1076003)(66946007)(66476007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rQrR7I+Ag9QF/iIotVPUBwkG/O473OX8XstQi1iq2MrmJfaFW1wU9eWLxSxjGlt5wTkNgLaRnxeQ90UG83SzlVk5vlPV5b6SaSAZbtO3dLs6okPc8u1Ld7mdpmvNpgEh0ORueFt74IzzSPgypYyWmFBOJWO+Q9psOvbQDM/t3c9/k+E3pa5F2fqQOpozdThTIWDRE71L5o7BnhTVVBp92f3Zj7yWfFVGulxKOC9mY5HP7Scwpg9n1U5mBrhE2u9VENiCnYOQeSz4Hrrh78xqRz6/IQwLAJ7FMEsjvHR0b/hoAIVze4CjRLg8fPeJA0WwZGCWTxzWaz30BOBJLkkQdtHE/PYMtHzSHTvkC1WdhpbeGBKHccNhxuc1nOeEqB8lja6QpPzzqVOV8ng9OYJfsILFHJqUyk3tH/AuI/qJwyyZ3NIoji3L2YZyuuB3t8H8ALd4UPg26AgjWwZZ3jrqD0hL5rGOTCZr2GzJwa9Mp4grUqzWzOKmXZFBJoesF1irDy5gRvA0O1fW0Vcd7AODSg==
X-MS-Exchange-CrossTenant-Network-Message-Id: db8569a2-2ec2-4e88-e209-08d814b95dfa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 01:29:25.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0lQog15plSMCQRFdlg96Y4yjjF1KmRKqo+KVfOfHNPrSOkYi9MLbJeRHjxHE+hj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3556
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=1 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200007
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:54:24PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
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
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> [snip]
> > +
> > +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> > +                                               struct obj_cgroup **objcgp,
> > +                                               size_t objects, gfp_t flags)
> > +{
> > +       struct kmem_cache *cachep;
> > +
> > +       cachep = memcg_kmem_get_cache(s, objcgp);
> > +       if (is_root_cache(cachep))
> > +               return s;
> > +
> > +       if (obj_cgroup_charge(*objcgp, flags, objects * obj_full_size(s))) {
> > +               memcg_kmem_put_cache(cachep);
> 
> obj_cgroup_put(objcgp)? Or better to do that in memcg_kmem_put_cache().

Hm, you are right, it's a real issue. It's fixed later in the series by
"mm: memcg/slab: use a single set of kmem_caches for all accounted allocations"
though. Good catch!

I'll re-spin necessary patches to avoid it and ask Andrew to replace them.

Thank you!
