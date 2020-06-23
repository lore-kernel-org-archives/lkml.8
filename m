Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0A72072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pnWx68KM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DQ8Rl6jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbgFWPky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:40:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19972 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733025AbgFWPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:40:52 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NFcVsp025548;
        Tue, 23 Jun 2020 08:40:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5caL1xGeHeWMdf0XRjxLpgHj3qoN3pMugG92HrZ7twE=;
 b=pnWx68KMcXV+opmjSy/iC5a4ROVnRv6PymZsrb54QFvG1MVVTkImLPTWzXPAHoDKBGhv
 /wVDPduDM8vQTfBMa49YvgZ8qVlNBTbTV19Av0eCja+ATnyScIJp/YKFPUgVOPKIrIZx
 44NthA1lo3YadCqcZe1nzjfX53jH9mK21KI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk2ugga0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 08:40:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 08:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie9R+Y9wniBX+q/N6rp21lhU50NugZuUixxpUjQRKxTLDTtCgSdeLEhr1WKSAze7+O/Q4aw6ZAmawmkHX5EDhn65yCmluhUIogtWXU2yhHsGjbAgYIM1W5JCrYWeUlYsZk/Nn43NLG2wfvx1/esZYcfCIDrdtxpGxOujufyUL7cRGuY7MtezQMoEjxwgDWy2tq18oAsE8lq/r+LyMGey299m3//5JkjZp9lNwv8fZj19lTaIBLT42KNQmBhmzbfp3dc+ngH3ofFJ9NixOFaAjFc/IGwA/BU5RJ2tS28iUq0DgjZ+gfl7Ujp760G9HhiCQFbA6TKg9w6j3AgBkjsOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5caL1xGeHeWMdf0XRjxLpgHj3qoN3pMugG92HrZ7twE=;
 b=LpszEPD3Fb67Ul89XWJo/AW3FBbaRFOqyK8PGAPiDquPjABXsb2/QQTsNcxhMpEVI6H+REmMfidktrtIXQe6edaY6QgB7NLXrnTh47KCBNRm5rsq25KPVz904Tk77Ge6LJM0fi6rPWoYgitUZAtm9EdhyfqDwaSy+LGTHsFt7DUhKfyWl0CGvTXw6zjl7CexRnFL7a9Y/k91VdUoVKjC4VxRJ3w9DAGqkqvL9V5CZiigis6v3tpoTXQOPqtyjaIXKEMnhp6yaHWLVZeD6yI50mAEeTeyBr15BKXtIGpVY9zRaSPs/dbLNy0J1mhIIiRv6B4y/3JGpLHB6FzowjjuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5caL1xGeHeWMdf0XRjxLpgHj3qoN3pMugG92HrZ7twE=;
 b=DQ8Rl6jS1r63F68DfE1jlwwV9ILSaPJX4cOyHtiLgb4CiFon3bD0pfdPRWOtDE4pNMC4HDyC8AVzlDqag2mPNU+wtgtNwMsKWBi8yzFWYjErz3fr0jbp1E0hNcZRHT4u8pG0udXEYMk1zFgdhAVYHu/1rjslX4cbtw0g+A7QOrI=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2392.namprd15.prod.outlook.com (2603:10b6:a02:8d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 15:40:30 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 15:40:30 +0000
Date:   Tue, 23 Jun 2020 08:40:27 -0700
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
Subject: Re: [PATCH v7 09/19] mm: memcg/slab: charge individual slab objects
 instead of pages
Message-ID: <20200623154027.GB345679@carbon.dhcp.thefacebook.com>
References: <20200623015846.1141975-1-guro@fb.com>
 <20200623015846.1141975-10-guro@fb.com>
 <CALvZod4jchG_4gvigzb=iAoi1ytX6HVJe0xCp8b8=cc4NiXENg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4jchG_4gvigzb=iAoi1ytX6HVJe0xCp8b8=cc4NiXENg@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:161f) by BYAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:c0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.13 via Frontend Transport; Tue, 23 Jun 2020 15:40:29 +0000
