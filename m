Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67115C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFD9206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="Nkh5gQLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgCOIyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 04:54:14 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:20462
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728062AbgCOIyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 04:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb0D08doBtqhCfa1eP8ml2ItbDNQcOPWfB+bC9otaDidzmK8sHjoUmeG0BLF2j81+Aqf2BpkXhlfnTVbHLFDHT6iEHTPIOkTRepN+ZgUXm4Xoq15l6L+Z4Tu70U11vXAPL7mLJfPznP37iSUfTQJl3Jnqi15c33s9V5MA/xL6Z93a6rojhANCDW9NH8DMSvxAIZerH6GZoZBS4LuydWa4R5O5EadIXSKLPL1t13W6aVINoS/oM3iNsHH8gGhGM+xp1buImHv8RNnYt8C8USNnH3YiztaKarrxT1yA/1iAWqCXaWeONT3BZ1EEnVWQGaOptCgKAWoxiWsZRfMKBkDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMwJoWMOxDvFpPQ0RXG4bJqlYW9ZdC7cpYCBQPgObjo=;
 b=V7WpKWKmGdQlMenmjsdPU4LVWWNTiGwP6yOD3rhi9QDuUfBg4I+IdcPgVbzwPCercAhDCN1ZEoCue0WDhJFmGK/p8VbxruFZ99YsfJwOv1tXDEywwPWG9N2SGihTSNJyuPctb37X5mtgnRB76CLf/UDz6wY3gOridcHQldA8FDtnQhfTVt6fwED2sV9u+MRaZAmj/5FvKXbi/zI3VLeruqNnQj4NeghfPTJHFHNLtLaDLc3vwmJ6Zps7dVD6H3vire9VpQV/mUTAhOk9bjEc/8CUi1Dz387/1pN+AZHTwhkSs/UPSm/SqnAP8TpXMLcQBp1G8iKGVvatc6d9uX7DPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMwJoWMOxDvFpPQ0RXG4bJqlYW9ZdC7cpYCBQPgObjo=;
 b=Nkh5gQLtrlNMqT3uCQUdMwRpDwTEp8aoz/VXZfJF9Y7+A0sq7dkY2k2TsZCYUVpXbrd2zHY0LcxTCp5IrmhTJC2QOog4oPqaFnLmgAyAvBGTTRjNV/DjVvRNoR/ORMOrTO0zzdyk9f2cyrvFdKzx6r1x7htqKykmvpRJ+dqylTs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com (52.134.21.155) by
 VI1PR03MB3647.eurprd03.prod.outlook.com (52.134.28.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Sun, 15 Mar 2020 08:54:07 +0000
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::ed88:2188:604c:bfcc]) by VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::ed88:2188:604c:bfcc%7]) with mapi id 15.20.2793.018; Sun, 15 Mar 2020
 08:54:07 +0000
Subject: Re: [RFC 2/3] mm: Add a new page flag PageLayzyFree() for MADV_FREE
To:     Wei Yang <richard.weiyang@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228033819.3857058-3-ying.huang@intel.com>
 <20200315081854.rcqlmfckeqrh7fbt@master>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <92d4b0fe-f592-8da6-0282-2ea8a015b247@nextfour.com>
Date:   Sun, 15 Mar 2020 10:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200315081854.rcqlmfckeqrh7fbt@master>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:7:15::17) To VI1PR03MB3775.eurprd03.prod.outlook.com
 (2603:10a6:803:2b::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR0902CA0028.eurprd09.prod.outlook.com (2603:10a6:7:15::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Sun, 15 Mar 2020 08:54:05 +0000
X-Originating-IP: [91.145.109.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71d31372-3099-4b80-38d4-08d7c8be6b39
X-MS-TrafficTypeDiagnostic: VI1PR03MB3647:
X-Microsoft-Antispam-PRVS: <VI1PR03MB364799F254EF2C7277D86BB083F80@VI1PR03MB3647.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0343AC1D30
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39830400003)(199004)(6486002)(110136005)(956004)(2616005)(316002)(54906003)(66946007)(16576012)(4326008)(16526019)(186003)(26005)(7416002)(508600001)(31686004)(2906002)(31696002)(66476007)(66556008)(86362001)(81156014)(8676002)(5660300002)(52116002)(81166006)(4744005)(8936002)(36756003)(84603001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR03MB3647;H:VI1PR03MB3775.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoQ9zNh4Qos0fFMpxSjz8yBfh76Tq7Sv28DybKvG8tZnfT5j4PoaAf3BO5rOifoQNBYge8wLwMkF0cahk8RCbfgFQmm6w1al7Zl2P0ycD2+85C/bjX+zkJ9chY6W676es1W/VmUbqUYhNq6vM+GNPG/HAijDFLjavQtcsqzlh1zCXZScMVlsrkfzcKd384T0HCbJx7dQl2FDS55UIKLo2xQxU9apDnQbYBT4EG1U+koh9JoTsf5+39Wg9hTwgEx1UKhInoAUNsENiJRIbzeP7EfmV993rrjYA3xr7Ip7h7JITg+5p7IT739nZxB/7WQNw6BukKB01XCBU/mpZorfs6v4okQRHMHMl0kvcodqB919ldIrPHcAWBzGcSisleO4zY+S7hA5RG7gp9mUT8+AimysOIiJNpERyVADaqDjFdzs3iA+jSOQh2Xssd3n7XAgY4qy3raaI6wZmEMDlgpYFllxMaoYBhi7xk1LGNC3ozQgUQYCTHMKyi6266UG+a8q
X-MS-Exchange-AntiSpam-MessageData: qGL7gZGZTkP/8fnLQWyDL7D3h3FIJVolMbKvUUH02zkxLlNU3xdX2VL9bktBvzfJFZMvaqhNbQp5sfGO9Tj19VKUNW8A/C5ftGSli4RHYE0lEQ+8mid2OIb9fUyAja14Yi2hdO2ZVTCdH8RBH1Rdxw==
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d31372-3099-4b80-38d4-08d7c8be6b39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 08:54:07.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzSedMFTWGk+Xxf3DwtEWhi0fgJleQAHt9Fer6t9EC6wzXfgm4oPSZZWHjLFQo7Cl9wXrrr85BCqOPQqSVVaE7ZAU77lIbv3LMGwTQKdPDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.3.2020 10.18, Wei Yang wrote:
> On Fri, Feb 28, 2020 at 11:38:18AM +0800, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>>
>> Now !PageSwapBacked() is used as the flag for the pages freed lazily
>> via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
>> new page flag for that to improve the code readability.
> I am confused with the usage of PageSwapBacked().
>
> Previously I thought this flag means the page is swapin, set in
> swapin_readahead(). While I found page_add_new_anon_rmap() would set it too.
> This means every anon page would carry this flag. Then what is this flag
> means?
>
>

But not all PageSwapBacked() pages are anon, like shmem.


--Mika

