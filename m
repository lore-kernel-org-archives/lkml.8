Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50123C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221832084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VjvgNFgP";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YC/eCGDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390350AbgE0QZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:25:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389852AbgE0QZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:25:46 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04RGK8dQ021329;
        Wed, 27 May 2020 09:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pD/B/qzn8DqQpMu46fnNpe4BmLwxijY+UpZFpuH6cW4=;
 b=VjvgNFgPiCvy3lYjX+P+gEDE2OQkRJJ4jJJBGccUF1BAN1AA/gtLBDCcpSQdXkQ3uT8k
 dX1DM/4KdWzTa3hAyygO+1GA9ENOhjC87qnoAGtfhJZDUeuFZcbqcg/CYIVMz06cePcA
 x6ndO1Y15lA/NbUzxwWSSfWsUzgCKoQAsi0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 316yb1d4n2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 May 2020 09:25:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 09:25:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHLhbwHiXkmcdfaIVmKhZqtY+UAdTlPmqijxhMIWTn2896mAC/oOQYCimDJ7IcKNIamoDUVyXo9UHof8FrSP9RLF31aSsdXeyCzi8jRp39x8mC4NpSOfxcb5+5+etcCnmEjB7hobpQnEwstCjeZ0Y1EtaBfJJ/+6RYACgf00MBtxIwTLChYuD66tr8Wx2+kYgEMB3WiLwhJThWbaSgb39P/KOzxASH82tZY/nQDHFLlnsp8o6Xin70RvlOg8vadQR5nSAQUSZgN9e8yfU3X4UbRKDdpoUB+FMGHdHVt7C2y/1LyHo/UVm+p2zV+LP8GLWnGML4w2KMUyvja1xGpPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD/B/qzn8DqQpMu46fnNpe4BmLwxijY+UpZFpuH6cW4=;
 b=Dejslqm4OCkExbWvbYLvCZ0XUqLyeGGzx8iTUVFaITXen2JMtgXVRQfHhhRM0yjNTgpUEK1nAHQphQGifWxak0V6dlD9605EYrIirjELmOo4oZN1eShbyAxuHzXvVS9r3e8+4EAClc2Tfb5QxBaHgEc+E7zY3eBAQmN+V18MVJ0QNZ+Yw4Gw7EUEodib++Si1L84MMcIiGv3mDqu3hNVY9V/T8/KA6qiIkHo/JaFObIGvp8nIVnbMqir0qisV5C44/PgCahUQzjJsY1deuKw9rlafNWzSyewgXGbOlAySytYES9Gi3RrC669meoWVuLZ0GLyNfltrAMcPZa4TH4NGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD/B/qzn8DqQpMu46fnNpe4BmLwxijY+UpZFpuH6cW4=;
 b=YC/eCGDgwRTyxVntPxIhGnewOXParHNel+vFaLWS9tZsVflmWDsFsXi71GfuBx/yfJ/nttZ1ZgP8inLCgHoWiBpc7wzByZLQHEiPSg40u1EJl+HUqhoB9T1NPIyQ72qhpWKxJXvnYEUqwX5quITtHbxM2xPaPVyc4Vpzm+0blMY=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2646.namprd15.prod.outlook.com (2603:10b6:a03:155::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 16:25:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 16:25:12 +0000
Date:   Wed, 27 May 2020 09:25:09 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/19] mm: memcg: convert vmstat slab counters to bytes
Message-ID: <20200527162509.GA396660@carbon.dhcp.thefacebook.com>
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-4-guro@fb.com>
 <a0a6c013-3a08-86f5-46a4-808a8c63a50a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a6c013-3a08-86f5-46a4-808a8c63a50a@suse.cz>
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8973) by BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 16:25:11 +0000
X-Originating-IP: [2620:10d:c090:400::5:8973]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18862229-480c-4d4b-8964-08d8025a87b1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2646:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26465686846B95FC8E2A4AB3BEB10@BYAPR15MB2646.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYVK7kiVvGOTAGawFqtcb+s63woS2Drwtf45PCTN4RBxOo0mhf8V5fgtp5EvO0ZabtcmdLCfoi9F2/ijrfbYBUyZ1qeTNVt4QR1AHtEfuo1GPIawJRW7lZ5FIa77AzBnbz4OzMMiGoPqeGrzPxDhazGA9pbuSRtLVJbYFu523UdHNQ/z3UrcUz7NxDhNbXLxOXBQk8fijR3iS9i3QWh+FwfoWFhT0QPzAeAvldTsQjyVjMaPTVEOHgz8IJon2xs08ekVSzqRqxKGQaB/CzV9dovIE01/n0NUT529I7ixW7QhCzoI2CMxDMc6NKtMKQ/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(346002)(396003)(136003)(39860400002)(9686003)(4326008)(316002)(1076003)(8676002)(5660300002)(6916009)(2906002)(54906003)(186003)(478600001)(16526019)(55016002)(52116002)(66476007)(53546011)(8936002)(7696005)(86362001)(33656002)(66556008)(83380400001)(6506007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Knpx0T4cfhSjUTliLrXPE4+Vtki8Cywu9irnNwmLauuK6FNNpD4KrLLm+kIZzBGP0AbEtUbjJQ1Bz3W+pQjKjD6m2saYxN1zwwywo3fN13MsSzDxJL5dN3bpbZITUbh/qIJhjNgO/H2Pp7m+UCpb9O0piumJa1JRtZ3+I6zNVAf3qMI92Kf/Xva6OBgsf2cnZOC1y8+b5l6SW89KTGIQGjkPPyyhvJDUffJYPSAqKp6DNgKVC0g48qEz6FWvPIHcwtmV91XCoYrnxeoJSRTmBuCeQU+BGDQjHohVLmOOjemhdJrLd1yzwJlyWIZ79/MEmKSm5SLw7ec/+S7nE8W0sJYC2hKOpivvDa6rmajiwDXxQu3Q66rnkxwl67II3qUbWfvwRmiH5+EJZjVUM1oCgZG2AuOhpbr/PqL+oh2gax+HcJrnkhFqdESY8Y0kORhSoA9wfmdugLDrWZhn5RwZtF/s5Q8Hx7qpLcGtaj7KyFqSWWWfh+L0mGFpLK1ecjcQJBTwq7FfMu+m1oJ1S/Vu/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18862229-480c-4d4b-8964-08d8025a87b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 16:25:12.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzDhViminyGPbpMWeRoo3HeIhB1KSe4czANyPil7l4+BrKbO/kLlNrsUpTSMViKm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2646
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 cotscore=-2147483648 spamscore=0 priorityscore=1501 suspectscore=1
 bulkscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270126
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:43:16PM +0200, Vlastimil Babka wrote:
> On 5/26/20 11:42 PM, Roman Gushchin wrote:
> > In order to prepare for per-object slab memory accounting, convert
> > NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE vmstat items to bytes.
> > 
> > To make it obvious, rename them to NR_SLAB_RECLAIMABLE_B and
> > NR_SLAB_UNRECLAIMABLE_B (similar to NR_KERNEL_STACK_KB).
> > 
> > Internally global and per-node counters are stored in pages,
> > however memcg and lruvec counters are stored in bytes.
> > This scheme may look weird, but only for now. As soon as slab
> > pages will be shared between multiple cgroups, global and
> > node counters will reflect the total number of slab pages.
> > However memcg and lruvec counters will be used for per-memcg
> > slab memory tracking, which will take separate kernel objects
> > in the account. Keeping global and node counters in pages helps
> > to avoid additional overhead.
> > 
> > The size of slab memory shouldn't exceed 4Gb on 32-bit machines,
> > so it will fit into atomic_long_t we use for vmstats.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> You didn't add Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> ( see 20200507204137.GC161043@cmpxchg.org )

Indeed.

> (Noticed thanks to the great 'b4 am' and 'git range-diff' tools)

I'll check them, thanks!

> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 

Thank you!
