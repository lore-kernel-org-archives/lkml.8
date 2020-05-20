Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03DCD207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SkcrK5jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgETHml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:42:41 -0400
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:29216
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgETHmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:42:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/3u6wHgdm2hOt+vSVwrqY9bQrEXebl4It3YjtUShx5GNlKdbKJ1kWfuNzLgF/4PyA2/0bRJ3rpz2dJ1FYTyqvOD4NPQ1SDIXC4HJW6K0pUp0sv5rCT+9yuhWMo3ls9Hl6m2wZOo257D6fgiqXq0oU6hJvxTUUzmukiiw098uW+zpuPaVsr9P7CowrIDjDwyLeV36c4/eGcMpHVVXeK4JC53UKrPb6netbZNaY9Z+EuPs/H37zH/FQ38Nj+vSWPBWOXnPOE4lae8qpMlE1C2ZRHmoClf2BSfbU4EXGM1N4Y9yC7UbGLR/2FK09lA0N72vBpwV3FHWt2ZVkNkJXpa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mlldXVpPvTEDJONXWZlvW6XXpbo3a3syELHWf8Y6vk=;
 b=helLhXwDXSAjCw+C/YyIj8uh6ayIa2Yvgs9s9bRodWjFckxW5/aNQaThL3IR1m0jdKAod8QV4uDw/oEXXJk698Q8s26HnyOBpvNxPpoqcWwfvt/fyaM5Hcl2eClkawmqBEaiTctA9a6GTwyuwBzGElA/3DD8tRpzkbZhMTy1LrM8ACCndHhqsLVMDOPGh1E6B+27tf2/vZPqFdm+JiP1jMiwmmS4VK501uA/RzAjG7oR3sXdJW5pxaXOADDS3o3Oop4EcsOWl4meQvzQB7/z1ojfd1Mc96sCIAlGlmzrzBDuUFFHhybrjoH8km3AxNKj8yCQYJPr4xoWfyUDnWY3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mlldXVpPvTEDJONXWZlvW6XXpbo3a3syELHWf8Y6vk=;
 b=SkcrK5jSOsG1PgSnTqfISSFFzLDwVfe8aPT3jZ/Om2YQvZ4NtmizzYohRtOQdo83FeNKcepb7CUi5zMr6P6reYYAYOwEjHuUJWrjHxkjbUtKMV3+cwhqUNRBLzUfapK92Z/A3J/wxM/s8k2KjG0NZgnreJ4iKYlipw3zoGT5l1w=
Authentication-Results: embeddedor.com; dkim=none (message not signed)
 header.d=none;embeddedor.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 07:42:36 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 07:42:36 +0000
Subject: Re: [PATCH] drm/amdgpu/smu10: Replace one-element array and use
 struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20200519225545.GA2066@embeddedor>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
