Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BA4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DE0207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="X+1RmTnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgHZPE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgHZPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:04:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1443AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:04:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cs12so846525qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nezFMoomRGnamLm6VDJCRAwVaIOSEqEXaCBNZ1rac9E=;
        b=X+1RmTnruIVUnUU7CVCtK6V5nDNsGTm6qcgHknRv+PULUg1C02zGlVGI0ggRhYysvh
         GyYKivjfBMG/hYHwWrYI7OYXz2bQwPTqsjADjw942pdsM/ItA9Xwp33xAdR+FqAtIjiT
         dgkBQtGr44e6HNrVZvjXFxrnoL9bg5sS/zmyjOEXKypGH/NlTrUZb2LBM9WTrxP6sIka
         FLW5TFz7bjLi/Ne24EFau+q5BkfD7cmu8K7lRWUdJ61wazcf2A0aIDCAPq3/pSaALAAg
         RGLPBBwQYfU9ffsN3spnzi3cwzJd1Cb2kFjDXDEAp5UEPKpKhvubY9CISDXmmndrj1Ot
         C8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nezFMoomRGnamLm6VDJCRAwVaIOSEqEXaCBNZ1rac9E=;
        b=evniGpbcKmZ+/BHWlVyIPUYClukNN5lWTSqk2xMti3xYzzBWCy8l/7lLIHPvFiPU35
         Ic3UHOe+iLkbR7yI5i8x39Yc/ZO6+pJhHii7nY+0KC1zxvFmyNCQmZvXBXT7h1OMy3Xy
         56IftnNZHytv54ZjKj44qLAONNe/SLecvFD6V2HtKT3TJbptrxqa6UUllFsW/jKXxyc7
         T1P30Yw6OUCZ4j9dr6jabuZlfCNBPJGmeWPm8fJ0E2L8O0YNB2NQWohSHBGYFvjMqWgQ
         F1ZZKPvgn1kUrow25/Voii6h4+M1oTJyPvLlmQDFrce7/A5FiDRTpLOP7y8RHbChQn9/
         TAMA==
X-Gm-Message-State: AOAM533KoVGKVAMS51ZiTLI2LSv0FU59FpMa2Hw4bKZiG2ajsOn6EfFR
        gBQDLGwWtf/NOd3+tR43bKHcXA==
X-Google-Smtp-Source: ABdhPJwihJG5a50pGlMuhkm9VKTiGPEN9v+nBLi9u5Ou0tub8ralCIBPCVXcqiQ9WS2mAQZ1eUADlA==
X-Received: by 2002:ad4:478c:: with SMTP id z12mr14679256qvy.145.1598454289427;
        Wed, 26 Aug 2020 08:04:49 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id a8sm2184730qth.69.2020.08.26.08.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:04:48 -0700 (PDT)
Message-ID: <1a2cfa9063b814e1001c2a8eb47a731529ffd33d.camel@ndufresne.ca>
Subject: Re: [PATCH v2] v4l2-ctrl: Add VP9 codec levels
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Wed, 26 Aug 2020 11:04:47 -0400
In-Reply-To: <20200817085852.20415-1-stanimir.varbanov@linaro.org>
References: <20200817085852.20415-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 17 août 2020 à 11:58 +0300, Stanimir Varbanov a écrit :
> Add menu control for VP9 codec levels. A total of 14 levels are
> defined for Profile 0 (8bit) and Profile 2 (10bit). Each level
> is a set of constrained bitstreams coded with targeted resolutions,
> frame rates, and bitrates.
> 
> The definitions have been taken from webm project [1].
> 
> [1] https://www.webmproject.org/vp9/levels/
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

