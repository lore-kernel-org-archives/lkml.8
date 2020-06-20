Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EEAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2543522B4B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="o4/9g3XZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VdthSFhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgFTA60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:58:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51880 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731105AbgFTA6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:58:25 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05K0t13m007152;
        Fri, 19 Jun 2020 17:57:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HQ1tiQm9xpHsBzfthHR3pkpNrHRX6SpS3IrXg+qLjWQ=;
 b=o4/9g3XZf1dD6/+gFM8lY96dVJVGW/8GSSsYa6gxGF5G9p0mJw6ILxXuyGOiXy3URAg9
 74ZZXbTEc+zDyzSI1HJpvfSHVgbsAAc7KaMubbjoLGoriQ46AnyCzlY/D8l4GHDR4X3y
 PNX6a2qqKKzxLaouOtw3DsPV/M3/k3baqcA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 31rcbeagnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Jun 2020 17:57:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 17:57:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aax1kzmhZ6QFNh2mazJJs+Bp8o+efKRPKsZdbvmcPmqk4/Ci1X/3G4pBCaf6DeE+pWyyM24pXBkBwPizmKoaSXNTxSEr76DRXZ/uFI4NciBZnqSf0DY3QEzV7ju0BXi6Xrm6jFJkUZG/WZVN2A3Ayi3nIO3JNRGPwyzS3dbnFEb2+RmIUQDgZvNtcgDFIDE/SEc3hk+QTEIde71U0CjUo4KY7YfppgC631NxQ/yNJz7t9AIsTuo6Hh1pk6CR9yxqXyue9lT4rKemQHaXRqsV0Em0JQL3xwYTg9ZMWOXNG5R7oZXp2yfnRGHzq6qICeTuoBV93Ju4dAL4Q0E+vs1Q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ1tiQm9xpHsBzfthHR3pkpNrHRX6SpS3IrXg+qLjWQ=;
 b=ZR5qOPExTVS90GQAD2YnmBbgycKFkIof9U07P9QDP+xrpLfouAOmSsYQU71Ifrljk3eAaIQboTD/mHtCungO5jyqd+BzwGoH20+vVVVFcQ6mKow9yKPQd1o1GLrMgheLAArVK4nu6QsODi8ApQvBDqHoevXAK0yaPBxI8qfgeNN86ThB5vY4upazOKBZtDZg+OPyOJLIjXJJRywGW820e+uavbMI3ptPqXx0YLOt5ucFHhEzZHRL7xLtoDDBuAWVXaRDDAecYCht4w9Q4tj6XS5n80vFcmecYD3BMiWsk/STtsZbcerTk9bUV90TCf8bm6c+TfxkhoYsRyuceQ9OFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQ1tiQm9xpHsBzfthHR3pkpNrHRX6SpS3IrXg+qLjWQ=;
 b=VdthSFhDarrYjSj9acRD3AJ7aeoQBYRck/cx/I+U6bzV5Vsboci9hdVc/YTgOIrCzVPX8amAuqnfFw/F4R/siHEOaEzrtgIsoJO70GDNxmN3Dfty7eCz9vqmJs3l5k9G0DYWkoeiYe/sxGUy4HD4rTFoen9ofel4XuZ1dIi3zcA=
