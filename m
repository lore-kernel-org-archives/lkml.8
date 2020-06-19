Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE4EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7957D208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lInlFCWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436732AbgFSSsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbgFSSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:48:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE87C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:48:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o26so8424808edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOd3iDo4hXVaLfjpQrGwcl6MAJNhNeqkCD1fMNBby3U=;
        b=lInlFCWIMVObtFCHv6pzn/EH5aaUXGaPfGr570PNHDFBIPGAsPRdEsHYjTGw13Y+kd
         zHmSI0W5Ub6UqpV4hXhqixQj+vURTXsACq9qhcfZNLnCzYIsx4KIVZaSTK/XBVvg9/lj
         TY3S+XOCrqCCqYReMGLYatqourz/hgNA4x4Xlouml5NQQirelMDS+8PeJ/ZQwysMUCx9
         raQZvoJYbr5g5w4qoN93W1g0BHlnBYB5yUbW/W/h5K7PG4TbGwToGXZLSPCPbqh+y6fc
         BCSYyZebqQCFDLhLnebzFo2GXSFIoNzFLtcygnf+6sunwCBxF87PExEhn7TxnjE+2+Yj
         jLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOd3iDo4hXVaLfjpQrGwcl6MAJNhNeqkCD1fMNBby3U=;
        b=bjAwhWc62fZwjUgPdgUCdSHJNhFAkYSOCvBS8PArltBNc6RU1ay72NwSNwQvFYpxZG
         /2xbuIqz2mt/i1wo57okzyWE8GHa4e1EVOC+0sbf+mja1aiN01sUfLdr4hSVIaVueTmQ
         oe+Bh/+J3jroeC1uuSSmVFlQAfCnIkjssA+j+HPErxYGPWBdsLW9M/RQBrJGaPuwojXG
         VZ3JZ4TmSFycH/r8h8l+fcnKmUFg8wrCwSDUswt6hwWTFruwStetYFosbtjA2Ny7mKSE
         DAA9qbM6ktC0p06EaziNAT86IVE6D9GjwnACmylJXJHp+/YL7niN2S30wu6b2MsuJngY
         Cxxw==
X-Gm-Message-State: AOAM531ZREhmOmCw0pQXDUVoUV8RCVaTdsUj85rQLO7Rp8K1ac36BFfc
        yMRWWUM/lawRZB/COXg4KMUl5ZTeVmgzIA==
X-Google-Smtp-Source: ABdhPJyoIxk48Q78OCvbNvVuMlBsBPJUVVW7g4Vdu4A/hpfd3vYLsm853ZyxHzZZreLQguiG2GP9jw==
X-Received: by 2002:aa7:da4f:: with SMTP id w15mr4575250eds.384.1592592527294;
        Fri, 19 Jun 2020 11:48:47 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-140.ip.btc-net.bg. [212.5.158.140])
        by smtp.googlemail.com with ESMTPSA id v5sm5342431eje.88.2020.06.19.11.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:48:46 -0700 (PDT)
Subject: Re: [PATCH 3/4] v4l2-ctrl: Add control for intra only decode
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20200616123001.11321-1-stanimir.varbanov@linaro.org>
 <20200616123001.11321-4-stanimir.varbanov@linaro.org>
 <a0ee566a587c28ffce97224abfa901520af5c83f.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6bb450e5-b959-6d9c-a794-5727818ff6ba@linaro.org>
Date:   Fri, 19 Jun 2020 21:48:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a0ee566a587c28ffce97224abfa901520af5c83f.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/20 3:39 PM, Nicolas Dufresne wrote:
> Le mardi 16 juin 2020 à 15:30 +0300, Stanimir Varbanov a écrit :
>> This adds a new decoder control to instruct the decoders to
>> produce on its output intra frames only. Usually in this mode
>> decoders might lower the count of output decoder buffers and
>> hence reduce memory usage.
> 
> Perhaps I missed some discussion, would be nice if you could remind the
> rationale from going away from a SKIP_MODE menu to adding dedicated boolean
> control for each mode.

Because I quickly realized that such generalization is impossible. If it
was per codec it would much easier, but for all possible codecs it is not.

The best I found is that in ffmpeg:

