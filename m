Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BB9207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f25GQimF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgG3VJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:09:15 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:43489
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730279AbgG3VJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:09:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3pt6V4lEU5agpaoeKMtnsI3AcRuaV7l04TDULA6aIS0HN71qmeXqktHzp7nyQ97WxUlxvb8rJA8TPp7qquekOriFP8AbZ3QweBoaayufjx9UEMOQ1BcIL8pKyYSLb/+YtOQeTDF2h/GkEoEIMJh6y4D2fW1iBMfti0ZpzLWOx0sQuvmThSegH53dsbxi1X4xeaM1em0a420I0T1l0imfuBzeEwkHfk9sdPd8eIa/FpeMHLEPQmkZp9A5RuEc3/VYva1H7NzzMH7w8qeCQCA2t0jSF0MeCGbKPyxK/03ngbsKkVOwCaYIAcwAbSNxcwZ+vudey0fTlulp/ih3P+PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYur5uIGaIPZhTE7Zh2MaXQeI5sXpME1RUBPEjb0HhA=;
 b=aW2Ns2JPTggBYTHr0WEIYiz55qKpySbBEm8KwQ2dZoNj5ngMZY4yctuQpAt5ZHnzRJRYcikj5w+5KoMXuSVj53DB90CHBrXIZFZgGtST1Po3bmSmzvesmqTYJGCMhRrwCXnOOAwK0qmmuVzTLXzvBMKRyclf/iY8pbJD4+QF+RgRnN2m8Wn8WVn9RnDc0DfOkuZ/QCr4yIHtwAYG2/V11qLsFWi5CghvabrW2Vz9sfb4JSIpJqvNrmpv2oNNZ5AfK4EEQluXI++93gNFqhH6yTD49dSc5nmc9gXP9eQOxq/kE7IyldOksikZA6KNHyzKErwmPPbw/xG4eoqcvn8uLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYur5uIGaIPZhTE7Zh2MaXQeI5sXpME1RUBPEjb0HhA=;
 b=f25GQimFE6klwBF+KN8czuC76qyzvUlQXXUPZJeoszSO1QFywQErfVXM+5/OxYuTaeoJoj+wScQmQNqVHs24KFi7SrjxyfCpwm/6cKJvXz5ByglhbCqIHje+5Rq9E0PJbQ7c0Zy9huu0UM2FdfAIsHtje5Znku1clVIT1X5GpPA=
Authentication-Results: lists.linuxfoundation.org; dkim=none (message not
 signed) header.d=none;lists.linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3135.namprd12.prod.outlook.com (2603:10b6:208:c4::33)
 by MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Thu, 30 Jul
 2020 21:09:09 +0000
Received: from MN2PR12MB3135.namprd12.prod.outlook.com
 ([fe80::ed25:3da8:909b:211a]) by MN2PR12MB3135.namprd12.prod.outlook.com
 ([fe80::ed25:3da8:909b:211a%6]) with mapi id 15.20.3239.017; Thu, 30 Jul 2020
 21:09:09 +0000
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     Alex Deucher <alexdeucher@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, Trek <trek00@inbox.ru>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Leo Liu <leo.liu@amd.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20200728192924.441570-1-yepeilin.cs@gmail.com>
 <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com>
 <CADnq5_NXOiAc7q5gQqF_wwtJD1o6nHjXM4O3gY6EwAQe9iOtXw@mail.gmail.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8c5cf518-12d2-7495-7822-c7ebf8e61972@amd.com>
