Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078222073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cqiqwgAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbgCCREa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:04:30 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:20302
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729000AbgCCREa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:04:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeKDJ62K/Tbp2FEYNXjwiwlkCfQ/6G7CwZFvj1ngBdq9B0Q2vJppI+cY034QuMNlCltHrhk2+oYLAQ2XbY0CYqWCPo8TNKTkDdLoGoSz6ulXUbDgMOiOiHK8XDrMmpqpIOjNdyHprD2s77sVeyUg3Q4jYdpnfOvIu4aiJhsa5qdtNCdnS/GNNG1aEj6zcQTO18sE7BdPkjR9eqhu8gJ8IXu40l/JQiLGMSE5l0um+gr45loYy211AckMEkkH8lVZcR3spRuKk/OZS/XWy/3MGccZ0GjwwyefKUr4RapjSxFgsDmG5tJRrnqtD7Wj/3rBWtvewuv8749Lix8GeQms2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPtfK5t+6xALbK8zwNW9i/3AI19PXF/GvftPPfakOIM=;
 b=oTbTxgyNyXmfU8pdy0i1a+zM1LVpdLi1CDKP1zvaGv0J4I9ObOVj/gu8kRm/MvN6OBDViqgRl/nIkPaDo6POqzeKgEtF1rc1wkIZ59eWJsi9AS4U+gGhsS+XLC/sT02FKTM9OdY3RBwaEQvbMfNzo0O+FIYQ4o9Co1dB1QJMwD/GyxEB4a6e5RuJTzMWdutwwq+XaZQIByvLiz8kTYxGr9q9rx5tHIiJ2ANT4s7gcFR9Kp9eHm+Z6pkdkIBQDvNpSObaJwmIv/vVLhOBcxRpHavV/Ct2bHgiPOHaLF7R82R9hUvOKDoNpv8g++84L5p3lTG8N4mmPGgEGGfeEfasFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPtfK5t+6xALbK8zwNW9i/3AI19PXF/GvftPPfakOIM=;
 b=cqiqwgAvVLbLSHvD4+iqFiNFH0R5Yf0KWJbBuA8Xinm8BS0SXZ6j9nP+dl1eUCDeFuj9XireuhwLg2vcVi5vvWldHnjF3hcG7mU8C1l/sE84PumgSqcRcPH3bJck75PZU8+djrlmjY3z9sEUFpRrjDtnqFZJS4nifijvWy1kb8A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2671.namprd12.prod.outlook.com (2603:10b6:805:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 17:04:26 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 17:04:26 +0000
Subject: Re: [PATCH v3 3/3] perf vendor events amd: update Zen1 events to V2
To:     Vijay Thakkar <vijaythakkar@me.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20200228175639.39171-1-vijaythakkar@me.com>
 <20200228175639.39171-4-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <77552e9e-7fca-7186-24cc-6a8a87d4b7b6@amd.com>
Date:   Tue, 3 Mar 2020 11:04:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200228175639.39171-4-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:3:101::22) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.247] (165.204.77.1) by DM5PR22CA0012.namprd22.prod.outlook.com (2603:10b6:3:101::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 17:04:24 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4785c8fc-37ee-4c95-f512-08d7bf94ed7f
X-MS-TrafficTypeDiagnostic: SN6PR12MB2671:|SN6PR12MB2671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB267187C79D372610E589528887E40@SN6PR12MB2671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(8936002)(7416002)(66476007)(81166006)(31696002)(5660300002)(81156014)(4326008)(6486002)(86362001)(8676002)(66946007)(66556008)(53546011)(52116002)(36756003)(110136005)(31686004)(16576012)(16526019)(54906003)(316002)(26005)(2906002)(2616005)(956004)(478600001)(186003)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5JhFpE0IYvrCu5keJ6NvKH/bZCM+bX/S9ya551RIPfJbSoYxECboCsjyVY+0Xd1BYa/DiR1Mv+eQmAb8N7ibuqBPIzFLNaKzwPzuQPwWeonsHeJS95ituq1amEZaCcRAqBWTAn9Mm74pJKuU8/5zPQ6/oNxRNNCG5ffaudKvsnmodRcPPKy/xPFIhGH4BpSgockeKh/NXRBWlEfGPutB56Q02BcGLkvnhimIDKb4qWSg6RAVKA+wBHihSYWESzBUej3nuDmhjdWJJEJ0oZkqDz8NfPZVCT/PQxYshDjrLS5q5C5CMWxSFfLPSjLRTyK7qlbAt7A8bBP22sHEvpPAwOTD0u+Du6zo1nZq3aQFFoHZvVRcYa1hNEAItZAD9n9z921B8Cbibo0Dut3MaKQgGtXat26K1xVl6Xr8EPnNLi9SLCzz8/WZ7lbeA1fmbCk
X-MS-Exchange-AntiSpam-MessageData: xbfVOTlU383yu+JfbBhPKLB0i6Jon3uczQHY3BAuAtXgTFTo2vXfirX8FFmIwbze3nBAYyeDEQmc/HfR7ZjeLJXAGmjXoAZm/VWnJEllKPCAFhvHgW8svlDubCMY9v758wPVckZcR7NC/ahXngYztg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4785c8fc-37ee-4c95-f512-08d7bf94ed7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 17:04:25.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0HAFfzkJ3iRF3QS2wY++XUhnmWMBmrhPTUO9SInWILnGsU19skK75SaOXyU481XZCdGFuvtC7UzzBm/QDj5Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

On 2/28/20 11:56 AM, Vijay Thakkar wrote:
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
> @@ -3,16 +3,72 @@
>      "EventName": "fpu_pipe_assignment.dual",
>      "EventCode": "0x00",
>      "BriefDescription": "Total number multi-pipe uOps.",

Please concatenate .."assigned to all pipes", like you did in the publicDescription:

> -    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to all pipes.",
>      "UMask": "0xf0"
>    },
<snip>
>    {
>      "EventName": "fpu_pipe_assignment.total",
>      "EventCode": "0x00",
>      "BriefDescription": "Total number uOps.",

Same here.

> -    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to all pipes.",
>      "UMask": "0xf"
>    },

The rest looks good to me, and so does patch 1/3 still.

Thanks,

Kim

