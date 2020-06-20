Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19937C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78F420732
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NXCaZl9Z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CjNLpWKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgFTBUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:20:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5174 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731323AbgFTBUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:20:11 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05K1I5ih006581;
        Fri, 19 Jun 2020 18:19:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=PO45wGZY/EFnGvrBDeyRWBDf4NqZCipiKwm7q3d2ZQM=;
 b=NXCaZl9ZEahzDkydzQwa3BVb+yBBKqZUPtJxBKmqUvEU/oj1pFTt2Ip0h4ThDPKhD7mN
 6PF4+/JUgD9Qwr6a/bAB7YrA3zQ8UlYHREJ628uBneKZyVGDnPNB5B1aoJLZvylyunPs
 0O6LvPs67L99/dfS+/7VmDJ5lVn9PmOPqS8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31rqwqy40n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 18:19:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 18:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw9mBICBSrFKeiE7uxrW7yYkGlbB7ud81zUfDf3XkL+1Yw4rweh5+xyLDrHqwdDk/g8nvONLQK4SmskgX4pKF+u2dm3VnJ7eYjRKOyl32k/GSTFqDxDhJZSWoUcR4FpNJhha/Kfm0Gp0W8K4B83lrqxh+hApdWwwL30foJjRnwIkV5N108uwHfg3t/mBL/pTME2FbF4JG+tYS8paHlsjsDLYe+V1zQDbOWWGZX6mdrENf7D104uT6iW7GmZExvHEVLMYJHRZeKHshDcsni0IzLM6cZzwLslEW3YJ3wU7m86+cpCxKNjJQRx89A0fCT51K5PRilaDXmHrm9H3NdgIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO45wGZY/EFnGvrBDeyRWBDf4NqZCipiKwm7q3d2ZQM=;
 b=ehF6lLwoEn2cwHxE4C2azn5mB+BVQxGTT+xiTOLQ0B3xGagvKeeMzfIcWvpqrBaaDq53vM1Fwg69+mmzHDdK849mV13M0/XY9oUv2k2s0pYLrSxuZdArUX2AaI/kg+IDilJRwme3yLUgb6EmWBs0o4mQmMGprgE8pSVZm9MQbGuu9OnddLB8qYZxKhzUFWlPZ4/Mfxxq5lFmPMgqvsYgaB0M4am17HVrjObyNTmMTfJkbBztVJ2xLLioWwhu+a2lctXSUWEW5yReh48sMdP5BuWHg3T2L2aQga8gs+5dhUJ/5do12exuQQmu8gFDtySH8m+8S8FttgU5rGyRY/8Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PO45wGZY/EFnGvrBDeyRWBDf4NqZCipiKwm7q3d2ZQM=;
 b=CjNLpWKf4zJtY5TzCAACz51YDb1pcBydWXmwOl+sOTuOkoTJP2cWNjj3go0pZUcdz17sENuqU2yq8jtSpoEjtDgy3PhImIJxFGSlrN9gtRcx97v2r2i1dRd46WJrjs65Z1kTAwAaK8kn1UBj7FoLDAE3ZKjp7Ne1axaCgwh/0Ug=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2805.namprd15.prod.outlook.com (2603:10b6:a03:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sat, 20 Jun
 2020 01:19:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 01:19:03 +0000
Date:   Fri, 19 Jun 2020 18:19:00 -0700
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
Subject: Re: [PATCH v6 08/19] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
Message-ID: <20200620011900.GH237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-9-guro@fb.com>
 <CALvZod67=97-thcR0QhhazFChWZ5p=ZjFLXYNnpj0ft5trRgjg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod67=97-thcR0QhhazFChWZ5p=ZjFLXYNnpj0ft5trRgjg@mail.gmail.com>
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2b5d) by BYAPR08CA0029.namprd08.prod.outlook.com (2603:10b6:a03:100::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 01:19:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:2b5d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edce8810-b2e5-45e1-5688-08d814b7eafe
X-MS-TrafficTypeDiagnostic: BYAPR15MB2805:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB280515D0CE4A3DBB28116D3BBE990@BYAPR15MB2805.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BtontoYYepY5No/oOnNKSvXiZrEs6+jJ3m/7YzIKf1FhlTavNYTn8Xi0TOc0no9yhqZnjKXGPpaeKIw4DYVQ1FavJpnS7lyWNfb6q8BeOj7zk2RCpxwQGDc4o7YmzRgE4WZF3IFjKyjRmhz3ep4ENSyydT90ZBIVxG0iWRcOlAr/A30f9us4HP96scB2YGXiq9gENCSSrmJdHmHdESTLyVKh+NCV08gmQUY0Fmd9BX8xcDLNmTT7W3lEZsgFArscwejYNPQHLoOakrTSq52pWuJ3+qvx6aAPTLXyKJXDrMg32h6VhZ+MhJB1JKk84B2StBWQbc4dGi1WXZZje2nJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(376002)(39860400002)(366004)(478600001)(52116002)(7696005)(186003)(6506007)(1076003)(33656002)(53546011)(66946007)(16526019)(66476007)(66556008)(54906003)(316002)(55016002)(9686003)(86362001)(5660300002)(4326008)(8936002)(6916009)(8676002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 48GciOZntXfBDIazbIt8l3jYqExmJ21f5muzNrqM0f94TcNtrUTT7AhxgM8lsG6oXHy8hrawynGBRHIOowno+p0ojd2CriW7F0Xi7WArlCOzwktUxTTT61zekJy+iXz5SXth+Wlq1eCO8ryTAA4FrQznAzMFHLZmxqnm/Zca4em3LIbyl0UEIlPf2a2la8P5LNoWdh3d+Yfi+36w6EKyhuy1BSm+SirylYo3PVO1qMS5S9DolOxetshNOdChtxpdFLgdmBNyEPyv9wCpkS3fKP+7YENYCLQqVBlcS44fC1vCCM8tu49N409LPC7acJpPQMUpXkJuSBhAy1btx0UJpG8r5F/noE/5bQ41Jkfuw7yafHmxJcB11RiOVccRLtUwg+xxCLqs68b1PfRHnc1tldcEodAGY18QCteF13jaRwA43rN5G5IlNI0ZuleXWbGnpCjH5pVgGAyXkEaTWKnbra7QYTCk0d9LNgGRnTnSNq8uCyNNJB82czmW1ZehW3XCbqGX/QWH4uJiWQ4Ii4WXTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: edce8810-b2e5-45e1-5688-08d814b7eafe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 01:19:03.4703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okyMd5dpjSUfQ5im+1axgZ8lf3vKjAMk8Ctk7a5ZDwF0++e1AR7njS8WBtQzSZNW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2805
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200005
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 05:16:02PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
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
> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> One nit below otherwise:
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> > ---
> [snip]
> > +static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > +                                             struct obj_cgroup *objcg,
> > +                                             size_t size, void **p)
> > +{
> > +       struct page *page;
> > +       unsigned long off;
> > +       size_t i;
> > +
> > +       for (i = 0; i < size; i++) {
> > +               if (likely(p[i])) {
> > +                       page = virt_to_head_page(p[i]);
> > +                       off = obj_to_index(s, page, p[i]);
> > +                       obj_cgroup_get(objcg);
> > +                       page_obj_cgroups(page)[off] = objcg;
> > +               }
> > +       }
> > +       obj_cgroup_put(objcg);
> 
> Nit: we get the objcg reference in memcg_kmem_get_cache(), doesn't it
> look cleaner to put that reference in memcg_kmem_put_cache() instead
> of here.

memcg_kmem_put_cache() will go away completely later in the series.

I know the code might look sub-optimal and messy on some stages,
but it's only because there is a big transition from the original
to the final state, and I don't wanna to increase intermediate diffs.

Please, take a look at the final result.
