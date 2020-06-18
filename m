Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5605CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA1120786
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Tf1NaoJ6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YhSeXeDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgFRTwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:52:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53018 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbgFRTwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:52:12 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IJhLiA032475;
        Thu, 18 Jun 2020 12:52:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=A9tA8XpTR0SRfWejwmz4BHC6wLYIYRSA/kXpLhz/9gU=;
 b=Tf1NaoJ6rJ6uY3OrvJiLWly5PjNYFkp2Sm/tW2S0QBXuymuXRelTL3HOI4OLcbXww01y
 Voa7gnZR5YjFw1JmKeQ/pYaL9ED61NuEIgkgt/ZlrVc1ps38m3yumq2wt9WtC6L5yBQX
 Gbu81AmVQ9AJJ/kZkVN75m5gwsYCGVP5bN8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u6nmht-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 12:52:00 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 12:51:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsFSfaA1NmKEeD9jjlnVYVHEJHJYzf9Uu6q/nc9QRDZofOLy/znZ7J5mR/FR1SSw4kElxZUQo8pESyHGtUUZP0UC0ZAM1LfEdZRI3yzvnneQFDczdwak2J099gd24uKnRAUR82WG9paz1j+n8FUZGzDGdjx/a1PRtfSCnwJyUhmbAiv+EJ3HLJuPLfo4m7+3O1NuXpdJDpayCoO2kWZQC10ARXEI65hWBpl58wri1mEIC63SDIUAVFwfKnNPjDHua1CAg3z299Btvy7omXzmtmRbc9OY7iQDhmpyf3K3btpLBTP0WjxNErfy/zlVU12UB6V+t/hr7kA9xlhi7R13BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9tA8XpTR0SRfWejwmz4BHC6wLYIYRSA/kXpLhz/9gU=;
 b=lWArwF7S8dJWoC7GYUzY8suWSUHbs2rEhPXA6YymMM9/IWcg+rLpBFXSf8Qf/lsO7azM++EitXmm8WbfYMmCwtnx/7E8DcANv1OEuQDylzvdrSVXpXLnECoVPvk1jL6xFMxXCn1QeWerOODbamnvAZgllKuwALdYmKnBFqNk2b5V7H3Z3g1WtzR9n759iqy1rI9bNsc9AL/jtZZkKbXDrKVXWuTdgS3xfgn1fn0HoId27MrjR8Ys2EGfBxzsXWxHYKkJg9l1TAe5hm+170J706PcYoM13rk+3M9HlIILQFOQxIqbse3j3M0CEPpdtS0FJR9HnnDhdvrWnrofHNY4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9tA8XpTR0SRfWejwmz4BHC6wLYIYRSA/kXpLhz/9gU=;
 b=YhSeXeDUW9/u045a+TtEzgUVwckWg6F1T6/Kxd8nil6XFDM/FAYWb0CalmKEa2jI/ba2XV1T5fjolWlj8003mvjvO0v7THIcwUaRyCaEQ0j86FRi/8Ec/aIAZp9XfCq4cxUyvCBMVbTccOkemU0K73E0bhlIrCQZr2dTkMB7LUE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3080.namprd15.prod.outlook.com (2603:10b6:a03:ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 18 Jun
 2020 19:51:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 19:51:51 +0000
Date:   Thu, 18 Jun 2020 12:51:46 -0700
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
Subject: Re: [PATCH v6 05/19] mm: memcontrol: decouple reference counting
 from page accounting
Message-ID: <20200618195146.GB110603@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-6-guro@fb.com>
 <CALvZod4Jur7EFPPWzoBvQgF0m3hXyohBrBirEySWoPTV23rvUg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4Jur7EFPPWzoBvQgF0m3hXyohBrBirEySWoPTV23rvUg@mail.gmail.com>
X-ClientProxiedBy: SN4PR0501CA0136.namprd05.prod.outlook.com
 (2603:10b6:803:2c::14) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:632d) by SN4PR0501CA0136.namprd05.prod.outlook.com (2603:10b6:803:2c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.11 via Frontend Transport; Thu, 18 Jun 2020 19:51:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:632d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d344bd-9c62-4d71-e680-08d813c10b04
X-MS-TrafficTypeDiagnostic: BYAPR15MB3080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3080F7589547432207FF335ABE9B0@BYAPR15MB3080.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZyMbhOX5aGltvJ+A5IcghS45Y8zQO9mZAdLIlGFOHD6Ks5mcQWjDnTcSUlynKSSw8QSDQFOKkJ69lmiFjRRj2GWo/Na45X0aGbQV1FKeW8s9a9gF9ApnjQXpIUg36ur3pSjEMMPBesLgYdx/Gh2ZDFeY4i0ne+Z4nuSZhUlX+jQox7xd2opYvnMznuraKibPhqW1QNhBTveFa8scKx6NtS+J0K0ZeElwO7ZnzfFepn4IVgX02mUtSQ6PFCL9Kz4dzVYcjaZOu7pL7gAo1QZTNwFm6r5Oaxc5wemsuWobrT4z36k2hC0GGLeFFyG1TNCHv61EFaBEeZPHbTD5333gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(316002)(8936002)(4744005)(6666004)(1076003)(54906003)(5660300002)(4326008)(478600001)(2906002)(186003)(16526019)(8676002)(83380400001)(6506007)(7696005)(52116002)(53546011)(66946007)(86362001)(9686003)(66476007)(66556008)(55016002)(33656002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: C6USD/yRZ2baoHQEkNJqHnIR8fE5tRzp6LgosmMOb2PhizZprA5fK42UNpT8WRzh0yahDzhipZReUQJbiPbqq8zXwG3+ODd44l+mCxANEVUIpolrsqElS4iBNyM/WCJDwX4Z7DuzsOiy8nMuReWiMphROij9wLibUcF53I/pMFQjXRbEOpucwUqbtL96wiIFYy7Wlt/AXzPKAoGEM0DqYiglPaElwVc60wyoVxdhOIQFHjxpasnn7j8SyQrzlSFMz+5+cPuJOknTZFvV84T8xKxeRLAORuojzLnMMyiH0LSpm9XktD+Rq4seyU44MpF4FgebJve2XBtWUcodhhdrqw96QuZW7tIKPTHJ0R+z332HZhx2RL0ADVmSTMLqwboudpJZ/+CB08Qa1tPmIYtHWSpw2WWejSZJdnOrsaJXydY7GnNm21NWWGR0+m+kKd5DFpWdo+aAvsn4unSfVfagywQBfKDzrPEte8R4TPRwv8NgB/+iQp9Q/ritixceWNzpdxRPW/HF1WqJIqHY5xIvCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d344bd-9c62-4d71-e680-08d813c10b04
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:51:51.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KS0nbD4qYTievkGP9GX69bdT9/+Mtw6TdZpVDaz/lzTJqbuyZ400RMOiLfvqUGBU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=910 mlxscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180150
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 07:55:35AM -0700, Shakeel Butt wrote:
> Not sure if my email went through, so, re-sending.

No, I've got it, jut was busy with the other stuff.

> 
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > From: Johannes Weiner <hannes@cmpxchg.org>
> >
> [...]
> > @@ -3003,13 +3004,16 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
> >   */
> >  void mem_cgroup_split_huge_fixup(struct page *head)
> >  {
> > +       struct mem_cgroup *memcg = head->mem_cgroup;
> >         int i;
> >
> >         if (mem_cgroup_disabled())
> >                 return;
> >
> 
> A memcg NULL check is needed here.

Thanks for the heads up!

I'll double check it and send a follow-up fix.
