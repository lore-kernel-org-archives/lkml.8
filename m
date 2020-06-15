Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA28C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD02206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q34wYY50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFOX5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:57:43 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:6082
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbgFOX5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:57:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0FzlObrMvPx5Yfe59cqeB4s5PBDwHAPm4oORECBLfvckF/JemopLMnzuU4tyaaDrpNjQlRu8OahNPD6W3DqYB6RbYjH8Yijr3e8Gt9+8RZiV+Lo9UJyCSaBJA28oEB/JmnrqyHR4vCSiDd+NS2cVY4BNJaWShJ/654Y3QxyRbUi0X9IYu6Ob20nd0GGfQpHUEx8YfobfzXW/GbFwGvc1jTc7vKge+4QnEeN7VWVBFZyPWNa1FSyzDMhxX0oSIiiUDLBoKA/yRZ6flz4jOllVHW8CQ7xzEMi6Pf3mFBq9UJ9KpkFB4U4Xi/ILyvYvB5oFXfT30dsgBqjG1uSUT6WvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGRwWTggQ0JenzXESwFnQH6dFS/cDUfqaFEXscCU1lg=;
 b=IGJ6ljUvS35rkfN+1onFftrEQjMHsxKjca9IcJXgUbX/76QPts/sK4gafEd2sUnfs54X81nAL5eTB7UPgo1mGyQ9ERdZbYdk8vWu+1XFJ97UrQFiAlAyGtrQ/inqNy+URVVpHUcLx0pPipGBiZB6pG+yueXJqD/SDsi6onvFnSoZ+vh5ZGPD2Q7KWg0QJ741U/7VCgoxk2sTSBVx1SyYUstzpx1419LYV0+l/y/zxKHDkj9GOCyuBEfy6mPzaTS5JvLCFmzHs9EhPm1QHOewQppBThDtwdE3iiGTbpmJCAAfM6lFNNbFvF66i6Q0rkEFjNSjrHcaF4+0P8x+JAe0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGRwWTggQ0JenzXESwFnQH6dFS/cDUfqaFEXscCU1lg=;
 b=q34wYY50ITrcmyKSzrn5nf7wMAM+m5Q8xJWbTW42dX8UIR/wCykmHBP9rJPk27Jiejva/ygilhCbebKTTTgXvpPxFeb8FKhRJ8FUEOwjAQ1OM8t8OwBJj213V56/30Z5R0A/crk4SPf64KzBhOQe3o8GzOuGDRlc9EHK+palCdk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 23:57:39 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 23:57:39 +0000
Subject: Re: [PATCH] drm/amdkfd: Fix reference count leaks.
To:     wu000273@umn.edu, kjlu@umn.edu
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200613193226.21531-1-wu000273@umn.edu>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <349ff701-613e-7234-45ec-0f874e135712@amd.com>
Date:   Mon, 15 Jun 2020 19:57:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200613193226.21531-1-wu000273@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::28) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.149.124] (165.204.55.211) by YTOPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Mon, 15 Jun 2020 23:57:38 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 738983ea-0144-4371-63ce-08d81187e25c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766ED1B2714A6C580444A9A929C0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhIWeAsmAUdBrj5JNEKVy5K1cfH+zxZgDiA65KrudyzmjPeO4noZTM+QAHsl4zq0TKmCSuVVOtmLpUWrh9UW815B9m/3A1zLD5YVrXvBe+NhC9MH53iWIOSSSu8a+Co3IadYMKzKWdiMiTL15mcrVrfh7oQNLbzLiZxdqh+FNEUGodDjWwc/q+2o4mpJCaPjOdjL2AeOnw1wloJqEbzVCtGqA+4utlBrN7tZo+oY3RbVfFabgNs8qqPT/t5XfnI3xlhRz14XUEqSi1oS6ZhD6rQmjMa74EatrXroxp4QZu8VT5HJvr34vGhwTJTvfGOkih3n68tZwzSLNVV78PXIj6bZN8/FLALfvJFBeU7wD0CeCV3P1jWCceRrxUsYqvOK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(186003)(16526019)(4326008)(8676002)(66556008)(956004)(2906002)(2616005)(6486002)(44832011)(8936002)(66946007)(66476007)(86362001)(31696002)(36756003)(52116002)(31686004)(26005)(5660300002)(16576012)(83380400001)(478600001)(53546011)(316002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r4DnOhXjAc4fW3GdDSsVGeFgpdtmezcg5n00Km52427cDOatx+gxKVjKy3natk1Ps8N5+qS5B8sN0c6NT1kqbEdWNOM32aOSPvzC8P3eZhrVcB5oCZkEjF2OkENsCEEjI0RpYRX0DWPV+80z1y2PHAfVipl99CKiVvgD8XXHYA8yUnARfF59SWaq538tEBcFIXovdhfNvAfOZCSPB/XQMaFI4LiV7GcCpHfomfR3VsQJwlIn0iTI6atkdslNFjUDs0jfkLtWliMFWd2299w4PXtZ0J/sEHhqg0Fyb/Q9ZxO7tTo1+k70YdvLN/a7dtyGpcxRUYcxYE7t3DInt8oa1J8kVUNXFN1P5314Kg/4+flJQFBE34paqTQNE3CaVliz3XDp2sz7JIwnux8wr0ZR7qYymhh4veOhLGt1dUip/hufl03dhzGmPNMtYsll1s7aceFHyXiCnFrDYsgTHHqYJIZCqb+NvtWZZtDFHP7ufblBSrWBFqu9qFX5FDybjCMF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738983ea-0144-4371-63ce-08d81187e25c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 23:57:39.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2NeNXi6vGnnkQn5W4EDXVy52sAn/tQbHmk/sOZgCT5sdpoYRNvdrPyRlj7xku5yKLHDWJlJHAA4u8TLj7gB/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-13 15:32, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object.
>
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

Thank you. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I'm applying the patch to our amd-staging-drm-next branch.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index bb77f7af2b6d..dc3c4149f860 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -632,8 +632,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   
>   	ret = kobject_init_and_add(dev->kobj_node, &node_type,
>   			sys_props.kobj_nodes, "%d", id);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kobject_put(dev->kobj_node);
>   		return ret;
> +	}
>   
>   	dev->kobj_mem = kobject_create_and_add("mem_banks", dev->kobj_node);
>   	if (!dev->kobj_mem)
> @@ -680,8 +682,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return -ENOMEM;
>   		ret = kobject_init_and_add(mem->kobj, &mem_type,
>   				dev->kobj_mem, "%d", i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(mem->kobj);
>   			return ret;
> +		}
>   
>   		mem->attr.name = "properties";
>   		mem->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -699,8 +703,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return -ENOMEM;
>   		ret = kobject_init_and_add(cache->kobj, &cache_type,
>   				dev->kobj_cache, "%d", i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(cache->kobj);
>   			return ret;
> +		}
>   
>   		cache->attr.name = "properties";
>   		cache->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -718,8 +724,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return -ENOMEM;
>   		ret = kobject_init_and_add(iolink->kobj, &iolink_type,
>   				dev->kobj_iolink, "%d", i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(iolink->kobj);
>   			return ret;
> +		}
>   
>   		iolink->attr.name = "properties";
>   		iolink->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -798,8 +806,10 @@ static int kfd_topology_update_sysfs(void)
>   		ret = kobject_init_and_add(sys_props.kobj_topology,
>   				&sysprops_type,  &kfd_device->kobj,
>   				"topology");
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(sys_props.kobj_topology);
>   			return ret;
> +		}
>   
>   		sys_props.kobj_nodes = kobject_create_and_add("nodes",
>   				sys_props.kobj_topology);
