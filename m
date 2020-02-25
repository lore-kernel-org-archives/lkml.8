Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7614C4BA01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755F020838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tQMTD9kM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgBYWx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:53:27 -0500
Received: from mail-eopbgr700079.outbound.protection.outlook.com ([40.107.70.79]:3552
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbgBYWx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:53:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6cWm3U8tX3nHisBn29tAxRnj5To5JGhpcPr6CkMtDM9nRz4p8AR90FqdT0skFFnPcaKVDoz64RkHAN7k62PtwMyQjj8iGrCNiK923Aj2CZlCIWHqHVy2aAEok6P72PytjckaznkboEJEiFs+dIsGRJ+m14WRGgMncy7eDBkum90zhV0obPeeogYGzFIy0lcym3OW9LvkVarM4fVgp+pH48rEWzjpO5EYyJp4064JKhqavD+PPVnh92c8cEIhfraJb3p7As/XTwMyE6xAMkyQRzF6KhDSCX8MEQJ3kc7wS8naznPhVz3xzeZGmpgDLkjO2ph8g+08+xWmNc93hrqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLj8Uf2EQww4a5V2JtimmI26Adv/oT9wXTRgg8/pdHc=;
 b=Eq0b1GvR+uiqsb8uF7b9/Aj7TVdpQW5MvdDoJjue4jeobXNxYfxDx8o8jzOXagxAK+31Uf7Pr01HCJBvTu9f7xJDnaKgjMeGexHVUx6oEH+JsYtM9iX7+t76wzRqG9dg8368/rPbfkZNbugUAa8sOG17nUUCvS66kSX+bgDtvrvJmy6NAGORfCfps1EPJ34ZLt60yRhmTJ1BAjoPYc471A/ntdbjDBBAJAVJAVik2iq9f6YYbeYSR2yUIxFNK2OH+qgYwhRYvoRAdY5txKGQB0L+UAEe6Ft1ogcXmr/0hYAzEjd4Z3w+CgdG+PwJ0z27Uy8dbfhrJS8vYTs3BRtfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLj8Uf2EQww4a5V2JtimmI26Adv/oT9wXTRgg8/pdHc=;
 b=tQMTD9kM+JXID+MPX8Hax1+FLAuEyWk3jyasyx1upC6kuszXlA0TF6lM/RUZIm2PVQlBhXmQXd05f89hoiJXtba2RiLIcIrnoiaZ2uYFfAKrTmYq07RpCsXz7VxDX8Nth5tzG0bdYIYLzP0hJXPcSik4FeicYw3QDJ6JpDC+6rg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2704.namprd12.prod.outlook.com (2603:10b6:805:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 25 Feb
 2020 22:53:23 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 22:53:23 +0000
Subject: Re: [PATCH v2 3/3] perf vendor events amd: update Zen1 events to V2
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
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-4-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <73b5b731-9597-1243-485a-788437500c7a@amd.com>
Date:   Tue, 25 Feb 2020 16:53:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200225192815.50388-4-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.247] (165.204.77.1) by SN1PR12CA0099.namprd12.prod.outlook.com (2603:10b6:802:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 22:53:22 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3ad5666-5d1d-46ce-419b-08d7ba458418
X-MS-TrafficTypeDiagnostic: SN6PR12MB2704:|SN6PR12MB2704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27049DCA880F142D4553BC6E87ED0@SN6PR12MB2704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(31696002)(54906003)(52116002)(316002)(16576012)(110136005)(31686004)(15650500001)(4326008)(8936002)(81166006)(81156014)(86362001)(8676002)(53546011)(2906002)(66556008)(7416002)(66476007)(66946007)(6486002)(26005)(44832011)(956004)(36756003)(186003)(16526019)(2616005)(478600001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2704;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoyYRDLTN/c53j+B2pIF0xSHQ0GRthTJHJEMApU9/fCvTCI50pw3V6FkhkQyfrheRjkkQH5hjVRpmAoE6EiAv4QgLxiu/96NZMkVduUrpI/gScFbOM12h4n3V1kBN/MLeHT8F4X7LUjfn4kHuE8avisiKmcQV8ZjjaKZ+i5PQSF51wwpW7NbW1baZVm7Y6T1TC88I7apYJscQPlbOTfKcjr39fc6y4gX5ZLlHEdo6+xx3Vj+Uns72LeooJShSRRZ761NV5YdpIJxAElS5JxFfnnZqr04fcu+3rPpwScQpAfTSnzPg7UN79uYJTrJWuI+tti3TkDtnPNfIcS7Ixg0FmMsq1y1F3jgAgQ2o4iVn1/P9sVKWxsKIwankvrvFmOXQ5SMRkiEPZ7b+fMko/ecCOG6dELy/no22E4CCwkCk+4A0c0ruMScIPmiFXKueV5y
X-MS-Exchange-AntiSpam-MessageData: A+/DiqX/YqW23TQF4m7AapFUemuFt9WiUYdgY6+kRwB511xWL7JcmeP321j2GFnNtcX8znzVBaj3DHtLmE1kEuSPNjG3wVSxiunufzLcvtTQgWsMdoWpWJdVqE838mvCBv3LRNy2cE9PHPcEnBqTJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ad5666-5d1d-46ce-419b-08d7ba458418
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 22:53:22.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/s0wSTqPg/AVLQ5oplF1k+MYSAJn7eqemrXbwWZFMzPNSm2L1zGtyNNEakED4wheAghYcIswPyZZG+kHepGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijay,

Thanks for your resubmission.

On 2/25/20 1:28 PM, Vijay Thakkar wrote:
> [1]: Processor Programming Reference (PPR) for AMD Family 17h Models
> 01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
> [2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
> Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.

Events such as the FPU pipe assignment ones are not
included in the above docs.  So can you add this one
to your list of references, since it has them listed?:

OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018

> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
> @@ -6,6 +6,34 @@
>      "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",

Omit the trailing " to Pipe 3.", since this one's umask
represents all pipes.  Feel free to add "all pipes" instead.
I realize this isn't a line you're adding, but since we're
here, we might as well fix it.

>      "UMask": "0xf0"
>    },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual3",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3."
This one is ok.

> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual2",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",

That trailing part of the string should say ..." to Pipe 2." , not Pipe 3.

> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual1",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x20"
> +  },

That trailing part of the string should say ..." to Pipe 1." , not Pipe 3.

> +  {
> +    "EventName": "fpu_pipe_assignment.dual0",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",

That trailing part of the string should say ..." to Pipe 0." , not Pipe 3.

> +    "UMask": "0x10"
> +  },
>    {
>      "EventName": "fpu_pipe_assignment.total",
>      "EventCode": "0x00",
> @@ -13,6 +41,34 @@
>      "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to Pipe 3.",

Omit the trailing " to Pipe 3.", since this one's umask represents all pipes.

>      "UMask": "0xf"
>    },
> +  {
> +    "EventName": "fpu_pipe_assignment.total3",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps on pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",

Please concatenate " Total3: Total number uOps assigned to Pipe 3." to the above string.

> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.total2",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps on pipe 2.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",

same here, but for pipe 2.

> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.total1",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps on pipe 1.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",

and here.

> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.total0",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps  on pipe 0.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
> +    "UMask": "0x1"
> +  },

and here.

> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
> @@ -37,6 +37,24 @@
>      "EventCode": "0x40",
>      "BriefDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
>    },
> +  {
> +    "EventName": "ls_mab_alloc.dc_prefetcher",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache prefetcher miss.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.stores",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache store miss.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.loads",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache load miss.",
> +    "UMask": "0x01"
> +  },

Hm, PMCx041 didn't exist when I wrote commit 0e3b74e26280
"perf/x86/amd: Update generic hardware cache events for Family 17h",
and their counts don't seem to match up very well when running
various workloads.  The microarchitecture is likely to have changed
in this area from families prior to 17h, so a MAB alloc can likely
count different events than what is presumed here: a Data cache
load/store/prefetch miss.

I think it's safer to just leave the PPR text "LS MAB Allocates
by Type" as-is, instead of assuming they are L1 load/store misses.
What do you think?

I'll review patches 1-2 tomorrow.

Thanks,

Kim
