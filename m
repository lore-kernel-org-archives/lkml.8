Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B70208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vKmKRb/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgFPGub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:50:31 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:13312
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbgFPGua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:50:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDSaQqOhtBq3zRgSFrEQ4kWOd/8gb/qofzUw3XDkyVOb+eD1jurgPU4kb/xRvlrAjsKWaBwtamLc2XoOTDWLZu1+s+gCG7s3P47pRnwRgXfoSCupQ1d8tOZIJdIAYf5LAq9yjOujSCk3zC0WAt9wvEWAWWDVuw7D3vrAxuDAlAjhgKxXCaMnABu99ISZSYCPFC+lxUG1AiDMIzBeUICQO0fJ3LucsWOs14g5CtKMBXkH1yVpl04la5nJAAgBcvauTPf0Yu4aoLBAUQObx282PKKhHPl8fqNnoGNnWHdWMSQcaIQxLsPOb4J7oQPD7k4qc33p48IOlHZT4JlJ+ig5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L19XrNWBjV9theO1LQzzYw0uxSuy5nteZ/et0OBHZv4=;
 b=bTknCx1SZn3DILZV8kBVemStL7wMB8KZ0qyVBfa3OPyI2GavYv+aV/dan1cAqcALifKXwsoaNfNWo7Tr4ZYcKGgwy7ZO7CmW3Lif9cX6PR0cEL46gnH8VnXmU1iaWa2VsLngrkDUV6YuNynEuForjyF+QUOhB8T0IDy+Y50Y/bm3Z9UwigkLg2n6DX6MpnWdpvyqiwvQetPdQCI9KaYaQspS6mgClVp7Qff8NYHt5pR88xi7QN4eSOGJhet4PeJyIvqxLdaFryBn2iFSSLN4nAea15jlnx+hN6cRMW2q0e6IjoNg4kveGg7rlSZvkV0DYqdnp8Ksgdm2Co/LpW60/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L19XrNWBjV9theO1LQzzYw0uxSuy5nteZ/et0OBHZv4=;
 b=vKmKRb/0fwdRTScqTxDyZIZc0bREsat9eOAdl8ZM8PsDofr1bgztHa3ANhRJI6eYftDIQgfuHTVl3WJkwXcq9Hl4/M993IlnWADLR6jd0vRzMnyTcf61Brs07VTFd7oC8TlIreAN9BrcNPd7dmOSlOAbKqS6Jx0dlQAD4Uo1iE4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.24; Tue, 16 Jun 2020 06:50:27 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 06:50:27 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/debugfs: fix memory leak when
 pm_runtime_get_sync failed
To:     Chen Tao <chentao107@huawei.com>, airlied@linux.ie, daniel@ffwll.ch
Cc:     alexander.deucher@amd.com, David1.Zhou@amd.com,
        tom.stdenis@amd.com, Jack.Xiao@amd.com, yttao@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200616063039.260990-1-chentao107@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a8fb3d27-d0f5-d28a-d24b-63be866ef76f@amd.com>
Date:   Tue, 16 Jun 2020 08:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200616063039.260990-1-chentao107@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f0d9:5706:e415:3724] (2a02:908:1252:fb60:f0d9:5706:e415:3724) by AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 06:50:25 +0000
X-Originating-IP: [2a02:908:1252:fb60:f0d9:5706:e415:3724]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a7114ce-8b40-4aa0-0f8d-08d811c18d54
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14668C6CA09802AE8D401377839D0@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZy9kUai8VqzaujvbidEL0uxegf0w9+alabJtRvC9yfgaQJLUMT7RHMaQhygrHPoWYyOm+YxsGYOKEoMOTH4sqVdDgzNPkPkuCfrx6cqa6FLunP5iHIDhdJq4V8rhCtSgE+PONnx4sqKdm8cOqTTTjOfWtPIFxP5mesFqb6XUyVXIIJK7/vnSxwCjG0NhCPGzVPA1B9kzAq8t/DjaQdzly0g2eQJSjHw/ECUQ3ymDqe9G2N75C9LWaGE+UJEgxcW7f3iqBdLA6AIoN5wimTR0oeMLlsOsGuF94SbwA+QgcgVg+Bo7bWlyW4rWCUQdMe3LWigtp1f8fA8LQtx762s7Qzn9BLZJ8ihCngc+KyudkShQEXOUYCVw0HvQoX/nT7m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(31686004)(6666004)(36756003)(186003)(16526019)(5660300002)(66556008)(66946007)(66476007)(31696002)(6486002)(86362001)(2906002)(478600001)(8676002)(4326008)(83380400001)(2616005)(316002)(8936002)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lElqRiAzyGRigPJ3o735nzE+giJ2xPxESnm4lc93mNaCc8G4u0M68wm6EvkYSHyq32ZwiUzw33HlUfIJBihMt+TAXmJqYHlg2xOR25TrKjtIKzAM1z1ZY3neDs96MPr1xw19NzU/MmUZPub2MlIMZtBT8hPwEUSEfUTuq2Okrp0lmKpgmFsyUgmdoU1QuxrNqSdPrjhjp3oxDl2VzZFf6zFRV5FCLFr4EiEXr6P6jf+7Eoyq3bqYOfL3c7StjYeTaADPjDxUq1j9XSERs7oR3O11zERC26B0BTytIFcKcDFi6SytMBAspFwU47/2L0UHkfSo8+cydRLJNWTyVeQ5eCeDTPnSmB95ddy9BThhaXjcRbLUqBCmR/bjGxTm1FWtVinGdNdcM6s9K/YGCcxAaNj4WlOl5hRfUiCHGJQoC1ZqizJ1aFaA1xZCYejAe729AlhwohS+LrHzYZ1b4e9+2wgWEXyCVY4PkNGqHFWmHN7Ios+vqTfie/QEdnYMTouQ1r7OXCy67eW//+yIYMZsH/oow/1R6rjxBDDB6u2fCBjIpApE1Ii4wvH90uif4Vi9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7114ce-8b40-4aa0-0f8d-08d811c18d54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 06:50:27.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLkuRgF6F7bfhcxA4ZMlQ3F6+olgS9B084QdY8hff2EikFQBUg9XrZhUtaZJBkgC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.06.20 um 08:30 schrieb Chen Tao:
> Fix memory leak in amdgpu_debugfs_gpr_read not freeing data when
> pm_runtime_get_sync failed.
>
> Fixes: a9ffe2a983383 ("drm/amdgpu/debugfs: properly handle runtime pm")
> Signed-off-by: Chen Tao <chentao107@huawei.com>

Probably better to remove the duplication of result and r here and then 
use "goto err".

Regards,
Christian

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 1a4894fa3693..bea8c36a53a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -862,8 +862,10 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>   		return -ENOMEM;
>   
>   	r = pm_runtime_get_sync(adev->ddev->dev);
> -	if (r < 0)
> +	if (r < 0) {
> +		kfree(data);
>   		return r;
> +	}
>   
>   	r = amdgpu_virt_enable_access_debugfs(adev);
>   	if (r < 0)

