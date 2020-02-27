Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C462C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C05246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fw8G9blv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgB0VUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:20:35 -0500
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:50528
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgB0VUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:20:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlIdeu/pFMqznDJdqPM5er7sxeCT9Dw0bpsSfy9Z0yomfV73etaVM/LH/JErl2jkVzpP0ikyJ22Q3LksryIh+z8rvTN7vWgS3VSjQONL3nVHGe1siRUNsp+LdZVxPVLC6JN58uLcYCuofLxj+9rGVRO5v7/AEnSI7syGOA6r3cb/cuc+64j5FmLExukMwZCKKl9QMNj9JvdDI7E4iQEyUYmFTfFwGyE6+c7FTijELMZglcetpH3502vvxShhpLxauK+Y8WzidI1k72OJZLfjkr0SRbLOBszvSDeT4xQHsuYr7AwHSUc/C9jmcIOAN8kf2PeRz01jVP8Gq1esQcGrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlDBZ30+Y+4Xx/9wGB+v2LKRo+M4teDHIA4JAHgThJs=;
 b=ODIeqcyrAcPd+NJcQRDJeUP+ADvr3tuP6armEoRma3STCgRJoAwJvvIQoeS6dAx5wl8hpFCyJUCHe9g/ikRoHpUETTLsL+mY0st281GpRLADuoSWjq8hVgF1BrfOCAJeDI49rj0mzUtewyrDbbz0TH4+Bpq2VdKq77+3GmUaIRGTEOqI8RA7RvPjTUWpftwTtDf9DaxtFp6D8QFN8lo/5BP4EgVSxh5H6fnLujPiggdwgyuHI9P7g+O0bgHh06e60Hfjgoutf3LxU1JyKWnDL8duNGexilg5ocwvHN6lC2G3ggAw7oL9uopjXsKazvwWjNHb8wh7OvpnHxIrumd5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlDBZ30+Y+4Xx/9wGB+v2LKRo+M4teDHIA4JAHgThJs=;
 b=Fw8G9blvILlYSCtlOD4MSjnVS9ZFu8UXQubUEbx7hN+3aZgKXrfiaoVaOCtUYhCB+XNBBzU4GUR4TDzFyJ0wdVuDIevx/BjFgg4sxsEwZyWl8GmsQthauIBUqGwDg46l1DCBpPgHinyG97CgCvxRhHK2AXPeySUYqT7LUZ3J1Wc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 21:20:30 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 21:20:30 +0000
Subject: Re: [PATCH v2 3/3] perf vendor events amd: update Zen1 events to V2
To:     Vijay Thakkar <vijaythakkar@me.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-4-vijaythakkar@me.com>
 <73b5b731-9597-1243-485a-788437500c7a@amd.com>
 <20200227200026.GA8493@shwetrath.localdomain>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <164d3a93-c607-2bd4-c9a3-dc4d8b275d42@amd.com>
Date:   Thu, 27 Feb 2020 15:20:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200227200026.GA8493@shwetrath.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0040.namprd05.prod.outlook.com
 (2603:10b6:803:41::17) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.247] (165.204.77.1) by SN4PR0501CA0040.namprd05.prod.outlook.com (2603:10b6:803:41::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Thu, 27 Feb 2020 21:20:30 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17e0c052-012c-48fe-e5f6-08d7bbcadf86
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:|SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26887BD762F9B5467F5A243F87EB0@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(956004)(52116002)(54906003)(2616005)(6916009)(44832011)(66476007)(66946007)(31686004)(66556008)(53546011)(5660300002)(2906002)(966005)(86362001)(4326008)(31696002)(36756003)(478600001)(81156014)(7416002)(186003)(16526019)(8676002)(316002)(6486002)(16576012)(26005)(8936002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6/zwTAd6khStm7YJvOn2j8CoFBSKSEv3lKRXLPf/EM5RKxdsrgej8EDWaj3a8AvC77Cn5Ticr3OGfHy/HK6dEEstr7Dlx5G0VQwntcBB3agfUQyHbsjAKUk148Y3bVG6Bcabf6guJ0iVvFxx2gvJt76xNW2llPGM/i2EK1ybUHiMzaD2eN1PlT85WkUzuYXoNg8xCWmszTHgTauzAa+a4WXN5DKCToi3w1qCcnEdzT53F7r4VU/mM9mgm0/Ek8ed2pJIpF6EFNuPxpVwvrcKnwvsyo7VL2PWKmoZs0Yc73VxWDnJO94yRHCmGA2EE4uiPzqHYQECLeRcd11QABh2Uz9FD0/fq/SLZjaOlHtUm56UsnlHecMofK9sKlRt59qQMPDNRq/TWM0Po8kMItOj4mxbPbSkvJBoW3ZgDYDvaPZtFnY7tq8v1yCi1mHGLvkxihsTRXWTOTDWwggJx10e+2RYvaZrYKuF9BSqHEBlwhUawew33uvXhz4km5F9EG6U0ha8YFZJURz87nVOl1Yaw==
X-MS-Exchange-AntiSpam-MessageData: 4qYdMT5KLVRzccxKz9ZczAUzlpWEj+0vm3QbyLiHL/kIgGcSbAQFdwGvmJiCRbpZU6lIam44AfeAx963+riGCpkCBaT3IvbLJEz8UVNLNbWE4i0kWRqhxqstMJk3bdNsYzFwZHhxyPGKojmKXsMB8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0c052-012c-48fe-e5f6-08d7bbcadf86
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 21:20:30.6341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8ALZPtbX5solri4qGDXM0bTpjIV34wQWsdZTPmROk5z4NVEyilIv6liBadP4gVV27MA6/dBrbZdhA5gR4Cz6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 2:00 PM, Vijay Thakkar wrote:
>> OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018
> I have included this for v3 that I will submit later, including all the
> changes for the FPU counters. Sorry, I messed up copy-pasting the text
> and forgot to change the trailing pipe number.

Please also look at addressing the review comments for patch 2 of 3.

>> and their counts don't seem to match up very well when running
>> various workloads.  The microarchitecture is likely to have changed
>> in this area from families prior to 17h, so a MAB alloc can likely
>> count different events than what is presumed here: a Data cache
>> load/store/prefetch miss.
>>
>> I think it's safer to just leave the PPR text "LS MAB Allocates
>> by Type" as-is, instead of assuming they are L1 load/store misses.
>> What do you think?
> 
> I did some checking accross PPRs, and this counter seems to have changed
> names multiple times throughout the PPR revisions. 
> 
> Zen1 PPR (54945 Rev 1.14 - April 15, 2017) lists counter called "LsMabAllocPipe"
> with 5 subcounters that have different names compared to ones we see in
> the mainline right now. PPRs for stepping B2
> onwards change this to the 3 sub-counter and primary counter name
> we see right now. This public description still changes accross various
> PPR revisions, which is why I had this set to what it was. The lastest
> PPR I can find is indeed lists it as "LS MAB Allocates by Type";
> I will change it to that with the fuffix of tehe sub-counter name. Since
> the same counter is in Zen2 as well, I will make the same changes there
> too.

Thanks, yes, and if you look at the Software Optimization Guide that I
just added to the bugzilla [1], Figure 7 "Load-Store Unit" on page 40
shows a MAB block separate from the Data Cache block.

Kim

[1] https://bugzilla.kernel.org/show_bug.cgi?id=206537
