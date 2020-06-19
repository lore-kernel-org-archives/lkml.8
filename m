Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B01FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28BF22400
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PXXxR/Wn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jKGOjoZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFSW5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:57:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44146 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730018AbgFSW5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:57:00 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JMi1Al009982;
        Fri, 19 Jun 2020 15:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MXEQfSNu0oOIHQdNYOlGMqFfLG5osBvasPMi0pITXmY=;
 b=PXXxR/WnXTEHkqXxZZ6nW+y+ayi5fJptldqhoAFQvlOyuhFGpUVix/BnF6lJsm8c4YKt
 s/AsQ7PcAf80n7vD6LYYq+Ueov6UA1wY562iJCVVj0/+zzgXG4aCjNujVbbSSd6B0aWt
 A3JVNe3BUlvm0VlU2Oz/zA4oUErjgGLtNrA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31s2rcs60q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 15:52:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 15:52:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpY42+eU+wRAb7amWRzru/RsyfXpBgUqT/wwann+BT/rd25rS4ukSVi4CI03CPe+BNN515Oepv7YDecUM8t7DdtW4RL0pOASERHLLmzHURLQl2rLZtnvjVincxhliVMpCeYpkfpYZfawWnlCIO0FSJr83rSNEec3uUnRih8/t6vvZy3RvLm45Hzq8OmQ+RjjshGzYRe/ef985blSvVaGlCF09Jx3M2qQy7dnuehg8crSuP2IKl3URHtve++gWwZQErlF+fkP02qZJxjBLCn0a0vmcNevN9t6WhGKsompB7zAhy0E16+YVbXXWiEJxax9ur71X9VjUqdTNkzX0SiKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXEQfSNu0oOIHQdNYOlGMqFfLG5osBvasPMi0pITXmY=;
 b=WqBHrBcEzlMQ31ni5UQQdOmRA9o7nkN+erBkjdAlq60vZtPRnjZZNdhuOWDpqK55Jok3dnuzLuC22hEpwnPgmncYixQXJwDCQKEadlPxQYfewbXAYwYKTKHkhopVSyX3ERGQ7HuGNslVR/HeBnyOJ3LfdFiHGvSmZDGAIiaKDMeWUeqFbM5LEFfixCB22WhCVF07BiohaNLKtOhntLWfbW1aQN82RcFc7jdO1gXxVbIz8NlTrJjXduYpJBbPTZAFdgecAnQusiVz98FmpCmXbAXcKAnf2mCBV+iXVIPTRVIn7as+wLiQ5HMm8ymqabJlHOSLmZkpr27ys6jHl7Vj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXEQfSNu0oOIHQdNYOlGMqFfLG5osBvasPMi0pITXmY=;
 b=jKGOjoZOOCwpm+mk5BIpFMJqh9eHS6iOdBlr+GK61wowyp+U+MdBVZcO3PSi7TuStUeKgaQRASLtC9p5tpkICY4ZXMum67uPnmZ/d05btKjqKrtumthJExU1V1p9eOVrK33hICXYjJMfPusN93qzeKJZ4SXc0X4bRzRI9a0htDE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3144.namprd15.prod.outlook.com (2603:10b6:a03:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 22:52:46 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 22:52:46 +0000
Date:   Fri, 19 Jun 2020 15:52:43 -0700
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
Subject: Re: [PATCH v6 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200619225243.GB237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-7-guro@fb.com>
 <CALvZod4hq5moKcb6f5L6VAS+v5+jKf8Hyd0gLotD7bMK7FsKgg@mail.gmail.com>
 <20200619213810.GA237539@carbon.dhcp.thefacebook.com>
 <CALvZod4-hsXx6GcrftsXtMA08w9gJ3Sk_Lv0CxzDF20xsyf9JQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4-hsXx6GcrftsXtMA08w9gJ3Sk_Lv0CxzDF20xsyf9JQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a2a9) by BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 22:52:46 +0000
X-Originating-IP: [2620:10d:c090:400::5:a2a9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b77858f9-0cfa-4169-cb0e-08d814a37be8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB314421BE3F689D528CA0CB01BE980@BYAPR15MB3144.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2k0rrDcXlUByyXdb+yX1GeXudEUVx1rK70BUxS3fUjCdPLeRvTrKL2cDQLI0PY9Hhx5BQNaBZZOwFn3HQOT4DqNYijqu3WaC7E749UpIUV19Ije+Z0t33iaXghgOZZ8bPFAKY7v+O7pAKSNyS9Glu1TUCmhW0bv43VVRjf8uLj0+hLRCusI5yQlJ3HjlrT2Pff9peFrD1Aws5C2eH2yxFzyyHXjl4Jgp1Fe8JlMRS3LP7y8agtZs2rWlVO41Blsk67x8okdeOmVJISNtGmG7Ta2gvG7yk4y7A6+PQxAfUvWGTjVDJZF2MWxR6+adEE8mY9lAZlPtihFwmZIJ69aLuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(2906002)(86362001)(66946007)(1076003)(66476007)(66556008)(16526019)(478600001)(186003)(54906003)(316002)(9686003)(8936002)(55016002)(7696005)(52116002)(8676002)(6916009)(33656002)(6666004)(53546011)(4326008)(5660300002)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JIXC9i0ze9PYZ0buFoC+P6npuyiIWDKWl16a44MEjFbxC5IrUTv1DV5LfrwMHHoKHPt3iWke659QmkJLTMc6Dmjpv3JEmQjxjo6+J7Acs3C/4CWd4hiX6v1u+uOdUAawGdjCJkeOM32gWWmirBEKyboVGUXwYqp1AV/sXJk/1AgDraWI5AhihT1oXo7EoxcPzIv/ZQFLtdWSSRNE3lCfPE9Hr7Q1Y3AX2Kn9iqQUoDsjuO+VPa8HLM/qxj+OcPLVw0CjWl4JUxrHMiosbFqdRkv/RvbWUWW8LHCx6YM5XVQ8Xfg5B0ly7htlBtNM9savd2fXBT1+okH28B59+fdWQQGZQ3XfM0BppP2wX9e+bnbzXuIY29+NItHVLTREedcb2hKvgRMvIhppKAmsOlVKm/V4cD6KTib0beDw8bER8/ijQks32cimgZK6XW6TLOqO4BdWPGvlDYBJ9IGUYonVwEXf1/QCmLZs9DJPXfKlFzxyetyTGhoEMAIN/vSGzwf7j35UuDN5a54JP+6TyLtBrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b77858f9-0cfa-4169-cb0e-08d814a37be8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 22:52:46.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL7ShV2FRWOCjmtcvSmgQ2yOKjimfiV9ihX+eTwcqypfmTZllDhS+TsJHSisoIF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3144
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 clxscore=1015 adultscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190159
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:16:44PM -0700, Shakeel Butt wrote:
> On Fri, Jun 19, 2020 at 2:38 PM Roman Gushchin <guro@fb.com> wrote:
> >
> [snip]
> > > > memcg->objcg is rcu protected.
> > > > objcg->memcg is a raw pointer, which is always pointing at a memory
> > > > cgroup, but can be atomically swapped to the parent memory cgroup. So
> > > > the caller
> > >
> > > What type of caller? The allocator?
> >
> > Basically whoever uses the pointer. Is it better to s/caller/user?
> >
> 
> Yes 'user' feels better.
> 
> > >
> [...]
> > >
> > > The normal stock can go to 32*nr_cpus*PAGE_SIZE. I am wondering if
> > > just PAGE_SIZE is too less for obj stock.
> >
> > It works on top of the current stock of 32 pages, so it can grab these
> > 32 pages without any atomic operations. And it should be easy to increase
> > this limit if we'll see any benefits.
> >
> > Thank you for looking into the patchset!
> >
> > Andrew, can you, please, squash the following fix based on Shakeel's suggestions?
> > Thanks!
> >
> > --
> 
> For the following squashed into the original patch:
> 
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Thank you!
