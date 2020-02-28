Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4750C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C02469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mpfnNyH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1QYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:24:35 -0500
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:6183
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgB1QYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:24:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7QvNGdiEZVnWswDR1crr8Dx92AIBRaf1HJLjAVptm2alFI3caeFUmT2sOCBAoo3YR3Xa1WXiNp4spoj28PAqSXELzovsMKoclQWwA83XlI2GPtcAPInAPPx92jvhsQusif3e8rMILIqRAoTF643WrVTCF0LTXErA+CqTfwecdM5C0//ySwzDAmirxgK6zOJBzrIq3Q8IVW7bAmWL1ucuTm+6QyyLGJ00sxfjrYWCqirzXG0tumCjcwFOkfSJhNwUybQZm3sM5jzNFKJ0Us0cAbZWI9I6tcJMkY8EYZLePrDI6IFDAAWJ7TDxrN3/8cG55t3DYlfNAtDub2B+40Xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teqrggq7Dg9SZDKnxbigLMQL23p2YqrY+PNN2zQpAhU=;
 b=msNW04gFui0JoOJSFCSEIv693I+btxe+00DmmRnC44go6fSYZSgNca1bY2y5RbjmCeQ2fsw53FYpOKYOHPfxe0gxm3CEAhNH2KMYRg665bPSELhg7mFqcWmPPE9uXgYO4ndVNRadsySGjzjtXKbVyufJdyVqIeyqk2nHUXfJSyM8IwA5Ow5LSrStSU87gxmqDV/5duFPfkJlR7CeBEtEwg/s4TXn1hhWbTLXP2GQJDfr8UxP5fDopKH/ZrQuIq2cgB4+MOF5nEAcdXzSLSYDB6vEEuFaWKMKV0dqdm/1ISX2AISekxLlmeXUMHEuMzJONU82qPoLTIIjOY/4PWg5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teqrggq7Dg9SZDKnxbigLMQL23p2YqrY+PNN2zQpAhU=;
 b=mpfnNyH8gtKVg0pMXMh54Ieb0GdvPhcSFmVuhIUVI0M/GzfGPsVY94HYN0MIdxF+Z6STdTfLeSiTpuz7jhbgbKAlfSMlqD50ic7gw2JBAijrxcCiBpF0+4Wti6zlwieNC/YDkqadTs/G/mhbBnknhqn7uI07pBgIZoiN9I80Xig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Fri, 28 Feb
 2020 16:24:32 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 16:24:32 +0000
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
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
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
 <20200228160045.GA23708@shwetrath.localdomain>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <f7dba82f-beac-2669-c7e7-5a85edc2798d@amd.com>
Date:   Fri, 28 Feb 2020 10:24:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200228160045.GA23708@shwetrath.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::17) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.247] (165.204.77.1) by DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16 via Frontend Transport; Fri, 28 Feb 2020 16:24:31 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adf5be8a-de93-4eda-f083-08d7bc6ab10c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:|SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2655D2992B49ADE6F77B0EA887E80@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0327618309
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(478600001)(8676002)(53546011)(6486002)(2616005)(956004)(7416002)(186003)(31686004)(16526019)(81166006)(8936002)(81156014)(6916009)(26005)(16576012)(2906002)(66556008)(66476007)(66946007)(5660300002)(86362001)(31696002)(52116002)(54906003)(316002)(36756003)(4326008)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2655;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywUyta0bGCusxz1op/YW05QvtmnjpX9pdH3Cuo4wEpLk7VYN/ssmEYQLh0DAwqkg/Jtd3FFLrgtYnrWE34zXLdrkOG/qilke7/bO+DNyEmMwvbOXtRInTysQRMAQ8WnNGDzgxCdwhOwBBugSbJ9hNYFBsoaYPself7eeLoazJu9XrG7ucMFEbLJtO1Z+L0Wu8fp8tKJRHrcBXSGNBpE5sBiRjJrFDvQtP5e9oWyYr7qHviPNgw3DB//i9vvKIzdCvjeKxpIPSKZonTCvjY2AKN6N02eJ6RY/jMOUdaiZBFMDfnj7qYs2Vihutdw04meiE/NTnw7lj//Nc7LTCvKC4dScNblsnql8XM3h0OKTGKOg+EKjKulNtyw7+sDocKLOiouK8lNBAxpO0+sAdgngjHgReNkpbEfVCyJyuU7U+hEWlqwChkN0MPxmLKb2HM9b
X-MS-Exchange-AntiSpam-MessageData: SYO6ng+ZffeXAMCnIb7XzqNvvArbFw9vzQeCdP0bxtM0lKgvbavzRylR2T+8CCvTuo0+Gxc65/j6pxEss0qFl80maxLBj1pCHv9/tFU4YcdxEZZb2AAHCa7FHPpMRw0AJMru+1TIVBPEznyCxLg3HQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf5be8a-de93-4eda-f083-08d7bc6ab10c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2020 16:24:32.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWO+8KJw5Z7kMqpbAzbyFkNvWC4+bmWnGZhswT3/MmY+4qEyFIZm+YSvQ4K3f14pdMsJAnqd4rsB5p+Ov+mlfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 10:00 AM, Vijay Thakkar wrote:
>>> +  {
>>> +    "EventName": "ls_pref_instr_disp.prefetch_nta",
>>> +    "EventCode": "0x4b",
>>> +    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
>>> +    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
>>> +    "UMask": "0x4"
>>> +  },
>>> +  {
>>> +    "EventName": "ls_pref_instr_disp.store_prefetch_w",
>>> +    "EventCode": "0x4b",
>>> +    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
>>> +    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
>>> +    "UMask": "0x2"
>>> +  },
>>> +  {
>>> +    "EventName": "ls_pref_instr_disp.load_prefetch_w",
>>> +    "EventCode": "0x4b",
>>> +    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
>>> +    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
>>> +    "UMask": "0x1"
>>> +  },
> These three are present in the PPR for model 71h (56176 Rev 3.06 - Jul
> 17, 2019) but are missing from the PPR for model 31h (55803 Rev 0.54 -
> Sep 12, 2019). Not sure what to do about it. 

They're producing nonzero counts on my model 31h, so leave them in?

> Similarly, PMC 0x0AF - Dispatch Resource Stall Cycles 0 only has one
> subcounter in the model 31h PPR, whereas the PPR for 71h is the one that
> contains the eight subcounters we see in the mainline right now.

I'm getting nonzero values on my model 31h for that event's
various unit masks, too.

> There could be more subtle differences like these, since I have not
> really compared the PPR versions that thoroughly. I was going with the
> assumption that since both are for SoCs based on the Zen2, they would
> have identical events. 

I think that's a reasonable assumption.

> Otherwise, I have made all the other changes and corrections, and will
> send in v3 after you suggest how to proceed about the above two.

Thanks, I'd veer toward making them available despite differences in PPR
versions.

Thanks,

Kim
