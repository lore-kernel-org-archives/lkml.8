Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC25CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92807206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HadJutmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFDMek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFDMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:34:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD4C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:34:39 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so2137082ejn.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nh6Fxl/rFWFjZ0mh1YLfpCBKN2BRCz1msmd0XlPhSPc=;
        b=HadJutmZrq87AfUahea24rwNBQV91QqGmVI4d13K1j39KvnX14bCZbUQspEMwpk+34
         +HMtPcc4DGkVylGQKtf3m9pU3P30qqLaCFAdM30VzuPBK5bb3QMlCiH/E1wHZqOTHOSF
         HoQdWaOpwNULI43+0fEySHjmGUn4j2zwla0u2VQGm/Aa/T7exLvDm1KKDPB2YEcPYo7U
         oZVXnCsyZBaFY2bwrquFVNHCWQ+69gPgurk6UO2nIpGjwB7IHavGHPO/G/IjvoNXeLJw
         P/XNNMLF74/w93fKg5QEMxfdd82ll8Hj/y9z+ju1LqmYzWj5RzhWUZsiSoCOEj2l8ZqN
         6lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nh6Fxl/rFWFjZ0mh1YLfpCBKN2BRCz1msmd0XlPhSPc=;
        b=gUwRfAu/VSXFt56yyWvfxzVCkLNes85/wsPXLtVBiPWk1wUYuejj0P/HX1zrHnBLfD
         BkkhSdNfoCzyeWLDX2Oy6qdXLSmC91qdoIBf7stkYF0GK/rOoEShR/q5PvnfKFycGPwE
         gGTJQtsCe2v13IQwYSU1py6zwdfxw3QlPnobSbHUnt6DnNcefHwTXP/g/0MBLG2+POGe
         QxEpdGsq19yn+6EuIltYAOHMN5b9oS0kohfLbWexKfEbQC4ho+S5CXLmRUgkZdEk5tnn
         5+w+jVHcLBGa1YPJSXdA0uSr7cC/2B8cdMpERzH8XzBxBsne1pVy2peGCRRnOWrnE0Mm
         tYmg==
X-Gm-Message-State: AOAM5323Rn43R/tV16TthfaiSZcPtZTl8NP7UfkigZfHPebHtSfK/tVX
        XN7q/EE7k40qYgBJUOdjfBEbYw==
X-Google-Smtp-Source: ABdhPJxjsRjcO77z+ZojCCiCgjuXwanDqsaKHDha7hYUwP8L6t6HmL0IsNT5xhe6gbVE0yPUV4zJrQ==
X-Received: by 2002:a17:906:f0c3:: with SMTP id dk3mr3576057ejb.202.1591274077853;
        Thu, 04 Jun 2020 05:34:37 -0700 (PDT)
Received: from [192.168.1.4] (212-5-158-209.ip.btc-net.bg. [212.5.158.209])
        by smtp.googlemail.com with ESMTPSA id r6sm1504624edq.44.2020.06.04.05.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 05:34:37 -0700 (PDT)
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
 <ce28a840-a763-6700-16dd-d708e570d55c@linaro.org>
 <d02c6cd0-a502-dc52-519e-54b6328d5373@linaro.org>
 <544b19dd-4883-bae0-b488-46c856eb207d@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6f71931a-9060-a399-835c-a1cf1f05dc79@linaro.org>
Date:   Thu, 4 Jun 2020 15:34:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <544b19dd-4883-bae0-b488-46c856eb207d@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 6/4/20 12:08 PM, Hans Verkuil wrote:
> On 04/06/2020 11:02, Stanimir Varbanov wrote:
>> Hi Hans,
>>
>> On 5/27/20 12:53 AM, Stanimir Varbanov wrote:
>>> Hi Hans,
>>>
>>> On 5/26/20 3:04 PM, Hans Verkuil wrote:
>>>> On 26/05/2020 10:54, Stanimir Varbanov wrote:
>>>>> Add v4l2 control for decoder thumbnail.
>>>>>
>>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>>> ---
>>>>>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 7 +++++++
>>>>>  drivers/media/v4l2-core/v4l2-ctrls.c                      | 2 ++
>>>>>  include/uapi/linux/v4l2-controls.h                        | 2 ++
>>>>>  3 files changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> index d0d506a444b1..e838e410651b 100644
>>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> @@ -3726,6 +3726,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>>      disables generating SPS and PPS at every IDR. Setting it to one enables
>>>>>      generating SPS and PPS at every IDR.
>>>>>  
>>>>> +``V4L2_CID_MPEG_VIDEO_DECODER_THUMBNAIL (button)``
>>>>> +    Instructs the decoder to produce immediate output. The decoder should
>>>>> +    consume first input buffer for progressive stream (or first two buffers
>>>>> +    for interlace). Decoder should not allocate more output buffers that it
>>>>> +    is required to consume one input frame. Usually the decoder input
>>>>> +    buffers will contain only I/IDR frames but it is not mandatory.
>>>>
>>>> This is very vague. It doesn't explain why the control is called 'THUMBNAIL',
>>>> but more importantly it doesn't explain how this relates to normal decoding.
>>>
>>> If in the normal decode the capture queue buffers are 5, in the
>>> thumbnail mode the number of buffers will be only 1 (if the bitstream is
>>> progressive) and this will guarantee low memory usage. The other
>>> difference is that the decoder will produce decoded frames (without
>>> errors) only for I/IDR (sync frames).
> 
> Isn't this really a "DECODE_SYNC_FRAMES_ONLY" control? That's what it does,
> right? Skip any B/P frames and only decode sync frames.

Yes, it is.
To me V4L2_CID_MPEG_VIDEO_DECODE_SYNC_FRAMES sounds better. If you are
fine I can send a new patch.

The definition of "sync frames" is a bit difficult for codec-agnostic
controls. Is it sound better "INTRA", DECODE_INTRA_FRAMES (ONLY)?

> 
> That this is useful for creating thumbnails is just a specific use-case.
> 
> Regards,
> 
> 	Hans
> 
>>>
>>>>
>>>> I.e. if you are decoding and 'press' this control, what happens then?
>>>
>>> Might be the button type wasn't great idea. In fact the control should
>>> be set before streamon so that the driver returns min_capture_bufs 1.
>>>
>>>>
>>>> What exactly is the use-case?
>>>
>>> It could be used to generate thumbnails of all video clips in a folder
>>> or when you open a Gallery application on your phone.
>>>
>>
>> What is your opinion on that control? I could consider to make it Venus
>> custom control but from the use-case it looks other drivers also can
>> benefit of it.
>>
>> I tried to make more generic one [1] but it looks it will be too difficult.
>>
> 

-- 
regards,
Stan
