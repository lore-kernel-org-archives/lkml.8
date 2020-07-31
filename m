Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069EE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ojwMuwtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgGaClx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:41:53 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:1304
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730820AbgGaClw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:41:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D70rYDDWcus4M1PcTu7l6dGWVXa416Mulkc+1wG4THe3FOVdZbUIq6sGaS78r8CvXSoULqyO2FUt2HNheQFa65g2Zsph+QI92WR/6VFdSZMHWQ7Cb5IZ5CoXMF4jgiUdAof5QCqQCduwjfy8WtRCCLm6Nda3jz6Za5hxhZwZAUabUTC/E5k2y9icLzAj3yBWi1DLCCVLXLrJiK76/pmWF5uVGLL+3bp019+cON9GSxamulWD5e2oED8wEvvvRlgP2LV15tUQ/1Xv/Cwa9lmU50K9U49MjIBb/zHmQRjjz5DygQTWbI1yVsOGc/NZVmtaD870pOYOKUHo2vaNUqEqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fTsY0Sdho0Cy9sMoBptEnTflUOdcCQKPJ+Uo1WRE9Y=;
 b=hPXuljPm8gCm7GPiTZEHmiK4Ef7lU0f56sRlQNVcfUs/hKLycvSAbs64xL5iKEdK5nHpJu4znsCQtm+ZWv8QWPf5Xrwuk4mqoWkOmWoo1OaWAONsPWtWUfEELP5J7OYEdx6CYng570IlIoo91vDznl/eYlOyKagSWaULrtzgQsJtXByNTomoK4hFQiTnp8Dqzj51ikkfMgYh7fBfV0pTGLXa4NRwhRCAIfxOJe5AWPWPRSCzPuMJmPvLEWH1SR6zcAOrfGF936+Pd8zrzKBtJMNeQnAibRHCU1HOSY3JBESQpwbIzceiE1SN13AMW2rMb3ESF/RZGF6JDcpNyNTZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fTsY0Sdho0Cy9sMoBptEnTflUOdcCQKPJ+Uo1WRE9Y=;
 b=ojwMuwtwM31s870d9W/m33Pgs7lK15PquabtGkj8m6iT48SH7QOe9LqJ6BSLX3CiXVU4XXQdl9S4NYfrg9GpctzZe8C2UKqB8vLSXn8NIg1ojlYIm5LD5SN46dm4FsuAv5hP5sUxYYydzW5aABjD9Bd1V6A9x8KYzKQ9Hg6ItrE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 31 Jul
 2020 02:41:48 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::657c:114:220c:88f9%7]) with mapi id 15.20.3239.019; Fri, 31 Jul 2020
 02:41:48 +0000
