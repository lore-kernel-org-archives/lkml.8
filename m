Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32DC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D994B20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1KhlpTKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCROrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:47:03 -0400
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:23970
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbgCROrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:47:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqepIqFN/djyiPwzYpC0okwIsk3PIsjVn7voj1bL6zZXtnL5BVXExB3s866p92nXc043NIfincjfoiKLDgQZe/LiAsnhfzxihMfund/eIYTus9f14vUAya0IfS3l3Kue9VwZHhEtcaoyNEqxhfu88Gn7kPwyfHd0BqFCrsumuMzBDl7Naa7T3flRoTvprNWItNqLhIpYKvJ0CahpUTOId6gGZIMvjEanlOGefKX7v+81NmNeunl6slQifObd+lcO5InFwRk2J89EbSTO8R7E1lbU8imzgv1FXre+BOmh3RvVojtkI1j6E541SAWHAQ567INyJfdbCpDLGAkqdOrM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvr6OAr/geSp0/Lid69jKcW5IPAKeNaBTjCaBLjtcls=;
 b=XUvoyjt+EIhCYtCfTa0W9hSwarrfb8mZxd52SeLGzcdvIB2OOQW2sv0pyXFT84AnvJCBPI8np6aw8BxMPanw4HbGcHiuNQTfS+lJEjCXkJBxDYv3eCQNpJ4qyj+6hMkvHMMctpcYzPOQZ/aU8lWdqw8qOjzwjZGKGF1XjwLIt5aolLPDb+KI3vExNfSGZMyZiDDaI8bJQCfUaVhBt/zj69wafmLUxTW6AXVAO+vV5gaAxv1iO1qwpC8E549ymcHy/kVPB1BSRt0cvcfmZc/jfbzyEa9sPoHJJYKx6JCqKjp6hgR5EBUz0V0ZTkQlvzfqzv38SdtM89gFVjRIw/r5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvr6OAr/geSp0/Lid69jKcW5IPAKeNaBTjCaBLjtcls=;
 b=1KhlpTKgpwNSgFXwHGmiOoofgmIZ6sNv1oPu0gpxf6mNByXWyzMc+RQor/e/aOFfRbzO4bgD3RTuJyJGPA6RleHyJLULQMrb0tIOeCI3Dk36R0jz+XjqHEZdlCbmax8qaPtPmAWeRGTqB50QqBVvFnl5Kllu2KI/q0tAQ34HPDQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2736.namprd12.prod.outlook.com (2603:10b6:805:75::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19; Wed, 18 Mar
 2020 14:46:58 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2814.019; Wed, 18 Mar 2020
 14:46:58 +0000
From:   Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 1/3 v2] perf/amd/uncore: Prepare L3 thread mask code for
 Family 19h support
To:     Stephane Eranian <eranian@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20200313231024.17601-1-kim.phillips@amd.com>
 <CABPqkBS8TUMTEz_motpd+8xK599tLXAonUHwp-CWMyU2RhcbQg@mail.gmail.com>
