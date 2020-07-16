Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E929C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A78206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T35eyFNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGPKuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgGPKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:50:14 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F9C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 03:50:13 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n22so3142846ejy.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Px6j0xeOYkPjHURcyI2MVrHh5xdpIzdarGduqmRZnc=;
        b=T35eyFNB1arzCVcg48FlkWIK/EYz/6agiVn+A1QezpzpbtETnIogDHR7nwleQfaTj8
         CTyVXJ7KNPc1R3pnb7//3tRYkfmi9JlFgYT48havDrV86+KC01p63DH85zGDloyTfHdh
         NhfAfpi/MB5m/BUOIua9EXatR6/8Clj2mcvUHHME5EyxiCRGGNTTfsfbXydlKrs79/6A
         d3ObVjjIeEOR1F2yhKyrIYgU6z3nwtoDSQ34ruxAkIVCU26FM6E8uIRq+O2c0u21Q8So
         TrCY4jLB2jU21/IyQmVUg5DLHwD7VOOEWoRvzFV22hqyQ+tXqYZhO837AO+/JyI2k8q0
         gXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Px6j0xeOYkPjHURcyI2MVrHh5xdpIzdarGduqmRZnc=;
        b=gD/fE1+b08APeOuFwWT55vOkWtlmt+9KOU77VgigGlHyeZjsNcotOWjA1xefaju8Bb
         MRFHzRlj4aiDPQaoCFrQ2YdVMZ6/5I4u4ZPkFbH+18VV8GPF3UE1ai4xoouWfK/wKV8x
         jefWbN6u3lClWxHI3+ouj8dfoQe7lJnY99pdNCRjfjtrKMXUriNaNlfHvHt4JuFiURhV
         YuI1R7R0AGUtaChZKtgCpUnzovVT53KiPIPmMf9ztq2sxWXFzyigbujcvEQLloZe1TlX
         PchGxHiyCEDo2qzVmkfZg1t4bVxyATJjho1HXDsuhgbCSqZsz9UJhh5pGSIMPlj9lj3d
         RkOw==
X-Gm-Message-State: AOAM5333gWb9PuMSF8xrQ4+lbZDc0Mo+vo9gmBbGTCLU/jW1OeQMtFhU
        pxXGfMvzZjTPykxE/C/RoY4CqA==
X-Google-Smtp-Source: ABdhPJyFgdX7spYQNHdnpyJWAr7qao+RiC56kNwWy1iEA9wQYNAgnfTAAkQNW9uF3c8/uSw6RGPUlg==
X-Received: by 2002:a17:906:a459:: with SMTP id cb25mr3115995ejb.234.1594896612299;
        Thu, 16 Jul 2020 03:50:12 -0700 (PDT)
Received: from [192.168.1.2] (212-5-158-188.ip.btc-net.bg. [212.5.158.188])
        by smtp.googlemail.com with ESMTPSA id cb7sm4768901ejb.12.2020.07.16.03.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 03:50:11 -0700 (PDT)
Subject: Re: [PATCH 1/4] media: v4l2-ctrl: Add frame-skip std encoder control
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Maheshwar Ajja <majja@codeaurora.org>
References: <20200705121128.5250-1-stanimir.varbanov@linaro.org>
 <20200705121128.5250-2-stanimir.varbanov@linaro.org>
 <e9ce36f9de4ef216028832dd78fd7ebc88d6ecb1.camel@ndufresne.ca>
 <513fd919-56a2-08b4-c8a7-5d37d7743129@linaro.org>
 <a4f07133bfb4821fa19a3b70fd156bd6107c653f.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <fc34934d-78ec-8ee3-6eaf-10f129ab80cb@linaro.org>
