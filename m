Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38ACE20885
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qwXl9iaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCNwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:52:45 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:6225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgGCNwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:52:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMx1kt5fw3voKwQCqIfVb8Ght8BCQSeXs3mqNvwRquqqOCgd86f/D7bQwCbBzOzRVPk9VXjMwLlzr3YviJ81Pw+KO4Nj3p1fhWN6VPzBLTaoNTgPW1L67l9nk8Wizs8VgiKCLgeWj5ls9Xb+pknJN6rzNVhIAZ2jE80ioXL0mmfy6uRguhR0UoHkCespQg0Ll5jg0GblqvUKt56wMRwnSyQ/DtDNHA3fKqBbpcFf9VhDP39vsj9I14ImwFAJ1HMSExbGXq6skT/5VSk3mf1GdmpGlqdNVtgsl8XXHpGZbQcRK19v8UO6IcpkbtHifqbqLWWzEQ6Xs+ECzVPHBYw0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTto8IfKnOWocnE5Ul0fKemrW3OE3XCsiNAWuiXBkSE=;
 b=m94z7Iq7jkYsfvE438/iabcWu4ev/geoG2xiz7B6V/+Dhu39O3K5a+f7/1QVMAZ7TyJV1/xX0wYXS5TIFDIB3ZrR2ezcwlaVZSzyk+wReY5Pq97OXZRZlgWtbNDAHZwmvAQkHFHcwPsFfSsfU1QKccLNWWLv0KGHLk6kGf5hMPmyh5e6qO67+RfoeOIf2xrXKFG5D3xynZd5Jn0ARlAlsddRcuKMmc31nIp0MqGWBUHwQMuoESMzj+EUB1/kGyk7A9CPufsMhMNeKnrTl55BP6x7MwHPtqAn3ezc0gYlG4sxIt6TScg17w6NBT0UK9xaagqTnFW5qVDXMISnWGGthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTto8IfKnOWocnE5Ul0fKemrW3OE3XCsiNAWuiXBkSE=;
 b=qwXl9iaYMjXn0h5xSZSVcpIg5nEZPNNKiuMk0Kod7aD2U5wQ0dPV5Zj4YEa7XBzjMNVZ6oD6GtDw28SO2MQGbO1wSQRD39R7SceVI5huVcCwzuKJNI6Fl0liQAbMwuf3vQ4MDTplqp13D+QCRBDGu/47F3LBbPPWPR9lrydFvbY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Fri, 3 Jul
 2020 13:52:40 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 13:52:40 +0000
