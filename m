Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F09C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770692253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DWX3GAKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAVJEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:04:41 -0500
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:28003
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAVJEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:04:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuaqTA2c2wedhMOUUXkha7inoyUD016OA0Uo/GuL4Q0pOBikQCaiuAjPPKfGTbX0QClfFXRfEDWd/qcsH2rQWG7H6/bmqcVwubMB+vUI9ZkfR6dcLApCV+X8nKPh5nKnxelg0jTuTqKcWnYKrhH2nL48MJeCF3SmwMnvsekDQLIi6FZMR17yK04xkCSYESA0bDQx213WzndWIlBflrV6imeNCj84YSNlEI7KEGFWg/y7cRRqpon6VTnKipsiSP+3YoqGKzqPjW3on3Xsb5MfMcwJkujHbt4cr1SFen2LAGm5vbPQ3jhWHXv+MeZmtWR1N7woIHFXnkcMVihk/IbeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9neAiRGJ2owE2sQV18UZ1qGXVvMyWjaZ0WRzN1Iv/UI=;
 b=AqoOikJKKZ4ER1+5IQC8H2dxNJRytGOfevdqCf7X/glmo9GR9yrFUpQAQrKzUpPbdBxvkezBQsey9P65GNoEzCKVFpVd1zePvXkf7ujd2xdUKkoq7dRYcaum12vyc8iL1W8pixWtCDzHEyECB7Fls0No4mGcCv482gdSzhBDhqthGer+03iH1fC5t2R42uUUtyOjlO7qqFzvQUQgQiljkUWJm9bc6CPFFbgV72PCH9HUaZbgpLil7eqViaGhwhExXfqFOv7wWkuxIIjHmkLwDYhvLjs1UemBRzMC1dCIg9dK7zGzGqqHkhwcQ1f/VzWd/rvkTpYEfkJI6p+Qg1DfzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9neAiRGJ2owE2sQV18UZ1qGXVvMyWjaZ0WRzN1Iv/UI=;
 b=DWX3GAKyOSUiO2m46nJcoRBpnNP0W1ja5xPqfgTqpTwMnAV8tFx58U7kAGGitI+rCOSJ+814jyD7hFYkECsXpbXnuR0uAfbHbtC7Rwv7UsjjrjHMb8vsrzylxb/Lk1dl3iDhP/CmHtuWP9GA2sL6iywJCRJWMKKcjYJ+2Nr3Kks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rijo-john.Thomas@amd.com; 
Received: from CY4PR12MB1925.namprd12.prod.outlook.com (10.175.62.7) by
 CY4PR12MB1239.namprd12.prod.outlook.com (10.168.167.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 09:04:37 +0000
Received: from CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::9be:baba:170f:3e2]) by CY4PR12MB1925.namprd12.prod.outlook.com
 ([fe80::9be:baba:170f:3e2%3]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 09:04:37 +0000
Subject: Re: [PATCH -next] tee: amdtee: amdtee depends on CRYPTO_DEV_CCP_DD
To:     Hongbo Yao <yaohongbo@huawei.com>, jens.wiklander@linaro.org
Cc:     chenzhou10@huawei.com, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
References: <20200122071643.8122-1-yaohongbo@huawei.com>
From:   "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>
Message-ID: <422bf3dc-2d9c-1a12-a7d3-a6dc9349a648@amd.com>
Date:   Wed, 22 Jan 2020 14:34:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200122071643.8122-1-yaohongbo@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::30) To CY4PR12MB1925.namprd12.prod.outlook.com
 (2603:10b6:903:120::7)
MIME-Version: 1.0
Received: from [10.138.134.82] (165.204.156.251) by MA1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 22 Jan 2020 09:04:35 +0000
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b97f1b9-1dbb-4ce2-fbdc-08d79f1a1b4d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1239:|CY4PR12MB1239:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1239903A210B119DE9723EF2CF0C0@CY4PR12MB1239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(189003)(66556008)(66476007)(16526019)(66946007)(31686004)(36756003)(81156014)(16576012)(54906003)(2906002)(8936002)(81166006)(8676002)(478600001)(2616005)(6666004)(53546011)(5660300002)(26005)(4326008)(956004)(31696002)(6486002)(52116002)(186003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1239;H:CY4PR12MB1925.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8m7M6/Ls0GJChL7vo6/lpLYzPR7vLcbAPXvq4N6MaVxzWrkTG1vWF9YMKUiC87QENIwgB/D5/eDP9d0nFuI7GxWc0IYE/Y7lu+O6rNHxevAzceWZpnuv+ZPC+mX103Rf3a/yK8yToODbzzk+Iuwz28KWhOu44S+7YzFN5b6zP1Eo5V1Q0tPP0CvrhrYqaJt5y2DI2ZyZQ4epkYaQ1kPbPD+AyfRV/H3NQGb7DncwBiXaSfpfmvMgthUxNItSziqxyrz049RBRelE5AQflhHLxbI4PXs796ttkixPc6QhGU4ouYcr5EpC49Ojrc7+eZeygO1yP8ud0MsWwhCAtLocJBK8qMxQ2VIZIVO+SIaP35C6eEM2TlU4hvcjOnVJAOFU2hXMg3EwEI6NOLLZWDNq4NTaZWdsJ426nbUHz3k9aIZTQ6m00S5tD3sYOYeUhlgs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b97f1b9-1dbb-4ce2-fbdc-08d79f1a1b4d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 09:04:37.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 269jUdZK2JRz3ba2vhtEHBpyZH2+KRoNhUDM+DbLH6w3C8uOoPFlQEIceDEhIfDz9hz7H0YVvcPUIcJZCghOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Deva, Herbert

Hi Hongbo,

On 22/01/20 12:46 pm, Hongbo Yao wrote:
> If CRYPTO_DEV_CCP_DD=m and AMDTEE=y, the following error is seen
> while building call.c or core.c
> 
> drivers/tee/amdtee/call.o: In function `handle_unload_ta':
> call.c:(.text+0x35f): undefined reference to `psp_tee_process_cmd'
> drivers/tee/amdtee/core.o: In function `amdtee_driver_init':
> core.c:(.init.text+0xf): undefined reference to `psp_check_tee_status
> 
> Fix the config dependency for AMDTEE here.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 757cc3e9ff ("tee: add AMD-TEE driver")
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>

Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

You may have to resubmit this patch to linux-crypto list, so that it shows
up in patchwork and applied to cryptodev-2.6 tree

Thanks,
Rijo

> ---
>  drivers/tee/amdtee/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
> index 4e32b6413b41..191f9715fa9a 100644
> --- a/drivers/tee/amdtee/Kconfig
> +++ b/drivers/tee/amdtee/Kconfig
> @@ -3,6 +3,6 @@
>  config AMDTEE
>  	tristate "AMD-TEE"
>  	default m
> -	depends on CRYPTO_DEV_SP_PSP
> +	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>  	help
>  	  This implements AMD's Trusted Execution Environment (TEE) driver.
> 
