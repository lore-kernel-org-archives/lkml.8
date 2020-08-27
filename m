Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A016DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A5A22B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u2xiLRRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgH0E2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:28:44 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:58880
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgH0E2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOeK+sTxk56rxFNHMRZuByABk/qZi7/JA3UlESFQlnDYl5cxArn03Bac61rpfMW/UF013OQCRiOIc6bf0lW714cEC2lYflsOtzGiazaU1hIL46nTsSIUDGBJdRmDofQ0BXT+LDJEmomKJCZGMhfFPcWaowdtTJXs68netSUB1HGV+s6aofzH4ZVkKKcrg3vrICwZPKXwUepImjOh720TxaOPZSubjdWPh4FlNLOqUU5WxYeFpY3tGyy9LmeYi4L/VxA4luAVxfrbovqDBLihzdu0uHCVykBgJQO/k66UwX28XSqpnTK5E4NmGfvkxouN+3dXARje6kotl2vWPXviIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+bPbadVx/ZxUw8phct8jIUERERsYZrQf59R3fvEu0Q=;
 b=GpHWGlrJYleqptQ/D8aWaotdVFFsNp3qfn+Ky/iO7XbgluEnxoogS/8dhTcG54/B2VxanEO6DSJoUXbSVdwUnnobzKGnCsWtXV9jZuV+d+1eGjOJyDOWE1l7JdKKebEg60zofpSKZvY8MnWYNTkTEXYz7NdWnI0lTT9a1L9N3qdJdHgEfbYIpHwXThuQ5SNBrFp2crxVx6nhvkvAEnSVFXzygQ1EJurq/xbSSxxSBOd7ZSqCLqAOQmjtNtr+oNHFtrCgbWxtvTz12N+nYq0HuEVybW8rlrAATD9Ksk2XrrCcKP7DDmzmrxid75d8xgUqWR6uiBv5udo9gB9edyF+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+bPbadVx/ZxUw8phct8jIUERERsYZrQf59R3fvEu0Q=;
 b=u2xiLRRpcLrmMNkJ+a+S/+oF3Lf0AWsF9+Peb4aODx8v6nV9lGw9MumIs6NnVJI1kjoIYaaDbTCyQ/tUN4lYP4XUtTB6cxxWwtf+rw4zDe8t5m+T7mu6CA+IsD7L/nh5PUNvJhyXY8XcoFc336E5xa1llmqUwaGcSx0xAK+dUqc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 04:28:41 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 04:28:41 +0000
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Move the ignore_crat check before the
 CRAT table get
To:     Hanjun Guo <guohanjun@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org
References: <1598430556-18788-1-git-send-email-guohanjun@huawei.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <eb7a2496-c7a6-caeb-8b44-4da07686ce12@amd.com>
Date:   Thu, 27 Aug 2020 00:28:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1598430556-18788-1-git-send-email-guohanjun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 04:28:40 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0949192a-cc0a-4c8f-4ab3-08d84a41acf0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2718B1BF67B8779EA436B7E392550@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gsVZzQQqlVleNdcwmsDymeGhMXxOQK/jX4XoS0cV7d78MGOLZO95upV3unygB9h4+MMTncZ/y6WcB3yTpIIaW4BpPOpWIvUCNkAMoKukvnempvnlUdbsD3zfZIcXxRlZt8lLgYwdRbyWE1bR48nOTpxiZ+J65mkuBN2X8c2jnW5SjrM+Ky8w0AvV96q68uqIymr4OQrulSKcLDhOS9x53kRAju4V39HUzGRQF52dAEHX9qJCAozQ+FO6j96dEyLYfDMdL5SPqcnV0tDQhjZ27BgwgjzJe5AOI7k7NNeAdOU8Vk8/+oytDaMqONmMiYGnfTxmmhBrmgIZ7jT+TW/yHf9qeE6iupaJW9rgMvlxu0tz3oJ1akcOMNXJB5r0AQ67
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(316002)(4326008)(16576012)(83380400001)(110136005)(44832011)(2616005)(31686004)(66946007)(8676002)(8936002)(86362001)(52116002)(66556008)(31696002)(66476007)(36756003)(5660300002)(6486002)(2906002)(186003)(26005)(956004)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c4i85bEOfIH1ocjTDeQtWQEwgL82HbgIm+hjIIN0vmOQJCT9hDDx0v3Mm7toaXax9jUfGytOwbKxGMkqF/aJJ4zCdVBkpJ9p+S7B93fexyhRLCwwRDiOvKmnsbI+/Pe7sEzJ6B6nMhFsrhDichDofmfCrDlIBdDZc0wpnkLGwF9WURRyEBmX19bHeTg23ITtEyq8yqh+64JHa4J5SSIcidjB62eA/g381N4PZg2NWd+X+oiO5ArRDlM3QCcbHTEEbcZJSMUFjcvq72Tbn0Eqi0b2SSH0KCaLXVQ6pXKdeQcLIh5JVHTKDk792lsaJPG4PlZRMw09v1yEWmwlv6jB3JuhTwQlrTB/PmNpLuLVQ+HCKjmWnxa+TEVdMHBHzsQMzlwXWe2ZJFdIPhWaAWgZ4Kb1yC1X8UVovyaXNkzLDQ4SgC9Bp4Em2HCvTofYMGiXLLehVHL4JdNPCM0Hnftjg3AhNyUuthOnd/cxNLnL7lWPmXqW0WdP0pYW2B+rrwj/dvVyD4zPSxMmC95MwvXX1gpP4kVzjo3CzoUheNmt3a+YkYxZHtTwpNBWkcDeWo3v6YQXVILaVEVApsRrWppYloN2tHkXhSnPh6SYKmuOvSQmf8J6QgkuJjIYTxpxOvYb/VQIHkwKLPqSI7NgBBqK3A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0949192a-cc0a-4c8f-4ab3-08d84a41acf0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 04:28:40.8723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMW6iHz9eXINf33Y7LrCJR69ClzvEGzYU37yxsWpaSDSYckzf8B58wKbpOtNXr9odefOa8nMtbpjOAOKlB6zBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 2020-08-26 um 4:29 a.m. schrieb Hanjun Guo:
> If the ignore_crat is set to non-zero value, it's no point getting
> the CRAT table, so just move the ignore_crat check before we get the
> CRAT table.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 6a250f8..ed77b109 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -764,6 +764,11 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  
>  	*crat_image = NULL;
>  
> +	if (ignore_crat) {

A conflicting change in this area was just submitted on Monday to
amd-staging-drm-next. You'll need to rebase your patch. It should be
straight-forward. ignore_crat was replaced with a function call
kfd_ignore_crat().

Other than that, your patch series looks good to me. If I don't see an
update from you in a day or two, I'll fix it up myself and add my R-b.

Thanks,
  Felix


> +		pr_info("CRAT table disabled by module option\n");
> +		return -ENODATA;
> +	}
> +
>  	/* Fetch the CRAT table from ACPI */
>  	status = acpi_get_table(CRAT_SIGNATURE, 0, &crat_table);
>  	if (status == AE_NOT_FOUND) {
> @@ -776,11 +781,6 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
>  		return -EINVAL;
>  	}
>  
> -	if (ignore_crat) {
> -		pr_info("CRAT table disabled by module option\n");
> -		return -ENODATA;
> -	}
> -
>  	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
>  	if (!pcrat_image)
>  		return -ENOMEM;
