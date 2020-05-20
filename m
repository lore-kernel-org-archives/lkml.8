Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F42520873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fCRMDAcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgETTTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:19:53 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:20448
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgETTTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:19:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlOE7LgrqIZvrrCFWAnmVNSav4jFTMZM9O+lcvd3UjhZfJYAGkmHpZveid11gUyXkOrRQqq51sdB7IOm2bADyG7mo3BfQmwnJLadTC8atQV1NPLr0P88vi9N5e0KfBySo8FCCcB5fC340Pm/ejhExNz0TjkgVf49lp+c9dORWINMKPKf5EZ71ibjgFTfhyMLH0pBqyU/XAFlkgWdEskP0R+U8+cz0tZAuM9U/51AanK0coHQG92hr2X4MNVJvZQb3NtQx48qxHLTBcGULrZOhzwo45E1YQ8NlzfqtnjUAgNDVyaqN2le7BWcViQHGv/gtGXNrJypANpUJjr3cUXggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNE/Kw6RC2DuNwPM/QVfHyUwCNoMvrbtVem8Jq5gKps=;
 b=QDoeiqDnRTQ5n9v/Eok30HMC0xeRASlLHEDeY5vmqBigjnad8Rs+vOacaLHURGRl0cuNOcfXbLnXLCfgPHPMrDxx9CU85VGbSC7Fe1Ew1YFqX63YIOm/kXHf8CcdADcuvLyOGiCu9Ke0v/2gk8AYxKd3Vk3V8YATSQK3+NEThCEAMh08Y0mjZsBfV4QJ+8ie/M+xFBrU5IJB7cZd6x3JnN6VeOf/AINd+iSKJ5jBQlLZ8yv7gNETvalsiagLD9Sl807DuHvamXOD9q7N81wGtnWWCYTs2cQiBtFiZGB1s9bbo4Z7EXwerAuW6QHGbL2YTPsGFc6eeSwiPUAtS6Z3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNE/Kw6RC2DuNwPM/QVfHyUwCNoMvrbtVem8Jq5gKps=;
 b=fCRMDAcN9Lejzkog+iGJQ4trah3Y02MK8v+CDDrg5XyPfLoI9klGO0EsCJoNCaS8qgwYwEh9qnUvPKY6A/ArCf1zD3ioQeLIjr9WXKaTT0O9m9kH613POCZMqACwd4xy48SBNJiHWqKqBTznaoMtIHzeHE346QioOVQpLJv6e0M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 19:19:50 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 19:19:50 +0000
