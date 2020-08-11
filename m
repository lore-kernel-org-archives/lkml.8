Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE32C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E24E2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ARZfN4ai";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kzeVxzWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgHKQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:55:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32022 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728962AbgHKQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:55:58 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BGtamm010971;
        Tue, 11 Aug 2020 09:55:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=q4pZQ9v+nhoSQHLTSxrI+yDzL78daPQt89BJps6jCVQ=;
 b=ARZfN4airs72kWU16oVmEC+HIQwpCZyD1sBiKr7jAjnSxuEgco56x+Bn47QeI80M3n3X
 0xa6Kjb4GeOQy8awO6jRh8mElDXJaA0kA5PQU9A712/QYu4J9Axai7QcDaiLAi6USG17
 AU1xWEkTzWOGgViNMwGljR+H261ocGec+Vw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32tc43u51n-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Aug 2020 09:55:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 11 Aug 2020 09:55:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIyOrURzprQKU7vO9N64D4CWjkMCnPicuUdC8rOA02vjb9gPMImuHuGLGwLaE7Si/CTFSRITMLih+5U6s8kQZdp18q8XKbhHXXvMHlHjFL4gCo3AwhXy7qLLFscBIMQCjr9NMmBd2R5Dn9+8J0qSeOdbmEpt5vPWrPNtefWmmaroGiBk9IlaSlc7r1rYs0hhR6AWIHAtwofOZNhCWHS7CEfn4Z7GMWBy1qYxwJfIpEg5WR7QtadlfuCiLK9X2YO2XEwLACwTz3UYbBC7kapbhnAeZGMEIkao0naBdWlYWlCZlgSS/g1y81cb6ck2XQUOZl/sH8xGsTdTmaRO0cJcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4pZQ9v+nhoSQHLTSxrI+yDzL78daPQt89BJps6jCVQ=;
 b=WnLcKqm/UrwZkWvm9AvkPAWOQ+W0tBJTJp9j+yD0rqRwxxs1IokrSI5b5GobCLB5RyFycpkWeCBuTdZ2XhoqCQBf99Dbr1rPua6KS4/B/fXCx4iEe4ZhzALZKh8HNBz24fSa5nP7/scNc+KKKLrdmdHyUyZTzu7CSd9rFXTyUti7E0/YGDtwXvKa8hpFFVkWVx6DFIQcc8KD/gbNa1xVQkHyJ+JIAPCYhb0o5zJ/DVOAOfqrBQsle2UJT9so6+8fiKPLAPPg2Je8rT23Df14smGepJBujVYMR8oGbfXeAdAZdhCCF5da4UyXAuXTnsbQWa1bMuTo8l+iEVymxiU4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4pZQ9v+nhoSQHLTSxrI+yDzL78daPQt89BJps6jCVQ=;
 b=kzeVxzWvm8O7HRCFpTvXpoD0IYwhgeh9gNmu1O0twxT9gn2scOD4RzbR+rTtg/ecyjcTy2kdNQUNKNoh3CEUf3mGLuImZg1WLYucu1ngT/pJ12lYp28+1cSy/y/XA6XgkBSmRIAJG9crsKFZKe2XP+YMD8RlhLVGUwYiu65Xg7U=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2439.namprd15.prod.outlook.com (2603:10b6:a02:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 16:55:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 16:55:31 +0000
Date:   Tue, 11 Aug 2020 09:55:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200811165527.GA1507044@carbon.DHCP.thefacebook.com>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
 <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
 <20200811144754.GA45201@blackbook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811144754.GA45201@blackbook>
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fa33) by BYAPR03CA0008.namprd03.prod.outlook.com (2603:10b6:a02:a8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Tue, 11 Aug 2020 16:55:30 +0000
X-Originating-IP: [2620:10d:c090:400::5:fa33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a22483-3698-43dd-b884-08d83e175b65
X-MS-TrafficTypeDiagnostic: BYAPR15MB2439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2439E62FCFA9E9B6CF7711E9BE450@BYAPR15MB2439.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGrvAnXt9mFhirIEQW3StcNrlawaj3U9k4/tX6UbfefPWrTjZSfTxrcaRVt3vUKsI4IATwL+BBvps53rCCsX9prWeA33rVcSqoP01vrrEUT9Yikf6qt0yaDFX8fuiKtNYvbyVBazB+Zv0VbGmF2e8zvEPU3H6ABnHo31JYhWTO20YIOt7fezlkNS1a8vFezMAApMn+uF47j6fY+IXWeGpec7U1BPINuYpkYoX10duD4IH9O7IPY+4wPT0eFzp9o5nRMLN7KXQdygougyfv9RxHrFxOSlul26q1myEBSRpZCXRDYvMiycMDT71hKFpZodR79VYvURsr90gZqCdb7wzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(376002)(346002)(39860400002)(86362001)(8676002)(6916009)(52116002)(4326008)(5660300002)(83380400001)(186003)(66946007)(9686003)(316002)(7416002)(8936002)(33656002)(55016002)(478600001)(6506007)(66556008)(7696005)(54906003)(1076003)(6666004)(16526019)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lsTrTna/d7L/DLRlQII3uc0wKBn2OA0VO47L2lr/Dcr1sV6ztMXXHG0koPlx+TeAZWGks753Sp5uinMj0BCSlcegI+hW9kM4qudHTcZ3h9ykL0JMwMq7L9IS6hInZbfECSf9rmdA57q/Y++9Hp3d8BfDPYBWtP5vcNVlzq3mj/o8sC96Zr9YdElNhK+Le4qTkp1B3WGRqVxK7kEmRzwQCOB75W79y4G+6zecNuu0eKpGyOVSMIRdPqlugjI2AB8vuuxDZ5TiHg5NEiXIsBc4xWXRySJkym7db7en296W2+1acoChHO2R7UxJmOQUYaGd68IPopp0hMBS8zjuht2rFxfc5eKbd+qYsXQUiLZoyqmK5PijuL65jq48FVMEAh76dpxYVF0XlhUlzhnqhi4vdKmODuZYsLHqkn6lxHuBsVX/hyIyDoVMmRVjHY1N69FOz/aEeprIwCCEMlrjxgq44jTAUbLMACj5EZPu64AVA22/f3Hm+HfPlzT3ZR5brV/HVCmEfdeSltp3i8FusYdIzF+3pjQOnzP3wqBi/ffF36YDn+XrXBtUM5NETnuIBq8y0fqXVlRMzE/YzvJetsOlxsFh1kmfnx7Qw8ZTVNoSgp/n1QIaxUOXxz9mdchDdq3HLR0TTdYwWRHnXrxvr7vss7eB5SyRZplQib+6rwrG52g=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a22483-3698-43dd-b884-08d83e175b65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:55:31.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leyAimhitqNOtIzygSHgUrFoYgn7RtKjLf/+i2VH7ta+s9ucGlP2ItggKxuLVA3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=947 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110118
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 04:47:54PM +0200, Michal Koutny wrote:
> On Thu, Aug 06, 2020 at 09:37:17PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > In general, yes. But in this case I think it wouldn't be a good idea:
> > most often cgroups are created by a centralized daemon (systemd),
> > which is usually located in the root cgroup. Even if it's located not in
> > the root cgroup, limiting it's memory will likely affect the whole system,
> > even if only one specific limit was reached.
> The generic scheme would be (assuming the no internal process
> constraint, in the root too)
> 
> ` root or delegated root
>   ` manager-cgroup (systemd, docker, ...)
>   ` [aggregation group(s)]
>     ` job-group-1
>     ` ...
>     ` job-group-n
> 
> > If there is a containerized workload, which creates sub-cgroups,
> > charging it's parent cgroup is perfectly effective.
> No dispute about this in either approaches.
> 
> > And the opposite, if we'll charge the cgroup of a process, who created
> > a cgroup, we'll not cover the most common case: systemd creating
> > cgroups for all services in the system.
> What I mean is that systemd should be charged for the cgroup creation.
> Or more generally, any container/cgroup manager should be charged.
> Consider a leak when it wouldn't remove spent cgroups, IMO the effect
> (throttling, reclaim) should be exercised on such a culprit.

As I said, there are 2 problems with charging systemd (or a similar daemon):
1) It often belongs to the root cgroup.
2) OOMing or failing some random memory allocations is a bad way
   to "communicate" a memory shortage to the daemon.
   What we really want is to prevent creating a huge number of cgroups
   (including dying cgroups) in some specific sub-tree(s).
   OOMing the daemon or returning -ENOMEM to some random syscalls
   will not help us to reach the goal and likely will bring a bad
   experience to a user.

