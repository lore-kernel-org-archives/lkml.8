Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A6FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCC7206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NdP84H1N";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kCeEAaHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKTdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:33:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgHKTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:33:07 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07BJWnig007435;
        Tue, 11 Aug 2020 12:32:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=C7HhIqKzOfHouVjJYFUIT5ZfHT1gq9Ocurb0un4DLpY=;
 b=NdP84H1NbcYDY4lLnvPmi9TPImg9sVHAOQeywfxAOOxWtT9tB1J1PEEXIrzJ8klx4k6M
 mDTQb9GKzNxGVq7NuP+R2oN5thr/gsCfKUBMYg3Y4D7ICEwPPdbG8HwKEPWytP9rzkvo
 TaI6Ur5028y/R3Ez1CvUigGs5YoZ4FlKADs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32v0kjrbea-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Aug 2020 12:32:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 11 Aug 2020 12:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQDGhPCuT5lhwGTCWJVCaKCO3s3NdbxMYEIYlwAbleO7uOtHvj7FdGr4oVlqFv9uFUPuyFj2Iq7KlcN+AXDw8noag5bsD81t4vN6A6lq/gjHxxzkobtLxz673tBsZ8c8wCTAWmjDvfZ6tr7jIf6gku+k6Bok0XsQCMW9JXlE56MEsozB2zL5B3mpKZ8dN5/ybuHeWBdaKWFagRcqAXcbuZ4CNN2Xk4fXF9ShwE1aNiSlNwfToBPCa1bwpeqTnNNJMXkgbD5w201bp+MJMt8td1WYyewNNJ8LXNf5zWS1QOuAdUf316hJEzWNzsJ1qlm+aqzbeNOwGwLsXSjqOsmXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7HhIqKzOfHouVjJYFUIT5ZfHT1gq9Ocurb0un4DLpY=;
 b=nN1VeS5orex46Ie8HcjZh3ntQu5Nv05fOEBRyRURo2uDs8CNEKXL6sCxj12HlHeJPHw0p96Ju796knq7owdAFOu0Gqi6TV3JOvy6Xily6nzP8vAJuXmAU/BlkEyvNb2ZZgAdHWH8N/nhaA/3kePwiKzgauDmO9P4COdI1HaujFwSnYPWtL00uTz49Co2PbRAc0BN6Fv9tPZXa1Rg3nVMbLwL43Ajr5cRrFWhLoCqy1v/86pJosDoXA3bP8XeCVgLA1802e9F2pz2tvH/XMZW2FJJrIdBuZ/+Xe5X0jfpTShVfCX6Bc6RTUJGBO00oGdx0W3529WrT7a8P+iAYPYqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7HhIqKzOfHouVjJYFUIT5ZfHT1gq9Ocurb0un4DLpY=;
 b=kCeEAaHxBziSe1hQ0z2Tom/Qabhk9amX7wEgktSzJmJs9+lTjIyn6fLnysiv+mUMqpHRJ3ysF25Wc+w1B0/LivuYFKcS+kO3DA2XGv+xSs19Wqay9/5VAd+FPBbwUJ3sfsk9GdeIuv89PJPUQVpNDI8AMwihz9bqSxKJYM1yicE=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3351.namprd15.prod.outlook.com (2603:10b6:a03:10c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 19:32:31 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 19:32:31 +0000
Date:   Tue, 11 Aug 2020 12:32:28 -0700
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
Message-ID: <20200811193228.GC1507044@carbon.DHCP.thefacebook.com>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
 <20200729171039.GA22229@blackbody.suse.cz>
 <20200806211603.195727c03995c3a25ffc6d76@linux-foundation.org>
 <20200807043717.GA1231562@carbon.DHCP.thefacebook.com>
 <20200811144754.GA45201@blackbook>
 <20200811165527.GA1507044@carbon.DHCP.thefacebook.com>
 <20200811183225.GA62582@blackbook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811183225.GA62582@blackbook>
X-ClientProxiedBy: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:fa33) by BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Tue, 11 Aug 2020 19:32:31 +0000
X-Originating-IP: [2620:10d:c090:400::5:fa33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7a40f3e-1b78-47f2-eebf-08d83e2d4a5a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB335150CED6A75026B3082BC8BE450@BYAPR15MB3351.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otREHULXhGt0HH09ACjHhsKUPJ5OORYmlQG1xUu6JGBQPLV0Fo32NsXSMpRYkC66B/DFjoXFERE/V5baDhtz1KSRilJZ0OTJj+RAcQfh6OXvG14u/MbbBOgj+OrnBeQCsAabz+ccA6qIXJLxdkeWH5gwuXdQoqzmqXK44HbgEOeglHFcaVtV4v0E7LMAEcsTKA1yLZyZHUtBtWPbPTnm1H8RsanF4ZOqtwsFYBqCORLquyJvaPQU4g9nm5nphD7VqLn/aBYN8qIX533eFIe2v0aYULtbLbrrvymcEWeSHG8B0IEcncjpIE2v1/wT96P2J/Wq604akP6F+QJEGBSZzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(1076003)(55016002)(6666004)(4326008)(498600001)(33656002)(6506007)(9686003)(83380400001)(66946007)(2906002)(5660300002)(8676002)(7416002)(8936002)(16526019)(7696005)(66556008)(66476007)(54906003)(52116002)(86362001)(6916009)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2cWNGU2LUUdweDvmiuRAK6dxv2qAxTqvix/ZqGc/NRsxvi3sqrts/RZxHW9EkqBF3k2R/X+GmNaOcO3q2H+84ko1nvFwpYIvqcdq1j6nuTvSafb21MtOaptzYQxrmW/r3qBzw4374h8dCZRxa3J5YIVvp5GcqiviW9Ba2DONLhhkKy8agQfqRIXdXm9mgR4qpCkK34DO8nI3bPW06MxaBVSFIfhPn4w04wwv9oWUwp8QEQpz1JjlmKyrnz8OUgbs2dfktRnMr+Fc4MFmBL/hjPgMJWjKqCnyFVspVlIeCViObCVW/pz6a2L/DgLiXp7Ea0OrEu6NN3m09Y8HaTmtQRrobm8SAOOco33uPE70jG1xFDLF7YypTLyVy/LCZ/bQ9aIsScCYyWj0bj+rcaTWZ4gDFgLqWpsndJASRyY19fFYDaSXRnqY4tQZzNEsQx1k3iwVHlJHo4xlw+JWg4Q2SAHCR0qjriCzA1mWMuMo4AERWZdm9aQp8O+rdyXuC4vLJZTjGKiDWk+K3zEeBsjY2uHkk0rkLwIn9PAREv6noozMEC+fYIm8fcm4O/yHF5aQrQ/aWop5syqd980jdENHrqtselJ7CzLOIE0mRzZ81Nr7uP3cC0lNWRZ7EUiNUuZPjV++yxLQi4yXcWC72wz/qw/cYAPV7c/he5oFZGtGQ1c=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a40f3e-1b78-47f2-eebf-08d83e2d4a5a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 19:32:31.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2OkEO/TapiGYXtrviW+hTYPx94G9goruhMbBtcUlukoNduI2JSXq9pC4ycBjk9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3351
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_15:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=1 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008110138
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:32:25PM +0200, Michal Koutny wrote:
> On Tue, Aug 11, 2020 at 09:55:27AM -0700, Roman Gushchin <guro@fb.com> wrote:
> > As I said, there are 2 problems with charging systemd (or a similar daemon):
> > 1) It often belongs to the root cgroup.
> This doesn't hold for systemd (if we agree that systemd is the most
> common case).

