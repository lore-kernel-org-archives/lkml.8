Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41EEC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F192082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4Tlzh2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgAJKyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:54:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37326 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbgAJKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:54:08 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so1147271edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=683GIdX4ExqgOWlzGwnCnJgXWPRG2CE2zHJsuw1s5ls=;
        b=H4Tlzh2pg0fFdLHuLzlkIhdnf4CpDMxqOgedxrWfrGenE/IU59XNl7FXRi5bQJ/1ga
         kSD/4M6L0K3TbMwAcDPTSMspdd6HQFIXMtopS+opK+gSLf0qVHYvhMpMNc2LvzCELyUh
         v9wUmPz9216Cd8HNirKPA2jT8h1deqDZChBwq2fx74ca9pIIpM0fUOoQxWu+nSX+iGsq
         9Y2BpsqtGfLIpOtwNHPHNIoMLKK80/OPX/jDNB3JzfJ/6ZI5G2wn/oqE3TfAVT//XvLi
         vJyv1+8nY7K3NdKwJ9PqOqDZvPGPa6YRxlxE6Jdl8UoKlLh4+ihZXloaktSoepfVHWPX
         pnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=683GIdX4ExqgOWlzGwnCnJgXWPRG2CE2zHJsuw1s5ls=;
        b=JUIbPAP17xArC/cde33qMx6H5Y9M1cfDiAeigXx+ylNpywFcviwsnDfkU1mQ8wPfYG
         1PWNR8RLV3WOe26APkHymTkIIB+UcnLibQJLOaJjugr85iOOnl8sP1gZBUvERMDhs+sN
         PfREqSk+ZiouOVd61WxQXy6bn2Hg98EWgzoCOv/rKv8ltHYSEgCOetl96fvh5/UMitDk
         DCNhnEa2a34KipZ9T8HMKlaL68Be10uJT1+XzgyE2lnXdVeYFGMoCrDmuOffU/4ARdXv
         h4yaMxDcAIRllLj8LrCRObOpGvkC9OGj0jRfEwXlmTYJDuLgabhe0Z3VrsXsjhDnLMUB
         J0nA==
X-Gm-Message-State: APjAAAUWTFY1InygWdd0UX2uMJF/wTBI2IiuQRNU7+1xbjESw8Wq58f6
        ffwK1F6hoUCDecfvxMaGlxEG8A==
X-Google-Smtp-Source: APXvYqwXi2p9od8RKzdFKvWzNSqewAgaEw93sWpDYWUInbFQeII2xkI489wglJJwYeOqJClu81XBJQ==
X-Received: by 2002:a17:906:84d7:: with SMTP id f23mr636627ejy.106.1578653646262;
        Fri, 10 Jan 2020 02:54:06 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id f13sm26014edq.26.2020.01.10.02.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 02:54:05 -0800 (PST)
Subject: Re: [PATCH v4 04/12] v4l: Add source event change for bit-depth
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-5-stanimir.varbanov@linaro.org>
 <c3b02589-1d7a-a476-7d33-7e555fbe276d@xs4all.nl>
 <ae233eb1-69fc-6723-0224-0c1fcf786156@linaro.org>
 <fb27b5cc-0eef-a7b4-f45b-a3986b77c4c9@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <988e49aa-469d-17a1-ca25-982c63536e6e@linaro.org>
Date:   Fri, 10 Jan 2020 12:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fb27b5cc-0eef-a7b4-f45b-a3986b77c4c9@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 1/9/20 10:57 AM, Hans Verkuil wrote:
> On 1/9/20 8:41 AM, Stanimir Varbanov wrote:
>> Hi Hans,
>>
>> On 1/8/20 6:09 PM, Hans Verkuil wrote:
>>> On 1/6/20 4:49 PM, Stanimir Varbanov wrote:
>>>> This event indicate that the source color bit-depth is changed
>>>> during run-time. The client must get the new format and re-allocate
>>>> buffers for it. This can usually happens with video decoder (encoders)
>>>> when the bit-stream color bit-depth is changed from 8 to 10bits
>>>> or vice versa.
>>>>
>>>> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>> ---
>>>>  Documentation/media/uapi/v4l/vidioc-dqevent.rst | 8 +++++++-
>>>>  Documentation/media/videodev2.h.rst.exceptions  | 1 +
>>>>  include/uapi/linux/videodev2.h                  | 1 +
>>>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>>>> index 42659a3d1705..fad853d440cf 100644
>>>> --- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>>>> +++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>>>> @@ -402,7 +402,13 @@ call.
>>>>  	that many Video Capture devices are not able to recover from a temporary
>>>>  	loss of signal and so restarting streaming I/O is required in order for
>>>>  	the hardware to synchronize to the video signal.
>>>> -
>>>> +    * - ``V4L2_EVENT_SRC_CH_COLOR_DEPTH``
>>>> +      - 0x0002
>>>> +      - This event gets triggered when color bit-depth change is detected
>>>> +	from a video decoder. Applications will have to query the new pixel
>>>> +	format and re-negotiate the queue. In most cases the streaming must be
>>>> +	stopped and restarted (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>`
>>>> +	followed by :ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
>>>
>>> I think this is too specific for decoders. Something similar to the
>>> CH_RESOLUTION description would be more appropriate:
>>>
>>>       - This event gets triggered when a color bit-depth change (but not a
>>> 	resolution change!) is detected	at an input. This can come from an
>>
>> What you mean by "but not a resolution change" here? Resolution change
>> and bit-depth change cannot occur on the same time, or something else.
> 
> What I was trying to say is that a resolution change implies a possible bit-depth
> change as well, whereas V4L2_EVENT_SRC_CH_COLOR_DEPTH is only set if there is
> a bit-depth change but no resolution change.
> 
> V4L2_EVENT_SRC_CH_RESOLUTION requires that userspace does a full resync to the
> new format, CH_COLOR_DEPTH implies that only the bit depth changed.

CH_COLOR_DEPTH implies format re-negotiation as well. In Venus case
8->10bit change will change the format of OPB buffers (now it is not
possible because of lack of v4l modifiers) and DPB buffers becomes
compressed raw buffers (to optimize bandwidth).

> 
> Which actually makes me wonder: is there a difference between the two change flags
> w.r.t. userspace behavior? If there is, then that should be carefully documented,
> if there isn't, then is this new flag really needed?

Looking into semantics of v4l events, CH_COLOR_DEPTH makes sense because
it describes what actually changed (similar to CH_RESOLUTION). I would
say that v4l2_event::type V4L2_EVENT_SOURCE_CHANGE implies format
re-negotiation and v4l2_event::src_change just informs userland what
exactly is changed.

I'll postpone this patch until we have clear vision what will be the
usage in user-space.

-- 
regards,
Stan
