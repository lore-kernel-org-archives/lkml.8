Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B86C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849DA21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iKp/Bvxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgCKGbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:31:47 -0400
Received: from mail-co1nam11on2093.outbound.protection.outlook.com ([40.107.220.93]:32096
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbgCKGbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDgXapLxg0zrpd0lryGC9UfM42oU3zK5VbK6RVjVfD8H2i1jUKpg6AbR/FB/i+JCFmtGjrwVHSZcDBkJv0fqOIdFj95wa0gEYeYZsGQ2yc5DyXmLsvYqJh7np2PmVKv0qX7gg8ZtzVlHabeX7Rf9twOcYO+mlpzrnzteazYvIssp/0CNsxqFECNhm8r2FWGj3Z8pG6ObFbLnTsMQpXWtzpUxBCAlJBVbQ2sbipDjfNIAg0nzIREX1OfLU/aTl5rRNVCKEK7sa/QojYggxDT1BBpbWWu3ETvYIsQJMpLO5WAKrYZJ3BjWrh/72iS5wJpBbokG4O1RHv5W+Y5/CYgysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCkHuTtuAB7yCIUvijeIwLHa0VxHEr37XKHhx1Esa7U=;
 b=jwcFAi0GkWhNQ/bgzREesK5X325iL3vV7CzfeolPrxIQ5VxS5HlgFw/mJ/aP7u5EDr8r+yZoCLj+4BnQvwuslkRey3VBScNMvD8C3qansNrzeOg0ZbVZuP2rUhqpUWwaCU3l2vuPY0yIrH8XPPW4xsnk8RwKMIQ/P9UEZegvBWwquNj+I0gz5aoQ+UQPKXXkT6aZbNe5LUF31rO2dawFaW8J+A8Un7mzOxqedC2ruZf5vJ1eLBNLpQQjjEj13Z8hZXm9/HmxYbu5LrcFMZgKlnVJCYXYT/bxgbsB6tv5yYK4Y5wG0hR3x5gcQ62hXR45j+m7nOvf4SIxCXe6Fr54hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCkHuTtuAB7yCIUvijeIwLHa0VxHEr37XKHhx1Esa7U=;
 b=iKp/BvxeMF8H7yRMsusZqiveADugnOzIocaLeVxEmXLw5mrH+mTVDddxsxiSq9rWehOhk51jIeIvjeJym82vJJ6Uhn70vifBeuUttB5taX0vhDag77+NaWsBQZ6CeHmxKBR9fhWITZadww1MF1jnSqWrXqCNK0lyS5cyHu3o2LE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from BYAPR01MB5494.prod.exchangelabs.com (2603:10b6:a03:127::30) by
 BYAPR01MB3736.prod.exchangelabs.com (2603:10b6:a02:8d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 06:31:44 +0000
Received: from BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb]) by BYAPR01MB5494.prod.exchangelabs.com
 ([fe80::a979:b2e2:fdaf:1ccb%6]) with mapi id 15.20.2814.007; Wed, 11 Mar 2020
 06:31:44 +0000
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
From:   Hoan Tran <hoan@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@os.amperecomputing.com
References: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200206102340.GA17074@willie-the-truck>
 <c85dbc06-a72b-9c98-fe41-b25069114b2f@os.amperecomputing.com>
 <32a35685-ff3e-9e5c-f6bb-960dd6f3d1d3@os.amperecomputing.com>
