Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8AAC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE96D2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VQIv9cYz";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QPrlGk43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBCSZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:25:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728435AbgBCSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:25:28 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 013IN5fB007312;
        Mon, 3 Feb 2020 10:25:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v1O9rHUWRTEwWexnSFtMT1OGgy4tpGYXX9cr2609f7o=;
 b=VQIv9cYzberpHy3qaOXdByHdUnSR2oQi6xYqhlToofinH6w9A5hCXpbSIxH5Wn74OLhx
 BmGB3uZJ+6n3t5ZngTs8NEcaNDmyJEOUQyjSdFkPaBBS+xnR5QtK/kTbjdWJ4YcuNx+q
 NdCLY6pfwc65SL90RGqlEbyM8pYqHTHffbI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2xx439mcnb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 10:25:20 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 10:25:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoHLWtaRlhGqUUN60PbBbJOb9ZXvbiZ5sm9ngJJqIY9PyaIS8a62ojWBvyM1FpMV4lcQBkHKtsLpdhYB6R0Xk5vCXgiZH+KyyfU/Y1vz8b/j+8TpBqykk/s4YY5978BFGImWhSHzuWofveLmfTWnZHoSFLVu9L/9rwQ3M3V1PNBdDc91zlytrnMkiQPbtXnQr6FRVbYI8tVBplmD4fwzSlBroxfwPhdijGkxmjWkQ8upPGcJptOGgE6C8aH1/Bpw1nOYYQxLkTvcC+vzOkVImiJCG32E7ebLRjsNyY4AnePEX0fJ2I3kZJVWe7neVx8zs7v05FQv/B+buPObrHxOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1O9rHUWRTEwWexnSFtMT1OGgy4tpGYXX9cr2609f7o=;
 b=DosfmzoGhA22XfgZgxXtgCCJhZkCMcHcNsCSCMkzV6uoGIfbdACXtGrBZOU/b+EWQP1ivKXoSXHv1CjK9HILQXyfhO4T10DV7bIARBjEtcBrus7LO9z0D1+McfEPUCULechjbjBDSfxhkJfKeUDFtoyD0jNuYa/KIPUKBufLum0HcRGuOY17SgB2JQL6rCH4Rbu2x9S/cSTdpfKVdI7Ij9vq2rfaV2ilvaFO+RYdxgjI5trcUg8btOOV4g11e5dUXkSUb70En3orJsRSLb0a8y8+WlJoFjqoXAkrE89oGR+4B7BvX4eIXkZssMJUhJyM9siO7pNIa05Auo+ZQfBizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1O9rHUWRTEwWexnSFtMT1OGgy4tpGYXX9cr2609f7o=;
 b=QPrlGk43zOaw7Bi0l5eFzSrqdwtN/PJtiK6tSnzgDHhk49N3CPU1gjHTF5rjFwj4Y7D6mquD8+LV91SZYoXmxztRoVDXPLeH/RkEzaV5i1X9ICkAEZhzo+hVtFWV+1a77RXca8ATUj5HgwoqsknFBXmqhtYM5V67y7KRbxIQUZM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2424.namprd15.prod.outlook.com (52.135.194.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Mon, 3 Feb 2020 18:25:13 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 18:25:13 +0000
Date:   Mon, 3 Feb 2020 10:25:06 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 12/28] mm: vmstat: use s32 for vm_node_stat_diff in
 struct per_cpu_nodestat
