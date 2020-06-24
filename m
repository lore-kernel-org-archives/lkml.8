Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2EB20702
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AFt3xVtb";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hcFBk8yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbgFXBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:49:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23652 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387778AbgFXBtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:49:31 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05O1h3gC021876;
        Tue, 23 Jun 2020 18:49:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9kf1jldxltmyvFbkdO6poS8DbTclJH6IOkFTiSNEbYg=;
 b=AFt3xVtbeKenYZlrCl9nIP+47tWhdIuUujB+qxzeSs0fFU5HZqI/FOIZtoX1Uv3urGJ0
 3fMhrjAhc4KJewe07g78iNAkSogS91lGmKhTc5yX9EgadC0L8Ivb1K9g6oZr1apbh781
 USoKb2bihUVMFW2vYX1FJHRmdk7pWYSl/64= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31uurb8cjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Jun 2020 18:49:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 18:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHZeYteMJS7FUEMfdW8qouCgvaOpM3S6sSEDLTKkuS3hDsObPQYOktr4FADEXjOVWMT5QXkyFWQJp9fLPyqLVsKN+VCm/q+jQam+NiLKkSxtV6qu1zcJjOeBkUeSpYZ6LtJf3QuS3h1pQR5jiLQVVRWZmnTkl/TjGq17MjmzgE9+zqwfznw3jx5kAgFsMnIp8PKMgmGMyYZ5Sd0dUlp1kwxGksrydV8waQ3lYGRw4TH52iRt6Jc82yV6urN0pJ8Lzj2b4d66Qb4lCXDsw97QBEF0MTGZZ8aiSIUAH6aRBxsuhyIEWLM5xPWvhYCJdFF/JNn7fJ4kRmJD2JjDpDKEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kf1jldxltmyvFbkdO6poS8DbTclJH6IOkFTiSNEbYg=;
 b=e8oVA7RYdXY+KPkvv997hx0JB5X2pH4SaUJdC37aOXpBy1s27QKau09KQ9L0Q2Q8l94Gq69qsa8fO4/IBkNrDWlu79rU1XPQi7wKdHTPI3QulnastReDuydXuUk8OFPUzVnY3rR57q8Dgcj3OBQw2dKHUAKGSfx3yMtGSHOiYa2mn3xQ5iwB/Qc/X8a5S1Mi4kkjemcZd+9gdLNINIrvNnC342v7auT40a5P7JfR24+3b+icRNktnLWtRFjiuwJ00+eGefKYHSc/bBk6Zth2M7s6bgaoymirxk2tMe2Ginhdf8u3oZO2hYABfMUZ9xdMSmcUYf5ESEhc/yFSsEjhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kf1jldxltmyvFbkdO6poS8DbTclJH6IOkFTiSNEbYg=;
 b=hcFBk8ydQcEZJBsjnk/7p5I/qNqaJ9bi7sSRR5iPLVHPUgU+7TBoq+/dUed/LWjaI0Jt7ieEOaqOAvLWshDVY3evu8PU4hxmTFeMSoFa79o3rzBCDBgf0Kd2pK6azi3RrKLYTObxWk3r3z+/hU+GH/Tl39HGlFBVQPR0mfbbWEo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 01:49:21 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 01:49:21 +0000