Ok, it's better.

> 
> > 2) OOMing or failing some random memory allocations is a bad way
> >    to "communicate" a memory shortage to the daemon.
> >    What we really want is to prevent creating a huge number of cgroups
> There's cgroup.max.descendants for that...

cgroup.max.descendants limits the number of live cgroups, it can't limit
the number of dying cgroups.

> 
> >    (including dying cgroups) in some specific sub-tree(s).
> ...oh, so is this limiting the number of cgroups or limiting resources
> used?

My scenario is simple: there is a large machine, which has no memory
pressure for some time (e.g. is idle or running a workload with small
working set). Periodically running services creating a lot of cgroups,
usually in system.slice. After some time a significant part of the whole
memory is getting consumed by dying cgroups and their percpu data.
Getting rid of it and reclaiming all memory is not always possible
(percpu is getting fragmented relatively easy) and is time consuming.

If we'll set memory.high on system.slice, it will create an artificial
memory pressure once we're getting close to the limit. It will trigger
the reclaim of user pages and slab objects, so eventually we'll be able
to release dying cgroups as well.

You might say that it would work even without charging memcg internal
structures. The problem is that a small slab object can indirectly pin
a lot of (percpu) memory. If don't take the indirectly pinned memory
into account, likely we won't apply enough memory pressure.

If we'll limit init.slice (where systemd seems to reside), as you suggest,
we'll eventually create trashing in init.slice, followed by OOM.
I struggle to see how it makes the life of a user better?

> 
> >    OOMing the daemon or returning -ENOMEM to some random syscalls
> >    will not help us to reach the goal and likely will bring a bad
> >    experience to a user.
> If we reach the situation when memory for cgroup operations is tight,
> it'll disappoint the user either way.
> My premise is that a running workload is more valuable than the
> accompanying manager.

The problem is that OOM-killing the accompanying manager won't release
resources and help to get rid of accumulated cgroups. So in the very
best case it will prevent new cgroups from being created (as well
as some other random operations from being performed). Most likely
the only way to "fix" this for a user will be to reboot the machine.

> 
> > In a generic case I don't see how we can charge the cgroup which
> > creates cgroups without solving these problems first.
> In my understanding, "onbehalveness" is a concept useful for various
> kernel threads doing deferred work. Here it's promoted to user processes
> managing cgroups.
> 
> > And if there is a very special case where we have to limit it,
> > we can just add an additional layer:
> > 
> > ` root or delegated root
> >    ` manager-parent-cgroup-with-a-limit
> >      ` manager-cgroup (systemd, docker, ...)
> >    ` [aggregation group(s)]
> >      ` job-group-1
> >      ` ...
> >      ` job-group-n
> If the charge goes to the parent of created cgroup (job-cgroup-i here),
> then the layer adds nothing. Am I missing something?

Sorry, I was wrong here, please ignore this part.

> 
> > I'd definitely charge the parent cgroup in all similar cases.
> (This would mandate the controllers on the unified hierarchy, which is
> fine IMO.) Then the order of enabling controllers on a subtree (e.g.
> cpu,memory vs memory,cpu) by the manager would yield different charging.
> This seems wrong^W confusing to me.

I agree it's confusing.

Thanks!
