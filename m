Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B3AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EBF2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qMk5iC49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGMBQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:16:46 -0400
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:6054
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgGMBQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:16:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0sRBJxy2uBAubkomYwxwZVI9YqlU6n3eoHoKEHLp+aX+NZu8TtgPjhg1sGnrm6hF9dRGJsHLpTYf0Jjw/Vlr8Kv94FuPJEZTYYaBF9f3jjuIBRSxT2DPLYN4VMTGXuP5dBshidI/FhZmgN1DJfesqLZ5z/TxbK+KmW9oajr7U5sj/eZIEjPVlDDfCkZlB6tKfuEaFPQkkd34abo4zyal97MGpLcvJ2ez+BJAWcePWhqJ5V+/DvMqtRrbUS15lPZ+BOxyMyI+QdDOTeejjXGvUS4KnXTzuV7OHmqYFGtyiuALYpCnmki7c0hftUbB3cfoBo9Z39rbvtzAm1BMvwhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpDrshVHXqNAA06mJqpKdST8NgabgdfvCB6qbi01dHI=;
 b=PrmKNDr6j7QwGmsC9XmxOeGRPxD9eKlxOHgGY6vDWRaM8Ydw59ZVuiHBt4DN1c7Bo8het4cuVzlXc4ISZs8ddEQflfqPOPvEItQDtnIg8g30R73o3QRaqBDA+XSME93a/h4rgP8bkB49T2Ws/Yz4u6Uafy8AL0dH4sWfJ7I3cNGyrvG/Z8HPHeGMFsZ5MG+DJKweWCC9AwSuHzbrjlA2gn69qpiGWlkN/WwvWH7RT150LAOfVfywdrPB4vn000heRFomHBgKkd1fDF4ViBj/V8yENgy7FZKnEoT0Uj0fgrFCj7GKg0v3Hmba7c4VTaMN9p9g0wZA0xoSXEKahvw80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpDrshVHXqNAA06mJqpKdST8NgabgdfvCB6qbi01dHI=;
 b=qMk5iC49UkhwDs3cDe8IAeqWzZl0INoEukJk3Xeg1DKbol5mhuCTq6+EeOiwPo8XyNPNIp8d0KY0XYQvdwyqmuR6v6gt9HlYV4Kxrwh/4INkAickN+psr6F0s7kL8rZ0/RsIbi1GXnzl4/G9a7ibAyJfRUJu30p13ZZMimCwGT0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MW2PR12MB2523.namprd12.prod.outlook.com (2603:10b6:907:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 01:16:40 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3174.025; Mon, 13 Jul
 2020 01:16:40 +0000
Subject: Re: [PATCH] ASoC: rt5682: Add fmw property to get name of mclk
To:     Mark Brown <broonie@kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200707100825.24792-1-akshu.agrawal@amd.com>
 <20200707103053.GF4870@sirena.org.uk>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <a2cf09b4-5f49-ba74-060f-bec9a49d21a6@amd.com>
Date:   Mon, 13 Jul 2020 06:46:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200707103053.GF4870@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN1PR0101CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::22) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by PN1PR0101CA0012.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 01:16:37 +0000
X-Originating-IP: [165.204.159.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25408979-4206-43f3-b3c5-08d826ca657b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25230F5E97CE571E0303B864F8600@MW2PR12MB2523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fJ2Gt1sBxkgeM7qRjZnwVj5rsghPESa+b9qCs/mHiocx9yhfMohqxjj9tIcaXiXUOozllHe2hw13PA5KPHQPGm8Zmvc8gYG0/Y+XbfmPMwn2DCCr7yYhvU2IwGrpvTC46U5EwUPjtnFGJPpYAKxviFkc4UJJTNFEZNRD51Sv/ORIYps/uhGWEz3bi/+bT7iFA2EDUQxswe09+nu5RhTPMgNL4ONRIIBqE83SFhHsPuQINTwZjLTtxRuPtKH1adAHM4rTVC6cT7eYmQlBR9EKtKGX6Z5WCeEymCMj5Y1qCIOasZnXjJieSHwL1fY7gi5RoL7W8SvT1bPGxOCMeO2JaqOyZ8yYTcg7/aq6egvSKO6Y46YTZGfqZx3bzIE/GYQs0EwqQ6UPrSV0Og+esKYjFY0XfUcBvWVn8GpGgmoOEl8qZF7HfdPw/bhrx5RYlcBRO/SMYuTN52N2GGu5svgwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(316002)(5660300002)(52116002)(31696002)(966005)(186003)(16526019)(2906002)(26005)(53546011)(478600001)(36756003)(6636002)(66556008)(66476007)(6486002)(956004)(4326008)(66946007)(2616005)(4744005)(6666004)(83380400001)(31686004)(8936002)(16576012)(110136005)(8676002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZUCYnmpM4FKn+lyoWADz77KNHRpUqucm4j2jrO7EKpEUgLJH5+m1J+oqe1aV8SpNuR17uuLXJo17WB7ZkXhoc+JJbCs+t+ISdsM4Wl8qK4um81PKJ5Sffi1WndzA99+YFtAOD8d93USFOQudTD00d+tbzoWyGLIW0lBzLdLkW9GIL/TwLQwOVthsTcqhosS0d10H0KajoufswyCO0+UkWPBhGSSNi2jCmRPIuomHEEFKwGmCbeJzWxIdLNYeAa6YQdTzDRA7t+gm4lh/UwA7gjw2HSnvEf4GtX5BsnsASlObv+gVYkFFv2rgMqmr8r8AY2wnbh6GTFuTu/2D9YAzDYPO4X1pLyFDNfhPJbRgE5Q32HtSh4nTPOAaCergsuZF9e3LDkMDx/+vQNnc0P80TRU1E6p4VsFVVccnE2WkmN4TWwHZavQXB5ME1+MOZryyy5JzHo+GFfhlVVcFQ7RJ7qIU0TohnuYLP4TCkoTMNPc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25408979-4206-43f3-b3c5-08d826ca657b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 01:16:40.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkbt+3nxlmteEWi7bf+CAWtXjg+EXViD3EOV+vgd97DSn1lLIICvknwuy9gWvdmetg2kIJLc+RF7zuUHzMLv3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2523
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/2020 4:00 PM, Mark Brown wrote:
> On Tue, Jul 07, 2020 at 03:38:25PM +0530, Akshu Agrawal wrote:
>> Non-dts based systems can use ACPI DSDT to pass on the mclk.
>> Thus add fmw property mclk-name to get the name of the system clk
>> and link it to rt5682 mclk.
> ACPI doesn't support clocks at all, you need to add a clock binding to
> ACPI first.  The idiomatic way to do this would be to have board
> specific quirks.

clk binding is present for AMD ST platform and using the same.

With recent submitted patches I am making them generic for all AMD 
platforms.

Please refer patches:

https://patchwork.kernel.org/patch/11658505/

https://patchwork.kernel.org/patch/11658507/

Thanks,

Akshu

>
>> +	device_property_read_string(dev, "realtek,mclk-name", &rt5682->pdata.mclk_name);
>> +
> No, this is not at all OK - you're adding this via a device property
> which means that this will show up in the DT bindings too.
