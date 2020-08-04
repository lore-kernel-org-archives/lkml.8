Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8022086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k0UUQGaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgHDQS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:18:28 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:26369
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728271AbgHDQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec/c63t4dcYjm6c7ykudn/di/RBXWutYU5cdER/1BbZbJ6sn0tqALthNXBeLyG6ZcAo0ueV1iVc8fTfSV1vfa6vwjQ+Osd2OGn+Cd4I0LWFAwxRnEPlNSIbqBLhkl3QHD7S6794i7wlJF/FRXUoLtkHx0OdXfKFWdqq39iZj3Z/Ua/ApkpUeQPfLg9hgE1rGTBqooKh/ZHEv1zFODkAUtPThfRjghjiLwMqNnOnzNBMgqJ7b7TsnTzARVie6hcvDFvYJOS3WKhxDtqNEyN9yBZqo4WhTL1S4Eu98bTwgkDxQC5HYi09scX1t8zxbSsQ1yCQULwmNc7vGeh+83H8LKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfd94lMqUs5pZhvwnisUhLwtasfM7T1LBvVYia5xzHw=;
 b=N1U2m++EXwfjYSq4VE8ad/iYXK+Q44nn6NFJpyJTrHonm2hhHpYmeuwUiTUzGVXBUmlfeSO5te3+MLicKddJTtG8Bk3uJWQ1AiF6X+CF6HNCMj20kDyz4eHoL7qKzobX+rx4VUd22xBTeK7n4M25TSEWqhIwiOhGaukp/wYP0P6WHv1vhn34EALxqGqzvi8Dd9qO26ool+9IpyBxm90rHXD6NFmj8KggiuSbPH8V7J1LqidlLuGR9GrMiZG8K0DbdEEXTj5tvQOQibp/DnDWB7qXzZC6ngd/6XbpUEZge6ZoDMvT4Xc2SG3Y08jTjU1tLwW7gT6duJcUjXPDETKNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfd94lMqUs5pZhvwnisUhLwtasfM7T1LBvVYia5xzHw=;
 b=k0UUQGaNlXtcBKPDBR1NEXMP8REXlyrHks5Lx7u2EjVHzL6N5buGCXen1Q109nDULvZqFl0Wqf4W7C3tNrDeVxV8Hgw9PokvjdTJVrrlCw+ur0ewmZ+/Az9TGtArV3Pqq3PF6TMdtUNcuXcpb3O8k3zcFOOE2AQRvhXc8CJqBUE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3575.namprd12.prod.outlook.com (2603:10b6:a03:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 16:18:18 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 16:18:18 +0000
Subject: Re: [PATCH] drm/amd/display: use correct scale for actual_brightness
To:     Alexander Monakov <amonakov@ispras.ru>,
        amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
References: <20200803200218.2167-1-amonakov@ispras.ru>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <35b551fe-7c14-3d8e-4056-39975bd75105@amd.com>
Date:   Tue, 4 Aug 2020 12:18:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200803200218.2167-1-amonakov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 4 Aug 2020 16:18:17 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b012456-7d34-40bc-d131-08d83891ff55
X-MS-TrafficTypeDiagnostic: BYAPR12MB3575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB357544FDB2478F31CE53C01CEC4A0@BYAPR12MB3575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSrCVOuKf7XdBEjxZCD2aGgwxkdmqYSEzbdLay9dcoRaM6Z7eQpsFgf9Kpx3IhrzgUlAO7B6l78pQEBhqsa+BqtDpeGhq16Yi7JDMtMfssmWqM5KY4lNF95KFNXJGONtU3DxAB4cOVS7bkZhPHJlj+AHn+s8tLV4ZBIBz0j5oIS7ipPWbXhvTFfxu1fIxHUyJ6lnmexqSPPio85vgBAkTcVaK+a1wtzyChJshtiHm4u7sgarh8oOJYTvZl4F+SdcYWtCuAhjaxFPTSeV11fLhViQb/tT0TQbsVcXEo9/xTpQNYdCYziPdSnn5/s5y+uMfHe3uQl9Hig1Dcjlbelb7aw2gBjr2moGToixhFJUnJWyYjfixn+73eMUnTpf1Jjxps+CPt/50OHXpTVRkRwoZhuGzYyrJxl1tFNB2AUt01ftUZaITKTH8YgHQvaiil8cLinCgK/oP3pG6RGoqBJ/ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(6666004)(31686004)(31696002)(16576012)(8676002)(5660300002)(478600001)(966005)(316002)(8936002)(6486002)(86362001)(66556008)(66946007)(66476007)(53546011)(36756003)(26005)(4326008)(52116002)(956004)(16526019)(2616005)(186003)(83380400001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4vOZarAZ5s8u7gC+YygzMPmPEwFJVsf9E9enD9ogyb53OZl41Ku1yuU5uBV0QD+nr154vLXrBER0n12EdiDiWRVygE2tQ764B/Nrm1kePK4tTAwDqW7HZFn4U8LzOEGzaa4l3R8rrxb1SQHy1PS+oh3YCxiUNJn8KhLwp7ikcyYb/0LNKpp1MNHtEEPZGyslchwOz/QnKQaLa24kOl8x8g8qEt5usWrnbe1mmNQrHaDNiyBCzAKnQvnpP0i3f+qCMtaRL73M76UOYUSV0+/pFZ58zvpZfR+9v97rSF9XixOgkJy9Wefiav3LeBBY+/MgoUZNb5R8UpfrDJS6C3ZheXFTTTdf61NvuOqT5xrbNOyOcVm7e6JHH1RZ5qiW3ITCGICf/wiLMduC+/G2b/Y3HDcu4igFfvkfFfNE4mW12XXzTbaVYk+c9Q/pG7GyJMw3UIx9ny5K1YOblIM1KiCeoRo6h8t+65NM2cQQYMdk/PZILKHR2K2ASLwtC/j6YbAfSrDTy5dVur4M+QgkbVjLORlZC7AW73rpDC4HyBY7bcNRdnyW7R3mUp2TW5xcdoH5Bw9EpRQjj8UIUSV1CqEIP5fnxOWCet3dRFu4n0HKGDUt+Yz1SJwz2GYH3IEYFZYZWZnMtvtx4Uc01rLPRv5WiQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b012456-7d34-40bc-d131-08d83891ff55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 16:18:18.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxS2+1/Y8wShdfzkOKL6kx1Kz0JRD5or/SuYX1CZWfFuf3zJ2NvmcJGPoZDIZtlXZxkFayTi+jnno8lRaXCE7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleaner change the other proposed patch since it doesn't need 
to modify the exist conversion functions but I'd be worried about broken 
userspace relying on 0-255 as the only acceptable range.

Not an expert on existing implementations to point out a specific one 
though.

Regards,
Nicholas Kazlauskas

On 2020-08-03 4:02 p.m., Alexander Monakov wrote:
> Documentation for sysfs backlight level interface requires that
> values in both 'brightness' and 'actual_brightness' files are
> interpreted to be in range from 0 to the value given in the
> 'max_brightness' file.
> 
> With amdgpu, max_brightness gives 255, and values written by the user
> into 'brightness' are internally rescaled to a wider range. However,
> reading from 'actual_brightness' gives the raw register value without
> inverse rescaling. This causes issues for various userspace tools such
> as PowerTop and systemd that expect the value to be in the correct
> range.
> 
> Introduce a helper to retrieve internal backlight range. Extend the
> existing 'convert_brightness' function to handle conversion in both
> directions.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=203905
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1242
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 ++++++++-----------
>   1 file changed, 32 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 710edc70e37e..03e21e7b7917 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2881,51 +2881,42 @@ static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
>   	return rc ? 0 : 1;
>   }
>   
> -static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			      const uint32_t user_brightness)
> +static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
> +				unsigned *min, unsigned *max)
>   {
> -	u32 min, max, conversion_pace;
> -	u32 brightness = user_brightness;
> -
>   	if (!caps)
> -		goto out;
> +		return 0;
>   
> -	if (!caps->aux_support) {
> -		max = caps->max_input_signal;
> -		min = caps->min_input_signal;
> -		/*
> -		 * The brightness input is in the range 0-255
> -		 * It needs to be rescaled to be between the
> -		 * requested min and max input signal
> -		 * It also needs to be scaled up by 0x101 to
> -		 * match the DC interface which has a range of
> -		 * 0 to 0xffff
> -		 */
> -		conversion_pace = 0x101;
> -		brightness =
> -			user_brightness
> -			* conversion_pace
> -			* (max - min)
> -			/ AMDGPU_MAX_BL_LEVEL
> -			+ min * conversion_pace;
> +	if (caps->aux_support) {
> +		// Firmware limits are in nits, DC API wants millinits.
> +		*max = 1000 * caps->aux_max_input_signal;
> +		*min = 1000 * caps->aux_min_input_signal;
>   	} else {
> -		/* TODO
> -		 * We are doing a linear interpolation here, which is OK but
> -		 * does not provide the optimal result. We probably want
> -		 * something close to the Perceptual Quantizer (PQ) curve.
> -		 */
> -		max = caps->aux_max_input_signal;
> -		min = caps->aux_min_input_signal;
> -
> -		brightness = (AMDGPU_MAX_BL_LEVEL - user_brightness) * min
> -			       + user_brightness * max;
> -		// Multiple the value by 1000 since we use millinits
> -		brightness *= 1000;
> -		brightness = DIV_ROUND_CLOSEST(brightness, AMDGPU_MAX_BL_LEVEL);
> +		// Firmware limits are 8-bit, PWM control is 16-bit.
> +		*max = 0x101 * caps->max_input_signal;
> +		*min = 0x101 * caps->min_input_signal;
>   	}
> +	return 1;
> +}
>   
> -out:
> -	return brightness;
> +static u32 convert_brightness(const struct amdgpu_dm_backlight_caps *caps,
> +			      const uint32_t brightness, int from_user)
> +{
> +	unsigned min, max;
> +
> +	if (!get_brightness_range(caps, &min, &max))
> +		return brightness;
> +
> +	if (from_user)
> +		// Rescale 0..255 to min..max
> +		return min + DIV_ROUND_CLOSEST((max - min) * brightness,
> +					       AMDGPU_MAX_BL_LEVEL);
> +
> +	if (brightness < min)
> +		return 0;
> +	// Rescale min..max to 0..255
> +	return DIV_ROUND_CLOSEST(AMDGPU_MAX_BL_LEVEL * (brightness - min),
> +				 max - min);
>   }
>   
>   static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> @@ -2941,7 +2932,7 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>   
>   	link = (struct dc_link *)dm->backlight_link;
>   
> -	brightness = convert_brightness(&caps, bd->props.brightness);
> +	brightness = convert_brightness(&caps, bd->props.brightness, 1);
>   	// Change brightness based on AUX property
>   	if (caps.aux_support)
>   		return set_backlight_via_aux(link, brightness);
> @@ -2958,7 +2949,7 @@ static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
>   
>   	if (ret == DC_ERROR_UNEXPECTED)
>   		return bd->props.brightness;
> -	return ret;
> +	return convert_brightness(&dm->backlight_caps, ret, 0);
>   }
>   
>   static const struct backlight_ops amdgpu_dm_backlight_ops = {
> 
> base-commit: bcf876870b95592b52519ed4aafcf9d95999bc9c
> 

