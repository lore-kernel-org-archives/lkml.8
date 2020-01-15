Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41986C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E9024679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UjSWK6pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgAOSTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:19:21 -0500
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:1793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729184AbgAOSTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:19:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6t/eyoZ1qNAyP3QL3sa98KxAiDEvzqfn2vjtOh3BITCwNa3dGC4HC+xx9kifddhGa03zX2bkq5pBZ6tuBHAn+yARdXw0C5ccu0U5xKhkKHwLtmRCY5RzKpkWt/JB6hugDMuC8KLsxmlrb7m4xnovI2zzTAJ3nPri6H6r7FDzi9xWiTRMMsbOWeSxDZ6kQkHYkZq7BNGr4BHPUNqVQ6PlMzEvIUCxmj90slAoGoyZi7/zBVdm7eFCZLfZuv9OTaq7JVgeKYhf0ZZXdBunnn7kLJ9LIQfyRRYi5LhO4eLSLKH2D0SKRiIeZ4r9AZ5hEjtgTySywqkbx3OGQuDtCKMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL393WADTUfmsm8CpTnbhfe5sqe/grn/ky7HY+WWx0A=;
 b=ogs4v0QdpLm/Vgk911gfUmstiECLpWFlAnfAQwM6sTaF4Jza/GkV+UAlkRwzI7lnZGj/uJJGOB2EXQB/4ah+gHrhU3tyihEZfXViLDC0JeYB2AMzYnHQYiS484dH+X4ri/kMZyieNFNnCOrBWxr3atUuTctQozD4Qfl2WgVgfnbssF+AH3nlizugfYSQWAodCeQhz88y1Gnq2comVYqNTnEnVx5Um8+2W6Z9Q35w+Rp5PqLnkQlTuO9zdFBB61SY6w5GDMp9RaXYBoEdqov/gqOwOMJA6HDBBn9dh2mAg4YjiaWzhyvpqPSiCAtSdqz6nIDAGOVIniK9YsmB4JWuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL393WADTUfmsm8CpTnbhfe5sqe/grn/ky7HY+WWx0A=;
 b=UjSWK6pMnXfkcM5Q8U9IOYRLVD4LsWXcpWh1KKQNeX2fMg+COYFRts5WhUjvAID4v92Pi9YxEv9eTli4uNExKVDlQY+Gf1MtchJ4DK6ldsgv07vFCT4XX8lIRnvuFMls+fMQdXdIF7mGLiHToML2TFaFem9PiPXrN/zTArYaUKg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 18:19:18 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 18:19:17 +0000
Subject: Re: [PATCH 3/3] perf vendor events amd: update Zen1 events to V2
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
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-4-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <4411225b-1bb3-a273-bd74-7923f91006ff@amd.com>
Date:   Wed, 15 Jan 2020 12:19:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191227125536.1091387-4-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0072.namprd05.prod.outlook.com
 (2603:10b6:803:41::49) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by SN4PR0501CA0072.namprd05.prod.outlook.com (2603:10b6:803:41::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.6 via Frontend Transport; Wed, 15 Jan 2020 18:19:16 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88eac23d-6d2e-47fa-1fa0-08d799e76ec8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:|SN6PR12MB2621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2621367E0C98CB4E53D1A70A87370@SN6PR12MB2621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(189003)(199004)(31696002)(5660300002)(86362001)(66556008)(66476007)(6486002)(956004)(66946007)(26005)(81166006)(8936002)(8676002)(2906002)(81156014)(53546011)(4326008)(478600001)(110136005)(19627235002)(31686004)(54906003)(16576012)(2616005)(7416002)(44832011)(316002)(36756003)(52116002)(186003)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2621;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgqXsIoyXm6LMidnWn0HYaTE6ovgpr0eSQ/JvuKwEn0u79dYD1+i61WzX6Nujg4RVE1e6zDOPSyQ7R4Rqzk1uvEAaeZKkn995cCsuTBgUrlgsbzZpGpodzuOZVYyOt1YeLwOsXhEu4gR0ZkjDeGBCxJsyk/eKZQIc7Eslxdu9XrE/3vRUeKg0Z19vsZv76vebgvE/AWXposXCkGFq7gVMlREfQMfChXOcgc0NtXtCHAXkC+Byq8bkwHsu5LPPJKjXUGt4P6CS/0YOEmZfA/DG5R9cKhgF0QUg1AQmIVB5LjIrNYWin8uNeR1+xWk7NSI+1XRNASUF0yjiVRkE8Tr58OK8tbeKThftq/4ZveXcW1mP+LRuaCPPJ3TEnpwW37OX4UyCK3Ed/92L22/oxbYkmyF7ivftl2RCiKkyrOyu5J+llhyGUtAYe9p9lxTKfOb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eac23d-6d2e-47fa-1fa0-08d799e76ec8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 18:19:17.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ovyj1pkMZ0uZUGFb5IPM3tRGQSZTfa1MyDZ4FCQM/4POGkgVsfiLEYwShX2mfQMTTdaIGDQLxmdVUFJNBrCdRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/19 6:55 AM, Vijay Thakkar wrote:

> [1]: Processor Programming Reference (PPR) for AMD Family 17h Models
> 01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.
> [2]: Processor Programming Reference (PPR) for AMD Family 17h Model 18h,
> Revision B1 Processors, 55570-B1 Rev 3.14 - Sep 26, 2019.

I'm a fan of providing links to the documents; saves reviewers some time searching for them.

> -  {
> -    "EventName": "ex_ret_cond_misp",
> -    "EventCode": "0xd2",
> -    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
> -  },

Ack, this is in the 54945_PPR_Family_17h_Models_00h-0Fh document, which describes zen1, yet I get zeroes out of the hardware, which technically could mean that Zen has a 100% prediction rate, but I doubt it, given the workload I gave it was very unpredictable :)

> +    "EventName": "fpu_pipe_assignment.dual3",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 3.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual2",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 2.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual1",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 1.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fpu_pipe_assignment.dual0",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number multi-pipe uOps to pipe 0.",
> +    "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number multi-pipe uOps assigned to Pipe 3.",
> +    "UMask": "0x1"
> +  },

The UMasks for these .dualN event masks are wrong: they need to be left-shifted by 4 bits.

> +    "EventName": "ls_mab_alloc.loads",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache load miss.",
> +    "UMask": "0x40"

and this UMask should be 1.

This concludes my review of this version of this patchseries, sorry it took so long, and I didn't do a fully exhaustive review of #2 of 3.  If you post a v2 of the series, I'll be quicker to review that.

Thanks,

Kim
