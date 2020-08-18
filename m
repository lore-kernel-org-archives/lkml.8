Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F9CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120D1206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZhY2egE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHRQtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:49:06 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:28128
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgHRQtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hw1LPLpSAba5SdcP7Hmv/fUiTLrILZDuDS2tZe6x7B8EYbf5f8A8PRs1ytK+9EnfrOF8YEgNEnxToQnaPDjmZpmt7YHnZvvRJLfo2cDSaFB6jt+3UILGhEf4acM7SwGkLJ4v7Gjv2NH0+RiLvZWrI4PL2FdzpuucmD2Ss1ZcOFP+a5gCmzhbBwaPhZqDrGq7kA2WjjJwwZbU0yAUY3tsCqnMDrovJTCDuHiE55Y30vuUU3il6dKBvEB7kpUylYrg56Zjw7xVn9L3fQYxw3ACYjw6MUUpwSA++xaAjecfsRtkcXM0mR0GiaVhtFw/IjRh2Af7xlbh3xXW0tVpsIu8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvbDfO3Kd/K5ppomWoeFPwyfEMCTLg48bYwlthk/alU=;
 b=l91f0YtdsEVZZ/EQ6cykJ3v1CM5GHnLvv5sI/NLWNOanIX0jA6WwRw89fvRP38fWDcp7aUFDJX/3ZXBZSycBof8XDf4/3v43+PmeK3FNxntyIZ0a+jtDwEtidLcD617Y+7SAVidre0KTq6fdnjkab7Jxft/ld4IbQC7oYftw7VyBntqcqaDex18DVcItsEVNwXPletPMnFskmA0leSOhvlYhpoIMuKXZMwBFnoOnzASsDTrz9DePnpUdz0roUcNJNPHXIIu94qzvJW2VY4EcPcRiDx4rimBUG9XehP3pytSuEpUj7xzZMhwLpT64rPvzOiNJNel8pxGELOy9cUKYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvbDfO3Kd/K5ppomWoeFPwyfEMCTLg48bYwlthk/alU=;
 b=ZhY2egE95ZQPCqJti4U4MPh+kLqwIZXJLOvnRzcJAI/4AefihckbL22FsI9UqPbkvbKaZ7I8jZKqqYWFrBOpkjSxua9LKNNxihLk3UhgJWXbux5zH05VZQ6b65l7wKUA6IFfs/z8xDKu6zDZsczx5Eu9s4ikcleZiMWyD06sjnU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 16:49:01 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1%7]) with mapi id 15.20.3261.026; Tue, 18 Aug 2020
 16:49:01 +0000
Subject: Re: [PATCH v2] drm/amd/display: use correct scale for
 actual_brightness
To:     Alex Deucher <alexdeucher@gmail.com>,
        Alexander Monakov <amonakov@ispras.ru>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200804201313.6464-1-amonakov@ispras.ru>
 <alpine.LNX.2.20.13.2008161149010.7727@monopod.intra.ispras.ru>
 <CADnq5_OaTdfVGCvENTr3tDrU+9jR0VYo-49sjByOQR4EwDWwPA@mail.gmail.com>
 <CADnq5_OqtuHy6oAQkuZvDxR4OsLSZRDoLazXxD15m7y0hWtH2w@mail.gmail.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <a5182129-27fa-d0ff-8aa5-a125aaaf8408@amd.com>
