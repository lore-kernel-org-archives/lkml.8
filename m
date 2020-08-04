Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AFAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F1B204EA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TF9eYOFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgHDQf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:35:57 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:14497
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728525AbgHDQfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:35:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgXMU+ZMaR6A2G+cX2t8b+eebNbHQrigP6RmNUz7F8oXCooGhaO/tLRfdPxgNOy3ElOKd/7bUmA9sLCt8q6jJj9jpohsFfMpWmf3xFNULlWxXESWqeiqkMwY2MQAzgXaw98FzoGMXkeWBN64r8XXmTKX2qEllSaz9V3bc+Ro3I77NLkbQ22D8m0oCYsARS7pmZXtnvpxW/Xy0cbyRfqcRQpfQWm4DH5OoleY1fEbeSFXBW6n/Ffg1WWx8bJ1wQQ3D9xdeWcHvRTPcIzT8MraPrNn6vpOUFL6dHEqvyAWaLzUYGwSv9S4VyssoXwuyAABkJ59pMkdeFYKfF37PRrf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyI5Xgpwn+mMAzV+JsVF8ilweF0EK9ghwhcNodMQpAw=;
 b=EWpDeBiXqFLwQ9psnQT72r9zMnO5S55ZpLwwvnm8NcoCP/0GW5miQ3D3LJYjUi+uNlJuju588eyfEyozaSqaPyk8NMT3RXBXNn10/3wUVgCCLLMdgobWRX1I+UPjjcDAbpi3xh50Ck6JaK9qQZZcw0iqqdtGOR/WG6pgbY8INFzs/vXAm3HZVk0QvU092XgmYg3W2TT39S21rJWDQvqCSTzJp1ePfWZZn4/xJQm40+hQphotVfNR0jrj3kJyw55vEb5hYYnT5RzRDKrGehE9Xf2MeVf4PoTsN4Udo2ranS2dqKT/mI20dzb5+VcqzeZOpiL3WhITnIUfA1VLzl+MAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyI5Xgpwn+mMAzV+JsVF8ilweF0EK9ghwhcNodMQpAw=;
 b=TF9eYOFDkxS0XaUy5cYcWDns1gkYQJ1REmrZA6UwPhsxc3Z6/nF2CliYsfpDrVD+O2kw96CaHpTYqvO1WFJYv+mHg3ig261Exdkc+s/1Fm3Qy17mWAabRqMFuikRDpTTTOHAqMAeq2nSwAprIIKZsTm3C75tU6DIJN4CF1jLsvg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2821.namprd12.prod.outlook.com (2603:10b6:a03:9b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 16:35:50 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 16:35:50 +0000
Subject: Re: [PATCH] drm/amd/display: use correct scale for actual_brightness
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
References: <20200803200218.2167-1-amonakov@ispras.ru>
 <35b551fe-7c14-3d8e-4056-39975bd75105@amd.com>
 <alpine.LNX.2.20.13.2008041922170.2454@monopod.intra.ispras.ru>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <f1bc6b02-0761-c3c0-d629-7b8f97bef8d7@amd.com>
Date:   Tue, 4 Aug 2020 12:35:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <alpine.LNX.2.20.13.2008041922170.2454@monopod.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::48) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by YTXPR0101CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 16:35:49 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: adaea594-9d2a-4565-17b7-08d83894729d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2821117F5A9DDC4C0E2D03D8EC4A0@BYAPR12MB2821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fe/cfLyPBvMBrUuOqiMtwVZJqXAZj+VvXj7gxa9cc4FczNNwHxWft8L1FN3njkEXVyqsLduz/JfwQGbWWhEEmyzfby3L3JePPCFbzECy48ww4pIKzuXIS3p4sZ/1Tomw/eRyZd3uSghJNtIf+A3CBB6prEixLsVeq/TvekIXGeTfNdDdoAnMLxo32QBYj9vDQq6dAo1SZ7u7pif/ppmp5ETWa5siYjUS410fE+k6/i8DHj7xQuNXWkj9UFIHLBE4ttZPdsrbysOR5aB4x6QzeyvN45M6IKTYEnFTMILNvwcupioRi5wouHzWedqcl+UMWsZmC1kk6pFTbGZ7APjfkXJWioqyEpa3bYlplr4lxPoWT6pAH1us56QDj/FwafEmjV9GIB+o5wFnMM/rc/oi1zNqKDWHPIxN6ev09+kJvtp2AmjLuiSfJ1AZ6MvBA9N6m7jQojhnDWxCSzfLTwTDOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(316002)(16576012)(53546011)(16526019)(4326008)(6916009)(2906002)(52116002)(6486002)(966005)(186003)(8936002)(8676002)(478600001)(26005)(2616005)(66556008)(6666004)(956004)(86362001)(5660300002)(83380400001)(66476007)(36756003)(31686004)(66946007)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sqS3d/MWmhhp7UcJapOfP82c6K/fTzLqCmWVZQ6jso7KNqYScLWWPjai0hD+hV+S3fEtawFmOquFDpxrWTlLuo/ES5W2Qk9v+IG/X8KxvtGqj5DmOs3wP1/tqZoP84VO8uNvlKLV13jBJkjXMLZT2rbCnq9mhX+gAwaYNR6STS4ygL3lX/6Y1TrXIRkMKcSup4HUdGqN9trChYyXCC1J/E2FjZdwXibYAiq78/44s/kWUf6Wy9YZBzMGbTCkGYRmL/iQG5HesUOVH3bZQPywFmDYuaPGlXcFv+zCKNb+VHnshes4ZPcfd6tRcH7Dbkwamgecpnq2uKsJxWlKY5vfQWLeplBAK0agaYHvPS0Dcjc6gKSRv9omiYuoVr4efxcuFQ2FhAWBkBq1X24H4LuIhOm47QGrGXL/sXAfk7raz27ccLcCiSJ0KBK9dfElMgHfYNS2KTt5gFvZ2he/LgEEyMlixoCDOAk+Z0FZ4/C+bnla0XZW+bw+mFMrZjEZfpRmP8pTB7HJk16LQe3nqtuT2x722EgNhCJUnlS9pe1NEhfZFcrvHrK1/8M2egxzh7QbCRYBUVnlLlXgDymb0Fs20lYAauXV/VfNgvwTQpeNbNDgk8HzloGnnBZpWzPWdQJ9cgN8buBWQ5/vu06wd29o5A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adaea594-9d2a-4565-17b7-08d83894729d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 16:35:50.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGGS1dolp95Gn/6Sg4hV4/BfHwL5jzx4pxtyY5DERRfwclQ0Qch9n34TBeemfbGnrKs5s+/FE6+rgvTfClWs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-04 12:28 p.m., Alexander Monakov wrote:
> 
> 
> On Tue, 4 Aug 2020, Kazlauskas, Nicholas wrote:
> 
>> This is a cleaner change the other proposed patch since it doesn't need to
> 
> Can you give a URL to the other patch please?