Subject: Re: [PATCH] drm/amdkfd: Put ACPI table after using it
To:     Hanjun Guo <guohanjun@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org
References: <1595411308-15654-1-git-send-email-guohanjun@huawei.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <443ace32-0860-f823-bc3f-3faafd5da54e@amd.com>
Date:   Thu, 30 Jul 2020 22:41:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1595411308-15654-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::26) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by YTBPR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Fri, 31 Jul 2020 02:41:48 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9e3c5d2-b835-4d87-b5c5-08d834fb45b8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766C7F4A0AB648490F2CF2D924E0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wjvj7yNS4oVOsmkw1/wLCG499p6/7GE+VWraHlJP2O5MdinYrfSI/S5ieHgZlTCFrtsJpCDTWKAa9wyODoxUGVUNcl/fgyao21xDfVkthFFs+PKpV4yltkyzbYY1nDkSG6XHe5mJvqTaTsuee7rbrwo26exbXRKMgvUO5NYKoU3dd7uuKaMwRDTTRoW5n9Ugyco0QrpGMrmjnCnSVpuVhFYq2UGaGAML8C5W+SaCC7V+HkX4MNFKRmhfjQQgWeLQFzYVFpVttbrW309D0qLUdrj9cx0Q8SmmwsykrsP/kKpOPVjdA0m289j3BLyeTbXNLhrjUkFI9wxLGZ6MrW+GUhdVLZkymnfUhsBBHKpQMKtxSylfyPPahoxwQo+oKlT1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(16576012)(316002)(4326008)(8936002)(6486002)(8676002)(83380400001)(31686004)(2906002)(36756003)(31696002)(66946007)(52116002)(16526019)(5660300002)(186003)(956004)(66556008)(66476007)(86362001)(110136005)(26005)(478600001)(44832011)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CgyLGm6wC+KdA9MrtwUyTF86UJd3PStCuUYbSxPfuu7Zfyh7RrK6QjVpfE5n24FKco/quZKQZAEujv39pEgq3Mn1IAaaVOAuU28Y6rzBiale4NYyCuoinwfYVdbgH/tIIPnvAS7PEKgKc0y+fj89MrN6QTELCvrVxKo0QahePbwzZV8LC/xlqe6aRezJuu3CFCdG3jHOPqhXxDdXlLGdfFL3XtEUXFTojfFdd9mGKFk6NB/kLPP/DjYgDNYzPiCVToCskjbquwyFgIyDcmIVCPHMohf1s4keu0dh5QYlmauIVHJjx5AFspgH7d9AAGGICQIZMOz+g27lFbYAjrGSNyO2sHstRiAxHCRC03c4Lox3T7irLJUzJyS7ucnm5RsBSl6IrBQfOVB+UymZWVla1LalXZVGBYnaka5oYmPvJr8JBIJMhTEsu1xnTTXBMg4eQZinBJFcU0PJch+pcuGAiVzfhWbA/F9MiaBoyq5Ee0If90q/FI3icrH9cW3iKmSz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e3c5d2-b835-4d87-b5c5-08d834fb45b8
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 02:41:48.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yHDH/ctuns5S99m010C9aDH98M8WJYGwxmG/B9X2joK0/3nvP4cHcUT7RxxtKq768/gOxNkahOaPdIYWT1HMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanjun,

Sorry for the late reply.

Thank you for the patch and the explanation. This seems to have been
broken since the first version of KFD in 2014. See one suggestion inline.

Am 2020-07-22 um 5:48 a.m. schrieb Hanjun Guo:
> The acpi_get_table() should be coupled with acpi_put_table() if
> the mapped table is not used at runtime to release the table
> mapping.
>
> In kfd_create_crat_image_acpi(), crat_table is copied to pcrat_image,
> and in kfd_create_vcrat_image_cpu(), the acpi_table is only used to
> get the OEM info, so those table mappings need to be release after
> using it.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 1009a3b..d378e61 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -756,6 +756,7 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  	struct acpi_table_header *crat_table;
>  	acpi_status status;
>  	void *pcrat_image;
> +	int rc = 0;
>  
>  	if (!crat_image)
>  		return -EINVAL;
> @@ -776,17 +777,21 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  
>  	if (ignore_crat) {
>  		pr_info("CRAT table disabled by module option\n");

We should probably move this check to before we get the CRAT table.
There is not point getting and putting it if we're going to ignore it
anyway.

Do you want to send an updated patch with that change? Or maybe do it as
a 2-patch series?

Regards,
  Felix


> -		return -ENODATA;
> +		rc = -ENODATA;
> +		goto out;
>  	}
>  
>  	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
> -	if (!pcrat_image)
> -		return -ENOMEM;
> +	if (!pcrat_image) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  
>  	*crat_image = pcrat_image;
>  	*size = crat_table->length;
> -
> -	return 0;
> +out:
> +	acpi_put_table(crat_table);
> +	return rc;
>  }
>  
>  /* Memory required to create Virtual CRAT.
> @@ -970,6 +975,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>  				CRAT_OEMID_LENGTH);
>  		memcpy(crat_table->oem_table_id, acpi_table->oem_table_id,
>  				CRAT_OEMTABLEID_LENGTH);
> +		acpi_put_table(acpi_table);
>  	}
>  	crat_table->total_entries = 0;
>  	crat_table->num_domains = 0;
