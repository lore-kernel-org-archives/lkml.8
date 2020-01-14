Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A660C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D977324670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0thSptnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgANXHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:07:34 -0500
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:54721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728650AbgANXHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:07:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNXLLG/82dqeUj2/Y6Fkn1dHrZnzLXpHztCj9v2VyvgRTZpcDU1NfFfnDhr81QNZvix8u1jvMY4DGBQCF0O2P10LFSm9oE1RhbRDba+cP1d84jZR78JQ3OsI5UgXuLwHPIMYEZYBdKPiUgv+gHswJTPVCDHbecRSkWg+6t+D4VUjtsiYBOzUMc+zrtNMcMhjh2l7eU7d/Uj9dl98hlbnk0Lmd0hsrFGMHa2+igWVKpvG/Lp9eCbBvP7johjowLhopDD8GUcJxK4FwrQ8FLs8SMOhDH6CNjgvq6/DY9blmWNnzr2heehvH7OHJtTjEnJGCagjMkotqD2z01uDoB5jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+g2/WPstq1j1gpltsAYcqNAGv0lvtRZ4XKQGkd25Jw=;
 b=aSm1XHhNVV0lprpD2i8ZwRvWVJrYuwwQHsRVhYKgGr96eDk6eNRohC3P6O34DR8Z8bgTrcS33Bb4JgBYO2Vj6BEl4chUn5w/c9uFIhnuBn22a20svko+/0dogfAWfi7ZSdMbs70hdi9WK97X/3cmj0nrt1I1osOjcGQrDlf5uJ5IZ6AmwRwUtxbubRV0Crp8cccygJ2B0/VUIWCjcINuueylnvts0ReQWXjOuJUtmdDaOvUU/ljO8fvRAqaM5QUbZvNjjCnIQ1VpKhgVqZUQ9n6FhyPpUj//qOQPDWw+rPh0hDwbu3W37Xz7KcBd7g/H3FXymAv3ittBfTN++/3sAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+g2/WPstq1j1gpltsAYcqNAGv0lvtRZ4XKQGkd25Jw=;
 b=0thSptnkm+YP+c7i9RyKT4V8dgxu5V9WZq/DXHNFq2kzdFuiCt3HbC1HFXn90TT4weHd8eNZmTAFCQIG4vftVhVfgpk/bJfq/A4CefgDiTLC4NVowd9mt/zpCW100bth7cIBC0+vd2ZUVJ2DHRx1ux762aoMXRPFoHT5MMvkBgE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2831.namprd12.prod.outlook.com (20.177.251.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 23:07:28 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 23:07:28 +0000
Subject: Re: [PATCH 1/3] perf vendor events amd: restrict model detection for
 zen1 based processors
To:     Vijay Thakkar <vijaythakkar@me.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-2-vijaythakkar@me.com>
 <e2cb90b2-7cd2-122d-6e31-dbca5f1c79a8@amd.com>
 <20200112131021.GA5437@shwetrath.localdomain>
From:   Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
Message-ID: <bc195ac2-d356-9932-993f-778e48ce799d@amd.com>
Date:   Tue, 14 Jan 2020 17:07:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200112131021.GA5437@shwetrath.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0021.namprd21.prod.outlook.com
 (2603:10b6:805:106::31) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by SN6PR2101CA0021.namprd21.prod.outlook.com (2603:10b6:805:106::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.0 via Frontend Transport; Tue, 14 Jan 2020 23:07:27 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fe48da9-e33e-4bf5-43dc-08d799468672
X-MS-TrafficTypeDiagnostic: SN6PR12MB2831:|SN6PR12MB2831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB283104CD6815F3898B98761087340@SN6PR12MB2831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(44832011)(956004)(2616005)(36756003)(7416002)(8936002)(16576012)(31686004)(54906003)(26005)(186003)(16526019)(2906002)(53546011)(6486002)(81166006)(81156014)(52116002)(86362001)(966005)(66476007)(8676002)(5660300002)(66556008)(4326008)(66946007)(31696002)(498600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2831;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoMrd9B1VVrwiYm6Bl8vaI6U3PL2rhCxLTw/PY8saHeX5wwl9L+igEkz3lSWyCdnj/6i6rVYe7aRPx7apuy4cVk56HBRsviztC1MSUbcuCrRMR+IVptMW7vT7CMYalL/upz03OuMwiI/WGpkUbmiqgGPk5pfOsqQloNqEQfdTV8OWcNkzgqpVCflMJqcV5gqobdj8mEkEZm92Z58k6BlNxXU9WCS4FzttFBJE6IDfj8QZbgWSz19sCDagTSUw/PdpWQgjadWNRtGdkUdtFk6YxePRzEsCBkziZIbWR2T5tt1nIJGAOBlya1wwqsdxX4jhSuZzAKd9BTbm03azYWMmFJVobRJGd1B9eWFjUvA102v15uKuoQDchXJCcWIrkwslpqhlCdOSO2FaAG60qHpobkKPQ0O1hrWJJzXIhWNgQvQqGavFERq8coO7shRpENyP27T55Aj02+YQPW4GkH3Ier810CZbmP9oIWZGMo19sg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe48da9-e33e-4bf5-43dc-08d799468672
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 23:07:28.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ndq7MQnpEi+2xqMuD7ITMFlVYyd6I19Mtavxk9WPWQpSsuG5AsVtwNI7XhwjL5yFyEN/G411OtzGpzqGu+Ixng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[re-adding all to cc, since I think Reply-all was not used by mistake]

On 1/12/20 7:10 AM, Vijay Thakkar wrote:
> On Wed, Jan 08, 2020 at 05:52:49PM -0600, Kim Phillips wrote:
>> Hi Vijay,
>>
>> I'm just starting to review this...first comments are:
>>
>> On 12/27/19 6:55 AM, Vijay Thakkar wrote:
>>> This patch changes the previous blanket detection of AMD Family 17h
>>> processors to be more specific to Zen1 core based products only by
>>> replacing model detection regex pattern [[:xdigit:]]+ with [01][18],
>>> restricting to models 01, 08, 11 and 18 only.
>>
>> I've asked within AMD to find out if those are the only ones with zen1 cores.
> 
> I did not find a go-to source of CPU IDs on AMD's website, and on the
> tech-docs list, what I found was out of date. For now, I used the CPU
> models for zen1 and zen2 that I could find on WikiChip. Let me know if I
> am missing any.

OK, zen1 is f17h, models 0 through 0x2f, inclusive.  We can assume the rest - 0x30 and higher - are zen2.

>>> This change is required to allow for the addition of separate PMU events
>>> for Zen2 core based models in the following patches as those belong to family
>>> 17h but have different PMCs. Current PMU events directory has also been
>>> renamed to "amdzen1" from "amdfam17h" to reflect this specificity.
>>
>> I'm not sure if this is 100% the way to go.  Technically, the events and their descriptions vary in the per model PPRs, due to things like AMD's validation tests passing.  So historically, we've kept the source of the events for a specific model in its PPR.  I realize that that may not sound very efficient, and in fact would increase redundancy under pmu-events/, but looking at the data volume figures for each of their family names, that is how Intel does it, too.
> 
> I realize that a lot of the events between zen1 and zen2 are redudant,
> but as you point out, that is how other related CPU models are also
> choosing to differentiate the events, so I chose to take that route.

Right, I'm just saying ideally we'd have to do this for each public PPR, not just zen1 vs. zen2.

Here is a list of publicly available PPRs, in chronological publication date order:

PPR for AMD Family 17h Model 01h B1
54945 Rev 1.14 - April 15, 2017
[used to be here: https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf , but not found there any more]
https://developer.amd.com/wordpress/media/2017/11/54945_PPR_Family_17h_Models_00h-0Fh.pdf
https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip

OSRR for AMD Family 17h processors, Models 00h-2Fh
56255 Rev 3.03 - July, 2018
https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf

PPR for AMD Family 17h Models 01h,08h B2
54945 Rev 3.03 - Jun 14, 2019
https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip

^^^ those first three are zen1.

PPR for AMD Family 17h Model 71h B0
56176 Rev 3.06 - Jul 17, 2019
https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

PPR for AMD Family 17h Model 31h B0
55803 Rev 0.54 - Sep 12, 2019
https://developer.amd.com/wp-content/resources/55803_0.54-PUB.pdf

^^^ these two are zen2.

PPR for AMD Family 17h Model 18h B1
55570-B1 Rev 3.14 - Sep 26, 2019
https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

^^^ and that's a zen1 again.

I'm sure the different PPRs for the same zen generation change their supposedly identical event descriptions, too.

>>> Note that although this change does not break PMU counters for existing
>>> zen1 based systems, it does disable the current set of counters for zen2
>>> based systems. Counters for zen2 have been added in the following
>>> patches in this patchset.
>>
>> Right, and I'd like for the regexes to not be restrictive like this.  Is there a way to get them to be more open to working for unspecified family and model numbers, like the current version is?
> 
> I am not sure if that is possible, but I also do not know why we would
> want this considering there are quite a few differences between Zen1 and
> Zen2 events. Missing models can always be added later, and if you can
> provide full list of models from AMD, that should solve this issue as
> well.

The problem with that is I don't want to have to update perf every time AMD comes out with a new model.  We have the zen1 vs zen2 model range figures now, and for now this seems a good fit, until something more automated is developed against the PPRs, which have the more restrictive model ranges.

>>> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
>>> ---
>>> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
>>> @@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
>>>  GenuineIntel-6-7D,v1,icelake,core
>>>  GenuineIntel-6-7E,v1,icelake,core
>>>  GenuineIntel-6-86,v1,tremontx,core
>>> -AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
>>> +AuthenticAMD-23-[01][18],v1,amdzen1,core
>>
>> Last but not least, this fails to match on my AuthenticAMD-23-8-2 machine, which gets me no 'perf list' output, when there should be.  I think it is because the regex requires the 0 in front of the 8?
>>
>> Thanks,
> 
> Ah yes, I did not realize the prefix 0 would not be included. Changing
> the pattern to be [01]?[18] should fix it. I can send a new version of

The most restrictive pattern should be first, for zen1, and to match models 0-2f, it should be something like this:

AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),,amdzen1,core

Then zen2 can be the catch-all for the rest:

AuthenticAMD-23-[[:xdigit:]]+,,amdzen2,core

Technically that family check can also be changed to make it even more future proof, e.g., 23 or higher.

> the patch set. This is my first contribution to the kernel, so I
> apologize for the newbie question, but should I send v2 as its own new
> patch series, or in reply to this email?

As its own new patch series, but after I reply with my review for patches 2 & 3 out of 3, please.

Thanks,

Kim
