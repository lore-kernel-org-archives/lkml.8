Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F90C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1DB208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 21:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="d9FhGcsV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lG2p1Kh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgFPVT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:19:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgFPVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:19:27 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GLJBIS005782;
        Tue, 16 Jun 2020 14:19:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1BhyLEt8qoas/6ORVdRISeMrJi8KrMuqm2sFgpKKStU=;
 b=d9FhGcsVD/YRF7w/G27c/ZhmddYbA28NHO09EEE/whp+a6/U86pmmQqpXWWcZhhOqZEj
 5cqhET0JKerq12yer4dKXeCnMHiJheVB9nQw4bScWA4Np3k/3geGtN6GS+OH8VEEX2rB
 wyMoUMdLfeL07YzNeiSWbF64nTr5jUhjHVo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31nes9c86y-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 14:19:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 14:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMoAisWcbNrj4z7sxfT7LotEfpc+s8I+vtEi258qYW1wBXqXasDg/J6V7EwZBXDEIzBfUTeth0YcalB3iZnzkVGRCV52sGosSCS+6IuOUAugLM7n+ilF9Wf7w5Ih1pOhLS9yenpuBsFnNdvdIpDwB8A25rAF+WJw1IGQJtfce/7gOxH39VL8fQU8wdubw/ceoGi/ip1UgWwsO8ZK6YgTO27zNYPXXy0R9BJQNClTEMcUs4nHkCylbZlxl1Jm1gefL0dXqB+/CNf5HcGLUGTpSpdmUa1osRQdG8O9NayumkXnPmwz76ge/7JfP5zF1Copd8jaoSICbr79uOTXQkDVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BhyLEt8qoas/6ORVdRISeMrJi8KrMuqm2sFgpKKStU=;
 b=CLJz6TMn6PwPRCgBfIhQmm7R7mT3PdfKC1LmG87WPaFclAURAUeXDYKKoRuUgmeJflFNw4o88SYebEAxuBf/stnfrSzwNwWAYWi4pz7cFTIpVacSxIoDFAp9rsJiwEyOQW1o1vzL8gWT+5ebNsqLuaqWHhYNalXx1G+eLj2dFs+5QC0gWxiGc/OTiYEweAC98e105QE2pPgkTU2XZryolh52lVH9s2JIO7+Y+sn3Asil0iSa5m97Fz1hqKoTnHDjPOzXz65EHfhJSajNTLKQ0GGBVIM6juuel/VGF1kt3teMugSGDFRko7uVntXskhquOfxzw6jC7S85RZcAxQwZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BhyLEt8qoas/6ORVdRISeMrJi8KrMuqm2sFgpKKStU=;
 b=lG2p1Kh7O1rB33NOHhetYktzj5vwQszHkm+xnBS+lv1KAcskuwZwaM+WCjphx9SLyfebglZMOjv04yKec4Eta+oduyOIFxrQuC+/V2upvHyVSZvkSpFYdxZpuJsx7WggJcREnqyrE0y57+HpcZiSSPSIvK4/PxLGB3HiM3irz+s=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2343.namprd15.prod.outlook.com (2603:10b6:a02:8b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Tue, 16 Jun
 2020 21:19:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 21:19:04 +0000
Date:   Tue, 16 Jun 2020 14:19:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Potential Spoof] [PATCH v2 0/5] mm: memcg accounting of percpu
 memory
