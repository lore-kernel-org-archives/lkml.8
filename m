Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA538C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35FA217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ch2tH6sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgFSVVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:21:30 -0400
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:22112
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726965AbgFSVV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgWOhWjr+Lh4ZCgd4PO7mxpVE6PlQllQwY1c+Ce1B5w1qf9f0NzqRZB/ZRgKzqpUjUcin/Z5BDNwM7d3Fqt5FyCfLSFfVj63Z7VtqXytVEs6AV2ZSqt1Oobhble1ZWZLHMrmFxr0FYQ8hETq4KZ5AT806W2KWwLDAt+fn9vggtZ5Rth7RPw5xwGbEuaDU0GiI3heW1FITdIUMt6b4hCIIUivkfOcrtYp+Dr2galix/kAJg47eXv0/pB6Ni6rfCcObbquPjikKcMEFr7MtKO3qosOKv8p89t9+1vAwpRPlDqKih+GEofC2BL3C/G+GpFpx3247OaxEqunefRLZjgWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsNP3XbVRSA6wGFLl6AzI1Fn6dyS2+l6lwsBZ+xrlZE=;
 b=mYwfdroxIhFXt3TdPR/btSAGYf6gjdaL160/Qp3M16tO094jvp4e6vZBgNkhkwT8/mKQ/jHbIaH3KixRm9USiqEC43ONbwr9XgFjR61qzkyEZbK2K3Q2shwU6O0tm+1JVl7q8ChqV/loBELAD9CXC0F9r/w44GAsJ7fF/1wWOlySyZ/BuZdI7Vjb6mfU3XUre6JL9x1o1SlEAW/PedIGwOLLhPWNg8Crm6rFmVdDLs76U7nnwjdVfU3K2KpNX38dw5EiZiIWrKzGt6aRCCyqTHvw7188eslAR89+OnnMbESd7VYmC38UMG04Vsq6Icj484fUDnDqPOD5jatGTTNhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsNP3XbVRSA6wGFLl6AzI1Fn6dyS2+l6lwsBZ+xrlZE=;
 b=ch2tH6sLXQ/v/scgokO2/tk7nP5Lo9nZrVF4StMSSbUqDQo8nF1kYBmzcR45WqVKpbX6EOd/Ja4HTjbp2f+HtyaDD+n/HmCDJAC6RUxavE1ITt4uqJlM6h94z6aXWRl38Ro4RS5KJNG3N2OxAhQ4mEhwzcSCWUbRoACxSE4bJcQ=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 21:21:26 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 21:21:26 +0000
Subject: Re: [PATCH] drm/amd: fix potential memleak in err branch
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200619114533.2612-1-bernard@vivo.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <3f7e1ac8-c613-8650-56d6-715d39d5f372@amd.com>
Date:   Fri, 19 Jun 2020 17:21:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200619114533.2612-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQXPR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::17) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YQXPR01CA0088.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:41::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 21:21:25 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45ce2caf-c039-413e-b962-08d81496b96a
X-MS-TrafficTypeDiagnostic: SA0PR12MB4574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4574A1A5FC3E08446E59463392980@SA0PR12MB4574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iASdIAzRPxSe+bnlcmn/Imnv/CV8n1hePhpy05ChHiiD6zeL3xsNL0g7t9pQ/9aSuQRBlLVIKPSAwR6WB6GZpxUabcaKhMhlH4dDDdZpJe6Riv1BITDqLuoxJ42Tr10a3kXLwemSo5UwJy0mdqQq6ohg/4fg24QSaNHpXgg+ZWXu1aONBtNJo9SekPJdRABRHZXWdwCVcUd2E1EhmTz6kkxx1ptuiJ9xXYLuUdoKcPKmHSJq7xg0zIu9OARnLxrhqaJCVF8pO7qsTCHF9Wxv9Y69iskaq13RoXiEkxzH0srIvLtDgeHC2mlF0tHlkuu9wMMqWNvTK6ENtHMH2aBGawOu9YAr6wRHke4Gr9Zw6yEO8Yz/cWjXCMBn22ewB6BtboxXnmgNboG/HIbUJ7VDv7B0jiazfWsbu+sjbnwnW+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(2616005)(26005)(956004)(66476007)(66556008)(44832011)(66946007)(31696002)(5660300002)(36756003)(16526019)(186003)(86362001)(31686004)(4326008)(6486002)(16576012)(316002)(966005)(8676002)(83380400001)(2906002)(478600001)(8936002)(110136005)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YL80xVBpoO1y8io1kkfnUyj0LvgN+FYdXlJzE3ejoDZhiRDnslQ/j9bnPi/bjRGFPL2abtPYjag5et6GcE+D8SrWMUV2nHz8FiQB5IgGbyMQgCxSR/ju6otF+aYSKgvu17lPSxE3yTfGPcBlHe8ABNc2xCetnpoINEB8tGpc3Gent1GXMLN46sSNSEBHyG5LB967H/8Dgzlws7Pe9DmjVI3LjAIgvqX76rAeHjubU6ux321JQzI/MvP72svGL4ZHJRnQ+67Klroq7JpVnBNNvk+QMqkKZ4MNpLSjmcBbf25L6scV/rOPIuy2/UoA/kbyNLzqb2JMGfDmzGiNGyX0pciLaT6dqwxz02IJNQ6WmPaY8GOfFGCFnSfMNW+c3/cuPV/0zD8khACxxVTeGMyK5qVVsKXalGzX3xt3WMjaDSvW278JJKcdCPjMYH6fh4240Etflupo+LfAtszf550f9vLj0xSWWjLqDY4N3+46+XoIOqDyAzDSCBEthzLe4uoP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ce2caf-c039-413e-b962-08d81496b96a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 21:21:26.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ/TVsSvrQUeZ1VcHZKFo3O/b8shHyE3BRWBhKGgl26+EgSqCo6eAb8ujLByWU0dUf25X0UlMZuHmadmjtzKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