This patch looks fine to me. Will you post a patch for Venus to ensure
this get introduced with an actual user ? I've CCed Neil as Amlogic
codec do have VP9 support which may benefit of implementing this.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> v2: Added links to webmproject in commit message and docs.
> 
>  .../media/v4l/ext-ctrls-codec.rst             | 43 +++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-ctrls.c          | 21 +++++++++
>  include/uapi/linux/v4l2-controls.h            | 17 ++++++++
>  3 files changed, 81 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index d0d506a444b1..23a45172404a 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3316,6 +3316,49 @@ enum v4l2_mpeg_video_vp9_profile -
>      * - ``V4L2_MPEG_VIDEO_VP9_PROFILE_3``
>        - Profile 3
>  
> +.. _v4l2-mpeg-video-vp9-level:
> +
> +``V4L2_CID_MPEG_VIDEO_VP9_LEVEL (enum)``
> +
> +enum v4l2_mpeg_video_vp9_level -
> +    This control allows selecting the level for VP9 encoder.
> +    This is also used to enumerate supported levels by VP9 encoder or decoder.
> +    More information can be found at
> +    `webmproject <https://www.webmproject.org/vp9/levels/>`__. Possible values are:
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_1_0``
> +      - Level 1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_1_1``
> +      - Level 1.1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_2_0``
> +      - Level 2
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_2_1``
> +      - Level 2.1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_3_0``
> +      - Level 3
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_3_1``
> +      - Level 3.1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_4_0``
> +      - Level 4
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_4_1``
> +      - Level 4.1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_5_0``
> +      - Level 5
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_5_1``
> +      - Level 5.1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_5_2``
> +      - Level 5.2
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_0``
> +      - Level 6
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_1``
> +      - Level 6.1
> +    * - ``V4L2_MPEG_VIDEO_VP9_LEVEL_6_2``
> +      - Level 6.2
> +
>  
>  High Efficiency Video Coding (HEVC/H.265) Control Reference
>  ===========================================================
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index 3f3fbcd60cc6..359dc737053d 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -474,6 +474,23 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		"3",
>  		NULL,
>  	};
> +	static const char * const vp9_level[] = {
> +		"1",
> +		"1.1",
> +		"2",
> +		"2.1",
> +		"3",
> +		"3.1",
> +		"4",
> +		"4.1",
> +		"5",
> +		"5.1",
> +		"5.2",
> +		"6",
> +		"6.1",
> +		"6.2",
> +		NULL,
> +	};
>  
>  	static const char * const flash_led_mode[] = {
>  		"Off",
> @@ -685,6 +702,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
>  		return vp8_profile;
>  	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
>  		return vp9_profile;
> +	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
> +		return vp9_level;
>  	case V4L2_CID_JPEG_CHROMA_SUBSAMPLING:
>  		return jpeg_chroma_subsampling;
>  	case V4L2_CID_DV_TX_MODE:
> @@ -938,6 +957,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>  	case V4L2_CID_MPEG_VIDEO_VPX_P_FRAME_QP:		return "VPX P-Frame QP Value";
>  	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:			return "VP8 Profile";
>  	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:			return "VP9 Profile";
> +	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:			return "VP9 Level";
>  	case V4L2_CID_MPEG_VIDEO_VP8_FRAME_HEADER:		return "VP8 Frame Header";
>  
>  	/* HEVC controls */
> @@ -1294,6 +1314,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>  	case V4L2_CID_MPEG_VIDEO_VPX_GOLDEN_FRAME_SEL:
>  	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:
>  	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:
> +	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:
>  	case V4L2_CID_DETECT_MD_MODE:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
>  	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
> index 62271418c1be..1b0bc79c1bc3 100644
> --- a/include/uapi/linux/v4l2-controls.h
> +++ b/include/uapi/linux/v4l2-controls.h
> @@ -650,6 +650,23 @@ enum v4l2_mpeg_video_vp9_profile {
>  	V4L2_MPEG_VIDEO_VP9_PROFILE_2				= 2,
>  	V4L2_MPEG_VIDEO_VP9_PROFILE_3				= 3,
>  };
> +#define V4L2_CID_MPEG_VIDEO_VP9_LEVEL			(V4L2_CID_MPEG_BASE+513)
> +enum v4l2_mpeg_video_vp9_level {
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_1_0	= 0,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_1_1	= 1,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_2_0	= 2,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_2_1	= 3,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_3_0	= 4,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_3_1	= 5,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_4_0	= 6,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_4_1	= 7,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_5_0	= 8,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_5_1	= 9,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_5_2	= 10,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_6_0	= 11,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_6_1	= 12,
> +	V4L2_MPEG_VIDEO_VP9_LEVEL_6_2	= 13,
> +};
>  
>  /* CIDs for HEVC encoding. */
>  