Date:   Tue, 18 Aug 2020 12:48:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <CADnq5_OqtuHy6oAQkuZvDxR4OsLSZRDoLazXxD15m7y0hWtH2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 18 Aug 2020 16:49:00 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a621e5de-47c8-45e2-cd21-08d843969ba4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2839117438721041C8371297EC5C0@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwoaOMtsI18X1FupYuhuqEKK+DKJI3QdLqjG3xbPrUPyUxKaB+KcrESiwPsb1PXU7px34R46Ca8lX3X5WC0I3xZGCCo3h24fcmfSwiM0kwOlX3cRF53COI2eR213HnWxeZxFh0DD63V8m2xYbNtgrMY37wbnYwrSCd7Sb35GQAj9To1YH5eQ4BNiRIWuNkufRHNyA+HmbJ5oc5EenEuxE6+CPIsFy9UK9ldVTjcqz0MPdZCsvgZwir+5oJzrviFpJ1ndcR9oPY4PSnN96pw/BbZLwBYTx/3QhF9lOJYxGuEx93MLS5mDKrSfikfOSTyMCaZWFHkSidfzZhfspAx9B0m2GFjgfBRDZBgjN1Pe0tcfLnljHr2ZCbirJgee6WNtDp/otzSUjn7gXZzmO6BMhTD1p1IyV7S8bSUt7Ko4c2QjvY8+07paHm/4QWzSTRJnKJAroe/MqLmskdw/q0kSaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(110136005)(54906003)(53546011)(36756003)(52116002)(83380400001)(16576012)(5660300002)(31686004)(16526019)(26005)(86362001)(186003)(316002)(66556008)(478600001)(956004)(4326008)(6666004)(66476007)(8936002)(966005)(6486002)(31696002)(2906002)(2616005)(66946007)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CD7MovZlG/Xp8l97Wx+8z+j7gMsqLvII7kI39hp6rHDclbYtgR/LXlSJqCxtQQSOltfakCGz0sZubWHPuNVmLz8yJuwh8ab4x+O75mwQCwOIEwe8q11CpLqYoOvCAUf/MmEhNohcFZHCNf5/cAVSdRij0GalEWhRSiUBMgUM/a40AluHT+b86R8F/iq00Gr0EjXupmW5TxkEy4kD9p2TaT/zEW/aQQp4Vn62h6HvGc9XCpfFvovnQRexuhcssLfyb176k4OoQ9xaFVa9UrxriFFrmQUb34ktY9Fd5pY8EKtE7vqRGShOYDaUTuu5azh9Lw5Hbdo4deeoef6yL7BXLZmjYV70VR16GjJnE8Kq+srYaRA+bD+PrAf0hbmsMJB2Kqp+wXG6PSyFYpE/oiZT5Ku7pAzKXkj2eCMgfUi9380qIeEQ3l+RMIfKSQYqHHs+wv3D9g68j8iHW2ScOkHtMavkGjnZLM+MqUwRpLUat1I5kzVnfb5XccfWnEKObe00/MPGizIP6QVnD2/sbCVYWIIaA12W423QGjjt/IeDdsKnv5nOtKUJoJTiX80tKHFDNrHEXURDCP251BHizM2QLJCXW2CPL/EfI2gSXuU0flwGORrK5eJaQzu0YfBDVHNsyls2UEEgAQcQPTUr36opJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a621e5de-47c8-45e2-cd21-08d843969ba4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:49:01.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USnyuWst5c3ROv0iVmsEIX9kaZJ2MHmRRTjydxjh6cvk1tHrWVid51WRViqQA8Zz9hp0BKbtqL61tbuuDqvRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No objections from my side - and thanks for addressing my feedback.

Regards,
Nicholas Kazlauskas