X-Originating-IP: [2620:10d:c090:400::5:161f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43270aec-6903-4aee-be77-08d8178bc25d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2392D271C7F86F90DEEC120EBE940@BYAPR15MB2392.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99a/szWyicSAdiEus2V5B7Fqc5Bpr2TLnioiASdDO9w3bPNo2y/Jv1g63GVL7xMK+MGeKCA47WXtzaYmQKl2UccxEg/DheYF2UDQXgXY+oaaKhtSTs02fztsdbiGKqZNdheooDE7lqaexcyrmw/XSpE/PLF7oX+deVrSsjL4Hsp297mf0i7VoBSEhHQqRlABfE2ycaf8sC6Xy/fe0z6hCZd3vpPKYNJXciMFkOWrnF6EePSx6Oc+eRNWPYMmPLP6X1DcqvHjwZkHERu3f7R/KCMCAGScMIv4bvY8CCZuVxhI/V2zM9bX5RAia7TuYe6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(55016002)(5660300002)(54906003)(1076003)(9686003)(86362001)(478600001)(66476007)(66556008)(6916009)(316002)(2906002)(66946007)(16526019)(52116002)(83380400001)(7696005)(186003)(6506007)(8936002)(33656002)(53546011)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: d4GptY6JQzM02NzBSQdWMDN1COl7tdSymRR3HPDSYgLF0Og6f9lHKZl28oTNQFoSxVVXH6OuuHha3C8ty3iZ6vrpHBHZZQaqecVv9qioqPFchCjGFtEYOVcaAu43aj2hUd/eIedjUKuoXEpoKZyMqaaFCas9hcdklJRM2GTfu1rfKLvYJD6Fl+MZPLzZuCc5sJFrIu5vrNiik9p3dgRz0FJgFyk602zslVGH6prfcAX/yJguHdXmMtYVtccq4JMhnsDhK1oVu21uTLd0QY9VJb1oD346i5Y06s1vPSiMXFrNeldDlmyFo47rt8ik6cEYDwyOiBb7XhxztkD75ZXJRKRSZwmNF258XHT4/Hj6T973qOJfrfKnMR08vM85SaYuqV6fVC8HDOXsas8OUoMn9oUX1J4qhcypPBpkt+/suXipuIqMa5OpwbZqM9SsY0bvaF2NMLRk7JQ68UQ/gCE3tsIs8f8gkJAieMZdc0tslqGCzxzQoDkw4tPcBkc3JchaJsx0J+keCX4SOOM9Cv6BIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43270aec-6903-4aee-be77-08d8178bc25d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 15:40:30.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arfhF0NnQ/KP2M1oCGlleHJe0txJUYmGNR8m6GN1RCc8UzceBC/5a0otZ+7L99oE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2392
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=1
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230119
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:19:25PM -0700, Shakeel Butt wrote:
> On Mon, Jun 22, 2020 at 6:58 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Switch to per-object accounting of non-root slab objects.
> >
> > Charging is performed using obj_cgroup API in the pre_alloc hook.
> > Obj_cgroup is charged with the size of the object and the size of
> > metadata: as now it's the size of an obj_cgroup pointer.  If the amount of
> > memory has been charged successfully, the actual allocation code is
> > executed.  Otherwise, -ENOMEM is returned.
> >
> > In the post_alloc hook if the actual allocation succeeded, corresponding
> > vmstats are bumped and the obj_cgroup pointer is saved.  Otherwise, the
> > charge is canceled.
> >
> > On the free path obj_cgroup pointer is obtained and used to uncharge the
> > size of the releasing object.
> >
> > Memcg and lruvec counters are now representing only memory used by active
> > slab objects and do not include the free space.  The free space is shared
> > and doesn't belong to any specific cgroup.
> >
> > Global per-node slab vmstats are still modified from
> > (un)charge_slab_page() functions.  The idea is to keep all slab pages
> > accounted as slab pages on system level.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> [snip]
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
> I think you forgot to put obj_cgroup_put(*objcgp) here again.

Indeed. I've added it, but looks like I've lost it during one of rebases.
Will put it back and resend. Good catch!

Thank you!
