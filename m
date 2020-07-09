Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42089C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B6C2070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t0Hc5/hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGIHOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:14:24 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:6093
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgGIHOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:14:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bajAfyBEv39jU6HeINw2E5cN4t1Xan9TRk4evE5LhT/bAS/OK+zzZsnv8hL4bge1JI4M+8kZLxI/xadckH7aPaJDgV5n1rtIfaVDtHyfswifSOHv4Nq7D2mXeqSoQgiYZBfZlkBN/txFxVEwFr9+QQ0inLh5kLzvBv9q4r7OlvwJg+MHCL4HAtec/+jbHsFDTgJjjTiPmJW0NwV6VAhSZrSA3PnINfi5vShzzhMsNYotgxUkFE1JI03s2PsQUmcvAr25LFYTEuBeQbuw6dNuZsIAvEJkQR2BYVkCm9VvJFdKRHAcz8Wsm5m9ivfx8JtQCNhbPS7DhQq46ZmFvZGixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiBfUsRoPbicrFS00U00A9dfXz4h58ZLnfTvFVuOioc=;
 b=L+G8JCWRBAHfBl89B6bJ2rhh6z2yXIg0/txrjwSyamsqOrou496nBMUwUlFu6JS4gin8oKNUeD7nZN/churo9xC4P3wVasCzwEVspsqp6Pg7Z9XQTvLinrKrbV/+5aUQ0SPq0K3bdPDH2cFn3S6LQUCOvXcveKQeL8TwCybPqJkw9MtE9WTYWYVguDfCQCjcJeWBsFOui3VQrcTXoxW+t9ey7yS8zbNxo4IduNIvVPUSeIKCEI1CVxfgbshFy41dl7EEkvfozFlpqi14LMfqU1XJjZjE0m2o7vqiJxmUkyTB5Y9gbIIGyWIH6/xp4cXr+UsADHTppt9gMQqfHPis8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiBfUsRoPbicrFS00U00A9dfXz4h58ZLnfTvFVuOioc=;
 b=t0Hc5/huO7JtwcnXLwGX2bL3KZBGS8XfPG1n4S6zJI1gk2HfZ9HFCX4ibpHY4m326oMkBpnMfW1Xc1X0emsx9jazR7CjSn6i6iPqlUJrW1ROKvEERZAOLl1NptzZKp2PoWqWm/QZNoWlgApBELOmx438E68cUOYjYMd/tYY69xo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 07:14:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 07:14:20 +0000
Subject: Re: [Proposal] DRM: AMD: Convert logging to drm_* functions.
To:     Suraj Upadhyay <usuraj35@gmail.com>, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200708161123.GA30962@blackclown>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e5389684-424e-6a38-37d8-9910cdb8b2f3@amd.com>
Date:   Thu, 9 Jul 2020 09:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200708161123.GA30962@blackclown>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::25) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Thu, 9 Jul 2020 07:14:19 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fc1c0dc-345f-4738-179f-08d823d7b347
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB437542EC31D537FE8300935A83640@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rObzAwXJYvw/f8+kT+BbDns/5wnNamYJpJpix6YxsP95KrlrxH8J4HeoPbA9CPyL3i5I2tx3/Dj92rOCPM/+jscSIaOeEuj5Mz8bcBAOkZfKGTWCasykJnitRtvIvxn69y9Zp7LpZJb4/4VSpoJZGyYwuCYoG3lzlPO6QUws1qV5HbdpS9wSwi2BNTws0S+YnoZrHrQGYPdkyKhQPFkOcB7hisjNgKHiAbvgYxwtdHEZBAXfY4DKhl+K4y/qzvtvWYl8cCMO0bzAocJC5DvPfpLq+2I6L7vTxVGQfl/exI/Rz8SVTzZLXeJ51l+vl563Gn9FOAmOM6DWjFJhAoZ18x6yFSbkGbRvoDSjz8lTMxSeWTPnFoLQrpdZef5WPc+1LCJdTRiIg476An/tLxZ+MH4hEH68gywRgBHQ6cG4WdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(5660300002)(4326008)(86362001)(52116002)(31686004)(2616005)(6486002)(6666004)(8676002)(478600001)(6636002)(66946007)(66476007)(66556008)(186003)(16526019)(966005)(8936002)(2906002)(31696002)(36756003)(316002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hkE4Q73nKoYamwbV6zq6wWUTXGLjjjY5PeWWzpmqZk6bl78G43VYEo5z3CVUTbrhJ3Kug++D8YL0asNwQRm/E131b6dAUbUp7U3iemmwqUfjOoIWqify951XpuZy8kgycqSWvD7FZLXHJ7w4RVb9DoZmA7SE6MAQ1qokqADqt1XQw+AaUAbgD5YxQW4bCPTLXFT1O5MGtbilUOify1KxzQeUuzgk0xrlJGha+ETCPYk9g6U7i0fTflAIISj90NJfriXA2zsgDcYUxYomnoqjqe6cc/rGA1KBcDG3lU0PYtoL2KTSMuyIeZf70RiC6IPfMUH2Rss9gKUqY9hKZlgzS5l6vFDP7b0CrmDkIA/o6zWKbLdEzdSfjNehbww96eNfesgRCKbHa5UNi90vUZuH6f7pXJbn4b/mKI1cMapid+uPsnv+rYhrvvuhHQ8xMWE23uAJrOkDvbcrpfiQG1/WWkgb9ClYrcb8Y8bL/gO/SJh+SiQEuSFugPPygZMJg/zejrSfYZ+JJlAzBbdw8JnJAXASMcujhJyKILtovvhOE01sjgrloyrUplyO1r8uS7qN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc1c0dc-345f-4738-179f-08d823d7b347
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 07:14:20.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Viuqak/Z/Nya7Lqsxu1Skw20pJ2+uooWlyop35BrsuH2U15TxorQ8zbCzAat///V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.07.20 um 18:11 schrieb Suraj Upadhyay:
> Hii AMD Maintainers,
> 	I plan to convert logging of information, error and warnings
> inside the AMD driver(s) to drm_* functions and macros for loggin,
> as described by the TODO list in the DRM documentation[1].
>
> I need your approval for the change before sending any patches, to make
> sure that this is a good idea and that the patches will be merged.
>
> The patches will essentially convert all the dev_info(), dev_warn(),
> dev_err() and dev_err_once() to drm_info(), drm_warn(), drm_err() and
> drm_err_once() respectively.

Well to be honest I would rather like see the conversion done in the 
other direction.

I think the drm_* functions are just an unnecessary extra layer on top 
of the core kernel functions and should probably be removed sooner or 
later because of midlayering.

Regards,
Christian.

>
> Thank You,
>
> Suraj Upadhyay.
>
> [1] https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-paramater
>