I just applied a patch from another contributor for the kfd_topology
part of this. See
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=amd-staging-drm-next&id=fc0fe8138309fee303bd12991f12b23f01bbf58c

Please rebase your patch on that. I believe that should only leave the
fixes in kfd_process.c.

Thanks,
  Felix

Am 2020-06-19 um 7:45 a.m. schrieb Bernard Zhao:
> The function kobject_init_and_add alloc memory like:
> kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
> ->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
> ->kmalloc_slab, in err branch this memory not free. If use
> kmemleak, this path maybe catched.
> These changes are to add kobject_put in kobject_init_and_add
> failed branch, fix potential memleak.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  2 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 +++++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d27221ddcdeb..5ee4d6cfb16d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -124,6 +124,7 @@ void kfd_procfs_init(void)
>  	if (ret) {
>  		pr_warn("Could not create procfs proc folder");
>  		/* If we fail to create the procfs, clean up */
> +		kobject_put(procfs.kobj);
>  		kfd_procfs_shutdown();
>  	}
>  }
> @@ -428,6 +429,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
>  					   (int)process->lead_thread->pid);
>  		if (ret) {
>  			pr_warn("Creating procfs pid directory failed");
> +			kobject_put(process->kobj);
>  			goto out;
>  		}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index bb77f7af2b6d..dc3c4149f860 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -632,8 +632,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>  
>  	ret = kobject_init_and_add(dev->kobj_node, &node_type,
>  			sys_props.kobj_nodes, "%d", id);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kobject_put(dev->kobj_node);
>  		return ret;
> +	}
>  
>  	dev->kobj_mem = kobject_create_and_add("mem_banks", dev->kobj_node);
>  	if (!dev->kobj_mem)
> @@ -680,8 +682,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>  			return -ENOMEM;
>  		ret = kobject_init_and_add(mem->kobj, &mem_type,
>  				dev->kobj_mem, "%d", i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(mem->kobj);
>  			return ret;
> +		}
>  
>  		mem->attr.name = "properties";
>  		mem->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -699,8 +703,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>  			return -ENOMEM;
>  		ret = kobject_init_and_add(cache->kobj, &cache_type,
>  				dev->kobj_cache, "%d", i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(cache->kobj);
>  			return ret;
> +		}
>  
>  		cache->attr.name = "properties";
>  		cache->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -718,8 +724,10 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>  			return -ENOMEM;
>  		ret = kobject_init_and_add(iolink->kobj, &iolink_type,
>  				dev->kobj_iolink, "%d", i);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(iolink->kobj);
>  			return ret;
> +		}
>  
>  		iolink->attr.name = "properties";
>  		iolink->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -798,8 +806,10 @@ static int kfd_topology_update_sysfs(void)
>  		ret = kobject_init_and_add(sys_props.kobj_topology,
>  				&sysprops_type,  &kfd_device->kobj,
>  				"topology");
> -		if (ret < 0)
> +		if (ret < 0) {
> +			kobject_put(sys_props.kobj_topology);
>  			return ret;
> +		}
>  
>  		sys_props.kobj_nodes = kobject_create_and_add("nodes",
>  				sys_props.kobj_topology);