Date:   Tue, 23 Jun 2020 18:49:13 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200624014913.GB358561@carbon.lan>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <CALvZod5m+iK-UsTmrTuhpGyDg=nT3+f=DZUho02AsLGbP4AGsA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5m+iK-UsTmrTuhpGyDg=nT3+f=DZUho02AsLGbP4AGsA@mail.gmail.com>
X-ClientProxiedBy: BYAPR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:72a3) by BYAPR06CA0013.namprd06.prod.outlook.com (2603:10b6:a03:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Wed, 24 Jun 2020 01:49:20 +0000
X-Originating-IP: [2620:10d:c090:400::5:72a3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c169052d-46ad-44b8-c132-08d817e0d084
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2759F8511E3FA6F5FB88BA1CBE950@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3TwiJLiWFp6LohoY6oi/8EiXR2NaGKETwF3I0vXy+H0I1wW8wTSCD8HFTtiwM4J8vO3eIVAYUEfR56844voOdd81iGRHV5sSBn/Qdl3tSg31oKRdy8LwfrbOlU7u8SBmSR3zgCE4sPUjNr+yt5VivayANJP1HvpSFYKlw8MfmcXTZBQCo2G2HL/rHl9HnFSoLItdgFI3Ab04VHun+3q05qudNQYeXYv6nI7U+5I2lIjZ9kzK/ZALuf4J6aC7TJ23DUSlhm0rbe7MxY2MQ8mHBqkGpl9nBnOnKtpcyqU/319t6VRwREL8RgbVX/0fZe0KHD3+9Amnwu8zpyrQxU/NXcnqxeoHOMmi09EUlZDhGPr03iuvn4TJU14lMNVAN/U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(4326008)(6666004)(52116002)(66476007)(5660300002)(478600001)(9686003)(53546011)(8676002)(1076003)(8936002)(6506007)(66946007)(83380400001)(86362001)(6916009)(66556008)(7696005)(2906002)(33656002)(186003)(8886007)(316002)(55016002)(16526019)(54906003)(36756003)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vGzkHYhKjB6BWkVt1K101mIqpYbJM5t7JvRfv7xBGkr0Hzta2Auuk49T7jZVHaCz6HVn/ejGTvTPIa9FumX7e6WJiYAfs/iE7FozFKgJP31WSh2vCwVCIWX8BVHJCRUJHvt7NEEadbtNH7GlPiSiahgYt1IMRTtl/mlzMyIhBgtkXfsc9d1jnwXnY/yZO7k0KbCYu9aIbjBJ1PC8CrjJGv/XL0aSLoUFwioQpTpDRQFQVjFZ8AeCmj5hQmXmLfd25YDe3sVmxJBPS3wO8yE3XDuC5i0lG2gdsLviOMVEV/uKvJrTqPgAPuwY88GN1+cRrCtHif2MJkqA2hKUFiucGwsBUrwlNcoDM+SKnwlCc6d3BIWyLj9LmqOae1Y5a3C14YgR7/HSrukAkHxgXll4NX+wJyPI6tjD1N/M5lN5l4YkPzZ1udT+T0YGoSzzMJZiXUDAbjV/XEj2KxlENpeflbRIfkSxXGlHl+HWBNFNeJC+TmXn7MZn1yq+HwJR9g55EuuLlfDdJ5PyjYkxTBCOsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c169052d-46ad-44b8-c132-08d817e0d084
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 01:49:21.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY5ReHSt8gTIUxVmeDBsYVcwhpFV3k7GeYmrTBEhYivA7WIgSYS/1DilsyXJELK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_17:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 phishscore=0 mlxscore=0 mlxlogscore=739 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 cotscore=-2147483648 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240010
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:40:41PM -0700, Shakeel Butt wrote:
> On Tue, Jun 23, 2020 at 11:47 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > Memory cgroups are using large chunks of percpu memory to store vmstat
> > data.  Yet this memory is not accounted at all, so in the case when there
> > are many (dying) cgroups, it's not exactly clear where all the memory is.
> >
> > Because the size of memory cgroup internal structures can dramatically
> > exceed the size of object or page which is pinning it in the memory, it's
> > not a good idea to simple ignore it.  It actually breaks the isolation
> 
> *simply
> 
> > between cgroups.
> >
> > Let's account the consumed percpu memory to the parent cgroup.
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Acked-by: Dennis Zhou <dennis@kernel.org>
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Hello, Shakeel!

Thank you for the review of this and the previous patchsets!

Btw, I'll be completely offline till the end of the week,
so if any questions will arise around these patchsets,
I'll answer all them on Monday, Jun 29th. Thanks!
