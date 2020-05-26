Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A554C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2670120707
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vebJv3oP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbgEZVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389096AbgEZVxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:53:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E078C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:53:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so1139097wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DtoiVIeHWERaSBEx78ia06b9zdq9g6cht2Ue69Q2Jik=;
        b=vebJv3oP2lnh/sFEpz8fOASD5UbPYep6VTqCHBS+JHprGL0YBJZxGAcPm4k7J62QE4
         p/M/2/mPnBpg/wsAkf9VHafckjeksiFC+8Q48XtKW13lFDI2aPka+bIgITPJX770f7uO
         1p1QqcK0D98ytVH6wHmEf2G5EYXB2+qu13e75MGXCuHQbiGdv7CNeHEZDeSRwFfPaVcZ
         VQg5yPNeqeadUR05lUYtYZ3kqOTDWsg2e+JQnnA7oXEbdF+fNWcXckAoPUmWfd2iNBSR
         b69Ic6rUqc6vd0Lc9ZA0hpWP8cQ8L0n/C1AOt99gjyMsoyUEUesEhDryb8kXBL6YQJ8Y
         4CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DtoiVIeHWERaSBEx78ia06b9zdq9g6cht2Ue69Q2Jik=;
        b=XiuYVcWKCda5IM4Wjk3C2FlApQDoq1ALMp8DRbYS9ecf7ZF1fKG9ue1ENYIxWKZulK
         7VpIBj0jDlWclQtd3ihYkULYLQoWKHCWATutJD6APPpdCFCWZz03nchb76UnXdcH61Zi
         oo+ql//ZkooTO/oidZ86jI2kHZO7i2TC2sYhxrxHgEZPwdA8DJAbvstuJD3dtn8uffQm
         YGK8fCGxGvFLHSvgoINY0M7/ZVjc6P+ZeXesJBYeNGVoSGC1e1StrOHFX0a/oYRH3gLx
         3LlBfAUEOZyqcrlhPv66TwRAQ0bP69iKNIjNpGZLtbxS0FBGwXRTBqZEQNPzIxhIxVaH
         CIqw==
X-Gm-Message-State: AOAM530mPDK9b5oqxIFoklwVN+ZYFAu7eI0hljA/Ek7F4pjFmm3ehHp+
        9liW39JGOeeXtfhG++qH3xpcmM8IEjk=
X-Google-Smtp-Source: ABdhPJztCSiQx52Bn3irhLyDl9tQ7W4IQbKMQ5dRf5diXRXZnGzoFQgLhALLR8gbkLwfMPc+sdzTug==
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr1141071wmn.36.1590529987975;
        Tue, 26 May 2020 14:53:07 -0700 (PDT)
Received: from [192.168.1.9] (hst-221-24.medicom.bg. [84.238.221.24])
        by smtp.googlemail.com with ESMTPSA id l5sm719844wml.27.2020.05.26.14.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 14:53:07 -0700 (PDT)
Subject: Re: [PATCH] v4l2-ctrl: add control for thumnails
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Tomasz Figa <tfiga@chromium.org>
References: <20200526085446.30956-1-stanimir.varbanov@linaro.org>
 <65ac9697-a43f-7025-e6fe-69c4a44c6d9a@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ce28a840-a763-6700-16dd-d708e570d55c@linaro.org>
Date:   Wed, 27 May 2020 00:53:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <65ac9697-a43f-7025-e6fe-69c4a44c6d9a@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 5/26/20 3:04 PM, Hans Verkuil wrote:
> On 26/05/2020 10:54, Stanimir Varbanov wrote:
>> Add v4l2 control for decoder thumbnail.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 7 +++++++
>>  drivers/media/v4l2-core/v4l2-ctrls.c                      | 2 ++
>>  include/uapi/linux/v4l2-controls.h                        | 2 ++
>>  3 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index d0d506a444b1..e838e410651b 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -3726,6 +3726,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>      disables generating SPS and PPS at every IDR. Setting it to one enables
>>      generating SPS and PPS at every IDR.
>>  
>> +``V4L2_CID_MPEG_VIDEO_DECODER_THUMBNAIL (button)``
>> +    Instructs the decoder to produce immediate output. The decoder should
>> +    consume first input buffer for progressive stream (or first two buffers
>> +    for interlace). Decoder should not allocate more output buffers that it
>> +    is required to consume one input frame. Usually the decoder input
>> +    buffers will contain only I/IDR frames but it is not mandatory.
> 
> This is very vague. It doesn't explain why the control is called 'THUMBNAIL',
> but more importantly it doesn't explain how this relates to normal decoding.

If in the normal decode the capture queue buffers are 5, in the
thumbnail mode the number of buffers will be only 1 (if the bitstream is
progressive) and this will guarantee low memory usage. The other
difference is that the decoder will produce decoded frames (without
errors) only for I/IDR (sync frames).

> 
> I.e. if you are decoding and 'press' this control, what happens then?

Might be the button type wasn't great idea. In fact the control should
be set before streamon so that the driver returns min_capture_bufs 1.

> 
> What exactly is the use-case?

It could be used to generate thumbnails of all video clips in a folder
or when you open a Gallery application on your phone.

> 
> Regards,
> 
> 	Hans
> 
>> +
>>  .. _v4l2-mpeg-hevc:
>>  
>>  ``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
>> index b188577db40f..cb2554404c63 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
>> @@ -991,6 +991,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:		return "HEVC Slice Parameters";
>>  	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
>>  	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:		return "HEVC Start Code";
>> +	case V4L2_CID_MPEG_VIDEO_DECODER_THUMBNAIL:		return "Thumbnail generation";
>>  
>>  	/* CAMERA controls */
>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
>> @@ -1234,6 +1235,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>  	case V4L2_CID_AUTO_FOCUS_START:
>>  	case V4L2_CID_AUTO_FOCUS_STOP:
>>  	case V4L2_CID_DO_WHITE_BALANCE:
>> +	case V4L2_CID_MPEG_VIDEO_DECODER_THUMBNAIL:
>>  		*type = V4L2_CTRL_TYPE_BUTTON;
>>  		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY |
>>  			  V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 62271418c1be..7e44a2779863 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -743,6 +743,8 @@ enum v4l2_cid_mpeg_video_hevc_size_of_length_field {
>>  #define V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES	(V4L2_CID_MPEG_BASE + 643)
>>  #define V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR	(V4L2_CID_MPEG_BASE + 644)
>>  
>> +#define V4L2_CID_MPEG_VIDEO_DECODER_THUMBNAIL		(V4L2_CID_MPEG_BASE + 645)
>> +
>>  /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
>>  #define V4L2_CID_MPEG_CX2341X_BASE				(V4L2_CTRL_CLASS_MPEG | 0x1000)
>>  #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_MPEG_CX2341X_BASE+0)
>>
> 

-- 
regards,
Stan
