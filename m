Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D787C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5DC20722
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UAyMrg6z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Dr59KVDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgBVArP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:47:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbgBVArO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:47:14 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01M0dlLA015042;
        Fri, 21 Feb 2020 16:47:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=o9dyc83FkO0j+IWrzoR++/xqIJ40LF9HCNm5SFKVBuY=;
 b=UAyMrg6zqPnpubcMm9sL73IMsUrOn95oI/XGdbyhkPxp7BJM0hMvS/FipdgvVQIrH7Bg
 xXl66TLag7cWPha51UWrUGulTI5f9+JvZMd410Z30J1tgOTm21KWaCRUvZOZtWVX+mdj
 UkPc6cVgLXv+eop7hstotfNLq5HuBjc8mrQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yap351315-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Feb 2020 16:47:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 21 Feb 2020 16:47:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnPZdMj2lC8jaU2pXelpscz6Cdt4GbvADqaQm5pLVZkBQ4nD1obrPxwwABFCncub3/5P7QXTTGe+baF+iHOHGdAsKX8EGxCvCRIy4k4K1QG1TbB1182758c8bE3sNymdI9UgWLHbH5UglG8VZlwJucf7qmWAwa6TOJn7OMIT0H5xIAmpvnG9Z7psscfjqjVNI1uTrzL78ZICnxhXhvOYtCpz46G5Kg8uB36u3emDs5gvGbnqXte+pShh78xdsVh91JQ8nfHzTGQXrCx38e2iJA3A3Yv/x5mxBTiXtPoDiyXODwkgspIrrK09qvqEK9YN+kxXc0l33j2ye1PbcVWFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9dyc83FkO0j+IWrzoR++/xqIJ40LF9HCNm5SFKVBuY=;
 b=fUoZR/Dwu1xQ9CAquxOHi5xqOrHI73Y7W7GTSxkWv1ofov7Mh03bT3ZdDS3aLARD2HXz+ee/GTBtv9jfil5SyhnUatIpXKVohCXLaolgNy11F9xB9ujlTzi39KaHhFBHt0/TfX46ll8TWThUY/Z/2R0wWWv1pYXdrS6RGO1iuMHRSjkqW+eOm7qL7mHBZEyEEFZiYkX5Vab2V0W8cLjuhqlTX+dm/O2yOVqt8tzZmhjdERPM+7+0c0+BT5K8/POy1Y8w9sKFlsmZYxFWrgDOeky8uIEKnJdQpIueorwnCySToYQrOGRwE79BYqviVO4H4V1I3B8O/PxjG/TX3BI+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9dyc83FkO0j+IWrzoR++/xqIJ40LF9HCNm5SFKVBuY=;
 b=Dr59KVDTJSBIrXEadE85S78YwuD+yEEos6v9Dfjqjoeoh1nbNVWcYUpDVboGnxVx4wioOc2GHS3MGpZFK1Hu7Ftf8imCRgulFpzZoejwa5KqBrgRJhUYDCAXu6bHi4SF9/Ib7bFRu8B2h/tHashjJQgXQVfnl5Eobgwrze5E6Eg=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3000.namprd15.prod.outlook.com (20.178.239.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Sat, 22 Feb 2020 00:47:00 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2729.033; Sat, 22 Feb 2020
 00:47:00 +0000
Date:   Fri, 21 Feb 2020 16:46:56 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Dennis Zhou <dennis@kernel.org>
CC:     <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [RESEND PATCH] percpu_ref: Fix comment regarding percpu_ref_init
 flags
Message-ID: <20200222004656.GA459391@carbon.DHCP.thefacebook.com>
References: <20200221231607.12782-1-ira.weiny@intel.com>
 <20200221235627.GA59628@dennisz-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221235627.GA59628@dennisz-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: MWHPR10CA0059.namprd10.prod.outlook.com
 (2603:10b6:300:2c::21) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c751) by MWHPR10CA0059.namprd10.prod.outlook.com (2603:10b6:300:2c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Sat, 22 Feb 2020 00:46:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:c751]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92e0bf64-aae6-4fed-d6a9-08d7b730ba0c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3000:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30007F23B13A6D07B013B7E6BEEE0@BYAPR15MB3000.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03218BFD9F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(55016002)(6916009)(5660300002)(478600001)(66946007)(966005)(8936002)(81156014)(81166006)(8676002)(4326008)(33656002)(54906003)(1076003)(52116002)(7696005)(6506007)(2906002)(9686003)(6666004)(86362001)(16526019)(186003)(66556008)(66476007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3000;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2uHwmbxeGhVQoXY2Dd92c3psPOCLVk8wKjrqRLRUqMp8nUHE7XEF0c8DDu2F1e6T/aTMI7CAeg2vawq7RszXaVzWsV0+8AV6Ymyt5NAtRbCoAdJXTMjczoOQCEvjD5849PQq1IIjQHGUFM8nFXpa5C2bg4Tj5xiZ5PmlBt4MpE9IoUTNrIbXeDJO9shL/dIiRrQoF7A3kcVC71s2dqNliF+Q3iKHqj7fEnQfWXTgjy0thDzpP4DDohH9HhXCtVlxVPf07I9HuyH0yjO+5UX56Uo83f3HPy3yCNdfEHN15ECQqNhJC9phCRXMhzLJ80pb6QPNM/Ua+maRJDAbcMbStT6K2cU4AWyjEjw9Oc6N7isu+ZUor3GHNemX+MfBqUwPmsx1a0mpP7cNDAnCcxJVX7WCzDzs6V0AiXLDb9e+4M4N2gHw7p22UxIyjuGUDqAgeFq+qez23iCT5YR1+7gs+Pc2UPGdHZI42QJk9cVSdW8gxgrC6CQ/BmzcPQwAkMWu9CI7aHifUJUEI3TsolPRKA==
X-MS-Exchange-AntiSpam-MessageData: cxhtV24lhawrHNmDgphQz+PxBNOrgWEPnrzj82owS8uWSolY1Ud38EOT8Byj0Cze9a+zbWY5gO//b1AuMmt0el46I/kO2HtT2cIG+N8ccZNy5eaFrOnGNC2OwfNVHVgf0IxzzjqEaibtJ0EaGc+TU6k2AttC/hI96lZDq0jImRTGcj6vwBHCO2E7I//3DwmM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e0bf64-aae6-4fed-d6a9-08d7b730ba0c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2020 00:47:00.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pawurmJPEje+y/ERYMzrKkkRWD5rtc+KaNIWe2/ZSX+nMozC9IXcB5sjdC0OASgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3000
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_09:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=902 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 06:56:27PM -0500, Dennis Zhou wrote:
> Hi Ira,
> 
> On Fri, Feb 21, 2020 at 03:16:07PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The comment for percpu_ref_init() implies that using
> > PERCPU_REF_ALLOW_REINIT will cause the refcount to start at 0.  But
> > this is not true.  PERCPU_REF_ALLOW_REINIT starts the count at 1 as
> > if the flags were zero.  Add this fact to the kernel doc comment.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> > RESEND:
> > 	Add more people on the CC list to see if I'm wrong here.
> > 	https://lore.kernel.org/lkml/20200206042810.GA29917@iweiny-DESK2.sc.intel.com/
> > ---
> > 
> >  lib/percpu-refcount.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> > index 4f6c6ebbbbde..48d7fcff70b6 100644
> > --- a/lib/percpu-refcount.c
> > +++ b/lib/percpu-refcount.c
> > @@ -50,9 +50,9 @@ static unsigned long __percpu *percpu_count_ptr(struct percpu_ref *ref)
> >   * @flags: PERCPU_REF_INIT_* flags
> >   * @gfp: allocation mask to use
> >   *
> > - * Initializes @ref.  If @flags is zero, @ref starts in percpu mode with a
> > - * refcount of 1; analagous to atomic_long_set(ref, 1).  See the
> > - * definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> > + * Initializes @ref.  If @flags is zero or PERCPU_REF_ALLOW_REINIT, @ref starts
> > + * in percpu mode with a refcount of 1; analagous to atomic_long_set(ref, 1).
> > + * See the definitions of PERCPU_REF_INIT_* flags for flag behaviors.
> 
> Yeah. Prior we had both PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD
> with the latter implying the former. So 0 meant percpu and the others
> meant atomic. With PERCPU_REF_ALLOW_REINIT, it's probably easier to
> understand by saying if neither PERCPU_REF_INIT_ATOMIC or
> PERCPU_REF_INIT_DEAD is set, it starts out in percpu mode which is
> mentioned in the comments where the flags are defined.  It's not great
> having implied flags, but it's worked so far.
> 
> Also, it's not quite analagous to atomic_long_set(ref, 1) as there is a
> bias to prevent prematurely hitting 0.
> 
> I can take this and massage the wording a bit.

Hello Ira! Hello Dennis!

Yeah, I'd simple say that it starts in the percpu mode, except the case when
PERCPU_REF_INIT_ATOMIC is set, then (atomic mode, 1) and
PERCPU_REF_INIT_DEAD is set, then (atomic mode, 0).

PERCPU_REF_ALLOW_REINIT actually doesn't affect the initial state.

Thanks!