Sorry, replied to the wrong email by accident here.

The other change was modifying the max_brightness range and rescaling 
internal min/max defaults.

I don't think it was sent out to the list yet.

Regards,
Nicholas Kazlauskas

> 
>> modify the exist conversion functions but I'd be worried about broken
>> userspace relying on 0-255 as the only acceptable range.
> 
> Not sure what you mean by this. Userspace simply reads the maximum value from
> max_brightness sysfs file. On other gpu/firmware combinations it can be 7 or 9
> for example, it just happens to be 255 with modern amdgpu. Minimum value is
> always zero.
> 
> Value seen in max_brightness remains 255 with this patch, so as far as userspace
> is concerned nothing is changed apart from value given by actual_brightness file.
> 
> Alexander
> 
>>
>> Not an expert on existing implementations to point out a specific one though.
>>
>> Regards,
>> Nicholas Kazlauskas
>>
>> On 2020-08-03 4:02 p.m., Alexander Monakov wrote:
>>> Documentation for sysfs backlight level interface requires that
>>> values in both 'brightness' and 'actual_brightness' files are
>>> interpreted to be in range from 0 to the value given in the
>>> 'max_brightness' file.
>>>
>>> With amdgpu, max_brightness gives 255, and values written by the user
>>> into 'brightness' are internally rescaled to a wider range. However,
>>> reading from 'actual_brightness' gives the raw register value without
>>> inverse rescaling. This causes issues for various userspace tools such
>>> as PowerTop and systemd that expect the value to be in the correct
>>> range.
>>>
>>> Introduce a helper to retrieve internal backlight range. Extend the
>>> existing 'convert_brightness' function to handle conversion in both
>>> directions.
>>>
>>> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=203905
>>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1242
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
>>> ---
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 ++++++++-----------
>>>    1 file changed, 32 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 710edc70e37e..03e21e7b7917 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -2881,51 +2881,42 @@ static int set_backlight_via_aux(struct dc_link
>>> *link, uint32_t brightness)
>>>    	return rc ? 0 : 1;
>>>    }
>>>    -static u32 convert_brightness(const struct amdgpu_dm_backlight_caps
>>> *caps,
>>> -			      const uint32_t user_brightness)
>>> +static int get_brightness_range(const struct amdgpu_dm_backlight_caps
>>> *caps,
>>> +				unsigned *min, unsigned *max)
>>>    {
>>> -	u32 min, max, conversion_pace;
>>> -	u32 brightness = user_brightness;
>>> -
>>>    	if (!caps)
>>> -		goto out;
>>> +		return 0;
>>>    -	if (!caps->aux_support) {
>>> -		max = caps->max_input_signal;
>>> -		min = caps->min_input_signal;
>>> -		/*
>>> -		 * The brightness input is in the range 0-255
>>> -		 * It needs to be rescaled to be between the
>>> -		 * requested min and max input signal
>>> -		 * It also needs to be scaled up by 0x101 to
>>> -		 * match the DC interface which has a range of
>>> -		 * 0 to 0xffff
>>> -		 */
>>> -		conversion_pace = 0x101;
>>> -		brightness =
>>> -			user_brightness
>>> -			* conversion_pace
>>> -			* (max - min)
>>> -			/ AMDGPU_MAX_BL_LEVEL
>>> -			+ min * conversion_pace;
>>> +	if (caps->aux_support) {
>>> +		// Firmware limits are in nits, DC API wants millinits.
>>> +		*max = 1000 * caps->aux_max_input_signal;
>>> +		*min = 1000 * caps->aux_min_input_signal;
>>>    	} else {
>>> -		/* TODO
>>> -		 * We are doing a linear interpolation here, which is OK but
>>> -		 * does not provide the optimal result. We probably want
>>> -		 * something close to the Perceptual Quantizer (PQ) curve.
>>> -		 */
>>> -		max = caps->aux_max_input_signal;
>>> -		min = caps->aux_min_input_signal;
>>> -
>>> -		brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
>>> -			       + user_brightness * max;
>>> -		// Multiple the value by 1000 since we use millinits
>>> -		brightness *= 1000;
>>> -		brightness = DIV_ROUND_CLOSEST(brightness,
>>> AMDGPU_MAX_BL_LEVEL);
>>> +		// Firmware limits are 8-bit, PWM control is 16-bit.
>>> +		*max = 0x101 * caps->max_input_signal;
>>> +		*min = 0x101 * caps->min_input_signal;
>>>    	}
>>> +	return 1;
>>> +}
>>>    -out:
>>> -	return brightness;
>>> +static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
>>> +			      const uint32_t brightness, int from_user)
>>> +{
>>> +	unsigned min, max;
>>> +
>>> +	if (!get_brightness_range(caps, &min, &max))
>>> +		return brightness;
>>> +
>>> +	if (from_user)
>>> +		// Rescale 0..255 to min..max
>>> +		return min + DIV_ROUND_CLOSEST((max - min) * brightness,
>>> +					       AMDGPU_MAX_BL_LEVEL);
>>> +
>>> +	if (brightness < min)
>>> +		return 0;
>>> +	// Rescale min..max to 0..255
>>> +	return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
>>> +				 max - min);
>>>    }
>>>      static int amdgpu_dm_backlight_update_status(struct backlight_device
>>> *bd)
>>> @@ -2941,7 +2932,7 @@ static int amdgpu_dm_backlight_update_status(struct
>>> backlight_device *bd)
>>>      	link = (struct dc_link *)dm->backlight_link;
>>>    -	brightness = convert_brightness(&caps, bd->props.brightness);
>>> +	brightness = convert_brightness(&caps, bd->props.brightness, 1);
>>>    	// Change brightness based on AUX property
>>>    	if (caps.aux_support)
>>>    		return set_backlight_via_aux(link, brightness);
>>> @@ -2958,7 +2949,7 @@ static int amdgpu_dm_backlight_get_brightness(struct
>>> backlight_device *bd)
>>>      	if (ret == DC_ERROR_UNEXPECTED)
>>>    		return bd->props.brightness;
>>> -	return ret;
>>> +	return convert_brightness(&dm->backlight_caps, ret, 0);
>>>    }
>>>      static const struct backlight_ops amdgpu_dm_backlight_ops = {
>>>
>>> base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
>>>
>>
>>

