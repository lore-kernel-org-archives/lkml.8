Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D53C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622A6246AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="B9xycl32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgB2MP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:15:28 -0500
Received: from o1.b.az.sendgrid.net ([208.117.55.133]:9071 "EHLO
        o1.b.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2MP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
        h=subject:references:from:mime-version:in-reply-to:to:cc:content-type:
        content-transfer-encoding;
        s=001; bh=CxY2G8+hH6looKZegTwV3bRia1B33iNELwkDEJltT5c=;
        b=B9xycl32K/tQE0DUKdIpo62jpLIzWAp696SAzw0OsHI4JZN4Yh5Uw9mb7TNVtbu9IWCR
        Wmr4j1/wtAbY8ReSSRR3JXZJBC805eJMJ0bLWQG0h21LdtXwilqv5fRl9piAIQ5BYtutW0
        2EMHHk9xtAl1IdVriGZxUFcukYK6p8xFw=
Received: by filterdrecv-p3las1-9564bb6d7-tv7m2 with SMTP id filterdrecv-p3las1-9564bb6d7-tv7m2-17-5E5A55DD-D0
        2020-02-29 12:15:26.104303209 +0000 UTC m=+1963979.605402342
Received: from [10.13.72.105] (unknown [212.112.166.34])
        by ismtpd0007p1lon1.sendgrid.net (SG) with ESMTP id snBUXJHvQZGWmePxrVPDDQ
        Sat, 29 Feb 2020 12:15:25.628 +0000 (UTC)
Subject: Re: [PATCH v4 04/11] drm/bridge: synopsys: dw-hdmi: add bus format
 negociation
References: <20200206191834.6125-1-narmstrong@baylibre.com>
 <5330543.DvuYhMxLoT@jernej-laptop>
 <64b6ef10-b2e2-02f3-56dd-14dd0782a7aa@kwiboo.se>
 <2970638.5fSG56mABF@jernej-laptop>
From:   Jonas Karlman <jonas@kwiboo.se>
Message-ID: <b2941530-b97b-9fbd-66a6-2e2092babf4f@kwiboo.se>
Date:   Sat, 29 Feb 2020 12:15:26 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <2970638.5fSG56mABF@jernej-laptop>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h2OvtDerPGWwTXn9o?=
 =?us-ascii?Q?eZMikKTllCNaHlnJJDAuMwxAsitH=2FYB5vz2Vxo0?=
 =?us-ascii?Q?esRrXVuMfp5MTQOcA7O2BDPrBsYC3ch6xKsh2kn?=
 =?us-ascii?Q?XesFgcEiKPTdM9E+GbJYv604yOrGGgxWWqW44Tg?=
 =?us-ascii?Q?+A5lBUUm+PcMRCXd3l+ivxFSWP3wo2ZBceg77xa?=
 =?us-ascii?Q?BjYW3wE2cQ+dfxU22ZY+w=3D=3D?=
To:     Jernej =?iso-8859-2?q?=A9krabec?= <jernej.skrabec@siol.net>,
        a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        boris.brezillon@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=utf-8
Content-Language: sv
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-29 12:07, Jernej Škrabec wrote:
> Dne sobota, 29. februar 2020 ob 11:09:14 CET je Jonas Karlman napisal(a):
>> Hi Jernej,
>>
>> On 2020-02-29 08:42, Jernej Škrabec wrote:
>>> Hi Neil!
>>>
>>> Dne četrtek, 06. februar 2020 ob 20:18:27 CET je Neil Armstrong 
> napisal(a):
>>>> Add the atomic_get_output_bus_fmts, atomic_get_input_bus_fmts to
>>>> negociate
>>>> the possible output and input formats for the current mode and monitor,
>>>> and use the negotiated formats in a basic atomic_check callback.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 272 +++++++++++++++++++++-
>>>>  1 file changed, 268 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>>>> fec4a4bcd1fe..15048ad694bc 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> @@ -2095,11 +2095,10 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
>>>> struct drm_display_mode *mode)
>>>> hdmi->hdmi_data.video_mode.mpixelrepetitionoutput = 0;
>>>>
>>>>  	hdmi->hdmi_data.video_mode.mpixelrepetitioninput = 0;
>>>>
>>>> -	/* TOFIX: Get input format from plat data or fallback to RGB888 */
>>>>
>>>>  	if (hdmi->plat_data->input_bus_format)
>>>>  	
>>>>  		hdmi->hdmi_data.enc_in_bus_format =
>>>>  		
>>>>  			hdmi->plat_data->input_bus_format;
>>>>
>>>> -	else
>>>> +	else if (hdmi->hdmi_data.enc_in_bus_format == MEDIA_BUS_FMT_FIXED)
>>>>
>>>>  		hdmi->hdmi_data.enc_in_bus_format =
>>>
>>> MEDIA_BUS_FMT_RGB888_1X24;
>>>
>>>>  	/* TOFIX: Get input encoding from plat data or fallback to none */
>>>>
>>>> @@ -2109,8 +2108,8 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
>>>> struct
>>>> drm_display_mode *mode) else
>>>>
>>>>  		hdmi->hdmi_data.enc_in_encoding =
>>>
>>> V4L2_YCBCR_ENC_DEFAULT;
>>>
>>>> -	/* TOFIX: Default to RGB888 output format */
>>>> -	hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
>>>> +	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
>>>> +		hdmi->hdmi_data.enc_out_bus_format =
>>>
>>> MEDIA_BUS_FMT_RGB888_1X24;
>>>
>>>>  	hdmi->hdmi_data.pix_repet_factor = 0;
>>>>  	hdmi->hdmi_data.hdcp_enable = 0;
>>>>
>>>> @@ -2388,6 +2387,267 @@ static const struct drm_connector_helper_funcs
>>>> dw_hdmi_connector_helper_funcs = .atomic_check =
>>>> dw_hdmi_connector_atomic_check,
>>>>
>>>>  };
>>>>
>>>> +/*
>>>> + * Possible output formats :
>>>> + * - MEDIA_BUS_FMT_UYYVYY16_0_5X48,
>>>> + * - MEDIA_BUS_FMT_UYYVYY12_0_5X36,
>>>> + * - MEDIA_BUS_FMT_UYYVYY10_0_5X30,
>>>> + * - MEDIA_BUS_FMT_UYYVYY8_0_5X24,
>>>> + * - MEDIA_BUS_FMT_YUV16_1X48,
>>>> + * - MEDIA_BUS_FMT_RGB161616_1X48,
>>>> + * - MEDIA_BUS_FMT_UYVY12_1X24,
>>>> + * - MEDIA_BUS_FMT_YUV12_1X36,
>>>> + * - MEDIA_BUS_FMT_RGB121212_1X36,
>>>> + * - MEDIA_BUS_FMT_UYVY10_1X20,
>>>> + * - MEDIA_BUS_FMT_YUV10_1X30,
>>>> + * - MEDIA_BUS_FMT_RGB101010_1X30,
>>>> + * - MEDIA_BUS_FMT_UYVY8_1X16,
>>>> + * - MEDIA_BUS_FMT_YUV8_1X24,
>>>> + * - MEDIA_BUS_FMT_RGB888_1X24,
>>>> + */
>>>> +
>>>> +/* Can return a maximum of 12 possible output formats for a
>>>> mode/connector
>>>> */ +#define MAX_OUTPUT_SEL_FORMATS	12
>>>> +
>>>> +static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge
>>>> *bridge, +					struct
>>>
>>> drm_bridge_state *bridge_state,
>>>
>>>> +					struct drm_crtc_state
>>>
>>> *crtc_state,
>>>
>>>> +					struct
>>>
>>> drm_connector_state *conn_state,
>>>
>>>> +					unsigned int
>>>
>>> *num_output_fmts)
>>>
>>>> +{
>>>> +	struct drm_connector *conn = conn_state->connector;
>>>> +	struct drm_display_info *info = &conn->display_info;
>>>> +	struct drm_display_mode *mode = &crtc_state->mode;
>>>> +	u8 max_bpc = conn_state->max_requested_bpc;
>>>> +	bool is_hdmi2_sink = info->hdmi.scdc.supported ||
>>>> +			     (info->color_formats &
>>>
>>> DRM_COLOR_FORMAT_YCRCB420);
>>>
>>>> +	u32 *output_fmts;
>>>> +	int i = 0;
>>>> +
>>>> +	*num_output_fmts = 0;
>>>> +
>>>> +	output_fmts = kcalloc(MAX_OUTPUT_SEL_FORMATS, 
> sizeof(*output_fmts),
>>>> +			      GFP_KERNEL);
>>>> +	if (!output_fmts)
>>>> +		return NULL;
>>>> +
>>>> +	/*
>>>> +	 * If the current mode enforces 4:2:0, force the output but format
>>>> +	 * to 4:2:0 and do not add the YUV422/444/RGB formats
>>>> +	 */
>>>> +	if (conn->ycbcr_420_allowed &&
>>>> +	    (drm_mode_is_420_only(info, mode) ||
>>>> +	     ())) {
>>>> +
>>>> +		/* Order bus formats from 16bit to 8bit if supported */
>>>> +		if (max_bpc >= 16 && info->bpc == 16 &&
>>>> +		    (info->hdmi.y420_dc_modes &
>>>
>>> DRM_EDID_YCBCR420_DC_48))
>>>
>>>> +			output_fmts[i++] =
>>>
>>> MEDIA_BUS_FMT_UYYVYY16_0_5X48;
>>>
>>>> +
>>>> +		if (max_bpc >= 12 && info->bpc >= 12 &&
>>>> +		    (info->hdmi.y420_dc_modes &
>>>
>>> DRM_EDID_YCBCR420_DC_36))
>>>
>>>> +			output_fmts[i++] =
>>>
>>> MEDIA_BUS_FMT_UYYVYY12_0_5X36;
>>>
>>>> +
>>>> +		if (max_bpc >= 10 && info->bpc >= 10 &&
>>>> +		    (info->hdmi.y420_dc_modes &
>>>
>>> DRM_EDID_YCBCR420_DC_30))
>>>
>>>> +			output_fmts[i++] =
>>>
>>> MEDIA_BUS_FMT_UYYVYY10_0_5X30;
>>>
>>>> +
>>>> +		/* Default 8bit fallback */
>>>> +		output_fmts[i++] = MEDIA_BUS_FMT_UYYVYY8_0_5X24;
>>>> +
>>>> +		*num_output_fmts = i;
>>>> +
>>>> +		return output_fmts;
>>>
>>> Driver shouldn't return just yet for case "is_hdmi2_sink &&
>>> drm_mode_is_420_also(info, mode)", because monitor/TV also supports YCbCr
>>> 4:4:4 in that case. IMO YCbCr 4:4:4 should be even prefered. What do you
>>> think?
>>
>> I think we need to have some way for controller driver and userspace to
>> control what hdmi output format gets selected. I know for a fact that some
>> Samsung TV have issues with 444 YCbCr modes at 4k 50/60hz but have no
>> problems with 420 modes. The Samsung TV edid lie and/or the TV is not fully
>> following HDMI specs
> 
> Interesting, maybe just some bandwith issues? I guess we should have a 
> blacklist for such cases. I know that at least Allwinner BSP driver for DW 
> HDMI has a blacklist, in this case for 2 monitors which claim to support YCbCr 
> 4:4:4 mode but they not.
> 
>>
>> From a personal and mediaplayer userspace perspective I would like to prefer
>> 420/444 YCbCr mode as soon as any yuv drm plane is active and rgb 444
>> anytime else.
> 
> I would argue that YCbCr is always prefered:
> - CEA 861 prefers it for all CEA modes
> - avoid dealing with quantization range - it's always limited range for < hdmi 
> 2.0 and selectable on some hdmi 2.0 capable sinks

This is probably true if your sink is a TV, for monitors with HDMI connections
I would expect or at least like to have an option to use rgb444 full range mode
for any desktop or gaming or similar use-case.

> 
> Anyway, there is no universal solution to avoid color space conversion in all 
> cases. For example, due to design of Allwinner Display Engine 2, it can only 
> work in RGB format internally, but it can convert final output to YCbCr right 
> before it's feeded to DW HDMI. On the other hand, you have meson display 
> pipeline which works in YCbCr format internally and relies on DW HDMI CSC unit 
> to convert output to RGB. Fortunately, there are also display pipelines which 
> can work in any colorspace internally, like Allwinner Display Engine 3. Not 
> sure in which category Rockchip display pipeline falls into.

Agree, and for Rockchip to my knowledge RK3288 VOP (Video Output Processor)
can only output 8/10-bit rgb (full range) to DW-HDMI.
And the VOP in RK322x/RK3328/RK3399 can output 8/10-bit rgb and 444/420 yuv.
I do not know how the VOP handles internal color conversion.

> 
>>
>> On Rockchip SoCs the display controller cannot output yuv422 to dw-hdmi
>> block, the optimal output format selection in such case should put yuv422
>> last.
> 
> Note that DW HDMI has decimation support which converts 444 to 422. This is 
> part of CSC unit.

This works as it should (after a patch to disable color conversion for 444 to 422),
the issue I see is that the format negotiation code will currently favor 444 to 422
decimation over using 444 output.
Note: 422 will not be selected over 444 currently in case sink report deep color support
due to drm edid parsing code following HDMI 1.3 spec, see [1].

[1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/drm_edid.c#L4801-L4806

> 
> Side note: CSC unit is optional feature of DW-HDMI and presence is indicated 
> by config register. However, it seems that CSC support is broken in DW HDMI 
> controller on 40nm Allwinner SoCs. If it is enabled, TV loses signal. I have 
> to investigate if only CSC is broken or decimation also don't work.
> 
>>
>> Maybe dw-hdmi can call a dw-hdmi glue driver callback to get the preferred
>> output format order?
>>
>> On a side note but related issue, the dw-hdmi format negotiation code should
>> probably also filter modes on tmds rate, something like [1].
>> It is needed to filter out deep color modes that is not supported by the
>> sink or hdmi spec.
> 
> Ah, you mean on TMDS rates supported by the sink. Could this avoid Samsung 
> deep color issues? If so, we don't need blacklist then.

I do not think so, the initial issue was reported with intel graphics but looking
at the edid and comparing to the manual of supported modes they do not fully match.
See manual info at [2] and edid when UHD mode is off at [3] and when on at [4].

[2] https://gitlab.freedesktop.org/drm/intel/uploads/36630c8a727bf8c66a53fd7470c88383/MU7000_manual_-_UHD_colour_modes.PNG
[3] http://ix.io/1H25
[4] http://ix.io/1H2e

> 
> Best regards,
> Jernej
> 
>>
>> [1]
>> https://github.com/Kwiboo/linux-rockchip/commit/fc3df6903384e764ab6ac59879c
>> 489cbef55fcbe
>>
>> Best regards,
>> Jonas
>>
>>> Best regards,
>>> Jernej
>>>
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Order bus formats from 16bit to 8bit and from YUV422 to RGB
>>>> +	 * if supported. In any case the default RGB888 format is added
>>>> +	 */
>>>> +
>>>> +	if (max_bpc >= 16 && info->bpc == 16) {
>>>> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
>>>> +			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
>>>> +
>>>> +		output_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
>>>> +	}
>>>> +
>>>> +	if (max_bpc >= 12 && info->bpc >= 12) {
>>>> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
>>>> +			output_fmts[i++] = 
> MEDIA_BUS_FMT_UYVY12_1X24;
>>>> +
>>>> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
>>>> +			output_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>>>> +
>>>> +		output_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>>>> +	}
>>>> +
>>>> +	if (max_bpc >= 10 && info->bpc >= 10) {
>>>> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
>>>> +			output_fmts[i++] = 
> MEDIA_BUS_FMT_UYVY10_1X20;
>>>> +
>>>> +		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
>>>> +			output_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>>>> +
>>>> +		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>>>> +	}
>>>> +
>>>> +	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
>>>> +		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>>>> +
>>>> +	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
>>>> +		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>>>> +
>>>> +	/* Default 8bit RGB fallback */
>>>> +	output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>>>> +
>>>> +	*num_output_fmts = i;
>>>> +
>>>> +	return output_fmts;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Possible input formats :
>>>> + * - MEDIA_BUS_FMT_RGB888_1X24
>>>> + * - MEDIA_BUS_FMT_YUV8_1X24
>>>> + * - MEDIA_BUS_FMT_UYVY8_1X16
>>>> + * - MEDIA_BUS_FMT_UYYVYY8_0_5X24
>>>> + * - MEDIA_BUS_FMT_RGB101010_1X30
>>>> + * - MEDIA_BUS_FMT_YUV10_1X30
>>>> + * - MEDIA_BUS_FMT_UYVY10_1X20
>>>> + * - MEDIA_BUS_FMT_UYYVYY10_0_5X30
>>>> + * - MEDIA_BUS_FMT_RGB121212_1X36
>>>> + * - MEDIA_BUS_FMT_YUV12_1X36
>>>> + * - MEDIA_BUS_FMT_UYVY12_1X24
>>>> + * - MEDIA_BUS_FMT_UYYVYY12_0_5X36
>>>> + * - MEDIA_BUS_FMT_RGB161616_1X48
>>>> + * - MEDIA_BUS_FMT_YUV16_1X48
>>>> + * - MEDIA_BUS_FMT_UYYVYY16_0_5X48
>>>> + */
>>>> +
>>>> +/* Can return a maximum of 4 possible input formats for an output format
>>>> */ +#define MAX_INPUT_SEL_FORMATS	4
>>>> +
>>>> +static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge
>>>> *bridge, +					struct
>>>
>>> drm_bridge_state *bridge_state,
>>>
>>>> +					struct drm_crtc_state
>>>
>>> *crtc_state,
>>>
>>>> +					struct
>>>
>>> drm_connector_state *conn_state,
>>>
>>>> +					u32 output_fmt,
>>>> +					unsigned int
>>>
>>> *num_input_fmts)
>>>
>>>> +{
>>>> +	u32 *input_fmts;
>>>> +	int i = 0;
>>>> +
>>>> +	*num_input_fmts = 0;
>>>> +
>>>> +	input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
>>>> +			     GFP_KERNEL);
>>>> +	if (!input_fmts)
>>>> +		return NULL;
>>>> +
>>>> +	switch (output_fmt) {
>>>> +	/* 8bit */
>>>> +	case MEDIA_BUS_FMT_RGB888_1X24:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_YUV8_1X24:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_UYVY8_1X16:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
>>>> +		break;
>>>> +
>>>> +	/* 10bit */
>>>> +	case MEDIA_BUS_FMT_RGB101010_1X30:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_YUV10_1X30:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_UYVY10_1X20:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>>>> +		break;
>>>> +
>>>> +	/* 12bit */
>>>> +	case MEDIA_BUS_FMT_RGB121212_1X36:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_YUV12_1X36:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_UYVY12_1X24:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
>>>> +		break;
>>>> +
>>>> +	/* 16bit */
>>>> +	case MEDIA_BUS_FMT_RGB161616_1X48:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
>>>> +		break;
>>>> +	case MEDIA_BUS_FMT_YUV16_1X48:
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
>>>> +		input_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
>>>> +		break;
>>>> +
>>>> +	/* 420 */
>>>> +	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
>>>> +	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
>>>> +	case MEDIA_BUS_FMT_UYYVYY12_0_5X36:
>>>> +	case MEDIA_BUS_FMT_UYYVYY16_0_5X48:
>>>> +		input_fmts[i++] = output_fmt;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	*num_input_fmts = i;
>>>> +
>>>> +	if (*num_input_fmts == 0) {
>>>> +		kfree(input_fmts);
>>>> +		input_fmts = NULL;
>>>> +	}
>>>> +
>>>> +	return input_fmts;
>>>> +}
>>>> +
>>>> +static int dw_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
>>>> +				       struct drm_bridge_state
>>>
>>> *bridge_state,
>>>
>>>> +				       struct drm_crtc_state
>>>
>>> *crtc_state,
>>>
>>>> +				       struct drm_connector_state
>>>
>>> *conn_state)
>>>
>>>> +{
>>>> +	struct dw_hdmi *hdmi = bridge->driver_private;
>>>> +
>>>> +	dev_dbg(hdmi->dev, "selected output format %x\n",
>>>> +			bridge_state->output_bus_cfg.format);
>>>> +
>>>> +	hdmi->hdmi_data.enc_out_bus_format =
>>>> +			bridge_state->output_bus_cfg.format;
>>>> +
>>>> +	dev_dbg(hdmi->dev, "selected input format %x\n",
>>>> +			bridge_state->input_bus_cfg.format);
>>>> +
>>>> +	hdmi->hdmi_data.enc_in_bus_format =
>>>> +			bridge_state->input_bus_cfg.format;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>
>>>>  static int dw_hdmi_bridge_attach(struct drm_bridge *bridge)
>>>>  {
>>>>  
>>>>  	struct dw_hdmi *hdmi = bridge->driver_private;
>>>>
>>>> @@ -2499,6 +2759,9 @@ static const struct drm_bridge_funcs
>>>> dw_hdmi_bridge_funcs = { .atomic_reset = drm_atomic_helper_bridge_reset,
>>>>
>>>>  	.attach = dw_hdmi_bridge_attach,
>>>>  	.detach = dw_hdmi_bridge_detach,
>>>>
>>>> +	.atomic_check = dw_hdmi_bridge_atomic_check,
>>>> +	.atomic_get_output_bus_fmts =
>>>
>>> dw_hdmi_bridge_atomic_get_output_bus_fmts,
>>>
>>>> +	.atomic_get_input_bus_fmts =
>>>
>>> dw_hdmi_bridge_atomic_get_input_bus_fmts,
>>>
>>>>  	.enable = dw_hdmi_bridge_enable,
>>>>  	.disable = dw_hdmi_bridge_disable,
>>>>  	.mode_set = dw_hdmi_bridge_mode_set,
>>>>
>>>> @@ -2963,6 +3226,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>>>
>>>>  	hdmi->bridge.driver_private = hdmi;
>>>>  	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
>>>>
>>>> +
>>>>
>>>>  #ifdef CONFIG_OF
>>>>  
>>>>  	hdmi->bridge.of_node = pdev->dev.of_node;
>>>>  
>>>>  #endif
> 
> 
> 
> 