enum AVDiscard{
    /* We leave some space between them for extensions (drop some
     * keyframes for intra-only or drop just some bidir frames). */
    AVDISCARD_NONE    =-16, ///< discard nothing
    AVDISCARD_DEFAULT =  0, ///< discard useless packets like 0 size
packets in avi
    AVDISCARD_NONREF  =  8, ///< discard all non reference
    AVDISCARD_BIDIR   = 16, ///< discard all bidirectional frames
    AVDISCARD_NONINTRA= 24, ///< discard all non intra frames
    AVDISCARD_NONKEY  = 32, ///< discard all frames except keyframes
    AVDISCARD_ALL     = 48, ///< discard all
};

> 
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls.c                     | 2 ++
>>  include/uapi/linux/v4l2-controls.h                       | 1 +
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index b9d3f7ae6486..d7f34596f95b 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -652,6 +652,15 @@ enum v4l2_mpeg_video_bitrate_mode -
>>      otherwise the decoder expects a single frame in per buffer.
>>      Applicable to the decoder, all codecs.
>>  
>> +``V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY (boolean)``
>> +    If enabled the decoder should start decoding only intra frames. The
>> +    decoder consume first input buffer for progressive stream (or first
>> +    two buffers for interlace). Decoder might not allocate more output
>> +    buffers than it is required to consume one input frame. Usually the
>> +    decoder input buffers will contain only intra frames but it is not
>> +    mandatory. This control could be used for thumbnails generation.
>> +    Applicable to the decoder, all codecs.
> 
> This imply that number of allocated buffers might be smaller (no references
> buffer are needed), but I think it should actually be more explicit that this
> must be set prior to reading MIN_BUFFER* and/or allocating buffers (since it's
> userspace that allocates buffers).

That is a good point. Will add this information in the description.

> 
> What if a HW support live switching of this mode on key frames ? And if so, how
> do we configure and control that ?

I haven't thought about such live switching. Probably in this case it
will be better to not release buffers and just continue, but in that
case we will lost the benefit of lower memory usage. In Venus case I
guess I will return EBUSY.

> 
>> +
>>  ``V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE (boolean)``
>>      Enable writing sample aspect ratio in the Video Usability
>>      Information. Applicable to the H264 encoder.
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-
>> core/v4l2-ctrls.c
>> index bc00d02e411f..2b1fb8dcd360 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
>> @@ -846,6 +846,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264
>> MB Level Rate Control";
>>  	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:			return
>> "Sequence Header Mode";
>>  	case V4L2_CID_MPEG_VIDEO_MAX_REF_PIC:			return "Max
>> Number of Reference Pics";
>> +	case V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY:	return "Decode
>> intra frames only";
>>  	case V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP:		return "H263 I-Frame
>> QP Value";
>>  	case V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP:		return "H263 P-Frame
>> QP Value";
>>  	case V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP:		return "H263 B-Frame
>> QP Value";
>> @@ -1197,6 +1198,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum
>> v4l2_ctrl_type *type,
>>  	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
>>  	case V4L2_CID_MPEG_VIDEO_MPEG4_QPEL:
>>  	case V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER:
>> +	case V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY:
>>  	case V4L2_CID_WIDE_DYNAMIC_RANGE:
>>  	case V4L2_CID_IMAGE_STABILIZATION:
>>  	case V4L2_CID_RDS_RECEPTION:
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-
>> controls.h
>> index 0f7e4388dcce..c64471e64aa7 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -744,6 +744,7 @@ enum v4l2_cid_mpeg_video_hevc_size_of_length_field {
>>  #define V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES	(V4L2_CID_MPEG_BASE +
>> 643)
>>  #define V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR	(V4L2_CID_MPEG_BASE +
>> 644)
>>  #define V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY		(V4L2_CID_MPEG_BASE +
>> 645)
>> +#define V4L2_CID_MPEG_VIDEO_DECODE_INTRA_FRAMES_ONLY	(V4L2_CID_MPEG_BASE +
>> 646)
>>  
>>  /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2
>> */
>>  #define V4L2_CID_MPEG_CX2341X_BASE				(V4L2_CTRL_CLASS
>> _MPEG | 0x1000)
> 

-- 
regards,
Stan