In a generic case I don't see how we can charge the cgroup which
creates cgroups without solving these problems first.

And if there is a very special case where we have to limit it,
we can just add an additional layer:

` root or delegated root
   ` manager-parent-cgroup-with-a-limit
     ` manager-cgroup (systemd, docker, ...)
   ` [aggregation group(s)]
     ` job-group-1
     ` ...
     ` job-group-n

> 
> I don't think the existing workload (job-group-i above) should
> unnecessarily suffer when only manager is acting up. Is that different
> from your idea?
> 
> > Right, but it's quite unusual for tasks from one cgroup to create sub-cgroups
> > in completely different cgroup. In this particular case there are tons of other
> > ways how a task from C00 can hurt C1.
> I agree with that.
> 
> 
> If I haven't overlooked anything, this should be first case when
> cgroup-related structures are accounted (please correct me).
> So this is setting a precendent, if others show useful to be accounted
> in the future too.

Right.

> I'm thinking about cpu_cgroup_css_alloc() that can
> also allocate a lot (with big CPU count). The current approach would lead
> situations where matching cpu and memory csses needn't to exist and that
> would need special handling.

I'd definitely charge the parent cgroup in all similar cases.

> 
> 
> > On Thu, Aug 06, 2020 at 09:16:03PM -0700, Andrew Morton wrote:
> > > These week-old issues appear to be significant.  Roman?  Or someone
> > > else?
> Despite my concerns, I don't think this is fundamental and can't be
> changed later so it doesn't prevent the inclusion in 5.9 RC1.

Thank you!