Subject: Re: [PATCH v2 1/2] moduleparams: Add hexint type parameter
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <73fce393-45a5-180e-307a-4f399a31c858@amd.com>
Date:   Fri, 3 Jul 2020 15:52:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0004.eurprd03.prod.outlook.com
 (2603:10a6:208:14::17) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR03CA0004.eurprd03.prod.outlook.com (2603:10a6:208:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 13:52:39 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 975697a8-6ef7-4797-90a2-08d81f5859e5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42373BD7127F7E6053ADA466836A0@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRVwIunjyd13K1rb8dMzxs4t/3Y/FCjY8tX/zF5IiK9xlL2HkFGPSZEeX33fEcLWPHLdO3nuPW9MKAU355b0gsgyernIJAwK8M1UAU0ZbalnrJNGAEnhjuLCNcAPI+zdhBIttd4WQjdBwJDiBLS8UULqH94DjwPuPE+Y1OafFX6PqdBVyKRR0xQscKpCXIVBdENgZOMtCD4RtDpgDM2UT5RSsKW8GsTXs6n9QNOmBPUV8YyUcVA18NXOfXXcTr4oFnr/HkDLxP1EXLioeZtQHx49nwlEc8Mv7n1sA5r2VUzeS2RSwSEfoxaIoZmyCWfKE48OGlLLOEyhtvQuvqi0gQlr4wqa7YQ8JlcqLjzfKhBjClWnsdpGdjKMNdRa+Kge
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(86362001)(31696002)(316002)(8676002)(8936002)(110136005)(36756003)(83380400001)(2906002)(4326008)(66556008)(66946007)(66476007)(31686004)(16526019)(6666004)(186003)(2616005)(6486002)(52116002)(478600001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sKaiWC0qc29MoekfdizLKGkhwmJMGznQBO3P6z8LiSsOOz9O8vk2klTl0USzghRcrNRHgpsRTcsYm9zGuZ7teV358JL+T+I1i+Ay7ryyQ2Sxd/7vUmQ/0jZAg9rzBal7qdlzVlYV7kCIMP4xjNTs4JtwyMmViLrU0+fMU4iJbvLSejagTmb7gjJLpzZTUkm0oO3kDSOE9OPO2lZRNgCZj94aPw7Wx3Qhmy2qQy+PaYV3hJwkU2nMDxDNnI8HhAFr39AYUD/FTwKTgLoFRgbmbMV7wIATj8qpOLU7uUkR2ALlYCATPDhC0WikDHaCmHeq1ivbHgt8Fu7TRtd7kAaWeaVIQ0DXFVmukJI6OeCshGbFZzmZAIcc6X2H6SuZbhC0yXlGfFs6T5KFYSn3pa8DR5BriKgMt8cjUg90U++ClAfXfJhAUbBXb7klNgXWw3E9imG/0BwIm6dhh6YMMl4ZcDExeXrys5l1tvjLdjf89/f9BEG0EnaTRntZ3M5mXywb01q3/YTq8+/arPcg5G0HA+Yfvp1MGiTgwjo5ZfC/UEnDg5CCw+7dgg3ecWHg4wKO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975697a8-6ef7-4797-90a2-08d81f5859e5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 13:52:40.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GK3QxIEPsu10CAngig9203momqFrEI2nY7TAwOSVMUpgBWmbHiiT+M8ivhQL91J+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.07.20 um 15:49 schrieb Paul Menzel:
> For bitmasks printing values in hex is more convenient.
>
> Prefix with `0x` to make it clear, that it’s a hex value, and pad it
> out.
>
> Using the helper for `amdgpu.ppfeaturemask`, it will look like below.
>
> Before:
>
>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>      4294950911
>
> After:
>
>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>      0xffffbfff
>
> Cc: linux-kernel@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Address review comments: Rename hex to hexint, and pad sizes
>
>   include/linux/moduleparam.h |  7 ++++++-
>   kernel/params.c             | 17 +++++++++--------
>   2 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 3ef917ff0964..cff7261e98bb 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -118,7 +118,7 @@ struct kparam_array
>    * you can create your own by defining those variables.
>    *
>    * Standard types are:
> - *	byte, short, ushort, int, uint, long, ulong
> + *	byte, hexint, short, ushort, int, uint, long, ulong
>    *	charp: a character pointer
>    *	bool: a bool, values 0/1, y/n, Y/N.
>    *	invbool: the above, only sense-reversed (N = true).
> @@ -448,6 +448,11 @@ extern int param_set_ullong(const char *val, const struct kernel_param *kp);
>   extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
>   #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
>   
> +extern const struct kernel_param_ops param_ops_hexint;
> +extern int param_set_hexint(const char *val, const struct kernel_param *kp);
> +extern int param_get_hexint(char *buffer, const struct kernel_param *kp);
> +#define param_check_hexint(name, p) param_check_uint(name, p)
> +
>   extern const struct kernel_param_ops param_ops_charp;
>   extern int param_set_charp(const char *val, const struct kernel_param *kp);
>   extern int param_get_charp(char *buffer, const struct kernel_param *kp);
> diff --git a/kernel/params.c b/kernel/params.c
> index 8e56f8b12d8f..487261eb836f 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -233,14 +233,15 @@ char *parse_args(const char *doing,
>   	EXPORT_SYMBOL(param_ops_##name)
>   
>   
> -STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu", kstrtou8);
> -STANDARD_PARAM_DEF(short,	short,			"%hi",  kstrtos16);
> -STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",  kstrtou16);
> -STANDARD_PARAM_DEF(int,		int,			"%i",   kstrtoint);
> -STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",   kstrtouint);
> -STANDARD_PARAM_DEF(long,	long,			"%li",  kstrtol);
> -STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",  kstrtoul);
> -STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu", kstrtoull);
> +STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu",  kstrtou8);
> +STANDARD_PARAM_DEF(short,	short,			"%hi",   kstrtos16);
> +STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",   kstrtou16);
> +STANDARD_PARAM_DEF(int,		int,			"%i",    kstrtoint);
> +STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",    kstrtouint);
> +STANDARD_PARAM_DEF(long,	long,			"%li",   kstrtol);
> +STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",   kstrtoul);
> +STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",  kstrtoull);
> +STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", kstrtouint);

All other indentations uses tabs, only the last one seems to use a 
space. If you touch this, then maybe make it consistent as well.

Apart from that looks good to me,
Christian.

>   
>   int param_set_charp(const char *val, const struct kernel_param *kp)
>   {