Message-ID: <20200616211728.GA7652@carbon.lan>
References: <20200608230819.832349-1-guro@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608230819.832349-1-guro@fb.com>
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:c84) by BYAPR06CA0049.namprd06.prod.outlook.com (2603:10b6:a03:14b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 16 Jun 2020 21:19:03 +0000
X-Originating-IP: [2620:10d:c090:400::5:c84]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a2597f2-4405-495c-8d62-08d8123ae55b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2343:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2343F89E2F41DFFC013F1130BE9D0@BYAPR15MB2343.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ieXDduENzhy4uOnzFjpdTB23Xy2sy/PRHtiW62LFPNA1TtNMEFQwpbey4eiDwzxLqNYS2y5GqiRXKeiIKT/Y0miIb2raImUL9qBNph4SSJ20YBulUfzg+g0OIl3dsl178YSeas/wwDUjWwQciTxNTxqPHZbSMQjfG2mK0VfHy+mfOl5GAb00oMMmvGDO8zL6B2v2HMpHxTTWXhNdYBcsITtmqwMyJOQNotHKI6wBn6tSHZcHKWCyeI4Y1c8xTW8dcZP8L3pnCv3WGXOvfqZD4TrdgjugNn1eNtjicn7gOWWrbksG5AU/duSj0D6W4jKc28PhwKyt7c7ysGjzrEm3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(316002)(15650500001)(33656002)(186003)(8676002)(6506007)(16526019)(83380400001)(110136005)(55016002)(5660300002)(4326008)(9686003)(1076003)(7696005)(478600001)(54906003)(52116002)(66476007)(2906002)(8886007)(66946007)(8936002)(66556008)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /5VsVU9HedF3GVTPG3PcWYEqrxXmixvErVc1xf9bEnZSCkWWWj70Cyxh3zwtUKokv+po+qDUe45akDzvf7xCc//Gsum+iq4nqH/7xxXd5zjBIm68bz8QSoc8wqW7OfizFiD3Vb6W4F/sf7QpNiv1kMBGNp96GglIBpxR/rDPcsBnZ0aTSNuvbl9v08r4stCTKQm6+5/qsdNoOPL4wn8TM3AekaMtqlagX8MWr7C8lZx/LFlMNqzitABFDXmF7z1PClxzGTnjNZDQiB/1MRSJkZwjuKCgWIITelhah1itUNI/JXSczo2oYfF8TFSYgulGl7IYBLG+CakOkikuGNU4JTLSQYbd4YmMLj3xwUPoIXp7X8UklfqDMZ22w71zTDcxzGFbeDSNFLyXQY7Z2UyBQxolCEVKNlZwSe1nDCMIB5XeICcxmXQeaI0QNxETGQ6bEQSZbERHtIJ3Qr9ulTe7Y6Ki1WESGATPvWva9QxmDG6eb0R8tJyJqu03MrtEVKNvs9e29R6jYJjtY7HwvFEVlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2597f2-4405-495c-8d62-08d8123ae55b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 21:19:04.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uon4ak1YE/3Jt9H2aim3Ne74MB4j7Sy9fMn+9n3SvbNDmLCU8ARUrnW8xQVZZEZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2343
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 suspectscore=1 bulkscore=0 cotscore=-2147483648 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006160146
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 04:08:14PM -0700, Roman Gushchin wrote:
> This patchset adds percpu memory accounting to memory cgroups.
> It's based on the rework of the slab controller and reuses concepts
> and features introduced for the per-object slab accounting.
> 
> Percpu memory is becoming more and more widely used by various
> subsystems, and the total amount of memory controlled by the percpu
> allocator can make a good part of the total memory.
> 
> As an example, bpf maps can consume a lot of percpu memory,
> and they are created by a user. Also, some cgroup internals
> (e.g. memory controller statistics) can be quite large.
> On a machine with many CPUs and big number of cgroups they
> can consume hundreds of megabytes.
> 
> So the lack of memcg accounting is creating a breach in the memory
> isolation. Similar to the slab memory, percpu memory should be
> accounted by default.
> 
> Percpu allocations by their nature are scattered over multiple pages,
> so they can't be tracked on the per-page basis. So the per-object
> tracking introduced by the new slab controller is reused.
> 
> The patchset implements charging of percpu allocations, adds
> memcg-level statistics, enables accounting for percpu allocations made
> by memory cgroup internals and provides some basic tests.
> 
> To implement the accounting of percpu memory without a significant
> memory and performance overhead the following approach is used:
> all accounted allocations are placed into a separate percpu chunk
> (or chunks). These chunks are similar to default chunks, except
> that they do have an attached vector of pointers to obj_cgroup objects,
> which is big enough to save a pointer for each allocated object.
> On the allocation, if the allocation has to be accounted
> (__GFP_ACCOUNT is passed, the allocating process belongs to a non-root
> memory cgroup, etc), the memory cgroup is getting charged and if the maximum
> limit is not exceeded the allocation is performed using a memcg-aware
> chunk. Otherwise -ENOMEM is returned or the allocation is forced over
> the limit, depending on gfp (as any other kernel memory allocation).
> The memory cgroup information is saved in the obj_cgroup vector
> at the corresponding offset. On the release time the memcg
> information is restored from the vector and the cgroup is getting
> uncharged.
> Unaccounted allocations (at this point the absolute majority
> of all percpu allocations) are performed in the old way, so no
> additional overhead is expected.
> 
> To avoid pinning dying memory cgroups by outstanding allocations,
> obj_cgroup API is used instead of directly saving memory cgroup pointers.
> obj_cgroup is basically a pointer to a memory cgroup with a standalone
> reference counter. The trick is that it can be atomically swapped
> to point at the parent cgroup, so that the original memory cgroup
> can be released prior to all objects, which has been charged to it.
> Because all charges and statistics are fully recursive, it's perfectly
> correct to uncharge the parent cgroup instead. This scheme is used
> in the slab memory accounting, and percpu memory can just follow
> the scheme.
> 
> This version is based on top of v6 of the new slab controller
> patchset. The following patches are actually required by this series:
>   mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
>   mm: memcg: prepare for byte-sized vmstat items
>   mm: memcg: convert vmstat slab counters to bytes
>   mm: slub: implement SLUB version of obj_to_index()
>   mm: memcontrol: decouple reference counting from page accounting
>   mm: memcg/slab: obj_cgroup API

Hello, Andrew!

How this patchset should be routed: through the mm or percpu tree?

It has been acked by Dennis (the percpu maintainer), but it does depend
on first several patches from the slab controller rework patchset.

The slab controller rework is ready to be merged: as in v6 most patches
in the series were acked by Johannes and/or Vlastimil and no questions
or concerns were raised after v6.

Please, let me know if you want me to resend both patchsets.

Thank you!

Roman

