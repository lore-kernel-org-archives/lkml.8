Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D8321D43
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MKLCvQoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgIHITE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:19:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgIHITC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:19:02 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0888ITMI075895;
        Tue, 8 Sep 2020 03:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599553109;
        bh=4eo8hs8HzetIEb9ibaaRaZuLk1d4NQhqq0X0s00zao4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MKLCvQooUkJ1q9w460K7G/4x+lYIEwCtwqnkxihR5/16AjtXRZkcUYAduUV/FBbsU
         2eMDFi3HgH0Dt2wMUQccqQSW7nqAarGYzYRo3KKDRc9aLyoL19zruegCnpm7jsR+/g
         HCmFxnHuuEyM7H5I42Ah/XZkvJgVOycZyE9/qESE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0888ITxQ048580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 03:18:29 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 03:18:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 03:18:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0888IPRk107862;
        Tue, 8 Sep 2020 03:18:26 -0500
Subject: Re: [PATCH] drm: mxsfb: check framebuffer pitch
To:     Stefan Agner <stefan@agner.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <jsarha@ti.com>
CC:     <marex@denx.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200907160343.124405-1-stefan@agner.ch>
 <20200907161712.GF6047@pendragon.ideasonboard.com>
 <20200907181855.GE2352366@phenom.ffwll.local>
 <86615b4b1551d4a6f1cfcc13b38e616c@agner.ch>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <dc5a16d0-4d2a-366a-7716-29dd8db1a12a@ti.com>
Date:   Tue, 8 Sep 2020 11:18:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <86615b4b1551d4a6f1cfcc13b38e616c@agner.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/09/2020 10:55, Stefan Agner wrote:
> On 2020-09-07 20:18, Daniel Vetter wrote:
>> On Mon, Sep 07, 2020 at 07:17:12PM +0300, Laurent Pinchart wrote:
>>> Hi Stefan,
>>>
>>> Thank you for the patch.
>>>
>>> On Mon, Sep 07, 2020 at 06:03:43PM +0200, Stefan Agner wrote:
>>>> The lcdif IP does not support a framebuffer pitch (stride) other than
>>>> the CRTC width. Check for equality and reject the state otherwise.
>>>>
>>>> This prevents a distorted picture when using 640x800 and running the
>>>> Mesa graphics stack. Mesa tires to use a cache aligned stride, which
>>>
>>> s/tires/tries/
>>>
>>>> leads at that particular resolution to width != stride. Currently
>>>> Mesa has no fallback behavior, but rejecting this configuration allows
>>>> userspace to handle the issue correctly.
>>>
>>> I'm increasingly impressed by how featureful this IP core is :-)
>>>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 22 ++++++++++++++++++----
>>>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>>> index b721b8b262ce..79aa14027f91 100644
>>>> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>>> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
>>>> @@ -403,14 +403,28 @@ static int mxsfb_plane_atomic_check(struct drm_plane *plane,
>>>>  {
>>>>  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(plane->dev);
>>>>  	struct drm_crtc_state *crtc_state;
>>>> +	unsigned int pitch;
>>>> +	int ret;
>>>>
>>>>  	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>>>>  						   &mxsfb->crtc);
>>>>
>>>> -	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>>>> -						   DRM_PLANE_HELPER_NO_SCALING,
>>>> -						   DRM_PLANE_HELPER_NO_SCALING,
>>>> -						   false, true);
>>>> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>>>> +						  DRM_PLANE_HELPER_NO_SCALING,
>>>> +						  DRM_PLANE_HELPER_NO_SCALING,
>>>> +						  false, true);
>>>> +	if (ret || !plane_state->visible)
>>>
>>> Would it be more explict to check for !plane_state->fb ? Otherwise I'll
>>> have to verify that !fb always implies !visible :-)
>>>
>>>> +		return ret;
>>>> +
>>>> +	pitch = crtc_state->mode.hdisplay *
>>>> +		plane_state->fb->format->cpp[0];
>>>
>>> This holds on a single line.
>>>
>>>> +	if (plane_state->fb->pitches[0] != pitch) {
>>>> +		dev_err(plane->dev->dev,
>>>> +			"Invalid pitch: fb and crtc widths must be the same");
>>>
>>> I'd turn this into a dev_dbg(), printing error messages to the kernel
>>> log in response to user-triggered conditions is a bit too verbose and
>>> could flood the log.
>>>
>>> Wouldn't it be best to catch this issue when creating the framebuffer ?
>>
>> Yeah this should be verified at addfb time. We try to validate as early as
>> possible.
>> -Daniel
>>
> 
> Sounds sensible. From what I can tell fb_create is the proper callback
> to implement this at addfb time. Will give this a try.
> 
> FWIW, I got the idea from drivers/gpu/drm/tilcdc/tilcdc_plane.c. Maybe
> should be moved to addfb there too?

But you don't know the crtc width when creating the framebuffer.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