On 2020-08-18 12:15 p.m., Alex Deucher wrote:
> Applied.  Thanks!
> 
> Alex
> 
> On Mon, Aug 17, 2020 at 1:59 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Mon, Aug 17, 2020 at 3:09 AM Alexander Monakov <amonakov@ispras.ru> wrote:
>>>
>>> Ping.
>>
>> Patch looks good to me:
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Nick, unless you have any objections, I'll go ahead and apply it.
>>
>> Alex
>>
>>>
>>> On Tue, 4 Aug 2020, Alexander Monakov wrote:
>>>
>>>> Documentation for sysfs backlight level interface requires that
>>>> values in both 'brightness' and 'actual_brightness' files are
>>>> interpreted to be in range from 0 to the value given in the
>>>> 'max_brightness' file.
>>>>
>>>> With amdgpu, max_brightness gives 255, and values written by the user
>>>> into 'brightness' are internally rescaled to a wider range. However,
>>>> reading from 'actual_brightness' gives the raw register value without
>>>> inverse rescaling. This causes issues for various userspace tools such
>>>> as PowerTop and systemd that expect the value to be in the correct
>>>> range.
>>>>
>>>> Introduce a helper to retrieve internal backlight range. Use it to
>>>> reimplement 'convert_brightness' as 'convert_brightness_from_user' and
>>>> introduce 'convert_brightness_to_user'.
>>>>
>>>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=203905
>>>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1242
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>>>> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
>>>> ---
>>>> v2: split convert_brightness to &_from_user and &_to_user (Nicholas)
>>>>
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 +++++++++----------
>>>>   1 file changed, 40 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 710edc70e37e..b60a763f3f95 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -2881,51 +2881,50 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
>>>>        return rc ? 0 : 1;
>>>>   }
>>>>
>>>> -static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
>>>> -                           const uint32_t user_brightness)
>>>> +static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>>>> +                             unsigned *min, unsigned *max)
>>>>   {
>>>> -     u32 min, max, conversion_pace;
>>>> -     u32 brightness = user_brightness;
>>>> -
>>>>        if (!caps)
>>>> -             goto out;
>>>> +             return 0;
>>>>
>>>> -     if (!caps->aux_support) {
>>>> -             max = caps->max_input_signal;
>>>> -             min = caps->min_input_signal;
>>>> -             /*
>>>> -              * The brightness input is in the range 0-255
>>>> -              * It needs to be rescaled to be between the
>>>> -              * requested min and max input signal
>>>> -              * It also needs to be scaled up by 0x101 to
>>>> -              * match the DC interface which has a range of
>>>> -              * 0 to 0xffff
>>>> -              */
>>>> -             conversion_pace = 0x101;
>>>> -             brightness =
>>>> -                     user_brightness
>>>> -                     * conversion_pace
>>>> -                     * (max - min)
>>>> -                     / AMDGPU_MAX_BL_LEVEL
>>>> -                     + min * conversion_pace;
>>>> +     if (caps->aux_support) {
>>>> +             // Firmware limits are in nits, DC API wants millinits.
>>>> +             *max = 1000 * caps->aux_max_input_signal;
>>>> +             *min = 1000 * caps->aux_min_input_signal;
>>>>        } else {
>>>> -             /* TODO
>>>> -              * We are doing a linear interpolation here, which is OK but
>>>> -              * does not provide the optimal result. We probably want
>>>> -              * something close to the Perceptual Quantizer (PQ) curve.
>>>> -              */
>>>> -             max = caps->aux_max_input_signal;
>>>> -             min = caps->aux_min_input_signal;
>>>> -
>>>> -             brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
>>>> -                            + user_brightness * max;
>>>> -             // Multiple the value by 1000 since we use millinits
>>>> -             brightness *= 1000;
>>>> -             brightness = DIV_ROUND_CLOSEST(brightness, AMDGPU_MAX_BL_LEVEL);
>>>> +             // Firmware limits are 8-bit, PWM control is 16-bit.
>>>> +             *max = 0x101 * caps->max_input_signal;
>>>> +             *min = 0x101 * caps->min_input_signal;
>>>>        }
>>>> +     return 1;
>>>> +}
>>>>
>>>> -out:
>>>> -     return brightness;
>>>> +static u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>>>> +                                     uint32_t brightness)
>>>> +{
>>>> +     unsigned min, max;
>>>> +
>>>> +     if (!get_brightness_range(caps, &min, &max))
>>>> +             return brightness;
>>>> +
>>>> +     // Rescale 0..255 to min..max
>>>> +     return min + DIV_ROUND_CLOSEST((max - min) * brightness,
>>>> +                                    AMDGPU_MAX_BL_LEVEL);
>>>> +}
>>>> +
>>>> +static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
>>>> +                                   uint32_t brightness)
>>>> +{
>>>> +     unsigned min, max;
>>>> +
>>>> +     if (!get_brightness_range(caps, &min, &max))
>>>> +             return brightness;
>>>> +
>>>> +     if (brightness < min)
>>>> +             return 0;
>>>> +     // Rescale min..max to 0..255
>>>> +     return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
>>>> +                              max - min);
>>>>   }
>>>>
>>>>   static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>>>> @@ -2941,7 +2940,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>>>>
>>>>        link = (struct dc_link *)dm->backlight_link;
>>>>
>>>> -     brightness = convert_brightness(&caps, bd->props.brightness);
>>>> +     brightness = convert_brightness_from_user(&caps, bd->props.brightness);
>>>>        // Change brightness based on AUX property
>>>>        if (caps.aux_support)
>>>>                return set_backlight_via_aux(link, brightness);
>>>> @@ -2958,7 +2957,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
>>>>
>>>>        if (ret == DC_ERROR_UNEXPECTED)
>>>>                return bd->props.brightness;
>>>> -     return ret;
>>>> +     return convert_brightness_to_user(&dm->backlight_caps, ret);
>>>>   }
>>>>
>>>>   static const struct backlight_ops amdgpu_dm_backlight_ops = {
>>>>
>>>> base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
>>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