Subject: Re: [PATCH] drm/amd/amdkfd: Fix large framesize for kfd_smi_ev_read()
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Amber Lin <Amber.Lin@amd.com>
References: <20200520135306.11221-1-aurabindo.pillai@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <1c09eb78-f2a4-3f20-1bee-2590c35b982e@amd.com>
Date:   Wed, 20 May 2020 15:19:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200520135306.11221-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::14) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YTOPR0101CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 19:19:44 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5ab3269-ba1b-4a7d-2491-08d7fcf2c41f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2495884A4F136ECCD398E00292B60@SN1PR12MB2495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sodXrRH0rm+3IUmxBmGMjdbHecxwkhT/CsrZN1hAAxI3xS2fQviRn9iqHvpwfJ0Uipe7fUbP5owK4fhRJBVqY2mMYy5w8M5C1jSBUnx1r1JmrX4we6Kkx+j6lUyt6JL7aqJ8PAe4oXvEQ05PC+U3ijB0mIDF8ZcbDEluik9pe3784gjobp9AyChCe0yq5p78XkO1AJEg14Rx4+plOed7q6Adu8lU811EAZYtSHSfiTSIN9OsWKJ2niWqQoTkMB6tdZ9FbjhdPukqtQoAOLXTKUNtFwAfK2D4P9reIDSn4Wd/8eUQswirxmQmXXsINs96QmdHc5JhBx4jRrE4aNg09aDLQHzH4GJl/Fo3lnQaJ2Re+lDF9C93HCzrEcX6lRt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(2616005)(6636002)(956004)(31696002)(4326008)(52116002)(66556008)(66946007)(5660300002)(26005)(16526019)(186003)(66476007)(2906002)(31686004)(86362001)(316002)(16576012)(6666004)(8676002)(6486002)(8936002)(36756003)(478600001)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ovtHEqY1/6mysqe6bbR4FbCYi1wmavccl9jtiMZPCR0eaDp2jYNb/DJejYPbo2KrDzATWyMVme22lsP8vIeTxSqehBYoK57gYlsuptS8hK1XwjAg9Pw+Iz0DuVUxdkntS8oXwpUrJcrztIGDB0rBlPTtsJcWCA/iv+auPBeblVp5ITvKYLy/RGgOd/M/xRuI9r5IPtswHgx6aEOxSlhS9DLnu3X6j2vu5sRfqDVTjqDvTXbZF5Sh8CBSt3sfckz21wPCOTq72Li7C2G0UW3OMqhDsFgQ+DsM/h6OKN3EV/y1OZyb5jmeQDMedsHgVdqCZ4W4xinnbNBk5ORNCmN8U7rGQOxiwFO/rI+UJMm5jTY/ntsxdJNAN6a/neQb3P3/df5Ftem1NozUcc26lNLda17dgKTRmT4zJaFNApOSDsqkaqVFsQGHuPB5X4+GRf/RGYSf0MmHMsnm/h7xuyOGGC5UB8HHCbHOz766KujKfnA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ab3269-ba1b-4a7d-2491-08d7fcf2c41f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 19:19:50.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rXaw2f4HsCtbFsgD/g8GxdQKghIaNE8Ibt6DP4wEjsP8A2++0DPSrc81T5w+zmRIM+4fXaXv/Rk2RczFD2wMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-05-20 um 9:53 a.m. schrieb Aurabindo Pillai:
> The buffer allocated is of 1024 bytes. Allocate this from
> heap instead of stack.
>
> Also remove check for stack size since we're allocating from heap
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Tested-by: Amber Lin <Amber.Lin@amd.com>

See one comment inline. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 26 +++++++++++++++------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index f5fd18eacf0d..5aebe169f8c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -77,9 +77,11 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>  	int ret;
>  	size_t to_copy;
>  	struct kfd_smi_client *client = filep->private_data;
> -	unsigned char buf[MAX_KFIFO_SIZE];
> +	unsigned char *buf;
>  
> -	BUILD_BUG_ON(MAX_KFIFO_SIZE > 1024);
> +	buf = kzalloc(MAX_KFIFO_SIZE * sizeof(*buf), GFP_KERNEL);

kzalloc is not necessary here, you could use kmalloc. The part of that
allocation that matters will be overwritten by kfifo_out.

Regards,
  Felix


> +	if (!buf)
> +		return -ENOMEM;
>  
>  	/* kfifo_to_user can sleep so we can't use spinlock protection around
>  	 * it. Instead, we kfifo out as spinlocked then copy them to the user.
> @@ -88,19 +90,29 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>  	to_copy = kfifo_len(&client->fifo);
>  	if (!to_copy) {
>  		spin_unlock(&client->lock);
> -		return -EAGAIN;
> +		ret = -EAGAIN;
> +		goto ret_err;
>  	}
>  	to_copy = min3(size, sizeof(buf), to_copy);
>  	ret = kfifo_out(&client->fifo, buf, to_copy);
>  	spin_unlock(&client->lock);
> -	if (ret <= 0)
> -		return -EAGAIN;
> +	if (ret <= 0) {
> +		ret = -EAGAIN;
> +		goto ret_err;
> +	}
>  
>  	ret = copy_to_user(user, buf, to_copy);
> -	if (ret)
> -		return -EFAULT;
> +	if (ret) {
> +		ret = -EFAULT;
> +		goto ret_err;
> +	}
>  
> +	kfree(buf);
>  	return to_copy;
> +
> +ret_err:
> +	kfree(buf);
> +	return ret;
>  }
>  
>  static ssize_t kfd_smi_ev_write(struct file *filep, const char __user *user,
