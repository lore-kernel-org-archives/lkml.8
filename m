Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209DC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B320716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ngCqnQ4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgICS1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:27:13 -0400
Received: from mail-bn8nam08on2081.outbound.protection.outlook.com ([40.107.100.81]:20769
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbgICS1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIYarHYgc4I8jYTmtXnfvKRuRFnvDpnLvxYXgRUJI9zoGHrbM/TQ+iYewBnUA9K+kqWsXvg4FimK8ugc275luj8UsC8eon4gM/4oIzG270sTUl426x2M/eksnD/hsKXwbtI6RqesIQydQhpxXjbo4UwYa1EIhdBwWUMLCmzDeXPC6yIWJKFtY2AXlSiPEwI4fKWLVEfCLWbVaWLfDLSv7OzSXLKSZL0Hj3BIsmon6Kn72bunsWpjN+GbH4Q7NPCB3GLgQPXEypAV31m5jfrdbPwdQx75ywrGdjlsiROSshqwjSrc0rXBU7+ntmzwNxljt4PqcwwhZ31m4j1kSSvu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDM+k9rR/4+t5cz6TEAD5cQ5cocM9g9KBWe/1Xe00o0=;
 b=iKwZach0w24ijuEUqhGfclT2ubAd0Y/Nr6QAESqmyPjl1PGKT/ab3WjcsNppMhCpH7pQGf3uvVYqUnjDXENbSV6zzILDS5K9BMaRK6p2fsBtSJ/dNohEjyDryiKCDf+YHZ7klrpoR5rgUedE/KjT3DxkGUA2MXkXbPjP2F58/KP0JsDhSrzPEgKzlf1EV1smxhIizkf2bEcx8wgPgSRzWkjEO/p3X7aPf+REPR6bLC/id6+xM9gvUKhFJ2VUpl+LAMRQ+wOxR858dM7WUkWzY7d3pmR0zydu9GcdsGavJh8VdLgJiSn0rupv2rwI72DX9KJW7KmOeuj/hdidnBlaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDM+k9rR/4+t5cz6TEAD5cQ5cocM9g9KBWe/1Xe00o0=;
 b=ngCqnQ4SRy7l9WPOxhZDa15RakBLKQpZLMBonibvd0S5hPdNGILsC+8K7yhUSdxpekGkcmiqoYYFXup00IKtaabxtHN8OHKQU3fAH3PsO9LyYSUstJtTNy6LrSH8ikbvR9HzjbU/hG9sCA4qifE10/hUo3azZWPtppSCJhoTxRU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB3220.namprd12.prod.outlook.com (2603:10b6:408:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 18:27:02 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 18:27:02 +0000
Subject: Re: [PATCH 3/4] perf vendor events amd: Add recommended events
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200901220944.277505-1-kim.phillips@amd.com>
 <20200901220944.277505-3-kim.phillips@amd.com>
 <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <7a0b893d-8f65-6423-3818-5dafc880dca1@amd.com>
Date:   Thu, 3 Sep 2020 13:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0104.namprd12.prod.outlook.com
 (2603:10b6:802:21::39) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN1PR12CA0104.namprd12.prod.outlook.com (2603:10b6:802:21::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 18:27:00 +0000
X-Originating-IP: [70.114.200.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac98c11f-372c-4ddc-b929-08d85036f39f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB32203EDDA89327BF949C30C5872C0@BN8PR12MB3220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uy54WwDruELvjubcr7UxbBsJseyIqkeTuC8GDR96pdeVdhTwzcyLUV/fSlmpU3SodDqlccTA7FzamQ/Y0l/rOXdTp+1+6IWzPo6sgMxe4o8ai6IS3xsR5pHlSsdioKFFB+V0PGBHwbcbtGf8b3wOtc1ExjbJn97sRKR6+43J9Ek9lEtieQr2l8M8ciAKf1EZq0nHcB3cEgqCFlDfz6cTAWrTGWbChCyww5n8CureF4iLqgZ11zQVe+uJe5xPeWBmk4D9MPpgGLZx87hvqrJC5AA8j9Ypc5GJfDDP9rxuPnHyEZh0f7/0gr53aUOGWGDVRQTy3TYBl5nf6k2nOot9SSEmhdff7Bw5SEJdA25Yv5Xkm0Xx+z7ZeRN/o66Ahxij
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(4744005)(31696002)(52116002)(4326008)(6486002)(16576012)(36756003)(478600001)(54906003)(44832011)(8676002)(6916009)(316002)(31686004)(2906002)(86362001)(66556008)(53546011)(26005)(66476007)(5660300002)(8936002)(2616005)(956004)(186003)(66946007)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0l5TMJ+KMhh6lS98QC4eR1DdLeiqX81uESA7bB9d577Sglnf8WlxgwydJQvYRzmiRO1V9sLsDGBX35bL2r+97+mecXJMw/g+4rZLN7hqIwofSogWRbxVGk/v6neLvSUPa0/sN+bxaE7m6JfWJ/tMSiWe5QhZgXr2+Hf4I+1xQUcLglqBpSwoOHAHnZXAbHGz7xu9fU7fUIg1gkIgC+tIPZeXKoP7bas0BKCAM43fquLOdTILbl/ukRJgEs0kGKE61qgBuEMf8yiXS6pzOY061fvxQd2ktx9XyNCxA2mFVZ+xLL+KKCYuQDQGRtXYdAF9x+jk7jkj5UynFkAE82znLSjD45v6jiPuSMrIpIzLDxlN2xEFVMxGR9DnXsIWShYH96QtiOcBJaYPW1g2E5PNfieTzAAhIxxo2liMxDB1+Ysxq0R9t8o/gyuTMwWchJ8v1uQOFfKPF10gnkyZB80R7i2RCSiOxWVpuGO9SfXUO9QaeCRTjKgafLzgbBugmssCrvEQ6Z07jKqoD/ZBYE2DZ5RIKhVE3SgAwd44iOzpMxX8PL3QuiObFyRfuLg5QpcEgIRYtfhCNofFbipQ+l900EId0t/+CmpyXxdYnveC1YQbaArII1vfQMz70KZH8/xM9YSoxAfuV9CVNPsvhWIPYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac98c11f-372c-4ddc-b929-08d85036f39f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 18:27:02.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AewgHEH7rONib5Lz48kUjOlGb605QcB51xd9HxkuISam4efVg0gIftSOYTyApAXJpm+h+fUQuGu3HyUyM/CXJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 1:19 AM, Ian Rogers wrote:
> On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
>> The nps1_die_to_dram event may need perf stat's --metric-no-group
>> switch if the number of available data fabric counters is less
>> than the number it uses (8).
> 
> These are really excellent additions! Does:
> "MetricConstraint": "NO_NMI_WATCHDOG"
> solve the grouping issue? Perhaps the MetricConstraint needs to be
> named more generically to cover this case as it seems sub-optimal to
> require the use of --metric-no-group.

That metric uses data fabric (DFPMC/amd_df) events, not Core PMC
events, which the watchdog uses, so NO_NMI_WATCHDOG wouldn't have
an effect.  The event is defined as an approximation anyway.

I'll have to get back to you on the other items.

Thanks for your review!

Kim