Message-ID: <20200203182506.GA3700@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-13-guro@fb.com>
 <20200203175818.GF1697@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203175818.GF1697@cmpxchg.org>
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::8957) by MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 18:25:10 +0000
X-Originating-IP: [2620:10d:c091:480::8957]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c28c4c-a4e9-4cd4-593d-08d7a8d668b7
X-MS-TrafficTypeDiagnostic: BYAPR15MB2424:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB24246008C4E48DF62DB9D0B4BE000@BYAPR15MB2424.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(346002)(396003)(136003)(189003)(199004)(6666004)(186003)(16526019)(66556008)(54906003)(6916009)(33656002)(6506007)(316002)(55016002)(4326008)(52116002)(5660300002)(7696005)(9686003)(478600001)(1076003)(66946007)(66476007)(8936002)(81166006)(8676002)(2906002)(81156014)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2424;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWZXTGiCQI+ik8nFclU7w5eOEr+oJo7E7T+pNgkVq4YzvCVROtf2VaZhIxPxUWN9RxMMndJvOTV0jK9AFb3j+6MIO6sjGBLAssZLqunKe+rMPttXKUBSlTifs3G3mECfzGySwQTLdvQj0nnVVqSODEcNn7LPEIIlBc5LNBfDn07nMqOUOrC5nm7kyEp0ZFLRuJ+W9rRIVK5/rtXP+mw7NcD4nfhNUrB5qchQ/Snh1jNLLJljPOXzQyycJgrUbF9NP+MOgeyytXlsZNlQVX+l0UHSqpcO6LgnBYRYWDdDHCrrlQWxBrd15TE8ByrD3H3Q1JN3SS3xVmCeNJe15FvnHZnDNG3IpCwiY9XX/J5ruT4i2jxz3h0wwoHvS/RVGV6ctpG6jOAmkHiTklLvWbDuuLByBS2QRvfwMcWSSGj+5bz2WoM6v5Lh7DES7Nle5SdP
X-MS-Exchange-AntiSpam-MessageData: IB/jxATprqc8l5KvuLEWhHag5DV6DPqufW2T/Zs2W70L8xR0715CgtOonFaXoCo8bxeu/nJfODWbeMSukjIuJRSSZCn2SDNc8M1+hZb73pCjWSxKPLQr8RxAck/2uX+47QDrBovIYufLT0QTXJHZIec+Rj5fJRC570Q5yjGdTAk=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c28c4c-a4e9-4cd4-593d-08d7a8d668b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 18:25:13.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAxl0tzLaEZ8vkP6W6ctMKNrspvvLFbznsV6FGDqD/DZsp3lNa+y6zdnGDc4YgoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2424
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_06:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=5 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2002030134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 12:58:18PM -0500, Johannes Weiner wrote:
> On Mon, Jan 27, 2020 at 09:34:37AM -0800, Roman Gushchin wrote:
> > Currently s8 type is used for per-cpu caching of per-node statistics.
> > It works fine because the overfill threshold can't exceed 125.
> > 
> > But if some counters are in bytes (and the next commit in the series
> > will convert slab counters to bytes), it's not gonna work:
> > value in bytes can easily exceed s8 without exceeding the threshold
> > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > vmstats correctness, let's use s32 instead.
> > 
> > This doesn't affect per-zone statistics. There are no plans to use
> > zone-level byte-sized counters, so no reasons to change anything.
> 
> Wait, is this still necessary? AFAIU, the node counters will account
> full slab pages, including free space, and only the memcg counters
> that track actual objects will be in bytes.
> 
> Can you please elaborate?

It's weird to have a counter with the same name (e.g. NR_SLAB_RECLAIMABLE_B)
being in different units depending on the accounting scope.
So I do convert all slab counters: global, per-lruvec,
and per-memcg to bytes.

Alternatively I can fork them, e.g. introduce per-memcg or per-lruvec
NR_SLAB_RECLAIMABLE_OBJ
NR_SLAB_UNRECLAIMABLE_OBJ
and keep global counters untouched. If going this way, I'd prefer to make
them per-memcg, because it will simplify things on charging paths:
now we do get task->mem_cgroup->obj_cgroup in the pre_alloc_hook(),
and then obj_cgroup->mem_cgroup in the post_alloc_hook() just to
bump per-lruvec counters.


Btw, I wonder if we really need per-lruvec counters at all (at least
being enabled by default). For the significant amount of users who
have a single-node machine it doesn't bring anything except performance
overhead. For those who have multiple nodes (and most likely many many
memory cgroups) it provides way too many data except for debugging
some weird mm issues.
I guess in the absolute majority of cases having global per-node + per-memcg
counters will be enough.

Thanks!
