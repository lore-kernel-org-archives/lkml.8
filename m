Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF6AC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53052176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ie3SKVn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgBYXVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:21:06 -0500
Received: from mail-co1nam11on2098.outbound.protection.outlook.com ([40.107.220.98]:35553
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728806AbgBYXVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:21:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frPTy1eZwrZp9/shrmamzDEGjH5KybXFvqqzuguct+b7Gnj+mO1LUREIESQJcRiFkRufRaLSWbEGvymy/WE9wLMKD7ShNyavU3nGsQEZNKRJYZPhACL2uXQ2n6D7+uhHfgGXQI9hJlsuAJsD+QhgHaejbRydX6xGbRXDXkjhKHsX0Ybox4d2O20lJW9A3yGqdcuNb3b8Ja97C/AFpo5sVyMnK3yeW/beTFUupD6GJMews74HpmEQc2+Deaunn/or6WQpbeFtiBgk2M2QgfKuV8w5vwMUuBbEgeaHWvuhTNnCm7QywZl9LTKESqblXeQN4Xc5nFmW2Y07WtUbBH6rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxvH5j3TGZCWq3GPheR1ntpAz8ujFy2EcIsfKhx1jOQ=;
 b=MBZw8g8r4rURh0iqVawdYk2jjHk3VdddflY0N0x4Bcj8i0aTJDyaWIUJ4ekeKMHMCc9B+mdTzMEmC3LLn8967Tc/nWerrAoWyTxoEV4QRuicWpzOygEXg3p/oI42t888sUMW7C1OsGmR9ejuKkLUCGjjmRnPNCOtvze06Qf2fbzyVIzXvSHtcNHGoWFsZb7MFIGgY66WG6LZpKFvSh6jXFjp6uM0mUqW83rmMEcXgl3x70e0LigSLpMNpUZT9uh6CjMjkB5vcw37Rmkbr/sPc+ISpLBFLU+uqDnk2VuXnfDRbQ56AiXOh9VB05VBbgt1xuFjpURcWbcwqXN4zuIYPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxvH5j3TGZCWq3GPheR1ntpAz8ujFy2EcIsfKhx1jOQ=;
 b=Ie3SKVn3B1OTyicDkCbQyBP34ET6VQkK9eU3vof8M4Gv8kfDCgHayVitA54msL7hh49IXbXVESAdmfj4E9jy2mDLz7BisNbNcWMNy2I4PJsCgQ4d02ieT4bSQgd3Nwp1pgSGggf2HpCoAu9BO2xC118VezHk5h6dIV5JkiScGU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from SN6PR01MB4094.prod.exchangelabs.com (2603:10b6:805:a4::23) by
 SN6PR01MB5165.prod.exchangelabs.com (2603:10b6:805:c3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 23:21:03 +0000
Received: from SN6PR01MB4094.prod.exchangelabs.com
 ([fe80::603d:70c0:63c3:9734]) by SN6PR01MB4094.prod.exchangelabs.com
 ([fe80::603d:70c0:63c3:9734%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 23:21:02 +0000
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
Message-ID: <32a35685-ff3e-9e5c-f6bb-960dd6f3d1d3@os.amperecomputing.com>
Date:   Tue, 25 Feb 2020 15:20:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
In-Reply-To: <c85dbc06-a72b-9c98-fe41-b25069114b2f@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY4PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:903:99::19) To SN6PR01MB4094.prod.exchangelabs.com
 (2603:10b6:805:a4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.76.34.152] (4.28.12.214) by CY4PR13CA0033.namprd13.prod.outlook.com (2603:10b6:903:99::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.9 via Frontend Transport; Tue, 25 Feb 2020 23:21:01 +0000
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a545b3d2-95ad-4918-8189-08d7ba496114
X-MS-TrafficTypeDiagnostic: SN6PR01MB5165:
X-Microsoft-Antispam-PRVS: <SN6PR01MB5165F04AD4BD27B7E5246479F1ED0@SN6PR01MB5165.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39840400004)(346002)(376002)(366004)(189003)(199004)(316002)(956004)(6486002)(66556008)(52116002)(107886003)(5660300002)(2616005)(81166006)(8676002)(8936002)(66476007)(86362001)(2906002)(31696002)(66946007)(4326008)(31686004)(53546011)(966005)(16576012)(16526019)(81156014)(6916009)(478600001)(26005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR01MB5165;H:SN6PR01MB4094.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HFG/2yMfjKwQ2FKmktNC5vXGLum3Uj90cHeJTARfRD9XB7AGvuOHNLqK4XT/VgAoMqeP0TTaqFQrkhepx8iaiINldWIDtlSxLxygoaJmXVNPzwdtXf+vWhtZL+lPgSLG/FN2bzfD/P5kl2E+ddMgO4oWKn++EtCWUVvqflz8kX7pXioNpXCkuJmcCbREtuDpAXCnWwq3r7h2rnQZ8EmXomvjItbFbtxBKJSjMuxULXcvGLrrX4X9JhBifmxkTKUTHJhG/FTxXdvYOUK54Smtzpi3YD6JKf2qIFnRtzSeprU29Jqpis4qRgxYanoXPCtsgzU7A5GvNNZlP6wexsvpUjTPspKc8o4EguL8OdAeATYXd0bw+OvycAzzy/WP+x/snHUjO4IN84XeIn+Z3hzkGq43xE2YE5I4fHIXzCxK5I0ZCCURu+j3lRZxnvmPjAhZLEjyi4ajI99DYK0ZZpY/hVy0wf0oCOwqc4KfRxvF+m/KDxjDr5Vq7MoZp4jHYrHxRdRquaFGg+izNr3kpqiZgQ==
X-MS-Exchange-AntiSpam-MessageData: jbp0C+4beStZMSbdJgomEvfbZOYPgtTAa8C88JlmBbEF1vCZglFBPD7PXzxiBX375EsOJQZ8dd8HekM0G+iOoV6Zh2vjBFrITgOb5Zoq3ole44Rq2ajep7ilVisxXgTElx7tWKc2pWdkLzg5CohWwQ==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a545b3d2-95ad-4918-8189-08d7ba496114
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 23:21:02.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXwHPWSfTt5ToBpBgVo7p4qw2NnLpodkiSyLrA9DpE9DZpP4iAYZz6BgF6IB3LNHS/h+h7oguszHeJ9REfDqqHX/wEWh/HCJ5Cl18CIs5nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB5165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Do you have any comments?

Thanks
Hoan

On 2/6/20 12:01 PM, Hoan Tran wrote:
> Hi Will,
> 
> On 2/6/20 2:23 AM, Will Deacon wrote:
>> On Mon, Feb 03, 2020 at 11:55:14AM -0800, Hoan Tran wrote:
>>> Some NUMA nodes have memory ranges that span other nodes.
>>> Even though a pfn is valid and between a node's start and end pfns,
>>> it may not reside on that node.
>>>
>>> This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
>>> this type of NUMA layout.
>>>
>>> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/Kconfig | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index e688dfa..939d28f 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>>   config HOLES_IN_ZONE
>>>       def_bool y
>>> +# Some NUMA nodes have memory ranges that span other nodes.
>>> +# Even though a pfn is valid and between a node's start and end pfns,
>>> +# it may not reside on that node.
>>> +config NODES_SPAN_OTHER_NODES
>>> +    def_bool y
>>> +    depends on ACPI_NUMA
>>> +
>>
>> I thought we agreed to do this in the core code?
>>
>> https://lore.kernel.org/lkml/1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com 
>>
> 
> Yes, but it looks like Thomas didn't agree to apply this patch into x86.
> 
> https://lore.kernel.org/lkml/alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de/ 
> 
> 
> Regards
> Hoan
> 
>>
>> Will
>>