Message-ID: <4d90f400-272c-56a4-9250-d8e238ed78c9@os.amperecomputing.com>
Date:   Tue, 10 Mar 2020 23:31:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <32a35685-ff3e-9e5c-f6bb-960dd6f3d1d3@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY4PR1701CA0014.namprd17.prod.outlook.com
 (2603:10b6:910:5e::24) To BYAPR01MB5494.prod.exchangelabs.com
 (2603:10b6:a03:127::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.138] (67.161.31.237) by CY4PR1701CA0014.namprd17.prod.outlook.com (2603:10b6:910:5e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 06:31:41 +0000
X-Originating-IP: [67.161.31.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54d3d8b5-7e54-4460-b40f-08d7c585dd62
X-MS-TrafficTypeDiagnostic: BYAPR01MB3736:
X-Microsoft-Antispam-PRVS: <BYAPR01MB37363369A0BD9FEC7080FE54F1FC0@BYAPR01MB3736.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(396003)(136003)(346002)(376002)(366004)(199004)(81166006)(186003)(966005)(26005)(31696002)(16576012)(16526019)(316002)(6486002)(31686004)(86362001)(52116002)(107886003)(2616005)(956004)(5660300002)(8936002)(53546011)(6666004)(2906002)(66946007)(66476007)(8676002)(66556008)(4326008)(478600001)(6916009)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB3736;H:BYAPR01MB5494.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6agdBnKhgkrFI7Cg/1KNbJOeSJaDTLkfmWlp6zAZ/gKWbflltqe+iDDvy3u+eIX+HgnoFPsCXVMkf0h5K56dKLva2rkMoiIuIlj/OYppZ3p71koblmB88Gc8uFN2kX09Js/ccaLTDJqyRHfr00Rf7mon61U+PrasFBMqSI/PpnBC0QueLFGHYRorQGpnlTAxli+xkIaeo4sWNej2jK7rqb3YqSptRS4IUDAYhPZfxCAyMvUff5hyepxYvbgf7ZmMZ40n9me8d3WP1T7Y2jLQ6Ftjv3Ys8PhkXpLvhWzjadiuxcaXtVbheDqRavCGKxNhRt11p0XTxysGtqOWiPxc7oSxqVt56qkWUTJktbf/VDEEZIOBvhZAZckm16m2mGTdKUwWc1NQui4Bh54QFFt8lfB2MTZNUg0gQmmrzHD+WqH0XAkNkLIeI+Lt4LYeu2oCdu3Ak1R8KXuWJ0rvypaJ3ytboIp3KpU5XKFsotBn2tLwmh5nlxsqLEbRp42MDIVV/ZGIgqu0Uwm3Id6XCE7Mgg==
X-MS-Exchange-AntiSpam-MessageData: usQYdefEjH3XOIq+/4BQB+hLVDSvkDlMKWpoijJlir9M9tIQVyWaZhyu9upwYT9iCEKWiuApPj/K0DzJf7KAVFxXcjxplsf/xhNXPfW3AiTq3lZBT9TfIYaICFSnnZ+VvtHEw+V10PMWT7aHbY3tYA==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d3d8b5-7e54-4460-b40f-08d7c585dd62
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 06:31:43.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQFqhx9YXLV+dwfggihaPUBnrIJWul/Ptq0uKw+8yEPbF1AN9Lkb7IiPQxEf9GXnKyuRlFF1cZtwYhfwbh/4YQHCNu/EEZ6clfA03tgM9cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will and All,

Any chance you have time to take a look.

Thanks and regards
Hoan

On 2/25/20 3:20 PM, Hoan Tran wrote:
> Hi Will,
> 
> Do you have any comments?
> 
> Thanks
> Hoan
> 
> On 2/6/20 12:01 PM, Hoan Tran wrote:
>> Hi Will,
>>
>> On 2/6/20 2:23 AM, Will Deacon wrote:
>>> On Mon, Feb 03, 2020 at 11:55:14AM -0800, Hoan Tran wrote:
>>>> Some NUMA nodes have memory ranges that span other nodes.
>>>> Even though a pfn is valid and between a node's start and end pfns,
>>>> it may not reside on that node.
>>>>
>>>> This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
>>>> this type of NUMA layout.
>>>>
>>>> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
>>>> ---
>>>>   arch/arm64/Kconfig | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index e688dfa..939d28f 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>>>   config HOLES_IN_ZONE
>>>>       def_bool y
>>>> +# Some NUMA nodes have memory ranges that span other nodes.
>>>> +# Even though a pfn is valid and between a node's start and end pfns,
>>>> +# it may not reside on that node.
>>>> +config NODES_SPAN_OTHER_NODES
>>>> +    def_bool y
>>>> +    depends on ACPI_NUMA
>>>> +
>>>
>>> I thought we agreed to do this in the core code?
>>>
>>> https://lore.kernel.org/lkml/1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com 
>>>
>>
>> Yes, but it looks like Thomas didn't agree to apply this patch into x86.
>>
>> https://lore.kernel.org/lkml/alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de/ 
>>
>>
>> Regards
>> Hoan
>>
>>>
>>> Will
>>>
