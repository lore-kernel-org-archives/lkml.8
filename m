Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03400C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD13B21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pOK37+Yz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cR0d3lil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgHGEhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:37:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbgHGEhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:37:34 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0774akG4008805;
        Thu, 6 Aug 2020 21:37:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=njtCxNYuD8spGctomRbwr2mX7qPL1e98+iAMerpILn8=;
 b=pOK37+YzftGnLf0ZUTAqYj25YywhqLn7Dsgk21VF8xGrFYpdaiRF2Eiv6rsrQyCH1IVe
 wbepXRJC1goL3uYF30SlPuRCCu3hrFCJ3hhkbCt9mFZj1lH+0rSiKpAmYS118xY/fr6V
 zvc9MnH2wW1vXLS9zQTZoGGVLT7uVXAMq7Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32qy2x0q64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Aug 2020 21:37:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 6 Aug 2020 21:37:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pvj5MFoTx0RuQpeRMAuK8nxFUPNi9NDE0sCNal8kXBdZCKjVCz0zzdL9O9VHP/QXyfWy1Fj3lyla77enoBFOU+w19SiXre6EmvlBreFpicNLUGfMgkDU5zu92xJyxqpP7v+kNohvNRo7jiArGloEuaZyIJmWvty+/FfBIv91Km1fByG1Xx6omEAMvasBwP/o2Aeq4zum7JJL79OIvzlgzN4io+IMMWPRp/dU6ghuewWEWIYh/QVm7PP16CndXzom7naaasHJQ+oluVOTLIRO/llVl+FDjm8/rr61+r97sTBI+LAlPfp3IxSpxk0ljKN0GnzXouWItenCXB9NGfs+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaU7w97U4GN40I7ZjHVqHYaMiz8PCdgfLw83vOxU6o0=;
 b=JNBNHdE+2NxHKEakWrmgz+DpDuWMzQbAfceHhW01Q5U+wiR5zCbzMXiWPPLWwpfjgmku1HG/aYx694u2J3RpPEhqmrk8WCfFKc2LINODGM7smvt8+hHixhHbECB3O87J6unGgVDrmCI+stpCsO/I4/q9ECfmQ/zXLMhyBHstecdfaAui9yQbD4uE+q42b1Jynsxa1GiNVrJD2BUeoA425ZY5WIY4joU3eIp7ucLHZH8rV1p28V5rpnvqUjLDCgsk3WMYuavBVP+Spz1TiYQgeYAQGmQYYRPY4AP7vD9DBrX7Hy3J9HzzM/7DU7XhHkkohLFuGVXtVdkg+bqozpG9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaU7w97U4GN40I7ZjHVqHYaMiz8PCdgfLw83vOxU6o0=;
 b=cR0d3lilAj1cVcM/cTVceT1jxHAR6TxmzV78iASEjA0WuqOF9151KOeyGrCheQVRzH1oKH7pxL1KtFeAkLX+EZpu3zySQ6PB0f+0li2jhkVV7arSuPgQG2BlgOlMoItub/jUm6rtEQFg0raM6qfgDSASwh1oDMKQdzsg+VdU0lU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3397.namprd15.prod.outlook.com (2603:10b6:a03:10b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 04:37:20 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3239.022; Fri, 7 Aug 2020
 04:37:20 +0000
Date:   Thu, 6 Aug 2020 21:37:17 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
X-ClientProxiedBy: BY5PR17CA0064.namprd17.prod.outlook.com
 (2603:10b6:a03:167::41) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:ab30) by BY5PR17CA0064.namprd17.prod.outlook.com (2603:10b6:a03:167::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Fri, 7 Aug 2020 04:37:20 +0000
X-Originating-IP: [2620:10d:c090:400::5:ab30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d31f1a-2a6d-425e-2dcc-08d83a8b9279
X-MS-TrafficTypeDiagnostic: BYAPR15MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB33976F9C5A038445691A685DBE490@BYAPR15MB3397.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFS7XM/ukvnVD+m+GT84xFpseVdUWLMR3N7q6Fo3WZmO2Lqi2fasVS4rcQZAf8/QkMl7FyGH2M3xwNzw02m7fH9qF5ezQt06+cYTHHNihCiLO51ZdB7kNofUqjVZ8IB6xjluEcZBb1W3Wx4iQ7B1aZewHqkeNbAQxCkwrfuIRzcVPage848ooA8q/H9YUKgqKWu8R+HcwYP4zsPf8cu+mEAqlZCri1Il9RCYRMk81CoK2DqHywrtWe8WTJRhuIILDVbXznN2MyhtFJ8Okx0cUHSqKMc87GCpwB85tDxMBHqRYm8a9ECL//nwner2c+Usf4ZjqV9Z5584zET8rvhHlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(7416002)(5660300002)(86362001)(66556008)(66476007)(33656002)(16526019)(6506007)(66946007)(186003)(83380400001)(7696005)(52116002)(54906003)(8676002)(478600001)(4326008)(55016002)(6916009)(9686003)(8936002)(6666004)(316002)(2906002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0fcYujMWtwY+pnA9CKz3Fi8LaOGfWT2PB4J7laxVkp5tpnOgISallkOhCFJKhEDY8AKb7IYqXs9VcIQvUA3W6am3hTzH2j5PukzOkKA2Lu/TQCj8Zu0gVLToh1kKzGk2CSYmbjAAaL1ylFaiFjcI5qZRFzzaJVimQL7I0+Ai0p7TG+A4QWhNqRaqEwfv+KHoxDaQ7owP5YuPBVOQKLCGpmWiT/cqX7kMiUQyFz3L13gCGBPKJs6dhGR9NPptdxXJTCWcHU8dhLrTCz7bZf3BWNgqi7+6zzQBvTgUrdAt8vBXLPi7camRMWHnhvOTfXsTKBjKbw6rjUHub9CSx6MUk1o85skIwR686puXGqZW1dopTbuciQMutHKBoGg4zry2ol2HgbvED/Ahop8IOZqVHS4B+gFGRZmSdVQGxsHUCv/+ywPr8tmlkL3om5Ml/1fEl8nbvRYHyUvq8mfgg+QCcMJcBKgc2iBJ80ph11qMWXGv3RKjIYF3R0souy6QUfixwkdefh3xt2bnrNB97OjQixYeQE2uexti0L8kAGSbv5skBk19URYlseGA4ayAAtzkj3gNAwhhiavn9o73uIPomlK586LfTBDt3wU2jKUfH9YpBEY1PF+N0On3bS5Sp1gbK435xAurHxiFVFrvDPFHSu1x22Al+BXB0osVQBYRiv0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d31f1a-2a6d-425e-2dcc-08d83a8b9279
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 04:37:20.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxHiWw4gfnMoaQRwZt4agYyV6A9sSq44LICslS7RHrMAVWiWif3gcy0mLZ27qiTc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3397
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_01:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1011 spamscore=0 suspectscore=1 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070033
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:16:03PM -0700, Andrew Morton wrote:
> On Wed, 29 Jul 2020 19:10:39 +0200 Michal Koutný <mkoutny@suse.com> wrote:
> 
> > Hello.
> > 
> > On Tue, Jun 23, 2020 at 11:45:14AM -0700, Roman Gushchin <guro@fb.com> wrote:
> > > Because the size of memory cgroup internal structures can dramatically
> > > exceed the size of object or page which is pinning it in the memory, it's
> > > not a good idea to simple ignore it.  It actually breaks the isolation
> > > between cgroups.
> > No doubt about accounting the memory if it's significant amount.
> > 
> > > Let's account the consumed percpu memory to the parent cgroup.
> > Why did you choose charging to the parent of the created cgroup?
> > 
> > Should the charge go the cgroup _that is creating_ the new memcg?
> > 
> > One reason is that there are the throttling mechanisms for memory limits
> > and those are better exercised when the actor and its memory artefact
> > are the same cgroup, aren't they?

Hi!

In general, yes. But in this case I think it wouldn't be a good idea:
most often cgroups are created by a centralized daemon (systemd),
which is usually located in the root cgroup. Even if it's located not in
the root cgroup, limiting it's memory will likely affect the whole system,
even if only one specific limit was reached.
If there is a containerized workload, which creates sub-cgroups,
charging it's parent cgroup is perfectly effective.

And the opposite, if we'll charge the cgroup of a process, who created
a cgroup, we'll not cover the most common case: systemd creating
cgroups for all services in the system.

> > 
> > The second reason is based on the example Dlegation Containment
> > (Documentation/admin-guide/cgroup-v2.rst)
> > 
> > > For an example, let's assume cgroups C0 and C1 have been delegated to
> > > user U0 who created C00, C01 under C0 and C10 under C1 as follows and
> > > all processes under C0 and C1 belong to U0::
> > > 
> > >   ~~~~~~~~~~~~~ - C0 - C00
> > >   ~ cgroup    ~      \ C01
> > >   ~ hierarchy ~
> > >   ~~~~~~~~~~~~~ - C1 - C10
> > 
> > Thanks to permissions a task running in C0 creating a cgroup in C1 would
> > deplete C1's supply victimizing tasks inside C1.

Right, but it's quite unusual for tasks from one cgroup to create sub-cgroups
in completely different cgroup. In this particular case there are tons of other
ways how a task from C00 can hurt C1.

> 
> These week-old issues appear to be significant.  Roman?  Or someone
> else?

Oh, I'm sorry, somehow I've missed this letter.
Thank you for pointing at it!

Thanks!