Date:   Wed, 20 May 2020 09:42:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200519225545.GA2066@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Wed, 20 May 2020 07:42:34 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a229a49-9264-44a6-bf49-08d7fc915d0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44683637F7E6F9BB923E117483B60@DM6PR12MB4468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fOwndbdznGsA0HdcWuFiFzp2eL0xRUcR4XGZHk68y8/ibVkfWp8WQ1+SFywM1MhTxxlWg75IBn/M5ahnduy/VL6K43iWysbaY97ZNPqW3o8NBb8i/p7Bv+2EAUVXbZg+y9A6jcqx8DvrWDdiejj4fanal0RkI1nnAQeCMtQFBN+WVFRy6P1ZIdj7ObRrrv3q8fdqXBq6J9o9MHtlI34uUxGvwScuH6TYAwpkvw9yEkGd1kU6jsa54Sx6UHAlFSLxW+EGweeMO4zLs3QItrFF5dciiuYT9K4UWdrgEAniH0oWjIngIpRAitG2IDeFfrpSkkDKRVaiuwQ7zt3ejmm2VwkmCKeKeSE10JrMetjcHRzWzteys6+3iGIORZI+y8MZ5Cx3UrHTDqcIEJmLKo1bUVTjrG6rBQ/KRaKO5sWpkVZu1YGPFR/NYmtiJtxOCUfs8c3c2PaPO8g99mmJNNWrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(45080400002)(66574014)(31696002)(5660300002)(966005)(6666004)(86362001)(52116002)(2616005)(16526019)(4326008)(478600001)(186003)(316002)(6486002)(110136005)(8936002)(36756003)(31686004)(66556008)(66946007)(66476007)(2906002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: m0+nkuzLpWnl+LzfovZ6tDpTX2EALH9JviZAS8TzrO7eUNeGoG18cO1xuGr9NVoCs/IEGdNau0PPX+huryinspoLL5C2Ptmeo73hM02BYU3zFq6sJd01pPsLCcBuDaHArOToJsNnNSbb5enGF+z1IzuK9+KAabkmkdsLL93lenB016voNgoB6o/tjkQV7Ae6/BdnV5xm6LfaVjIBeWu5RcEOCAbnPO4IQM5l0lshjrbasUBl6eDBwZ+c/IfSu1q53dS4I1u0izKFFi1rMz+7CYRQhJ/JRTmPwub/XcoigTLm9MDqhGoUtOzxUTe10587qLJ89O279+QjtLcUzuPD1lEi5hHLlvhCTGJjXYjL2O/tQUFjjdUT/FnqS1pkJ8dbELjRKSwkWCh9w/WKh1hbhKCa3vkLfUqZPQG/fl7HoMI5gI1sh+31YzsgvyB7eYuDInh9jTcoVpZZbPcHaa8X5VQobDX+hHlhm5uuEYQbBbVY5muvr+/uwvmz0rx7IlziiEpqs7rNVPrcJbDcy6rlPIuEaKxnYyV6YOuPCnOvFdjGAqCVYT+rOAVWHGBJfq6F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a229a49-9264-44a6-bf49-08d7fc915d0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 07:42:35.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zDK610TnFFTu7NSNqzpIWsxRameozes6TxDZD02bwt5mvEySj7UBsWiGQT1KT62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.05.20 um 00:55 schrieb Gustavo A. R. Silva:
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>      int length;
>      u8 data[1];
> };
>
> struct something *instance;
>
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>          int stuff;
>          struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
>
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct smu10_voltage_dependency_table.
>
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgcc.gnu.org%2Fonlinedocs%2Fgcc%2FZero-Length.html&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C8a400bdb88924a1d951508d7fc471966%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637255254622039268&amp;sdata=ILOPPn17c%2B3oyLLdh%2BgH2b%2B8RdhWuTFGxruRD7GUHOo%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FKSPP%2Flinux%2Fissues%2F21&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C8a400bdb88924a1d951508d7fc471966%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637255254622039268&amp;sdata=lCr5Otij55Snq27BDp4RmtW4hNhOS%2Bm4vSUOOAz07XA%3D&amp;reserved=0
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Christian König <christian.koenig@amd.com>

May I suggest that we add a section how to correctly do this to 
Documentation/process/coding-style.rst or similar document?

I've seen a bunch of different approaches and some even doesn't work 
with some gcc versions and result in a broken binary.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 6 ++----
>   drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
>   2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 246bb9ac557d8..c9cfe90a29471 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -410,12 +410,10 @@ static int smu10_get_clock_voltage_dependency_table(struct pp_hwmgr *hwmgr,
>   			struct smu10_voltage_dependency_table **pptable,
>   			uint32_t num_entry, const DpmClock_t *pclk_dependency_table)
>   {
> -	uint32_t table_size, i;
> +	uint32_t i;
>   	struct smu10_voltage_dependency_table *ptable;
>   
> -	table_size = sizeof(uint32_t) + sizeof(struct smu10_voltage_dependency_table) * num_entry;
> -	ptable = kzalloc(table_size, GFP_KERNEL);
> -
> +	ptable = kzalloc(struct_size(ptable, entries, num_entry), GFP_KERNEL);
>   	if (NULL == ptable)
>   		return -ENOMEM;
>   
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> index 1fb296a996f3a..0f969de10fabc 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> @@ -192,7 +192,7 @@ struct smu10_clock_voltage_dependency_record {
>   
>   struct smu10_voltage_dependency_table {
>   	uint32_t count;
> -	struct smu10_clock_voltage_dependency_record entries[1];
> +	struct smu10_clock_voltage_dependency_record entries[];
>   };
>   
>   struct smu10_clock_voltage_information {

