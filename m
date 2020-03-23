Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14179C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D049720719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AGLHkMTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCWUum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:50:42 -0400
Received: from mail-eopbgr760045.outbound.protection.outlook.com ([40.107.76.45]:28774
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbgCWUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+vKHg/3USazNzFeG1fTraU0AM2Zig5wMJblKrBDjy0vSko6ENyf8oFQ6bk7ezI4xdPwKEWXinp7FrmVhc/uyQ+1xHE4D+AsAx3vNdj8EBGaVoNwC7Z9OeCmKzmx5g/BtMtahjdvbU3pj/rFMAz2PEZlCgZVckUOmjfkdls8YJzce/d5+MoAKA+9R+vUw4Nf6RfbRql9/QnwyUFcQdh7Eo/syWCUiJFDfCSyesjKc7kED4S1k0Npdl8+v8fQD26xMc24RQdWSMGV3NmnrD90r1NyzKQYTX5wFOwP3Lndl3XTiAUACqMmHYh3SBCveXVEv4rRbYmEU1LWB3Nj0r2tcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9v2qgmivuqfi5CoYRW9GhCB8sNLzS7baL2fefKsMtU=;
 b=NoIEJ7aWj4520Hc0p3wbaIe6NktjXI0PS/Dfc/rMF3b1FqYTC96ZLKX1Jbkf+xc+FIALlRYIpkFu0f7Rz/vOUyk50uq0dvttMIbCVdqXXxjKkV7tClKbPmk25+8H9oMXLFM3HObEI1WvWyXAdCDd1aC5kaec0A4DneKd1vp7D2ayo3ANBazjLa4Sm1yvgZS8fgR/cHl0xdze77f+WSviebN9f4JvLRDMMm0rMk8VWZewupACqPzrS0kYmsK4q3rbXcvuOtu4W2MKOXhYo4sYArwnLtbnSU526bPltk3nNC5C7h2g94sEgE4Qm47qBNfetjuwXjiaA5BR33Zpf8m8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9v2qgmivuqfi5CoYRW9GhCB8sNLzS7baL2fefKsMtU=;
 b=AGLHkMTBFVNmfQHkcX3c9PMYcp2lOF41E0dB6XUHIOMUd9HM9WrkTGHsH85ZqTH01SNI0rv/GemkrVY+upJsYSCqP9UCY7IB5Zvmm4tLK2mpaoOGskWjmhfIo2qgBQzSLA8EE7cAtzpLE9+1JBHPxfW0tWe+Uj1P1ChrKMU0uF0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 20:50:37 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 20:50:37 +0000
Subject: Re: [PATCH 1/3 v2] perf/amd/uncore: Prepare L3 thread mask code for
 Family 19h support
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
 <2581de5a-969b-93c7-0565-2eef51717900@amd.com>
 <20200318204257.GL20730@hirez.programming.kicks-ass.net>
 <CABPqkBQn7VRWQu-JU9BfE8y3g_uqhKEtN6GYuVuKs6QTGPHzgw@mail.gmail.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <a78c303e-c988-20e0-9e30-6fdc63d5d75f@amd.com>
Date:   Mon, 23 Mar 2020 15:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <CABPqkBQn7VRWQu-JU9BfE8y3g_uqhKEtN6GYuVuKs6QTGPHzgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR14CA0017.namprd14.prod.outlook.com
 (2603:10b6:404:79::27) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.6.146] (165.204.84.11) by BN6PR14CA0017.namprd14.prod.outlook.com (2603:10b6:404:79::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 20:50:34 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9eb38649-e050-4888-955e-08d7cf6bd6c4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2767F3E908A8217D67B304E987F00@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(8676002)(36756003)(53546011)(66556008)(66476007)(66946007)(4326008)(6486002)(8936002)(54906003)(16576012)(478600001)(110136005)(2906002)(956004)(2616005)(81156014)(81166006)(52116002)(5660300002)(31686004)(316002)(16526019)(7416002)(26005)(186003)(44832011)(31696002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2767;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfBpzwoEIRT8zucO8QqZcIwbqJL35XH2uphodys3NZxqwUJvT91L3pLIpcG4KcmGYmPN8jFRHEvam2n/O8c9KWeJkbw3/N0YwOQOWXaCYuz2ZPNtsvN5HPcu8VgaE63C1fw59i0wSK3bYmVStyxqyQoLk45AL2q9sV+cO6OLuIXSM240sOV89yqXL8WUfnwEsgRoKvnNrR1F4z4PhO+2FHQI9YSBDsqqrU+iACF5Lk+/dBvhUDEOcSA9tVF2IX7wBwzwZm2pYpqxCIoPrhMjFcBFHMd7lYKz9oXjbcLYzuZMjd8Sf4oAWkFvMQb4VG5pmdzcXwleXSUVdrah04scZHdMdm/lm6inc2g+ENj7ZBTZHbFCBP/+MhrSYu40DrRYfaLu119q6DNHui6Y279W8FmpjhGI667NuFubLzknAMM1NK67eLbHkpfqjwmfTOMr
X-MS-Exchange-AntiSpam-MessageData: lSD2POAbdd8PZYS1GxugFVfmg7iNnUuevW//F58kKNuvK8BvsIqS+3n+6N6JJx9alZN+29MCtGS4+hfUzINkOwKCmP8Wawgmk51T+Nuv+tNBH+bWkilPznsz08/4frZsNVOEfp+Ay9foT4XL7xeFSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb38649-e050-4888-955e-08d7cf6bd6c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 20:50:36.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRhpRX4MI1ApV125SbHQ7alWxanmpin1G/cjY0eGYrO+JTjiShoVgVmaQ16SNeXGRJpTFjTvzBm8OzR/CZa+kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 4:26 PM, Stephane Eranian wrote:
> On Wed, Mar 18, 2020 at 1:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Mar 18, 2020 at 09:46:41AM -0500, Kim Phillips wrote:
>>
>>>> But this does not work with the cpumask programmed for the amd_l3 PMU. This mask
>>>> shows, as it should, one CPU/CCX. So that means that when I do:
>>>>
>>>> $ perf stat -a amd_l3/event=llc_event/
>>>>
>>>> This only collects on the CPUs listed in the cpumask: 0,4,8,12 ....
>>>> That means that L3 events generated by the other CPUs on the CCX are
>>>> not monitored.
>>>> I can easily see the problem by pinning a memory bound program to
>>>> CPU64, for instance.
>>>
>>> Right, the higher level code calls the driver with a single cpu==0
>>> call if the perf tool is invoked with a simple -a style system-wide.
> 
> No, it does not.
> 
> With -a, when -C is not passed, the perf tool picks up the cpumask for
> the PMU from sysfs:
> $ cat /proc/sys/devices/amd_l3/cpumask
> 
> You can easily verify this by running: strace -etrace=perf_event_open
> perf stat -a -e amd_l3/event=0x00/.
> This is the default common mode.

What I meant was that with -a, the driver only gets called with the
'base' cpu for each L3 PMU domain, i.e., 0, 4, 8, and so on.  With -C, it
gets called with all the CPUs the user specifies: these are different
behaviours, and the driver can't tell the difference between e.g., -a
or -C 0,4,8, etc.

> The problem is that here to get any meaningful result, you need to force a -C.
> The CPU in the cpumask is just the CPU to which to attach the event in
> order to access the correct uncore PMU.
> Here, you have one CPU per CCX which is expected and perfectly fine.
> 
> The thread_mask is a hardware filter on the uncore L3 PMU. If you set
> by default the thread_mask to 0xff, then
> you obtain a full system view with a simple -a, or per socket with
> --per-socket. So we need to find a way to
> make this common case work properly first. Expecting the users to know

OK, I'll send a patch to revert the thread filter feature until the above
issue is addressed.

> that for some amd_l3 events you need
> to force -C 0-255 is not practical. I also think that forcing the
> cpumask to 0-255 is not right solution. This is not how
> this is done for any other uncore PMU I know of and some do have the
> thread filter, such as the Skylake CHA.

Odd, the Intel uncore driver's cpumask is 0, so not sure if AMD's
is right to set it any more...

Thanks,

Kim

>>> If the tool is invoked with supplemental switches to -a, like -C 0-255,
>>> and -A, the driver gets called multiple times with all the unique cpu
>>> values.  The latter is the expected invocation style when measuring
>>> a benchmark pinned on a subset of cpus, i.e., when evaluating
>>> the driver, and is the more deterministic behaviour for the driver
>>> to have, given it cannot tell the difference otherwise.
>>
>> That seems to suggest it is all horribly broken.