Date:   Thu, 30 Jul 2020 17:09:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_NXOiAc7q5gQqF_wwtJD1o6nHjXM4O3gY6EwAQe9iOtXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To MN2PR12MB3135.namprd12.prod.outlook.com
 (2603:10b6:208:c4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Thu, 30 Jul 2020 21:09:08 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f002c898-caa1-4838-d698-08d834ccccfd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3101F6ECCCA1370A2F6754FD99710@MN2PR12MB3101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAxf7m9Lf6BXtqxHjlBJd8lewfCPRpPK7BCUixYlSwjcN9lUnwqNdVMWonZnMef5VIYouo4irb9c2rnSMQSW2meHN/4tbm3p1xuQUhYLQx/GNqh6FE0et+Rnb0dmWoLBZHb4wh7cC9B9TBp7P1eYZzBtl5cFQcTNhUmbQbSmPCJaV8bJ0h+yNb+sFFRpXMHN88zo5LD3FZfkWa6P2duBIFbfSarTcMWu66ipToQckKj9ti8Ao2yl3eSc/40KlzFDd1egRoUGUGXPdfjQ1MhV1aSvE9b+UUdrujbySPmpwSB+G56OSA+AZbuKG8yU9wJfBsoxohgl7yX/WqQygxulNQJQYZ0Fd3HLnk8xUtVQQc15Qqzdzm/XA8+1v878ADozlNtJL1rBaqj+VzTU46gCGDXFn+7tlmu/HMK2NDFkRdWIzmw3JSU8vbt12ScqzyYE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(110136005)(36756003)(956004)(83380400001)(2616005)(2906002)(31696002)(16526019)(54906003)(86362001)(316002)(186003)(6636002)(44832011)(26005)(6512007)(478600001)(66574015)(31686004)(6486002)(5660300002)(4326008)(8936002)(966005)(6506007)(7416002)(52116002)(66946007)(66556008)(66476007)(8676002)(45080400002)(53546011)(21314003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TFf2/6M7XG6JRk5Xn02cpDJq14UjHJXmcojNTablGpfBJ7LYrDJIYwCymY8w2ndIMNtUqarBFbr2AzxTeBkpQpDv37FSdxyrsVe0dnlhCL5htPEqo2DDT/M+rZn/kJKt6sv/v+rkNCFVQCUVEnLo9H7Jw2Rh0f+yuGhblEue4UEqKv+N2NlwVowRmQgPYck/YUMaxGpIJchnZK+6TW1rMTXCvzhXRmK9cThmBcv4+48cSuEC4WiBvR4bLg5cDrSi+ykNBICbmvpRjCj3pydZGvtf77msHNnzX3CizAaUvUO/GuHODg/Qg5HSoC+iCqb15/8fkyjSOevEKdLd7I7NWLM0vpuByNgCbaAzNAS6anrEB0rV4PwI+2YV3cwtI1UwPCeuvT20b8I0vxJNMntIu8xEaL+QWsJp5nK8qQlvYpPMzPx8ciKdtZAKp/oBD66lh7XnKE8uXn0LzKvQS7im8iTFiVpY2u39RaVx3WWmFGDLup5WOVUZsFd4u6WCQNMO/eGpBZkQNDWyBGz3/OuMPtWR25dOKcIGyCcW5zoCH30w+gUaXOFVPVnvKJiUny71D/MpwHPcM36A4xGhzAZVbP76tOaf0DtVMgyB8u5JFY01sAGygce9uZWs0XAtlwdDyqYZV6FbJuy2nKfvCrKVbA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f002c898-caa1-4838-d698-08d834ccccfd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 21:09:09.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNqZbMFtCVFkCFakVacJif9rRzGbTXezYKvzvE85Ten2bLNE9QbM8Mah9o3Xfrbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-29 9:49 a.m., Alex Deucher wrote:
> On Wed, Jul 29, 2020 at 4:11 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> Am 28.07.20 um 21:29 schrieb Peilin Ye:
>>> Compiler leaves a 4-byte hole near the end of `dev_info`, causing
>>> amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
>>> when `size` is greater than 356.
>>>
>>> In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
>>> unfortunately does not initialize that 4-byte hole. Fix it by using
>>> memset() instead.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
>>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
>>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> I can't count how many of those we have fixed over the years.
>>
>> At some point we should probably document that using "= {}" or "= { 0 }"
>> in the kernel is a really bad idea and should be avoided.
> 
> Moreover, it seems like different compilers seem to behave relatively
> differently with these and we often get reports of warnings with these
> on clang.  When in doubt, memset.

There are quite a few of those under drivers/gpu/drm, for "amd/", "scheduler/"
drm*.c files,

$find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *(|NULL|0) *}" \{\} \+ | wc -l
374
$_

Out of which only 16 are of the non-ISO C variety, "= {}",

$find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *}" \{\} \+ | wc -l
16
$_

Perhaps the latter are the more pressing ones, since it is a C++ initializer and not a ISO C one.

Regards,
Luben



