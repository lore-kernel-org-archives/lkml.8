Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4682C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF5A2068F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s6W3OqnN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXHyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:54:33 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:39494
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbgGXHyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:54:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgahfFISRhrI/u2wfC/3sMB1sB12HHCwkD7/rQi96NomR87dKC2whrlX1jWCZ/6r0KIYLbLjZvsSQv0xLI0sZjlKXOpcr7EIe13GE7fV/JBT1t7qmKJ7fwGwW0Ev58b88HYLcLj3zj3gJroCtaeF5HYq4LVB8pqKkcProTq3iEwbh9GfGmHlJaRcEtNdHudj9c5MpkLdJQJJR9EzwGFlAk2rHzYnPjFi0KwMpyZH/cX0MHU3xoXvpj5AIny3n4rk+/WEPvotJ4QYxkM4ckgcVDrBvjpZMY7fl0QDMI/z7oLZ8cJL4+1OYsZeQfpjxtq2LuSrZkAGFdL34uXnYTb6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IUFQP2w9iuYCht6cCRSMnRaENO0suYfah7XwH5rY0U=;
 b=VdfLeUBkmZ4iYcierzI67NJEI/5WY/QgR1QuJPVwQF+/fE7NVJ0ET0UNGhZ/t2L/IjstnatKgnidL89N335a2XIo/Csg71/l7tpnzD67FHn3wKyXisbLxrWgEse6a21dL3ThyUHUN1ivmxdKyMV1FzXhVuMSit5vOSSqilxo1KATD1Ii2aBNhw+fS6inLueHVle+zXo4XL1rH790nvgNE51qNHD82MIWxlftPYsA/IO9m97OCjdeeZCP+W2uTmE4eBIq1h+q4dq2I/NgWaBqGpcsHSuFVbLzy5BhZDefUJREx8RxpZHK5qgE63CBtbaLzVCO2R27mpN+MHiHlFKYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IUFQP2w9iuYCht6cCRSMnRaENO0suYfah7XwH5rY0U=;
 b=s6W3OqnNYWG4MvvcC9kiyMZGCVxYyJ6ZcvLetBCMN/w3MFtm3QJSe3wuN1ElI0p1ql8eEA4A7iFFYGyexFFW4bNerIz14uj9aNJUMAz9a86utQoU3RLsKWQYo3UYX+TAaf09dLpALCFEntndwXfXOxSm2YKAHSSBQtGDtMQdhlM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 07:54:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.021; Fri, 24 Jul 2020
 07:54:30 +0000
Subject: Re: [PATCH v3 3/3] drm/amdgpu: Change type of module param
 `ppfeaturemask` to hexint
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200703142939.28663-1-pmenzel@molgen.mpg.de>
 <20200703142939.28663-3-pmenzel@molgen.mpg.de>
 <50e7239f-9fab-8484-7aec-085acc5ec658@amd.com>
 <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <54ad054c-2cf4-765e-4ecc-44e2b98422f0@amd.com>
Date:   Fri, 24 Jul 2020 09:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <7e5b2284-0549-185c-4afd-f7d193e2faf9@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0062.eurprd03.prod.outlook.com
 (2603:10a6:207:5::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR03CA0062.eurprd03.prod.outlook.com (2603:10a6:207:5::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 07:54:28 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 942d0598-5921-4d94-3d7b-08d82fa6cb70
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4126578FBF8CCA3CB7B00E6483770@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyvARchkuhl4WUzHA5o9eKD31KnujSW3W1wyZAIxz5ToOeTMc39dE7trqJqvzhkiXLkzOGoi4qTFCcPd3QBVx5jICFsBEYOxRGfDCbr9NoM95MsaLhX/zuVukhSc4eqzm3bX5mjVPnxABhbmOjMysTfWjiGSWcBzUfOfPW1natEqRsKoD61jcXTosLT++2cRrTAPQ7aNxyNk2Je6z2mJWKVxDG6omJf/oGFaMFfbW1bxW26RmI8KxUmOjpIXUaZH4cHPEs8zTU5pySZKm4JF8d9nZWWBYYW6sqTTBlcDmvZmpxLQPJdGNTb/+RgbdVYnL7pnSFr1BhSf43in7UCOqTL657tfSBBdMgRfa7mA6KWT3w1TIVrw4379eG+1SEpZV/VcfxRTHskFgB9TkL08eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(31696002)(110136005)(66946007)(4326008)(5660300002)(2616005)(6666004)(31686004)(16526019)(8676002)(186003)(6486002)(86362001)(83380400001)(52116002)(6636002)(66476007)(66556008)(36756003)(8936002)(478600001)(2906002)(316002)(81973001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S7r4wvMXK5ENOMPDndVAc3qXNiiTNTTgUHgHPvIXCEE0LaLxrokWp68jlzG6p4vaXe35Kt6zt4hm97aClj3VNTYli+eKlgihFnLFpD2YdN0N79NEc1h3tY/ks6KNGDgnbJ65ynxd3Fo6jfkt8/RfXa+QNq8PLGkcws5gjSphqY3c8zQZJQJUc1BVH237KTv3QQUvTFcRcsBfqnKqBN8XLZO6YVnHKi5NFk07Egmc7MVhpfnGUDGKQ/xtIO+HjiARzldGBNF6FSLokTMwjXHL1u8Sr0iiBwb1kkkapP6b2+JAqfaMbeAlgfLkgmPoyk9zLNohP/K1FjDbvAtbyqdVxCIJqAGfAHujeuu/VsvMoP5M1b4AnjLuRQ/ygyG2U8qgFIu0LS6oJ3cvrMIP5gsu5C5cJa3WPSs3o7WACEImhcHJLxwNs+XUx/zbrfGRDYskK/8ZQsW3oj9lCYl8sKAU5ynx6hcrjyMLYtORXJoJtFQtPdNmzgkZ046D2wyCT/SlTGQDiHQjBnd6rsbEi14S0NzyFzgkIRVHz8H4NSG0z+WHsv35MBlnS7dUBTuhOhGN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942d0598-5921-4d94-3d7b-08d82fa6cb70
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:54:29.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c6cx5nF6R6PHXa3ER9TOEFnpX6mnyfxN2VdzPr4MSnvnXh8aOXWZJ1iEXgXeGrT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.07.20 um 15:44 schrieb Paul Menzel:
> Dear Linus, dear Christian,
>
>
> Am 03.07.20 um 17:29 schrieb Christian König:
>> Am 03.07.20 um 16:29 schrieb Paul Menzel:
>>> The newly added hexint helper is more convenient for bitmasks.
>>>
>>> Before:
>>>
>>>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>>>      4294950911
>>>
>>> After:
>>>
>>>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>>>      0xffffbfff
>>>
>>> Cc: amd-gfx@lists.freedesktop.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com> for this one.
>>
>> Feel free to add my Acked-by to the other two, but I'm not familiar 
>> enough with the code to review those.
>
> Thank you. Sorry for being ignorant, but what is the way forward?

Well, that's a very valid question. The general approach is that driver 
changes are pushed upstream through the driver maintainers tree.

Since this driver change depends on a change in the general kernel an rb 
from somebody who feels responsible for the code in the general kernel 
might be a good idea.

But since you already addressed Linus comments and it looks rather clean 
I think I can just push it to drm-misc-next on Monday if nobody objects 
over the weekend.

Thanks for the help,
Christian.

>
>
> Kind regards,
>
> Paul

