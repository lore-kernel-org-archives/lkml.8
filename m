Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8237AC3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489D42073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="ThQWcX2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgCFHVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:21:09 -0500
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:54587
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbgCFHVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:21:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tv+Ov5jl+sUfxfVyeK2sD8LVxsXmFOrPDqTbKR1RHCSGx4u8uHfORywZGVWGTtg6XkdsB8SNCCDR4Y6Yv8sGEiT7LYfC0dsX7Os2Tiy412C+NweWZS7rSMxoJpChkSEbeOpLkyoNYPCFxHiaQeHGnrrEbkitCUbdlKRZdY13Pujplyh280kfQjOT6pGBXONidceraGQQN8oTGFuQdwuBPBVIR/cMktm4WMXoRvzBY9PM0tztLfTxre4jwh5b69ovJDm8NrtzN6IyyNJ0zUkFmKBNJMbpGTAI0njjdrKqMvcC2e2kH16skYtJaqLACA8cQ8jn6VUnMwJETSebej0lYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1TYj6awG889fqOvLgpUvDthZfIy9Btor/D4GkPEDSw=;
 b=UaAKBrWUa9HCVi9yH0Bf3R2EWt1WA7AuF+SIHgRqto6tPWRobk3mnUqug/iNQSMixmrFNZYKB2+O0lTY6nAPg6Clz/Z7E98utineWXdZO8AgUZBfIQniukKk+/BIUjrBS14xKaj8UIk11FiWYacjLtIoMFQU65miChOsnZA3C1Fictq3yP+Br/XADfmdI86ayxWdmTgkvD3tRHhV52coixYA4XGA1AMFYz3G6YLzw5d0yT+NiR3CGgd1/0+wHTmEfwd+G0VpsiDvf4EI6U+LeQ5c6bhdhDHdbetFLxJ8bLk/WJlIVe+ylaBPO8RNV9Z6HZNqNKIB2qcIX65zA5SCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1TYj6awG889fqOvLgpUvDthZfIy9Btor/D4GkPEDSw=;
 b=ThQWcX2atl7GGQ8QiKhXgNETkN/eUnoLt/0lJDDJ95jRxRh7B6ctaogGhAEidK5CDGn7GOWwiaSArQOn4dD1TM3F/stEure6PLERpVVcO3YHAnUbCRRC5EJ4Itg9mDqNPfitu6Nxa0G1zgl45Ej4ZKU66weOPlb3I/MGgTW2YTI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2542.namprd11.prod.outlook.com (2603:10b6:805:60::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Fri, 6 Mar
 2020 07:21:06 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2772.019; Fri, 6 Mar 2020
 07:21:06 +0000
Subject: Re: [PATCH] perf: Fix crash due to null pointer dereference when
 iterating cpu map
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, jolsa@kernel.org, meyerk@hpe.com,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        acme@kernel.org
References: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
 <20200305152755.GA6958@redhat.com>
 <20200305183206.GA1454533@tassilo.jf.intel.com>
 <20200305195843.GA7262@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <f5a7ff48-659a-bce1-2ad0-54f334c27379@windriver.com>
Date:   Fri, 6 Mar 2020 15:20:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200305195843.GA7262@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HKAPR04CA0013.apcprd04.prod.outlook.com (2603:1096:203:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 07:21:03 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 473cc92b-8b86-4307-f916-08d7c19eef1b
X-MS-TrafficTypeDiagnostic: SN6PR11MB2542:
X-Microsoft-Antispam-PRVS: <SN6PR11MB25427942A458FA94E7DB23A38FE30@SN6PR11MB2542.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(39830400003)(376002)(189003)(199004)(4326008)(478600001)(2906002)(66946007)(66556008)(66476007)(5660300002)(6666004)(81156014)(8936002)(2616005)(8676002)(956004)(81166006)(31686004)(6916009)(16576012)(6706004)(186003)(26005)(16526019)(54906003)(316002)(6486002)(53546011)(86362001)(966005)(52116002)(36756003)(31696002)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2542;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSTs8GHX4L2xnPJ/OJEA4Sy+PDTakQwITH6sGJWuPosNSOn6dbjHu8ZF7AxX7yVKA668SrjbKiG//L1PSo1IbiXGtXk4ZuOHtElYQJnymZ1a72zE0LEHEvoQS2utR7BXPWPus+WWk2MlqDt6od+NdtzahsxYiMS75d2viZMKXCrkjIaqiyEMxoPvC6AeAmHmgWGTIry7WkPc0lH1Lw3gNGdXrIISXgN5AjXXoWooLfo9RpjxCreFVi4WcHwXXqQbtn7qgl6hdQhxdrzk4FoEQJvopfER5E2ahewXAaXZ7oB8UaZC5eqYj2MzUjNFUL1UG+3RnwCMQe/ZrevpuONFaF41CRe+ouypAdnYsINPnzd7mRHsi7IxOUoe/oCYk1D1uKmLPX1xJ9iogo2dr5/Si5L5Mfi2UVVQ1WPf8Dr4pHveO9jFkaWo0MSEvBKd7xkIOJn1k6e03Ncm7yIiuZHXRJz4mYBRqrfwbDDOvZcR7PBCIcbdQ9pTZrGdLABmrBChzwPxB0YGfyUBFfVP0GnTs6dstCnZY6yuxFGtn4rid5bzOURaboV8BczHmLXYc6Bf6GL8IYjXHOz90CN8CfjhwQFNFaclYccDyZuSZGVlnWM=
X-MS-Exchange-AntiSpam-MessageData: Ojr2aS53Wuask4YDOydbCCTkDixgMntYbUdDyhttVFP9YGMHrZoviBolCw3ONTVc+6zUKi/KxfpGp07cBd+19anEb8fvNefYVDGVKeidvf2QMv2WHVvfyAN2gYYAp7BH4OlkkXM9F5P2uxA+2T/E0Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473cc92b-8b86-4307-f916-08d7c19eef1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 07:21:05.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxVjqQku9oc8RPYTzJbjCsBUTLzvS2qzWcsQc1KUl0DmcrFR5+64x3EGu+NC31dfXYFc8KInIV7Ul9skrJuiiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/20 3:58 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 05, 2020 at 10:32:06AM -0800, Andi Kleen escreveu:
>> On Thu, Mar 05, 2020 at 12:27:55PM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Mar 05, 2020 at 06:47:19PM +0800, zhe.he@windriver.com escreveu:
>>>> From: He Zhe <zhe.he@windriver.com>
>>>>
>>>> NULL pointer may be passed to perf_cpu_map__cpu and then cause the
>>>> following crash.
>>>>
>>>> perf ftrace -G start_kernel ls
>>>> failed to set tracing filters
>>>> [  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
>>>>                sp 00000000ff937ae0 error 4 in perf[56630000+1b2000]
>>>> [  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 8d
>>>>                      76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 89
>>>>                      4d f4 31 c9 8b 45 08 8b9
>>>> Segmentation fault
>>> I'm not being able to repro this here, what is the tree you are using?
>> I believe that's the same bug that Jann Horn reported recently for perf trace.
>> I thought the patch for that went in.
> Ok, Zhe, that patch is at the end of this message, and it is in:
>
> [acme@five perf]$ git tag --contains cb71f7d43ece3d5a4f400f510c61b2ec7c9ce9a1 | grep ^v
> v5.6-rc1
> v5.6-rc2
> v5.6-rc3
> v5.6-rc4
> [acme@five perf]$
>
> Can you try with that?

Thanks, that does fix the issue I met.

BTW, my change in perf_cpu_map__cpu can be used as a preventive check
and the "1"  in perf_cpu_map__cpu should be "0", and assigning a NULL in
perf_evlist__exit makes the clearing complete. So are they worth a new patch?

Regards,
Zhe

>
> - Arnaldo
>
> commit cb71f7d43ece3d5a4f400f510c61b2ec7c9ce9a1
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Fri Jan 10 16:15:37 2020 +0100
>
>     libperf: Setup initial evlist::all_cpus value
>     
>     Jann Horn reported crash in perf ftrace because evlist::all_cpus isn't
>     initialized if there's evlist without events, which is the case for perf
>     ftrace.
>     
>     Adding initial initialization of evlist::all_cpus from given cpus,
>     regardless of events in the evlist.
>     
>     Fixes: 7736627b865d ("perf stat: Use affinity for closing file descriptors")
>     Reported-by: Jann Horn <jannh@google.com>
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>     Acked-by: Andi Kleen <ak@linux.intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Michael Petlan <mpetlan@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Link: http://lore.kernel.org/lkml/20200110151537.153012-1-jolsa@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index ae9e65aa2491..5b9f2ca50591 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -164,6 +164,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
>  		evlist->threads = perf_thread_map__get(threads);
>  	}
>  
> +	if (!evlist->all_cpus && cpus)
> +		evlist->all_cpus = perf_cpu_map__get(cpus);
> +
>  	perf_evlist__propagate_maps(evlist);
>  }
>  
>

