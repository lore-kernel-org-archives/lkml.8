Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39A820732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jF3n4hgy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VMwkwlU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgFVS0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:26:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60320 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729860AbgFVS0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:26:01 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MIF8dX027612;
        Mon, 22 Jun 2020 11:25:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=96zbVdU2e+eLVudwhSrLzXqa0L2UKbHteXgeDMrbt8U=;
 b=jF3n4hgyh9OVY/eidekakpfmfUdqlarV3ERBHL13hMk5nZ0YiH/oDe6onTfunCNEDdlk
 RRSCpIBP3B2L2qQXD4vKjkjwVhsr9lZ5iMkJRTI0Z2tMGQ7NUuNE2sP+FFqPBLdsiMiP
 xTvoXqytaJvZmwhFa5QUqLypF3vN1Pd258s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31t25bpvv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 11:25:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 11:25:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjiFG8wHzeyFS3AJZIywp/sH11g8OslzpCf0oYU6FfWrm1kRIh68z5PSITCfelwR59KkXNfi+8R0UEBbgsofSqz0RUHOCziosA9o2eXfomVrA9TsuLlFmfW1DrqNpFdOTx2qt0Pv8W8wEtzu/5yrz7Uxs887IICzJeVYbPWPfF91ZPMirR0b0D6dMgvl59vLEa2pa0Ono26alvWihD5j8DEjOIyzJ2239YblNzHgCaIgbl6Fazj+YdXjhjKsIz3oqVw/C+wvB1TcIe7nF7wzZ7UXbaAi0yjfJbqF34GijoeQ/hnItbuZwmYDB03WNyNj22R3JIASdPXgwwkSnhKIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96zbVdU2e+eLVudwhSrLzXqa0L2UKbHteXgeDMrbt8U=;
 b=ahU86rRvpICNDMygtGtXlX6JslMZKgn6Km1jnkwsWpmnJ+LL1hFsrfymxIBLlD7a9+99IvzPRAor7+mo9zVK7M6N+AfvO0dpK8uspE/9XHwF1vHGnS5busDngUwIbSwBfOT/aBLZaskMt7gAZR05HqkCic96A6xX2gx7Ljk48P/00WKqDvhJ4bmLILXmriaNwcvPn3JwjcnhepwanfCb7xrwRLK6UBuuQoJhIqAUx9yw9XaSlXdUgvZLkdXI8Ih5g3rYbWTtH4i4RAVKBSyOySMTaCvyRXY+DESiT993wrsV/8oPLo4Za78hB2jZxxV4LzTV0Oyc7/+SbKQTTIvCOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96zbVdU2e+eLVudwhSrLzXqa0L2UKbHteXgeDMrbt8U=;
 b=VMwkwlU9JxU9VQZiywRZrzAd3B3of4hHLTI2p8chNR1KPl3dKAAlRahdkYQZvVdxnqS96nnclhQRKXCPFQ4h+/uHCPf72G44aOzfvfXmn3wlhWj+DNlrKF8REO3TkejwW/QmbUByU61JfI2NBwRy38zLYwbccV6YnQsNG09PJ/g=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3222.namprd15.prod.outlook.com (2603:10b6:a03:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 18:25:48 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 18:25:48 +0000
Date:   Mon, 22 Jun 2020 11:25:45 -0700
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
Subject: Re: [PATCH v6 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
Message-ID: <20200622182545.GC301338@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-11-guro@fb.com>
 <CALvZod4Bfx3j+=spRSct5_cBL4U+XFF228iZt3EdkGqf4kokrQ@mail.gmail.com>
 <20200622180153.GB301338@carbon.dhcp.thefacebook.com>
 <CALvZod6A3ibpurMsuj+8F3DXYh7sb3L8eNmHf_NUTpvQCiDDmw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6A3ibpurMsuj+8F3DXYh7sb3L8eNmHf_NUTpvQCiDDmw@mail.gmail.com>
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:88b0) by BYAPR08CA0022.namprd08.prod.outlook.com (2603:10b6:a03:100::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 18:25:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:88b0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce81c031-93dd-4525-79a5-08d816d9af85
X-MS-TrafficTypeDiagnostic: BYAPR15MB3222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3222DE734E7F1119A5EE8AE8BE970@BYAPR15MB3222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEa6yfDu8OGms9M16MvJBAXUrxl01dYt3BcEIEkiUmqcb+5rvQEeu9fnkgAettpsPio5qKvOAMK3AEtHD1iC9Bg0Pe7JHnIdtz69bXg054FeBVFhu5P4NEWTcaXy9XutR0h/tAJPuvLXwVihnbGVAa3g+iATC4VzOlYRxTwWAYE80u2ItMj50qzOCY/0hn8Y6lgWPE9ZXiIgUdpLBVejheTL232+YShoBcHEPsSiGrsRQbbcMXa2Zb+D+l05wwBK4etuZWBDg/V/GJTdtBMiEAa31NH8dSfuHDunMxne9o2AMAemjx6z5vBvLHh/ToLdLB1Lj8ds5uEYzho/LXXMog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(6506007)(52116002)(16526019)(7696005)(186003)(86362001)(6916009)(53546011)(2906002)(66556008)(66476007)(66946007)(8676002)(8936002)(83380400001)(55016002)(1076003)(478600001)(33656002)(316002)(54906003)(5660300002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /wVhuP/mMGEQ2n78kb+M4dF4RiBpCUqLACVaAXwUNUH+SThI4iJl+fVslLcsdd72DBsdUZDdX5V8lb0PBOyG11XZKckLs6X7yiiou3rvqGzpb6kUvEsxgHzaDeJLH2ITp07mdtodfTHrKSWNOVRbBKXyJE9E/GSuGpxy/aiIcPcht/sZ3FCKat2OMfcxbVE7J+dMzQLIx8ECJCnkPoMGTotUnrJgAVMSMweNxWjnPRRJ2qTHxtyWwvVP14UK05+ij6bVzTE65d8BjCO/Xka3Z2mBin38U+TOhtgsTqGe6qhAjkRJIQK/mUKuC7PnImWjFP0XYA7/DlCNzXpdhIOB30dEJtfhy6ziBtU6Z5cXH4FFi9SF+C0WLfdsbxSbNSy3+4yJ7HPMaOxKZKTnZ/iEW36t8U7x1i5zS3U/XsNdt4/ICWS5BJhX/lO0BBu2u9uj3dB45A+mt8Nc7KgO3ONi4ElgZy7H21lxdS7fqO5mZZHwYi9xVVD7ZDS4Rpr03AfVhA/VdfNMDXbk1HZeByARMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce81c031-93dd-4525-79a5-08d816d9af85
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 18:25:48.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR5w7q9MNU7chZnQ74DLt+o8hZ8NWfUKFYTyLPWalTQxJua3YZAmWEOVPSEUcS+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3222
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_11:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 impostorscore=0 cotscore=-2147483648 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=2
 mlxscore=0 malwarescore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220123
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:09:47AM -0700, Shakeel Butt wrote:
> On Mon, Jun 22, 2020 at 11:02 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Jun 22, 2020 at 10:12:46AM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > Deprecate memory.kmem.slabinfo.
> > > >
> > > > An empty file will be presented if corresponding config options are
> > > > enabled.
> > > >
> > > > The interface is implementation dependent, isn't present in cgroup v2,
> > > > and is generally useful only for core mm debugging purposes. In other
> > > > words, it doesn't provide any value for the absolute majority of users.
> > > >
> > > > A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> > > > It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> > > > and also allows to get any additional information without a need
> > > > to recompile the kernel.
> > > >
> > > > If a drgn-based solution is too slow for a task, a bpf-based tracing
> > > > tool can be used, which can easily keep track of all slab allocations
> > > > belonging to a memory cgroup.
> > > >
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > >
> > > Hi Roman,
> > >
> > > I am not against removing the memory.kmem.slabinfo interface but I
> > > would like to have an alternative solution more accessible than
> > > tools/cgroup/slabinfo.py.
> > >
> > > In our case, we don't have ssh access and if we need something for
> > > debugging, it is much more preferable to provide a file to read to
> > > SREs. After the review, that file will be added to a whitelist and
> > > then we can directly read that file through automated tools without
> > > approval for each request.
> > >
> > > I am just wondering if a file interface can be provided for whatever
> > > tools/cgroup/slabinfo.py is providing.
> > >
> > > Shakeel
> >
> > Hello, Shakeel!
> >
> > I understand your point, but Idk how much we wanna make this code a part
> > of the kernel and the cgroup interface.
> 
> No need for the cgroup interface. I was thinking of a new interface
> like /proc/slabinfo_full which tells active objects for each
> kmem_cache and memcg pair.

To me it's a perfect example where tools like drgn and bpf shine.
They are more flexible and do not blow the kernel up with
the debug-only code.

> 
> > The problem is that reading
> > from it will be really slow in comparison to all other cgroup interface
> > files. Idk if Google's version of SLAB has a list of all slab pages,
> > but if not (as in generic SLUB case), it requires scanning of the whole RAM.
> 
> That's a bummer. Does drgn-based script scan the whole RAM?

To be precise, not over all RAM, but over all struct pages.
Unfortunately, there is no better option with SLUB, as there is no
comprehensive list of slab pages available. So the only option is to scan
over all pages with PageSlab flag set.

Thanks!
