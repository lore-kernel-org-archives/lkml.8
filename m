Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92746C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0622078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kqi1+lXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIJH0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:26:55 -0400
Received: from mail-dm6nam11on2052.outbound.protection.outlook.com ([40.107.223.52]:60864
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbgIJH0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eE45ANClbzGFVItJKvgZOiUCSeWefmf+fRUyGI0MxNgkANLN7r/vWHEYFIfepfP85Pdy5TMiClhOYdSUWnB9XcViJezcVpfab8SIZQllcTa6gun4C/wm3db24+dvvuuYFp5IjA9rRFLU/E2BGCalsPTofjaB3oiZUgrdsAOCllKNNUwxWTfVdK2JH+x9ED2rZyKZqIHo3bvGPGisfWeYzo3YdgR3ngWjqCzv4kbM2+Qk3We48oNeRwdcV3aifZ7IdmGeWx3QIJQODUlllyFAydpOgUzH+vPRAyBWHD8kOLvp8NqMAE7YL+SCsr/pjADhn9vej3HDtMqtwJy8LivI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1ZE0SK0D0IE7s2Zd07MnnbCBNFnEK75DaijWItx25M=;
 b=M6iz0pkYkkFxrydc3NDg+SfsVlfR7ZYmyR5PtwNAwfBTKJmsQNBNeas8EnY07rurAWgy69k1KGe6fIQtxinjvaW4ACajEe5P+3mqj7LOyQd0jDebXjGKZAi1lj93wY/pjla09neyDYeIemhsJka7ERszaE2ICSyRRxjUQuQcwN0wtVOpygZ+csWX8d56gncxr0o+hnJo6hoL1lIwbitPU1IHY7BE2Y9L+QGher3QGfs1pT1sSSaOqMeqv9J0VwtrKf0o8m7VmQlAkC5wZc/KQq1v+SzSwlchNlWLqaalwPBLPAgKSj4VnZ0IHEFGbzsEnhCJhV2GWGC0qyihtTKFpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1ZE0SK0D0IE7s2Zd07MnnbCBNFnEK75DaijWItx25M=;
 b=Kqi1+lXrg0zDoyfeQ1e57pBCIH0xKq+xWvU7w8W8QRzH+wQR3dfJQ5UWiNDVgwTbYSB2UHYB4DmRnmPKWy3Yz88JMLj0HkVIfujBxJcsOCSjMnKQy5SwzmbatoAC3B8l+3AWBMBDxl76730MFnUlECtUu1WoNUlky8/59UzmqzY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1597.namprd12.prod.outlook.com (2603:10b6:301:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Thu, 10 Sep
 2020 07:26:44 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6%7]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 07:26:44 +0000
Date:   Thu, 10 Sep 2020 15:26:33 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Yong.Zhao@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/amdkfd: Fix -Wunused-const-variable warning
Message-ID: <20200910072633.GE2472906@hr-amd>
References: <20200910025532.19616-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910025532.19616-1-yuehaibing@huawei.com>
X-ClientProxiedBy: HKAPR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:203:c8::15) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by HKAPR03CA0010.apcprd03.prod.outlook.com (2603:1096:203:c8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Thu, 10 Sep 2020 07:26:41 +0000
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29ddcedd-1c1d-4794-c9d0-08d8555ade6a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1597:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1597CC173EBC270DD068778DEC270@MWHPR12MB1597.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI1+KT1d/Lttd81YouMhEl74UDaK22K3ucgxIIfRP/i5hnSby/xBhTg2CwzGk1aSmR1hDKUwrZjN+FRArGw17oongDJXXePo+e5o5IX+aV7i/HJ4dmY1PmKbM9I+fEq6qGKuurtSks90Sh2djFQiDQIHSqBkKj/ipg5EmVLGcPzZd5sHzeNLgBwh7UiQemhpzgr5fbRvmYZqWbzGY2PCS+zdOQxzkN9UQl/27cGaJKUI4+eFpjA2hFvvGm4kG41nUVKYsZz9cCiS/vjYaCrshkXLAbHBTg41V4+pA5HLiJBg98v1iQLzzx+NDh/fCIQ48Zn+RnlYY0Yl76GAt4obojQEHM9PE9+RjJBC8FOuYG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(66556008)(83380400001)(33716001)(26005)(66946007)(33656002)(66476007)(6666004)(1076003)(45080400002)(8936002)(6916009)(8676002)(5660300002)(9686003)(6496006)(86362001)(2906002)(966005)(316002)(478600001)(16526019)(956004)(4326008)(55016002)(186003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qyMfUbc7dy0jDfnq91jUiTR+2++bXL4PteBrrvVEu5dWsiDfDq3qI3aep6D7rmSsnZr1ChVSmVWzkmeR0mkrbKhf6XdJ5IBqWxsjaWoLorrLuvNmNMXEOnweVsGj0kY/TQQ80Yr1PgVUI9sMlK88NVpWCVuQyb0K9JIVjPBElbn7SJ3UEJpFkkWDZK4mPG2d5BtBfO1zVLLBC3y2bY62fkf5fEzw0zew+bbRlzp2jMXHSgF9j/ne4rD+ktcSWYeRAX3v9ZkelXFtYJiCP3H1/dRlaUlmJJeCq7Kyd3wYHKhxC0xortslXKBgy5Syf4zfQKEAiaNox364+REsIX3gdixFumQ7CzYPb9Qy2YX8PPRT3kfKTyyHUKh60M9CBPU1x3WGL5TfPYm2RxfMp8HVapiPvO6OYlEEFbx9m4boOqz2oNyzziFaeYipI49xvVM9/w4Vfa4VBKu7oIKh+VePdP3bOrEUXLezuPCncYhErCTeaS9Z2Vquy/rGoIHsC01TtdgbLp7bK9DJSJMAV9A5TqgPCawQSc4o8nvyJviBFtGx2YBiA7ftWIZ355CkfSpHdBXNocUKk5XluKWltiBAjI0OXCH7jeZGCxKWtWkayFHKuy5wF8G+QrdViFOGrV/NOGxemJtQzIQxs8TOsJw3Qw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ddcedd-1c1d-4794-c9d0-08d8555ade6a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 07:26:44.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqUsnpoO7MR02CBlGxH2WAZ7u2JLD6+0JorKY+MReln7fi075n1lbveKn3UmoUI0WQi+KfWXmmlBXccwx4OQow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:55:32AM +0800, YueHaibing wrote:
> If KFD_SUPPORT_IOMMU_V2 is not set, gcc warns:
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:121:37: warning: ¡®raven_device_info¡¯ defined but not used [-Wunused-const-variable=]
>  static const struct kfd_device_info raven_device_info = {
>                                      ^~~~~~~~~~~~~~~~~
> 
> Move it to ifdef block.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Raven already has the fallback path, so it should be out of IOMMU v2 flag.

You may want to move raven_device_info out of IOMMU v2 flag in kfd_supported_devices[][2] as well.

Thanks,
Ray

>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0e71a0543f98..cae4df259e26 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -116,7 +116,6 @@ static const struct kfd_device_info carrizo_device_info = {
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
>  };
> -#endif
>  
>  static const struct kfd_device_info raven_device_info = {
>  	.asic_family = CHIP_RAVEN,
> @@ -135,6 +134,7 @@ static const struct kfd_device_info raven_device_info = {
>  	.num_xgmi_sdma_engines = 0,
>  	.num_sdma_queues_per_engine = 2,
>  };
> +#endif
>  
>  static const struct kfd_device_info hawaii_device_info = {
>  	.asic_family = CHIP_HAWAII,
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cray.huang%40amd.com%7Ce8805fd43e9a4ad33cd008d8555a567a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637353193795034052&amp;sdata=HqUGjUpQtfCkZ3wA1%2F6HTCZrn%2F4%2BuQORTobzaIYa%2BNs%3D&amp;reserved=0