Authentication-Results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3478.namprd15.prod.outlook.com (2603:10b6:a03:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sat, 20 Jun
 2020 00:57:22 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 00:57:22 +0000
Date:   Fri, 19 Jun 2020 17:57:18 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200620005718.GF237539@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
 <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
 <20200617033217.GE10812@carbon.lan>
 <e510e964-2703-d123-120c-816bbdd35743@suse.cz>
 <20200617143110.GJ3183@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617143110.GJ3183@techsingularity.net>
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:2b5d) by BYAPR11CA0054.namprd11.prod.outlook.com (2603:10b6:a03:80::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 00:57:21 +0000
X-Originating-IP: [2620:10d:c090:400::5:2b5d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a22976d3-2f98-4c2e-ce51-08d814b4e3a5
X-MS-TrafficTypeDiagnostic: BYAPR15MB3478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB347871C87A16DE60DB141C0FBE990@BYAPR15MB3478.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qzp2fyaL/hP7JR7+7VyOXkuAYcrlCKFvGAK4uvmC6ESL4WeHPzaGkMJiOtuYaephRlI4y3BHn8YonH72a6Xh0o0XWF3W5171c+zQ/CBz8TXIjTuWD09y1jqBvY9LsRNw/HmtQZ5yrSDMlclpxoLkvpxkCOjSj1Iu3MiAQf2FJBcu6Iwc8IUbt9VCrpXk3BFRJ/kXvLjRwuzmQXuSlqUeqUHLD2PlBgNo5PEQ2vqP+iQ7/R0FMyzyJwxrYHB1wjncnIb1U1ACblWLQOi409t1FyvEfWVoJXYS/hf7A99S8Qk0/T4VcyRll7fWUJRNFBAjpngpngz5raBxsvl42qSOlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(316002)(186003)(8936002)(16526019)(83380400001)(33656002)(54906003)(4326008)(5660300002)(7696005)(52116002)(6506007)(9686003)(55016002)(2906002)(66476007)(66556008)(66946007)(1076003)(6916009)(478600001)(6666004)(8676002)(86362001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3H94Ek/d9SJLfG8pLB1yw9E3iMwLAtvahJpKXPpuNolXBb38Rp6rgnj3iP6FaCPI1NcoVtoOdxLnRVplyNDTW0CGBdry8Z6uBbAbdDCDJUfgl5mUB5k/qH1YY+ISFPmJxBsnvHSecbACT/rV27aS6Jx57zHbJFasPRtHZU2AyQL7nC55DK1n0CiNa4go03N2BFpnrLZ762LznG+fTrD6M/xZh2NO6OF2WFFgiGKHIvHGpVka7WZ1MOkPLhf2vgeqi59AEZA9JvZR7VaMf0t1HzhnSf0M+RP+vB+l3BGfu59pK+kfaKkvBFB/ZGW0DZneXh8jsnIH5Rd9wJs6EvwHrYS+hgeCVZF0kewLiqOt9HEhquOGUqb65jxLhv+uFslu029LZ6jOa0+o7yWD27X7WY/MGWkzEBEdB3H2vMthXurHFLvddgRL+18j9CoJ+TMO0/W8mg28WVOJSNpJE93Zs9FQ8jAZj6rTe1AFiHYNT2G3Zwb2mE+RVHLVN4bi1EjHo+yR8Dpn5b7HarBdMsNoDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a22976d3-2f98-4c2e-ce51-08d814b4e3a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 00:57:22.1428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DJqGB+ht7BIhqiTCoUYeYAO//jWaP+4HVZ1EtX+IyLCMs8cATD0KuXBCc1IOS3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3478
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 malwarescore=0 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=1 mlxscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200002
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 03:31:10PM +0100, Mel Gorman wrote:
> On Wed, Jun 17, 2020 at 01:24:21PM +0200, Vlastimil Babka wrote:
> > > Not really.
> > > 
> > > Sharing a single set of caches adds some overhead to root- and non-accounted
> > > allocations, which is something I've tried hard to avoid in my original version.
> > > But I have to admit, it allows to simplify and remove a lot of code, and here
> > > it's hard to argue with Johanness, who pushed on this design.
> > > 
> > > With performance testing it's not that easy, because it's not obvious what
> > > we wanna test. Obviously, per-object accounting is more expensive, and
> > > measuring something like 1000000 allocations and deallocations in a line from
> > > a single kmem_cache will show a regression. But in the real world the relative
> > > cost of allocations is usually low, and we can get some benefits from a smaller
> > > working set and from having shared kmem_cache objects cache hot.
> > > Not speaking about some extra memory and the fragmentation reduction.
> > > 
> > > We've done an extensive testing of the original version in Facebook production,
> > > and we haven't noticed any regressions so far. But I have to admit, we were
> > > using an original version with two sets of kmem_caches.
> > > 
> > > If you have any specific tests in mind, I can definitely run them. Or if you
> > > can help with the performance evaluation, I'll appreciate it a lot.
> > 
> > Jesper provided some pointers here [1], it would be really great if you could
> > run at least those microbenchmarks. With mmtests it's the major question of
> > which subset/profiles to run, maybe the referenced commits provide some hints,
> > or maybe Mel could suggest what he used to evaluate SLAB vs SLUB not so long ago.
> > 
> 
> Last time the list of mmtests configurations I used for a basic
> comparison were
> 
> db-pgbench-timed-ro-small-ext4
> db-pgbench-timed-ro-small-xfs
> io-dbench4-async-ext4
> io-dbench4-async-xfs
> io-bonnie-dir-async-ext4
> io-bonnie-dir-async-xfs
> io-bonnie-file-async-ext4
> io-bonnie-file-async-xfs
> io-fsmark-xfsrepair-xfs
> io-metadata-xfs
> network-netperf-unbound
> network-netperf-cross-node
> network-netperf-cross-socket
> network-sockperf-unbound
> network-netperf-unix-unbound
> network-netpipe
> network-tbench
> pagereclaim-shrinker-ext4
> scheduler-unbound
> scheduler-forkintensive
> workload-kerndevel-xfs
> workload-thpscale-madvhugepage-xfs
> workload-thpscale-xfs
> 
> Some were more valid than others in terms of doing an evaluation. I
> followed up later with a more comprehensive comparison but that was
> overkill.
> 
> Each time I did a slab/slub comparison in the past, I had to reverify
> the rate that kmem_cache_* functions were actually being called as the
> pattern can change over time even for the same workload.  A comparison
> gets more complicated when comparing cgroups as ideally there would be
> workloads running in multiple group but that gets complex and I think
> it's reasonable to just test the "basic" case without cgroups.

Thank you Mel for the suggestion!

I'll try to come up with some numbers soon. I guess networking tests
will be most interesting in this case.

Thanks!

Roman