> 
> Alex
> 
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>> $ pahole -C "drm_amdgpu_info_device" drivers/gpu/drm/amd/amdgpu/amdgpu_kms.o
>>> struct drm_amdgpu_info_device {
>>>       __u32                      device_id;            /*     0     4 */
>>>       __u32                      chip_rev;             /*     4     4 */
>>>       __u32                      external_rev;         /*     8     4 */
>>>       __u32                      pci_rev;              /*    12     4 */
>>>       __u32                      family;               /*    16     4 */
>>>       __u32                      num_shader_engines;   /*    20     4 */
>>>       __u32                      num_shader_arrays_per_engine; /*    24     4 */
>>>       __u32                      gpu_counter_freq;     /*    28     4 */
>>>       __u64                      max_engine_clock;     /*    32     8 */
>>>       __u64                      max_memory_clock;     /*    40     8 */
>>>       __u32                      cu_active_number;     /*    48     4 */
>>>       __u32                      cu_ao_mask;           /*    52     4 */
>>>       __u32                      cu_bitmap[4][4];      /*    56    64 */
>>>       /* --- cacheline 1 boundary (64 bytes) was 56 bytes ago --- */
>>>       __u32                      enabled_rb_pipes_mask; /*   120     4 */
>>>       __u32                      num_rb_pipes;         /*   124     4 */
>>>       /* --- cacheline 2 boundary (128 bytes) --- */
>>>       __u32                      num_hw_gfx_contexts;  /*   128     4 */
>>>       __u32                      _pad;                 /*   132     4 */
>>>       __u64                      ids_flags;            /*   136     8 */
>>>       __u64                      virtual_address_offset; /*   144     8 */
>>>       __u64                      virtual_address_max;  /*   152     8 */
>>>       __u32                      virtual_address_alignment; /*   160     4 */
>>>       __u32                      pte_fragment_size;    /*   164     4 */
>>>       __u32                      gart_page_size;       /*   168     4 */
>>>       __u32                      ce_ram_size;          /*   172     4 */
>>>       __u32                      vram_type;            /*   176     4 */
>>>       __u32                      vram_bit_width;       /*   180     4 */
>>>       __u32                      vce_harvest_config;   /*   184     4 */
>>>       __u32                      gc_double_offchip_lds_buf; /*   188     4 */
>>>       /* --- cacheline 3 boundary (192 bytes) --- */
>>>       __u64                      prim_buf_gpu_addr;    /*   192     8 */
>>>       __u64                      pos_buf_gpu_addr;     /*   200     8 */
>>>       __u64                      cntl_sb_buf_gpu_addr; /*   208     8 */
>>>       __u64                      param_buf_gpu_addr;   /*   216     8 */
>>>       __u32                      prim_buf_size;        /*   224     4 */
>>>       __u32                      pos_buf_size;         /*   228     4 */
>>>       __u32                      cntl_sb_buf_size;     /*   232     4 */
>>>       __u32                      param_buf_size;       /*   236     4 */
>>>       __u32                      wave_front_size;      /*   240     4 */
>>>       __u32                      num_shader_visible_vgprs; /*   244     4 */
>>>       __u32                      num_cu_per_sh;        /*   248     4 */
>>>       __u32                      num_tcc_blocks;       /*   252     4 */
>>>       /* --- cacheline 4 boundary (256 bytes) --- */
>>>       __u32                      gs_vgt_table_depth;   /*   256     4 */
>>>       __u32                      gs_prim_buffer_depth; /*   260     4 */
>>>       __u32                      max_gs_waves_per_vgt; /*   264     4 */
>>>       __u32                      _pad1;                /*   268     4 */
>>>       __u32                      cu_ao_bitmap[4][4];   /*   272    64 */
>>>       /* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
>>>       __u64                      high_va_offset;       /*   336     8 */
>>>       __u64                      high_va_max;          /*   344     8 */
>>>       __u32                      pa_sc_tile_steering_override; /*   352     4 */
>>>
>>>       /* XXX 4 bytes hole, try to pack */
>>>
>>>       __u64                      tcc_disabled_mask;    /*   360     8 */
>>>
>>>       /* size: 368, cachelines: 6, members: 49 */
>>>       /* sum members: 364, holes: 1, sum holes: 4 */
>>>       /* last cacheline: 48 bytes */
>>> };
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index a8c47aecd342..0047da06041f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -707,9 +707,10 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
>>>               return n ? -EFAULT : 0;
>>>       }
>>>       case AMDGPU_INFO_DEV_INFO: {
>>> -             struct drm_amdgpu_info_device dev_info = {};
>>> +             struct drm_amdgpu_info_device dev_info;
>>>               uint64_t vm_size;
>>>
>>> +             memset(&dev_info, 0, sizeof(dev_info));
>>>               dev_info.device_id = dev->pdev->device;
>>>               dev_info.chip_rev = adev->rev_id;
>>>               dev_info.external_rev = adev->external_rev_id;
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C801b15acd01d4ae785cb08d833c646d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637316274006319686&amp;sdata=x3X0UlMW%2FnzTkmjHUTIyTEgQKC8m%2BrpqXBBMFLBhbuc%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C801b15acd01d4ae785cb08d833c646d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637316274006319686&amp;sdata=x3X0UlMW%2FnzTkmjHUTIyTEgQKC8m%2BrpqXBBMFLBhbuc%3D&amp;reserved=0
> 

