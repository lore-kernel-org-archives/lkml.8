Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BBBC2D0E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F37221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k1wa7Y6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgIKDY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:24:56 -0400
Received: from mail-co1nam11on2040.outbound.protection.outlook.com ([40.107.220.40]:7265
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725300AbgIKDYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:24:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJqpzmGerhYYMDR9X83pPguH79xbPQK92/f4JBkvxxVY3epMMM/HoOgMftWtaUx8wbgbP7BI0YvAX6DOHB8Vn4zul7ET6jFUrwpgqhYAyg9pM/hPWLRj4tcJP1t0UTMwbm0L1NCqsqhpY1N8bqndnGE2x4mmLuE2UEUiMg5FS6gzeMnCovrzts0BsoGvyBCkvjJSZly/y5t9jlU8NfZAcSMuDH4utXVhocaZL07GdGHyDqI1Jigt/LQE8nE1Wq+1SNGQ/FNC1KQYAyYqgcJmkijKinZnykhnvSsJo8dJKXpe3ygATVNTUw2mNbiQL+e4hdd4urgiEBITOI608y7GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPrUKHZhn/Hwu+/Lgdxw3eUO9mgswWBiDSVh/mljLcY=;
 b=Bbz0GADZGFBIp++JNaawyPO+k4dWWFpXEOWfZLls4FQ/5+K2a8ORg4gsBj4nRDsV/CZKz39EKdvTocciOlzb0DKLhOfOv1Dci+Y35FMUdf71Mhc5L1FbKB7vTslE2+K8oi8yckPMuTRMFUqvqwgNS6Uvoyx4txhrh0eZnjo1FF3jObq88LkZKSFL5tdYps23G8jYHHLrVVXdogYKyw2yXBf+HrMcq329Iw7Jn9f5BMSYVIOmPb6KxW2hbDymxXZIs/599DylR0QoTZ/+QL8tBVU7CS2mM5N2tUeQZSxm2E3CpBEi8ny4nySZv9URAYaquAOc9e0h5jb0k8ZfeYISeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPrUKHZhn/Hwu+/Lgdxw3eUO9mgswWBiDSVh/mljLcY=;
 b=k1wa7Y6X5DDSdULABuyIJM8HRoaATfo1W0J5qz7uwPF9ouovCzfYAvgb6PxgksT+SQ04bG+WZaMzs1vPWgM2jHV412Tb85DQQ1vN3+a8rfIuGThrBopn0gc5EOUii9KVr7LgIGCSuCIzvHQrRnxsYRCA9ehqiqP3n10R51bzjVM=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR1201MB0026.namprd12.prod.outlook.com (2603:10b6:4:52::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 03:24:49 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 03:24:49 +0000
Subject: Re: [PATCH] iommu/amd: Fix potential @entry null deref
To:     Joao Martins <joao.m.martins@oracle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200910171621.12879-1-joao.m.martins@oracle.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <f1a0b4f7-33df-f541-9df8-39dd282aef29@amd.com>
Date:   Fri, 11 Sep 2020 10:24:40 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20200910171621.12879-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:3:2::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (183.89.247.160) by SG2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:3:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Fri, 11 Sep 2020 03:24:48 +0000
X-Originating-IP: [183.89.247.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bf5462e-05b7-45b0-634a-08d856023d95
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0026:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0026B63B70CF4889BFE099C6F3240@DM5PR1201MB0026.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyFdqQRU4mZ6AfxIE79MdDREo0++m6liq2+sOROI+41CPPf+s/o19sh2nIIZ9AqbrBhokUV2Zm9brsqZ+AAtG6vO5OM0+kg7hY6c19dvXsmnJEcVIsQqgGm7KMcwE4+yFcE/PlwDoW/7Cjvedlgm24V0R0TEjDuHG9GvN3xnAUnWEI/q47qTgJl8z7OVXz/pGQDX1JlPk80fi5sRXY6JtmWQukOTHSUJ5IyPzZ2AxbeDtgslRKRZJ1Q8FSxgWWjHyXVggM/maP3B2N4vSyfEYa1cXbTXT22OD3cQbatp9xWJENtcIeRVu1CVt9IKMd5AgfF/yLq58G2UwpkNq2bha/CjhnvH00gYZgpP5AR4G1Y8EI7b/YaBHj0uLZyP1KYW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(52116002)(16526019)(53546011)(316002)(6486002)(31686004)(4326008)(6506007)(478600001)(8936002)(66556008)(66476007)(186003)(36756003)(6512007)(54906003)(83380400001)(44832011)(66946007)(6666004)(26005)(5660300002)(86362001)(2906002)(8676002)(2616005)(31696002)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LMnr2Zhn+g5TiItQ5/GjZJMIyZCnGXm/8/SprdmC1sCOEcG5PVDhS3f6d0qouFril7ttV2A5DPR7ifX6CLEe0Zh3PEuuD7EY8V3xPt8snT/yimnt/lRxjw5AqGXJr62gQk1Srv9gDkdGlD60VrlhPDch9KCU/4umVU4k/mN6UNQEY531E92upRVeG3rO5OGLlkirjGZJ3WzlmQZndbClOyNjXR3MYOGB61nXOGfK5xV3xIsukrAw1AJRxoY1fNnODFdJzgiYDGHZyp/z4KE6gX04YISjFDK/T84Vby2xq8f36XQGe7RWdGGQHZENoGVlI/6dUYrpqFkjgCK75q/V/aZ25ebbKFsOx4zktFdA6p2EopgEsCzm5B7JsxcKRzPm+QPEEItXScS2f4V9EZ/EuyOLb0cCm/cQrgMdlIRJtdDDwnLk3wjgRPWXilfoKmT2E7QgT7AEn++OIU8CftOkGVVxv/krT/gSnVZXhh0usxpDJBHnzJUFkF4FpERzu0chT2Lu6k6t18c6nUgn+WzM3giqwVch1r2fwK7i3tm+xxl4m/U8JdR0MCNVcFhUhRf8Wg4bZ4h+Lih4t4l3zwdvmSoerP4b/hTZ7iGj2hkiOIzZasaiui08xBepC8VIALefKoNYOfubAjxO4FwcVSGj/w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf5462e-05b7-45b0-634a-08d856023d95
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 03:24:49.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp8Z3amtkK10sdmSjFiWywWY+iVGfQy8mxLTXQVlAoPoetOxR2GnYGsw8nJ/R7CxpFcAajpnBRQ+bE0WVgcoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for catching this.

On 9/11/20 12:16 AM, Joao Martins wrote:
> After commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn bit after
> programming IRTE"), smatch warns:
> 
> 	drivers/iommu/amd/iommu.c:3870 amd_iommu_deactivate_guest_mode()
>          warn: variable dereferenced before check 'entry' (see line 3867)
> 
> Fix this by moving the @valid assignment to after @entry has been checked
> for NULL.
> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Fixes: 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn bit after programming IRTE")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   drivers/iommu/amd/iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 07ae8b93887e..8abe1c7ad45b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3864,12 +3864,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
>   	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>   	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>   	struct irq_cfg *cfg = ir_data->cfg;
> -	u64 valid = entry->lo.fields_remap.valid;
> +	u64 valid;
>   
>   	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>   	    !entry || !entry->lo.fields_vapic.guest_mode)
>   		return 0;
>   
> +	valid = entry->lo.fields_remap.valid;
> +
>   	entry->lo.val = 0;
>   	entry->hi.val = 0;
>   
> 

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Suravee
