Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F79C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9894D22B47
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WfnGiMui";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="A1o5syFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgHJTds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:33:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728388AbgHJTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:33:41 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07AJPFbd005136;
        Mon, 10 Aug 2020 12:33:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=oF1CgUYSYHrTcSZ8+JEJZAt6l5+k0eNTJg+53PkDhwE=;
 b=WfnGiMuiIdiJxDInzBFvnuDzhcuauZMYXU8CtAVhmfRMZJLsBffvQIKo8db9MTk23w/K
 hJIzNUIvhUnsSTOEUHQR/WSFPKTLNiEVTp9oJxIOYc48a8DZAMGXilv46QvDp2AkzI5C
 MP4M7My0EBtyQ/sJYjrjH1jOB7fE3uy8GrI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 32srrn12ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 10 Aug 2020 12:33:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 10 Aug 2020 12:33:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE8mxyEHdZ2dEzS3k2VWKKv/OEXNZ/U5pBbq06uFspOCzqbd7k1KIUbHOv789okX/sMxPPrsZWX8BTc/HxBVwrxbGybxsE7vr3HuM7v2HfmKwnE5H9Fty3gW8EDGCKnb/kcLDSTW9NBNc7YfmC4ns1Iniy3b90LxMWXnB0XIs0icNo0aeCNA/7A8GkplJQClRNKh2ZAepIiG05dOH5D16LNTIkbAvTmwix7oVErd3HojLaQXRx92EHfV8kcXLFFqwuNYlENECsv0iwo4yCxA4YxM3jQl47LYfOx6IvPHMJtWmKOF/flcvUJa5whT6LzsJcpC4ilIl+xIsfIT3bHzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VHMN3n3J5aPeGc8vVYqvq7c8TDXAM94IAFgeIaWWBs=;
 b=C81ExwAYQFeyA0UN2BBCUYr5i7bQjIcfu8peyxy541fRb+QSMr7JTzvqGU8E5dTDS/ieKgIqc6JAuZI7aaM5eznFw1gpFPFFIsqTTtDu547cJxP7JCQXY4Q+54sOMVpSm2vl+zN8IP0QkqOz9Zgis5IUjvc+Y6c4KJzUZ9QWpAjeCkdSQ7r8hEb+0Dpro0nGsYHjN6d9eDZlXENWgRPlHyWZgtWd2B3IdMbv9fX0OKfDiR9rss7ylGjlCPSKqWh25r/mMt7bC2pG65HRuAfYIGOj1qVhWJsRtLvFAfIEVLBh6wcLX/iFTsyKtIIq2wCd614PnkYXVmVXLmZ5hz+9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VHMN3n3J5aPeGc8vVYqvq7c8TDXAM94IAFgeIaWWBs=;
 b=A1o5syFEGOn8g8vcpMloPt9a/t5uksmZXt3opTkqZcioYd7AjofyK/BrJVqXqGN7cJrGUTptQw322IqdCrUoJlCHpx5xUhfYp7PmJnuN8CoKFnqe7+tJU1iolOBq7rWyLoyllHwMP4wDr6ExF0Nmw6cck5VuBV8RRXb6W86LkG4=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3030.namprd15.prod.outlook.com (2603:10b6:a03:fb::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 19:33:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 19:33:24 +0000
Date:   Mon, 10 Aug 2020 12:33:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200810193320.GA1428107@carbon.DHCP.thefacebook.com>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
 <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fa33) by BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Mon, 10 Aug 2020 19:33:23 +0000
