Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA402C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA3208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z22L8kU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDUEUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:20:35 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:64065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgDUEUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM2yvHfRyVPDbmulYww1T+WwG+xvyybRuryhE9Oh05jfGv2lY5bM55ByUqSscCwTJtvah34XszOW+sN6mAyE3+apZ/5CZVHSKoxTLg/kaHb+QK81gfNhJq1pcPsDm76i+y7jo7X7sNscO/pSec80COCFBuHmnH3lwIhjCOZpc0eoiuC1tkmOckmqPgDGrtUOkhPRyur3hbgSzPGKgC75oeRYQVJqneFyxCr8SN/1/wYkjYG696hrkoa1TUysHRA9MvqSedfGGhyQukXeQV39th1wHL3IOR6Yeue2LhtVoQbLay7KOb+Tf/LEzqeEPdsP3paWNfBlzJErNTAfuOTv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtQt/OnHibnVXo60N7SHI8zhmoFaGicObq36jZ4RgDQ=;
 b=Zi3wLN82CF6r7ligWEoYIUSoaEkj9FEi+gTxhP84XQ8G/nQJVDtk0eX08gW2rRpCF48S/o4vhBZLoWrFCJa9f6kCA1dRMQ+xBRYNL8IEMQa3Ni7Y68sUlX0QUbYLgvKCeCZEokOD9ExczBJsnGDS/yqzZUDFN/kyiDI8xoKR2HTRbSPnKdzysafzh+wef8jlUMMdVGdjnTfkeVKoqQf3SKBW4cDCrnHOu2w5br3sTr691YaTssl42JurLHw4Wlpnni6ufUMj1JaJ19aa95tU+5ARGPR8I7bpWGe7TjnVk56DdZR9l/YnRM1uRSWDkE4W1/AWcIM3xpB94Deg3j77+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtQt/OnHibnVXo60N7SHI8zhmoFaGicObq36jZ4RgDQ=;
 b=Z22L8kU9QLb9kyglBig0GHvmHZ1n2EaNz7OgGPr6CGOWgZx4Bvypw7PGPuInYS0ql/yylfmleWFF9AubQ0blrrCqaW1PKP2PlwupM4+HFNNYw12zuD1mO1bRO5xFpWZPskLZkMUXqAMG0cdxSLHPOF9zQXp+i4IKSafRjWc3vo0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 04:20:31 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 04:20:31 +0000
Subject: Re: [PATCH V2] amdgpu: optimization-- reduce noneed mutex_lock area
To:     1587181464-114215-1-git-send-email-bernard@vivo.com,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
References: <20200421022528.126437-1-bernard@vivo.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <16175fa0-4d9b-2de8-e708-22b373a6f7a4@amd.com>
Date:   Tue, 21 Apr 2020 00:20:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421022528.126437-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::38) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YTOPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 04:20:30 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e26bbd3d-5747-42af-e9b9-08d7e5ab540c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:|DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882FFE8CCF6B4BB85518AFA92D50@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(110136005)(86362001)(26005)(31696002)(4326008)(8676002)(36756003)(81156014)(8936002)(66946007)(2906002)(16526019)(186003)(16576012)(956004)(5660300002)(478600001)(44832011)(2616005)(31686004)(52116002)(6486002)(316002)(66476007)(66556008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1R6NTpLPxKqwZeDtBAirtAuTJ1/hsV5IEX2ENiD7aG9SicleGyClcdzBMs2iIJaKIZHuq70jxfm77/k3mAlsMf6bVazp4OfCdQ2yL8IiO/4rOpT6yYsk2yioziopF4boEQROrsM0U1DNt0PfUocU2mFwlfsBW8TkmhzQBO0w9dTg9WPRuKXxAqjsd6jKTjDCNIMYuYY7Z1qufrBZkqDUJgcrGudT269Gp0EhoD3XsBBURAbGGIRKh5n0wWzqytIjhLmlrYeCevOcs+Z7Qd46wIjQ/4cljZHamW658Wp+fChtuK4iQq2iHYnMpRaJ1ekW97Y537YKfR9uGb1NVC6uG1/XO7EWBSB4pOkjCCO+n+tHEVRBNVi1GzT62hgJcqZySpNA0CnR8lqbdVTaRLz/jtyxZ9vHvlnDRWFYiJb1iPiPTXk+FvlRhWWUhncC/Wk3VLT57i9Wd1+UQvlSDMd1wRNHDmYLRPrQBpKMQmX4tMTiTc0oV5urADtd5HJ0Vy3W90nbbIUK+HdpAzSX2AzqBA==
X-MS-Exchange-AntiSpam-MessageData: /V86TuOj5LgXhP6XsnSsmxthsT3qsLt70gz0CV5TW7FMOslqIzphB35XdBDmQP2yXbrYxnl5VS/86SKOrzGliR3v4v/zf0a3Zl0L9pug5WWWffCBbNBedT53d7djK7IGYxRreUsCRWbOHANWBbMYHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26bbd3d-5747-42af-e9b9-08d7e5ab540c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 04:20:31.0684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DsKFkbjvLl2wJ6a07aOYbqusT2eJ20DJ4BRbMOGgl+6l8Z8n++OhmIJDQ2c8EW49GCStx27GRSTS0Q9yUpBTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

Thank you for the patch. Please see some comments inline.

Am 2020-04-20 um 10:25 p.m. schrieb Bernard Zhao:
> Maybe we could reduce the mutex_lock(&mem->lock)`s protected code area,
> and noneed to protect pr_debug.

Typo: noneed -> no need


>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Changes since V1:
> *commit message improve
>
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1226588/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 327317c54f7c..3c3769e57174 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1285,17 +1285,18 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	struct bo_vm_reservation_context ctx;
>  	struct ttm_validate_buffer *bo_list_entry;
>  	int ret;
> +	unsigned int mapped_to_gpu_memory;
>  
>  	mutex_lock(&mem->lock);
> +	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
> +	mutex_unlock(&mem->lock);
>  
> -	if (mem->mapped_to_gpu_memory > 0) {
> +	if (mapped_to_gpu_memory > 0) {
>  		pr_debug("BO VA 0x%llx size 0x%lx is still mapped.\n",
>  				mem->va, bo_size);
> -		mutex_unlock(&mem->lock);
>  		return -EBUSY;
>  	}
>  
> -	mutex_unlock(&mem->lock);
>  	/* lock is not needed after this, since mem is unused and will
>  	 * be freed anyway
>  	 */

Please move this comment along with the mutex_unlock.

Regards,
  Felix