Message-ID: <2581de5a-969b-93c7-0565-2eef51717900@amd.com>
Date:   Wed, 18 Mar 2020 09:46:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CABPqkBS8TUMTEz_motpd+8xK599tLXAonUHwp-CWMyU2RhcbQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:408:70::38) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.3.58] (165.204.84.11) by BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 14:46:55 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9acf920b-eb95-44bb-ef80-08d7cb4b35e9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2736:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2736FC97135D9F7F5320C37587F70@SN6PR12MB2736.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(6666004)(26005)(186003)(7416002)(36756003)(5660300002)(31696002)(86362001)(31686004)(16526019)(956004)(2616005)(8936002)(6916009)(66476007)(66556008)(66946007)(2906002)(478600001)(316002)(53546011)(4326008)(54906003)(52116002)(44832011)(81156014)(8676002)(81166006)(16576012)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2736;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRyI8PugDy0WTYo0avAi0fEFWkca7c0Ek1xF0btQeaJ9ONybLjofnicOp9yMTzoyEZBSvVywbkKSqUsDS2lBpC3JfqdLz/1CiiKsPNq2PmDoAQhoebyXyjsbVCY+PueXksK7Swi07Wy0STwJ4W478jWf5oBRJsU1sFqF8UDZrM8adN6X94FyKxsRboK4E48PmpB6ueOhzjXVncP9FjLyu7BLSbpPcpP4O+7juNdgtrfjRQoG+IryviHZCzXTgkC8G1FjkNdpPQwyccmkI0uW8M8vpa5hCM0WuVWNZI5ThlafWvW5JvnEbDykNd11Geq/bF63B9z+I0UGiUWW3F5KGT+r9LA2dqvaMv8frlRL4FK9CpfhpAFHMCTHCMRcq/0nABqw/Qh/e80rsC5MSlRAhGWj+N2EOouD6cGhBQ+CRSIP20WUEscCfdpantAtg/xQ
X-MS-Exchange-AntiSpam-MessageData: maPHHt2CfI0bRjGF65mJpXbb7EPOv8o76FvdyWMVXRhilsQTRX/+yeHGGsWIVLkpdbT69Ivuv7YTNPeyUQqsFjOR5OuPQnSz4Z3K5HyXS9hjRR259WZ3TgzGvSmCZU4OmBkqP3FOa1nc2L7AMNVFQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acf920b-eb95-44bb-ef80-08d7cb4b35e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 14:46:58.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHxFXpkQf/J6DRv4j4Zg9r+awIqOEACUTfSPWvauJUYYAjhgM3LDmAdAUZUcCX+Prc/j3Oql82zj5gFON3h8Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 9:09 PM, Stephane Eranian wrote:
> On Fri, Mar 13, 2020 at 4:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
>> +++ b/arch/x86/events/amd/uncore.c
>> @@ -180,6 +180,20 @@ static void amd_uncore_del(struct perf_event *event, int flags)
>>         hwc->idx = -1;
>>  }
>>
>> +/*
>> + * Convert logical cpu number to L3 PMC Config ThreadMask format
>> + */
>> +static u64 l3_thread_slice_mask(int cpu)
>> +{
>> +       int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
>> +
>> +       if (smp_num_siblings > 1)
>> +               thread += cpu_data(cpu).apicid & 1;
>> +
>> +       return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
>> +               AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
>> +}
>> +
>>  static int amd_uncore_event_init(struct perf_event *event)
>>  {
>>         struct amd_uncore *uncore;
>> @@ -209,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
>>          * SliceMask and ThreadMask need to be set for certain L3 events in
>>          * Family 17h. For other events, the two fields do not affect the count.
>>          */
>> -       if (l3_mask && is_llc_event(event)) {
>> -               int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
>> -
>> -               if (smp_num_siblings > 1)
>> -                       thread += cpu_data(event->cpu).apicid & 1;
>> -
>> -               hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
>> -                               AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
>> -       }
>> +       if (l3_mask && is_llc_event(event))
>> +               hwc->config |= l3_thread_slice_mask(event->cpu);
>>
> By looking at this code, I realized that even on Zen2 this is wrong.
> It does not work well.
> You are basically saying that the L3 event is tied to the CPU the
> event is programmed to.
> But this does not work with the cpumask programmed for the amd_l3 PMU. This mask
> shows, as it should, one CPU/CCX. So that means that when I do:
> 
> $ perf stat -a amd_l3/event=llc_event/
> 
> This only collects on the CPUs listed in the cpumask: 0,4,8,12 ....
> That means that L3 events generated by the other CPUs on the CCX are
> not monitored.
> I can easily see the problem by pinning a memory bound program to
> CPU64, for instance.

Right, the higher level code calls the driver with a single cpu==0
call if the perf tool is invoked with a simple -a style system-wide.
If the tool is invoked with supplemental switches to -a, like -C 0-255,
and -A, the driver gets called multiple times with all the unique cpu
values.  The latter is the expected invocation style when measuring
a benchmark pinned on a subset of cpus, i.e., when evaluating
the driver, and is the more deterministic behaviour for the driver
to have, given it cannot tell the difference otherwise.

> I think the thread mask should be exposed to the user. If not
> specified, then set the mask to
> cover all CPUs of the CCX. That way you can pick and choose what you
> want. And with one event/CCX
> you can monitor  for all CPUs. I can send a patch that does that.

Do you mean something that will allow the user to do something
like this?:

perf stat -a amd_l3/event=llc_event,core=X,thread_mask={1,2,3}/

Wouldn't users rather specify cpus using -C etc.?

> With what you have now, you have to force the list of CPUs with -C to
> work around
> the cpumask. And forcing the cpumask to 0-255 does not make sense because not
> all L3 events necessarily need the L3 mask, so you don't want to program them on
> all CPUs especially with 8 cpus/CCX and only 6 counters.

Is it not possible for those to be run in separate invocations
that use the simple system-wide case, e.g., -a?

How would adding core=X,thread_mask={1,2,3} specification
change the -C invocation behaviour?

I thought of having the driver set all CPUs in the threadmask
if invoked with a cpu == 0, but that means one cannot specify
-C 0,4,8, etc.

Thanks,

Kim
