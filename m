Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B19C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A123207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="E3KmjUx5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XjLoiikk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgGPTju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:39:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728788AbgGPTju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:39:50 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GJNNHU025214;
        Thu, 16 Jul 2020 12:39:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xMRhBbrP5CVjSo+DaNV6NL2j7az6tS0hsuJLzAUzFoA=;
 b=E3KmjUx5Denms/hpkrvtoeHjDzeQdFra3uoMgGaglVjuIJ1+ckL1hjLdDgAFfhavJnD9
 b07iG4k3Nm7hq+d+/OreDqymtTFOtHRGNzr1k13EoZW5IrtftJL6I8gF6+Pxq2/uD1ql
 mp2fzbClR6ZtudgNw1FQvA+HQ/FUgeeascE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 329nqvjbke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Jul 2020 12:39:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 12:39:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKQB3+21TR+IcJIUTyEv9McBMisqbZN/qGMJ76Cu/jm3psJAOx+qG/p/DJNrkLymXHtIBnwMpFj3I5JFq8Ox29DV+XTBaOdr4WbZO7jN99fyTe+4VjwD5sWed2F/GCu7u7USksCRGyuVSefIYuc/UJoCWzvt3M58kIoLaDMCjbwqpqFNyxG7qHqERK+fIEcPQZv7p8XY3x8lGnGw6dCYfZhCEs6gA5B4WpeAcagsLpKSUOv6NZU/A7WUKto187yGdTsz3h0+605hO4vdqTJ85Dw+hg1+LNif7R09pc1Ht9o5micP5fY+GM2yj9aF3jbQs7LBszQk3uWWGNEyVSn1PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMRhBbrP5CVjSo+DaNV6NL2j7az6tS0hsuJLzAUzFoA=;
 b=Yp6v9ER3oTqCXn5r9f8XSEnrzOkPZ/KRRUhCoB4ZuHlapgvKCEht+Cek/tInxtVwjiKFZpevepIbNveVN4MJVHGZ/QaHUwztVujahTWgDmqorz7R1VMNdCJ42ADt8sKFLQjJoev1zvmZ5ARuERP8n20mxsjO5/j/3lmMspm0NgGMtfNydcjBoEB5uPL42ZvHvk14rs0VyN4wKHPJPWCbsC4KrgWB+OFrwFWMeG+PrQ36T366kjHnCSAwgFXJMhjt87O5LqPiDkhoCLrCQSmlCTX98HvQuZ1s6TGk+zXIArHbn1pQqP3xjbpy8RCoUUD+Qhyipt6zsvF2YhMFegmVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMRhBbrP5CVjSo+DaNV6NL2j7az6tS0hsuJLzAUzFoA=;
 b=XjLoiikkE9GCdOjdOs/pi1ore8WHL5Kve8lgBxLDu42tw26fVZqaIE7Cz/bC2NbteNj+Y1vdfjzmrB9iuminSV4XO4Dw/F7zuVOXiOj3MZw/PDdt+KKQtRzfV5brSd/69GNKaB9hcbjlbokxy7OK6JsDkQBE7X2p69T6E/ASawg=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3652.namprd15.prod.outlook.com (2603:10b6:a03:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 19:39:29 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 19:39:29 +0000
Date:   Thu, 16 Jul 2020 12:39:25 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Muchun Song <songmuchun@bytedance.com>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: memcg/slab: fix memory leak at non-root
 kmem_cache destroy
Message-ID: <20200716193925.GA13387@carbon.dhcp.thefacebook.com>
References: <20200716165103.83462-1-songmuchun@bytedance.com>
 <a1e6a270-e7e2-78f0-62dd-c7e9ad1b2903@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e6a270-e7e2-78f0-62dd-c7e9ad1b2903@suse.cz>
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2192) by BYAPR11CA0052.namprd11.prod.outlook.com (2603:10b6:a03:80::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 19:39:28 +0000
X-Originating-IP: [2620:10d:c090:400::5:2192]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4abd1582-f75f-4b91-4cd3-08d829bff481
X-MS-TrafficTypeDiagnostic: BY5PR15MB3652:
X-Microsoft-Antispam-PRVS: <BY5PR15MB365218884AA4FCCA9B40723FBE7F0@BY5PR15MB3652.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vQ3eqZVjuH4reOejV6tUX299oOzu9IsVJEy6K/D/QkSUPFzCh0agGflwbaE6xeOW9Ws56bMN8V7nGul0BZ/mRMMMufnPl0C2km7d0Z4je5CrLoY/EIx+3cj/U2k0v8VXZvwlOcmQ5bN9dvseh+LayDN+vOiCmLRwud1DWzuS13dPVXb5T8aX85u/DS8CsUcD7ss8aNomhM2NRRrhegsNR5+dhP3d0lbXV2EbnP5rF3Jw/Py1ruhDTOvnvX6R+AjPD4ZWkSdRsZoxeBX5fFhl8NJDzyfw/cRt5pFb6NZsXtwfJQ8we+pKnfXt13hLHQi0oZl977IN9tSKxr4HjTTNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(4326008)(52116002)(5660300002)(6506007)(7416002)(66476007)(55016002)(8676002)(66946007)(33656002)(53546011)(66556008)(7696005)(9686003)(6666004)(8936002)(316002)(478600001)(16526019)(83380400001)(86362001)(186003)(6916009)(2906002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ri83lRb9JMYWtbkOIXS8l12UtwxDdjc0rZHXzbLfen4GWgTS2fbVxbNq9VfFMSume2d5pGtomoHqB4I2NDZ580Plk6N6XRxNJmEJJ9RDSfupZw3iWNj4pL19IgWnlVJjxGgq2tioHmuNMt6xRGnQDZAtpSWaODBGHiQh1kDaRWM8bTvAohxGFcH3jBNya932HzKgtcppL/pXpHu8cZP1yHNyrnyUVY5RU95HDOHBPVJeIUTTk8bYMWTAyrEI5KtFfdRntvn/nqCiL5Xen3n3TEEtB5wTOh50e/+uVjrxGt376lEgbFbNpNln76O5Ji/ymbMa1yLFJbnyUX/iWntuvZUJ0StwMBvApnxW8W2+Tt9FDan5bL1XA41+QdRrk9unw12dLrDe9VgX5axO2/aPhWU/1zDyMq3OwSwxA3bOP5ScO8m2C4i3iJRnO2qt0I7gKuZBoFgmL610//CkJXFGDl58Wf0+Fa0iBMQC1JXWIhJg2OTgGFB1XsA0awEbkol478a+Uiz7SIezvUCMy0Jz2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abd1582-f75f-4b91-4cd3-08d829bff481
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 19:39:29.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAWeSfeYftLSxKE/iGjGizB4l7g8ZlVTKolLRPLzrqKde/FTb+eCJvJiLG28q4ct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3652
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=1 phishscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=796 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 07:21:42PM +0200, Vlastimil Babka wrote:
> On 7/16/20 6:51 PM, Muchun Song wrote:
> > If the kmem_cache refcount is greater than one, we should not
> > mark the root kmem_cache as dying. If we mark the root kmem_cache
> > dying incorrectly, the non-root kmem_cache can never be destroyed.
> > It resulted in memory leak when memcg was destroyed. We can use the
> > following steps to reproduce.
> > 
> >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> >      so the refcount of B is just increased.
> >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> >      decrease the B's refcount but mark the B as dying.
> >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> >      B. It leads to create a non-root kmem_cache for allocating memory.
> >   5) When destroy the memory cgroup created in the step 4), the
> >      non-root kmem_cache can never be destroyed.
> > 
> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> > So only when refcount reach zero, we mark the root kmem_cache as dying.
> > 
> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> 
> Cc: <stable@vger.kernel.org>
> 
> And it will need to go before the series that starts with
> mm-memcg-factor-out-memcg-and-lruvec-level-changes-out-of-__mod_lruvec_state.patch
> 
> most likely causing some collisions there to be fixed up...

Collisions should be simple, as all this code with corresponding problems is
removed by the series. So in theory we can even skip applying to 5.9,
not sure if it's a good idea though.

Thanks!
