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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3101B208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uRSImO4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgHDQXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:23:10 -0400
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:4321
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbgHDQVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcqijRejEuODjm5bJGgIIvQtGO1yAZRFFY6ZFsF+4Fgq5i7l08FYpmYN/lYJ6RC4UHKYBbwgkU+OXSF76BTz9m1yAzZKUQtFnMA2xoHYK297NoreWjwfw9rTMAHgNCpdFCTtnVfZzpmNTKktYRUeIzsWqO0Cna6rUQngI75G4OzxNgORljnFNd0mC9h3/yrD8XRXrKrNqY51CeqLCQUfqO7OBqwdgA6dXzKViUfW0rQkgl5Yx9klwkPW5ZjxS3KnOYUMS+U5HgO2lnvIsfEoAPhzX5yOxExuwK+6Z31qFKUW7RxHZ8/XHgQEP0OXT/8u9mza7kYWo9b4k6CJAKa1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv8coRyrgi3+34EaHkGH4iPHYKOflG1bdul2wCtpuMc=;
 b=U3gJ25S3nU7pUDV9NAIpR0YzJHpYNOtH5L94OCBvEj24RvyWLv8VYkpspH74LSnfjWq8lHTzo0QlIpCnkJIjvLkFR6hihfcE4QCDODQlCKPg+JNqTzOBM7qmqW1IZFS9epF6RWSwMuQrBMIRNtv/9i+ZqFjGcsgnIz7AhHUdkPr6iZGKDcFkseiXr7QVwOMi6Zhd/tgMd7d0Q3qKFZ4WHxO2Z8xTmv0Ur8GZSsQGyp03lDiHq/ObiwQ8QOvlgw1kePfKYgLOcqfiGV2S2G86aqT2LfFUF4w8xa4RRaG/P9BsfT8qUAgBLDZkEoZoNIM8/R+MfulHhx/N/vV/lEQSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv8coRyrgi3+34EaHkGH4iPHYKOflG1bdul2wCtpuMc=;
 b=uRSImO4+nKV0dgkvskRXOgHDmdKGuPLkgaob1gorB13dDa/q3+B5UORw0h/O0tmllHwZ0AlVWHKjs6CEYvSmWTs6qlZX7JARI9gQZ79wfoGs3+SFqELSZYIG3Uciei/9zg+nyYD0zSDacnrYp0XyrQgIK7MFps7e7S+h2lrY7Y4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB3796.namprd12.prod.outlook.com (2603:10b6:a03:1ae::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Tue, 4 Aug
 2020 16:21:14 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::7d42:c932:e35f:71b1%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 16:21:14 +0000
Subject: Re: [PATCH] drm/amd/display: use correct scale for actual_brightness
To:     Alexander Monakov <amonakov@ispras.ru>,
        amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
References: <20200803200218.2167-1-amonakov@ispras.ru>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <a3a167d9-9117-edc1-c761-b31fa3194f8b@amd.com>
Date:   Tue, 4 Aug 2020 12:21:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200803200218.2167-1-amonakov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 4 Aug 2020 16:21:13 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74d8b8b5-394a-415f-8258-08d838926862
X-MS-TrafficTypeDiagnostic: BY5PR12MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37963932C70781C3FC794289EC4A0@BY5PR12MB3796.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnFF/SRf0xb1o9PezCJhD0pcIqkHWHWwsmCLgaXF4JtptXTX/TjTLz5pEc9SSxNlzIZwpQvXs56xA29YE3oqIc/YfkudBRzBOqf5+aeAlj2SlDSFHarZ89C93ffuHE+kx8OCUu/EMcpa8GYdadQMerjBMdVB8LsGu/UP9Plwox1Kqe7b/BFe/HktlTaXBZWrMMpa/in0o4hjMjPLbSfG2DkP6fV7l6B7srrw4cqYVaMrGtI9VEtNKXjnF+J8fLDOjwstplHhxkySMVCdCNlQtCq3qRo/RPoVLttejMsbiAp1i42WUatNv+ViAFse7JI4ijsLQH0oJirLicglxMmNLp1dEAI1fV3bQx+7FVMpdUrX01+yPwhntARBo9nsDAONS7ZozrYyfmN/4yCKKshc3LmL5IMglVXPN+N0Phc+/k0VNho1vLuYwceB1y3AbNhPoB9dEtKO9QBMsE04ziCO9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(966005)(52116002)(36756003)(316002)(5660300002)(6486002)(31686004)(53546011)(16576012)(86362001)(66946007)(83380400001)(956004)(2616005)(6666004)(31696002)(26005)(478600001)(8936002)(66556008)(66476007)(16526019)(2906002)(186003)(8676002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BsSLaNVcIP0hjapCgn5bqdw7Rgudigodi50riakIYO1HF3NWMub+Ec4hwa1hXHSwA8nt4Jw1psfbg5KMojnXbi4YXibI7ybvUHTXio/DwyIb8zcKytto4iub3MdMHwfXwZyHs3Km8QY9qSd+Pv1mmF4OcxNL1+eB4udm1O2e/1sKkBUeWxA1tbR+UnVKN/MxxA6D97jQZEe5B2v9JwPFW6Bw0hJqiX4k0yr1Z1fiWKCo1PLArLXaBRXDVWx+hidEj13b6cds3b5WFspJXRqjyxA4dwpFigInoFHnFMETp7TOGdC9ahEeFvm2GfESnKd17lBcWvaeYtCIrKH+PZ54Mo3H3l4GB5HHXtTPfhXru1ezj5BmH8G1/CLnVXFQVn8965ewulMsgjvGuwgIzEYxSgeRbdirwvO35xXvu7Av1n7iKp0DiLTtvkw3F5QDvtmePZL7elpPKKZP32Rdu9sBtOF/eaIfFdZx6sxf7Bt/FyDgceM1zgGsFS71jM8Efeg59clSHcpFZC1150lSBsR9ksJ9qUMZ5gqa7SirZrxY0d5F2pgGSRWCoX97r5QcM6CdkrDTOIJJURlVfich7C2h4Q2HyTpRUzsStY860kDQqImuq4GINc0qCh3BpAVxdrBPHWmsz+AjLx5kfzhXLGQEHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d8b8b5-394a-415f-8258-08d838926862
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 16:21:14.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 985WGD26JGGec8Qi57yXt/DB8VPis6SdHI+N0PUDLw3hYcG403ohtvHIcbX/F6rBBVsqzxL8sVqRAUUc1NNWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Overall approach seems reasonable, nice catch.

I suggest to add convert_to_user_brightness() instead of making 
from_user a flag and extending the current functionality though. It 
makes it more clear from the call site what's happening.

Regards,
Nicholas Kazlauskas

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

