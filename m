Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05925C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE472075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="IoB0+cg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgE1GJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:09:08 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:6228
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725859AbgE1GJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff8Uq1dLQnEOm9m+d95HCPSiixMyAkbxKPuodtPIF8cJJkLG5ON6rmEOcC8ADj4RKdyAOgzlYZUO9SaV3UkcbgMlBE6axNsVlf1nD3zgizU3r1rVQ+5IKM6JDyc2TSMIFgEwXvcDF52JK00tw709Gp3Vj+x+Zd+0M+r06HhsxJyWoIvizFjtULN07KjcPJgiy8JfqFA/oZHppudFht5TGrNMk8AQDy3ZvNFr5FQEnfYBUZHH1T2QKpUpuwTzKSTAb8jO/lguidGQu6s5ANSjoihM9NXKsx82u+xkcDuWYCRF67VQ6BewksPqHZMoln9tueRUMLw5iVt9eB9fC25JMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdtb7k0erezvtKZlDYfeoifDI1kv6qS2NbHBTD8Os34=;
 b=KkzSH3Tut9yFS5We0sYG8+GMQj6a3bedEtk2F0zp1UWHXcwA5sP6x2hkvXwvJmsHIugARt4vEMLjAp2s1BPpZDWHPdHMy9TzWgZPSDQcRX/lcTXiezh2w8yJlFI/VM2uFQ+0hGoTOewmji/4BIzC6/xHE4gfcNJDIkEQje3IJx7MsRE/rKVv6PLueDoMyACT1QOXqVRABwMWmdP2qH+EsFR+uT1BiBMBYO0QeWUEfUpDYUr0PZ88VfuxSKYUmmn5BbNtV55SVYnHPrm+Z6jsEV58oa3mGQkKGMEY4JejmuI+XSfq2g+wncywAeUmbAziCp4SOoSdg4lh9lScClhi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdtb7k0erezvtKZlDYfeoifDI1kv6qS2NbHBTD8Os34=;
 b=IoB0+cg7WE74ExyeWjr0IGLJKLa6EYH9aW8nQnnrpTEotFFxxPoi1SKonsUbwM801ZBZe5vwRLxA5LruSpuW2DTn3qz+8Lahv464L4oTubT+DLw1O5Cd3EJKHLE39XG3c+1adUWApnugdtiu7Op1UpA1/OQvX7Ukq2g409b+EIE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from HE1PR0601MB2251.eurprd06.prod.outlook.com (2603:10a6:3:98::19)
 by HE1PR0601MB2156.eurprd06.prod.outlook.com (2603:10a6:3:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 06:09:03 +0000
Received: from HE1PR0601MB2251.eurprd06.prod.outlook.com
 ([fe80::9864:8c:829f:f47f]) by HE1PR0601MB2251.eurprd06.prod.outlook.com
 ([fe80::9864:8c:829f:f47f%12]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 06:09:03 +0000
Subject: Re: [PATCH] tee: fix crypto select
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200527133924.724819-1-arnd@arndb.de>
 <CAHUa44HXs_h5ZBizHXDtYWa9Ubk=64AgiM5zj7rGx0CxVcSbTA@mail.gmail.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= 
        <vesa.jaaskelainen@vaisala.com>
Message-ID: <06e95717-7b00-68ef-67c5-d01422839994@vaisala.com>
Date:   Thu, 28 May 2020 09:08:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAHUa44HXs_h5ZBizHXDtYWa9Ubk=64AgiM5zj7rGx0CxVcSbTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR05CA0377.eurprd05.prod.outlook.com
 (2603:10a6:7:94::36) To HE1PR0601MB2251.eurprd06.prod.outlook.com
 (2603:10a6:3:98::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.24.18.171] (193.143.230.131) by HE1PR05CA0377.eurprd05.prod.outlook.com (2603:10a6:7:94::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 06:09:02 +0000
X-Originating-IP: [193.143.230.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c43008fb-fbb9-4ac7-a94b-08d802cd9ed1
X-MS-TrafficTypeDiagnostic: HE1PR0601MB2156:
X-Microsoft-Antispam-PRVS: <HE1PR0601MB215696219B0D2BEEB5DB8488ED8E0@HE1PR0601MB2156.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhaBTGdBshRF8Q3GA+DZAIYV2B/GgEghSM26Hz9RVN/Kekh9jnJKMPgFUJziWgmZN4E/5XoE9j8oKk0Iqv25QUPy9qIe1Ogeo4pJ4v+vQCdv/CJ8lmvuVTNPQFTAdFOvGD5HDShsWxQ6RRGivznBGaXUZMNrqZQKI3Zdr9bYf9lVhZjS+JcpqomRfJ8y1FPEzmlFCBhbkl+jOOHGyFYVMy2iL07kyaBroQEzMUO8lXLLQcUgZe/X5pl0fnZpSHkSsyzKfw3WvULYdj/fYzzqnrl+G+0QBMID+xlaH6o33eR+vW/byesjAz3lBL9dJ+edBB/sne5rlex9PcXySrQQMDBDzVCQGTNQWsvsX3Ix3//CQ1tiFRR4+driFaOKgG3e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0601MB2251.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(316002)(5660300002)(66574014)(66556008)(8676002)(66946007)(36756003)(66476007)(31696002)(16576012)(31686004)(85202003)(53546011)(4326008)(16526019)(6666004)(6486002)(54906003)(8936002)(26005)(186003)(110136005)(2616005)(478600001)(956004)(52116002)(85182001)(2906002)(86362001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hua6NIsumP+QOEc1tG2rGc1zARRToRY9J38Cyt/Xdf+5Y/f+pYpO6wzJXRxcsFfPpyd+cuYn2JanFCtdjAuLVz5MijnQ1Kk5rKxMKhMhxb0KgtI9E/8ZzBbGG7hKfMZwgl2B7hrnWQu3pkrP5ObCJ9o1xwYFBLZQUxkQ5khu3sFIM3z3B4kvWqVPK/tqIcdZrvNyc7PHc750+h5Bxl2rkkqMhnnp2S7aI93skh4GoUN/FMNM2tpkyK42C+cI0jvxpielIERvEqH94KIRO6gj0h7ozY9OF5U/oRt7vgGXNFq5MWB4582rSkyO4i/FgcngitE7mXOJarNQf2UQwz0Auyf8XTKhRs+vkLByOX+mykpY/k7g/ar4X64yn2Ob9kZzFP7X99aSQ5JiaZkI7TqtGuF/Osgrxr45lJ5MZsKfAz9cXGEnvLlws/OtQ9qQlw0TC8n4Vl/3RcfBKtqPGg5lmDdu1CtiMfBXA0sedhhjwOJajTEL4UJxCETf3Z9TkDxt
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43008fb-fbb9-4ac7-a94b-08d802cd9ed1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 06:09:03.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQqCIhhXmSAlc6f5lBNKw12dGGX2pXhZOPX7vGb2y6vo+T8uQTjCsIGiE2H6RjgDN6wRgMucgKSTDmlg2f34rAnud20tBIsfsIUg3PMQlhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0601MB2156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd & Jens,

On 2020-05-27 18:07, Jens Wiklander wrote:
> Hi Arnd,
> 
> On Wed, May 27, 2020 at 3:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> When selecting a crypto cipher, we also need to select the
>> subsystem itself:
>>
>> WARNING: unmet direct dependencies detected for CRYPTO_SHA1
>>    Depends on [m]: CRYPTO [=m]
>>    Selected by [y]:
>>    - TEE [=y] && (HAVE_ARM_SMCCC [=n] || COMPILE_TEST [=y] || CPU_SUP_AMD [=y])
>>    Selected by [m]:
>>    - CRYPTO_DEV_QAT [=m] && CRYPTO [=m] && CRYPTO_HW [=y]
>>    - CRYPTO_DEV_MEDIATEK [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && (ARM && ARCH_MEDIATEK || COMPILE_TEST [=y])
>>    - CRYPTO_DEV_SAFEXCEL [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && (OF [=y] || PCI [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
>>    - CRYPTO_DEV_CCREE [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && OF [=y] && HAS_DMA [=y]
>>    - CRYPTO_DEV_SP_CCP [=y] && CRYPTO [=m] && CRYPTO_HW [=y] && CRYPTO_DEV_CCP [=y] && CRYPTO_DEV_CCP_DD [=m] && DMADEVICES [=y]
>>
>> Fixes: e33bcbab16d1 ("tee: add support for session's client UUID generation")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> The regression was introduced in the soc tree, I'd pick this patch
>> up directly into that unless someone sees a problem
> 
> Thanks for taking care of this, please go ahead.
> 
> Cheers,
> Jens

I am also OK for the change. Sorry that we did not notice this during 
the review.

Feel free to merge it to the original commit or leave as separate commit.

Reviewed-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>

> 
>> ---
>>   drivers/tee/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
>> index 806eb87d4da0..e99d840c2511 100644
>> --- a/drivers/tee/Kconfig
>> +++ b/drivers/tee/Kconfig
>> @@ -3,6 +3,7 @@
>>   config TEE
>>          tristate "Trusted Execution Environment support"
>>          depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
>> +       select CRYPTO
>>          select CRYPTO_SHA1
>>          select DMA_SHARED_BUFFER
>>          select GENERIC_ALLOCATOR
>> --
>> 2.26.2
>>