X-Originating-IP: [2620:10d:c090:400::5:fa33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5501b2e-ab7e-4459-7218-08d83d643f23
X-MS-TrafficTypeDiagnostic: BYAPR15MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB30304A66D23BCF478E28067FBE440@BYAPR15MB3030.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DALnzpmn7AQzNPsUQi+86DjSuMMnEMSMQ2gclptZzS8GR0uG1FXTS1DTfI48u47cj4/OkHIZxa0cibWWU6GznfzBv3ds2iYflLftxYTCY1G7Wdq28qtLeGaF0URZX09grtNcpvZhOtDyNFlW+EAyuf9U3aKB067JBKsoIVBKoAV+zvFW2xXLpuAI6uNEtZvXOUWgaJ0FA75wcizmb+q9c7pz0qq99BcBKaF2vQTcQJcsEvjc1g8ziTlHPm3LJINkrgdnltDSE2EdUodlBY5LSAk1C8ZAmpb4Cq2wP2nVLELvOuCiyrgqp9P+RK5BXzlwWk21tUH0NjAUilBWRg+u3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(39860400002)(376002)(366004)(66556008)(66946007)(6506007)(9686003)(7416002)(86362001)(5660300002)(55016002)(2906002)(110136005)(1076003)(8936002)(316002)(66476007)(186003)(16526019)(54906003)(478600001)(33656002)(4326008)(8676002)(83380400001)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: P8pp67pLxdX6dz3XZMn9Qgjg6eAxR2DhuyW0XMl+5yaOF+vAIKpvHL+KAQhDfvyH+yAaRbLs3+A1Q/qJe038VvCGqtckNmJpHz0vCUg/ypPRTK/vjqyIGkNFOxNt0GVsqGIz6/ogBmUh/1hNGF5ryx89Eyn61gXNGH4G3i2ldNkxmUKgRHOW/k/Vms0sY2qP8hyzVBk3h3HFfQVCiMmr02RQ810PZQVzk7qg+Y+V+6oIOF7PvFuNrssiynWt0HzCEwDGdFZXC+L+4D9Sqqkl9AwRjLFkVyxayKeogZNO/WAUpboDsLAgg6g3dtLmh+jFw7+oaxlwJ3qGGwEXopnhaSOqhcVZFPKbjofdAzuY3oWg3FX+vAHuqUH36ueb/YFKgPk5LhbpwpuO0ZzibCBVqL4FRRqi4VaUSMp84olq9J7f2UFT0fLBcpdwNdnuzO4gqVfqTVc3+i6eYEQOuAzm17a1z+fOyzlj+/bg/91iZqbuCwJzV834u9tO5cYU85opIQHoK97ht3c1ezQqV4jGdq0okEzompPgHnIMqc4W+ov/qSum5chob4gcWE5HHWOBbR0YrGIK4rgo8ovMX3q37SiUsLk75y1xVt/SEQKHk4l3/uyaI9veS+NU0rerJOOvZHG8EznfsdPcqP4gwoowhZ4O0qpbaP8LcCME42QvLRQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5501b2e-ab7e-4459-7218-08d83d643f23
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 19:33:24.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aG0FozqhGmnA+5xhKuv6b3T2ragsCFZTE5rKN+M5145uqm7byOqoi2D6hsrQWQeH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3030
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_16:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100132
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:37:17PM -0700, Roman Gushchin wrote:
> On Thu, Aug 06, 2020 at 09:16:03PM -0700, Andrew Morton wrote:
> > On Wed, 29 Jul 2020 19:10:39 +0200 Michal Koutný <mkoutny@suse.com> wrote:
> > 
> > > Hello.
> > > 
> > > On Tue, Jun 23, 2020 at 11:45:14AM -0700, Roman Gushchin <guro@fb.com> wrote:
> > > > Because the size of memory cgroup internal structures can dramatically
> > > > exceed the size of object or page which is pinning it in the memory, it's
> > > > not a good idea to simple ignore it.  It actually breaks the isolation
> > > > between cgroups.
> > > No doubt about accounting the memory if it's significant amount.
> > > 
> > > > Let's account the consumed percpu memory to the parent cgroup.
> > > Why did you choose charging to the parent of the created cgroup?
> > > 
> > > Should the charge go the cgroup _that is creating_ the new memcg?
> > > 
> > > One reason is that there are the throttling mechanisms for memory limits
> > > and those are better exercised when the actor and its memory artefact
> > > are the same cgroup, aren't they?
> 
> Hi!
> 
> In general, yes. But in this case I think it wouldn't be a good idea:
> most often cgroups are created by a centralized daemon (systemd),
> which is usually located in the root cgroup. Even if it's located not in
> the root cgroup, limiting it's memory will likely affect the whole system,
> even if only one specific limit was reached.
> If there is a containerized workload, which creates sub-cgroups,
> charging it's parent cgroup is perfectly effective.
> 
> And the opposite, if we'll charge the cgroup of a process, who created
> a cgroup, we'll not cover the most common case: systemd creating
> cgroups for all services in the system.
> 
> > > 
> > > The second reason is based on the example Dlegation Containment
> > > (Documentation/admin-guide/cgroup-v2.rst)
> > > 
> > > > For an example, let's assume cgroups C0 and C1 have been delegated to
> > > > user U0 who created C00, C01 under C0 and C10 under C1 as follows and
> > > > all processes under C0 and C1 belong to U0::
> > > > 
> > > >   ~~~~~~~~~~~~~ - C0 - C00
> > > >   ~ cgroup    ~      \ C01
> > > >   ~ hierarchy ~
> > > >   ~~~~~~~~~~~~~ - C1 - C10
> > > 
> > > Thanks to permissions a task running in C0 creating a cgroup in C1 would
> > > deplete C1's supply victimizing tasks inside C1.
> 
> Right, but it's quite unusual for tasks from one cgroup to create sub-cgroups
> in completely different cgroup. In this particular case there are tons of other
> ways how a task from C00 can hurt C1.
> 
> > 
> > These week-old issues appear to be significant.  Roman?  Or someone
> > else?
> 
> Oh, I'm sorry, somehow I've missed this letter.
> Thank you for pointing at it!

Hello, Michal!

Do you have concerns left here or it's good to go?

It seems that this blocking the whole percpu accounting patchset from being merged,
and I still hope it can be squeezed into 5.9.

Thank you!

Roman
