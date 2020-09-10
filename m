Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE78C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0B820720
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gBWl3EZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgIJOgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:36:19 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:37088
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731139AbgIJOcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:32:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUu13nCcldwfj0zDc8IcJLuhodqXOfoC5WPqC6rXUlCl5tX2vcfIFQ+cwkNrwG78UAlK0QytAUHdb2eBESTc8N1GZt/ZnsYDFe8mdDs7/w+mQMzA3gnPZQNlgLuc7KKVmNPLpKv7OBxrJBFAJRAK1fnnkSxJ/rO55el6dC86c+XxXJ4cQ2bnaI8h9TaYthNUHS3j6Pr3TZjnPCHEgzTtj7A3aCcPrDQgn3vtOk3HRP1cRf+HG/Z09k5foAGctm/60TPSzUi8O70dCX3BIirRx/rel9tpartU7lp3YpMlIys1w+ryDW2NXO9iG17SLIW+MXtoJCl8uvXm9UWSPl06QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW4FB5BAqYyM/jWrbRbi4oI5x6RGXYhuHWhEq5RQO2s=;
 b=lTeaJPx0dBx0ZoEOn60kcXlr9ZKG066KEwoM7Bm3soqi3HWlSh8DI6HZOR24tNWEBe6scHhmEIjLoBfv5n4ec70NfiKkvnFOjjgtMy1BIYLt5t/1FZReW5WnjAzFQJu7Pz/CcHddFzkbWl5/tOrs82Jfqo646K60ERsfyMaGwuYskU3+UfAiJr0O/KTEKoknaLVYVMizB+kymvnTZ7hhh/1gwyxpDJ+BV7x7m5AR/SdpwQ5tfELrecRrLyMJAhbsj4WGMGFZgIYzdVyqPJNZn76jmq6AvgQHqC+ikRigyImxHUs9/6avDqHTbmVUeqi/EkSpA4rPSvoVV8wytXkZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WW4FB5BAqYyM/jWrbRbi4oI5x6RGXYhuHWhEq5RQO2s=;
 b=gBWl3EZNKiZqnT82uHhfeWUUJtD1wrSZlfAQaZmTsnDhHWIJHeD5Da3qxF2mVp7p3LVciiOSRWbexd8InjhuqqbbBEniWkCJaLmfcLC0sZfstU0zcu6Gqx9icUkcqw1pDdH18YcRr9eLBka04Gnzjs4/bHIg09mkmtC9+YNd2AY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 14:32:24 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 14:32:24 +0000
Subject: Re: [PATCH v2 -next] drm/amdkfd: Fix -Wunused-const-variable warning
To:     YueHaibing <yuehaibing@huawei.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Yong.Zhao@amd.com, ray.huang@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200910025532.19616-1-yuehaibing@huawei.com>
 <20200910075006.41484-1-yuehaibing@huawei.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a0dec097-399e-f29e-c252-cd741862ac9e@amd.com>
Date:   Thu, 10 Sep 2020 10:32:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200910075006.41484-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::25) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 14:32:23 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6eb3b03-0934-4442-1003-08d85596559f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB244721BF2BE36D48FDFBD5A192270@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1xbb+LmSeQvoJg1HqNY84Khxzh9bLz/Z/bd14BG0XeeNfArYH/wQbABxtbDVa4EE5O3lHD1X4EE0+11ceWyeeubhbggY3lF5WcrKpfwm49tlpG2lJ718MaNMkcQEWDB320T5XLkWQGcbYrboHq5AAy9GTnAUq8GYEES7EJyoMnESx+0t70uUelKIPHTyvCI6c/7PEiJ6gra7iJnCwzVV+I9AtRkxpYcnmdLKT0XyX8U83epd3HHai4LrYLYtkR9MVyHcGN51qbZusV6ZcVaAGYIoqUW7gpPrZdEp3tlL1zexmKtMhzuHcImHPEfOYimMJWPJC2ARv78hZVGD1424JQCscF+szdLNJ3j9LetVhsNM9xfCsd9XPHNw4AFaL6iw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(6486002)(8936002)(956004)(86362001)(26005)(16526019)(186003)(52116002)(31696002)(2906002)(5660300002)(478600001)(66476007)(36756003)(66556008)(6636002)(16576012)(2616005)(316002)(4326008)(83380400001)(8676002)(31686004)(44832011)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rytbtlN4TnT8ytyNZoWffpNkmMZ4iKDKV1Ojw2br06oT0hzTw/ayYXwGQfSQNVLHA4E2CDzzYN102iQIkF4uNDhjxycfB6StSze48eIlyX7GU75UbOKLjiQzxr7glgc0BBC2pPasxxYEZLsSaf12H++38WeURGxWSWl/T6gUwbnrcgW5cEQg4qN1W5Dnfw3Y1C9GjNSgA5d9c50GTwdXggZE0C6h7D4XFmRxklzZcNLifqrMltbB2p1sAUcYqEVBaDp02dVnwExXxpYzRUk1YtDJq1J2UBL09xFJZ+HDQXlQ3QA3MmuqnVH+RF0ep6aWqgP5ziopuETTb0ctx8FXe1P2T49F5xE0AEA6FxVVr67V++BhkIvm475ZmS5bkZpMrFWTVq2+aI+wbafafX/11qzCqU8FEdHRgs6HDRYy3tJ242zf2ypp8O9uzzloMF/D7IZ5gqxCSWTaPqdApCdNyERNSAB9aViOpgMSzu4ms8VlrqZGOGLKYSiMUHPJ2VD+Z9qD0SDvnODq2fVeGzEAQslQWeTztHT1U0mmb7YpHZ5QHC4cctAABhlHbIWoFC1Vh51DcU8inkcpVod1nBzuvsb2tfgPeww84yuXESMe8m1mZq7SBTGS6HpkNM284CofpgKx6ubLfBZQwrNK0mNfmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eb3b03-0934-4442-1003-08d85596559f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 14:32:24.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXtRMXSs9qwmXy8kIXMxZz+vCBpTtAnU9W16lRwBuUnG6bKXCM+u4ONtHEdoswfli7uUtG/2ODtnjOF+3fNN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-09-10 um 3:50 a.m. schrieb YueHaibing:
> If KFD_SUPPORT_IOMMU_V2 is not set, gcc warns:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:121:37: warning: ‘raven_device_info’ defined but not used [-Wunused-const-variable=]
>  static const struct kfd_device_info raven_device_info = {
>                                      ^~~~~~~~~~~~~~~~~
>
> As Huang Rui suggested, Raven already has the fallback path,
> so it should be out of IOMMU v2 flag.
>
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I applied your patch to the amd-staging-drm-next branch.

Thank you,
  Felix

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0e71a0543f98..e3fc6ed7b79c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -503,8 +503,8 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
>  #ifdef KFD_SUPPORT_IOMMU_V2
>  	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
>  	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
> -	[CHIP_RAVEN] = {&raven_device_info, NULL},
>  #endif
> +	[CHIP_RAVEN] = {&raven_device_info, NULL},
>  	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
>  	[CHIP_TONGA] = {&tonga_device_info, NULL},
>  	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
