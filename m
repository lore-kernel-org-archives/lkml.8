Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3269C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1842415C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hXk7nHnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgDFO2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:28:32 -0400
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:6038
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbgDFO2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlMZQo8eR/4942sZRHdm3aafbwiRcaKstYINssQyxO+fXbTE6VFdhYZDZsfvIRCHbQaZqd+W0vfp/oAwVRFdo8adNrC3nUdzHqU0AAEsAJVRc0PmqZSGjWm8wC543VoBxnWLonMaWh5Quu8Krysq7lQFHcrDK0+EZrUaj0K8BDCuQ+ho7oKR2InX+9dzW8Dhs47//GjvGzXIlKKIVQX19WwDWw+CWOakfcvH7YkqzqByDKCEMJkFbtKn/qxd1Y+1YizoP0dB9fv2b6yD9k8iKH4wKfl15y7+Y0ib8zFYQWcQPc+wQNulJFRlGYcVQ9r1VJr83iNmxHvWDeF5Ub43qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/qoCkbnKHJCBgdMTa/2issKe/yDnSU1y8MvuHHNrRI=;
 b=mRQSMfQorliP2bODRO0Rpm4nnPudQqkVBibf1epJE7NQUluOlvmJl6d84R9jhFN/loD6PpOK6ompfhT1hDOi9oOJ6LfA4y1+6laeMhKJCMR4rkPCON3K7HIOdGRS2XUwE8YDqjGRT6uDn5PFDz60uMo8/U+QQOhGKFnfX1sqddcYTwn2mIJrcoeYXb0yM62MU9QW5OWDmVDAuE9ZlAYxqIkyKujkUdrHKeyEzmF/7nwYaRwqVZlsSN+kvKHqi4YCPJxjJK5TlRYxSVsPYX6BZih/HRFztBfmuQhm8XRVS4zjAIX8nkCsdYRnppo/2lqvRM8/A9MtM+wgV00vuVm2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/qoCkbnKHJCBgdMTa/2issKe/yDnSU1y8MvuHHNrRI=;
 b=hXk7nHnXwNtVJlh3G9Mfnb+ky/HokAUdg0Mk8QYEylxUDc8+6G4UwW4tEj3M2BGAUByWt/LbmGfdHcr/kcSlk7mIbrvyrgSE8XbtrUb1zGPESOH5UOHXDwtkOI8Y6/a6LdeLQY8FCATbvlyu7pJdneiz6DgokoAoDe1tkxCzOYs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 14:28:25 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::654c:5d93:fd49:88b3]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::654c:5d93:fd49:88b3%4]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 14:28:25 +0000
Subject: Re: [PATCH] perf script report: fix segfault when using DWARF mode
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <20200402125417.422232-1-agerstmayr@redhat.com>
 <6a098ce1-1981-dcff-ea62-af5fc07ec7fb@amd.com>
 <20200403124028.GA18559@kernel.org>
 <bf95c9f1-1970-fce4-c6f2-dc231730e7ab@redhat.com>
 <0a942366-c8dd-4767-ee84-fdc0024b035f@redhat.com>
 <20200406125915.GQ9917@kernel.org>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <f523cfca-5592-c1ea-ad5a-7603c967c0c5@amd.com>
Date:   Mon, 6 Apr 2020 09:28:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200406125915.GQ9917@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0040.namprd06.prod.outlook.com
 (2603:10b6:5:54::17) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (70.114.207.150) by DM6PR06CA0040.namprd06.prod.outlook.com (2603:10b6:5:54::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Mon, 6 Apr 2020 14:28:24 +0000
X-Originating-IP: [70.114.207.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65ed5fa8-ee3b-4e84-996e-08d7da36c436
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-Microsoft-Antispam-PRVS: <SN6PR12MB284618D9D7C5C1011B7D61B687C20@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(4326008)(31686004)(52116002)(2616005)(316002)(16526019)(956004)(7416002)(186003)(54906003)(86362001)(66556008)(5660300002)(8676002)(6486002)(81156014)(16576012)(81166006)(110136005)(2906002)(36756003)(53546011)(478600001)(31696002)(26005)(66476007)(44832011)(66946007)(8936002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0s10lmf6sx/NfXHxY+/JS6bdlbXuwV0fz9Zwz99VWxbqEitlaVUKmMQVv9/ToNBFtzc8Zjhs76rJUJ8QpMJ+lnKykvWBNNHfFVYffvuDaEDWNkghDmRCZf+yNC0TLyEfk/kzie7bUIEFM3LhSHrRheoomhEiaBTx9RKQjlJ0aGHhiD2+A1cMH1wTn5Gq+CZcUqq7mDAhTURxF7AUvt5a4WayOVX+QPX6nLTvCnErrg7+jlVI566QD8oXaJ9PhjGum6auofR6V6IfEu7j3HIABSAAh5qoF2l/Gwzl0d2bDdC/HXnRqvzY0MS9FZ63hkzf0ifvDrip9pP/8cYCdwMyuI9N5x4iQg7aDbtc5azkX8VRR09H6n8fkhsnaS0IS2VQa1SFBbcYlr6KsTPwvjSflzr/ktUi7WI5cG4RLS1f5Ts27zuwGr9Bc58XfrN2gD4
X-MS-Exchange-AntiSpam-MessageData: iz7jHaR9P6zSpXsqaezSzljPd1P7dN2UgMJPE8hflXqds5hw9uWA5OmPnznBPLA7qJ9oDXhk+nDJvc0pBGKXmEC88/f7A/UxTBmyKKZuSmqsfH5jySrfJGa1lnrfJXCnT+nwSPEPR8UE6zZYTClTvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ed5fa8-ee3b-4e84-996e-08d7da36c436
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 14:28:25.2745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mfaatiuuMo2aHT6bKeG1w2AIzLGxC9Js2XyMZVFRDYa/r48jHahCmidoqDjR8uLfh1hlct3/b/UC7Qj5VfrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 7:59 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 06, 2020 at 11:30:23AM +0200, Andreas Gerstmayr escreveu:
>> On 03.04.20 15:16, Andreas Gerstmayr wrote:
>>> On 03.04.20 14:40, Arnaldo Carvalho de Melo wrote:
>>>> Em Thu, Apr 02, 2020 at 02:07:51PM -0500, Kim Phillips escreveu:
>>>>> On 4/2/20 7:54 AM, Andreas Gerstmayr wrote:
>>>>>> When running perf script report with a Python script and a callgraph in
>>>>>> DWARF mode, intr_regs->regs can be 0 and therefore crashing
>>>>>> the regs_map
>>>>>> function.
>>>>>> Added a check for this condition (same check as in
>>>>>> builtin-script.c:595).
>>>>>> Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
>>>>> Tested-by: Kim Phillips <kim.phillips@amd.com>
>>>> Thanks, added this to that patch.
>>> Great, thanks!
>> Ah, I thought you were referring to my initial flamegraph.py perf script.
>> Is there anything I can do to get it merged?
> 
> I'll test it today, were there any Tested-by: or Reviewed-by: to that
> flamegraph.py?

I just added mine.

Kim