Date:   Thu, 16 Jul 2020 13:50:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a4f07133bfb4821fa19a3b70fd156bd6107c653f.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/20 9:12 PM, Nicolas Dufresne wrote:
> Le mercredi 15 juillet 2020 à 18:42 +0300, Stanimir Varbanov a écrit :
>> Hi Nicolas,
>>
>> On 7/7/20 11:53 PM, Nicolas Dufresne wrote:
>>> Le dimanche 05 juillet 2020 à 15:11 +0300, Stanimir Varbanov a écrit :
>>>> Adds encoders standard v4l2 control for frame-skip. The control
>>>> is a copy of a custom encoder control so that other v4l2 encoder
>>>> drivers can use it.
>>>>
>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>> ---
>>>>  .../media/v4l/ext-ctrls-codec.rst             | 32 +++++++++++++++++++
>>>>  drivers/media/v4l2-core/v4l2-ctrls.c          | 10 ++++++
>>>>  include/uapi/linux/v4l2-controls.h            |  6 ++++
>>>>  3 files changed, 48 insertions(+)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> index d0d506a444b1..a8b4c0b40747 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -592,6 +592,38 @@ enum v4l2_mpeg_video_bitrate_mode -
>>>>      the average video bitrate. It is ignored if the video bitrate mode
>>>>      is set to constant bitrate.
>>>>  
>>>> +``V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE (enum)``
>>>> +
>>>> +enum v4l2_mpeg_video_frame_skip_mode -
>>>> +    Indicates in what conditions the encoder should skip frames. If
>>>> +    encoding a frame would cause the encoded stream to be larger then a
>>>> +    chosen data limit then the frame will be skipped. Possible values
>>>> +    are:
>>>
>>> I have nothing against this API, in fact it's really nice to generalize
>>> as this is very common. Though, I think we are missing two things. This
>>> documentation refer to the "chosen data limit". Is there controls to
>>> configure these *chosen* limit ? The other issue is the vagueness of
>>> the documented mode, see lower...
>>>
>>>> +
>>>> +
>>>> +.. tabularcolumns:: |p{9.2cm}|p{8.3cm}|
>>>> +
>>>> +.. raw:: latex
>>>> +
>>>> +    \small
>>>> +
>>>> +.. flat-table::
>>>> +    :header-rows:  0
>>>> +    :stub-columns: 0
>>>> +
>>>> +    * - ``V4L2_MPEG_FRAME_SKIP_MODE_DISABLED``
>>>> +      - Frame skip mode is disabled.
>>>> +    * - ``V4L2_MPEG_FRAME_SKIP_MODE_LEVEL_LIMIT``
>>>> +      - Frame skip mode enabled and buffer limit is set by the chosen
>>>> +	level and is defined by the standard.
>>>
>>> At least for H.264, a level is compose of 3 limits. One is the maximum
>>> number of macroblocks, this is is evidently not use for frame skipping
>>> and already constrained in V4L2 (assuming the driver does not ignore
>>> the level control of course). The two other limits are decoded
>>> macroblocks/s and encoded kbits/s. Both are measure over time, which
>>> means the M2M encoder needs to be timing aware. I think the time source
>>> should be documented. Perhaps it is mandatory to set a frame interval
>>> for this to work ? Or we need some timestamp to allow variable frame
>>> interval ? (I don't think the second is really an option without
>>> extending the API again, and confusingly, since I think we have used
>>> the timestamp for other purpose already)
>>
>> Do you want to say that the encoder input timestamp, bitrate control
>> (V4L2_CID_MPEG_VIDEO_BITRATE) and S_PARM is not enough to describe
>> FRAME_SKIP_MODE_LEVEL_LIMIT mode?
> 
> I don't think we have spec to give the input timestamp a meaning that
> driver can interpret. In fact I think we gave it a meaning that the
> driver must not interpret it (aka driver opaque). So remain S_PARM to

At least for Venus the timestamps are passed to the firmware and used by
encoder rate-controller.

> give a clue, but some stream don't have a framerate (like RTP streams,
> unless written in bitstream).
I think v4l2 clients should be able to guess what would be the frame
rate in such cases, no?

-- 
regards,
Stan
