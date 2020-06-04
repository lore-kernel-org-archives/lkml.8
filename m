Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0460120820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="g8wRyxai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgFDJJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:09:09 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:48021 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728593AbgFDJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:08:57 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id glrkjqbQWCKzeglrojT6Dn; Thu, 04 Jun 2020 11:08:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1591261733; bh=j4KmuNfoaD1xgru0STWLiixs8IWyKqQToaes8a8SFfM=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=g8wRyxaisc9bkXrFJVdkVtuRd2L6hwzYieCL0LlDIbz33nd1dewAnqgXtrDi3kg6+
         z52Y5SlGec3+bDQkPxR7u+Q+/pzvkHDEhsgTz50AYTzfCdoyMxFbTbDdmUssUIu6oG
         0X96eGKhSwseQQEJrDApfpn8gyWc9M03uMxdGMSnicxFXVak5OvHUqoRhqAHr1u2u3
         6xA4kdiI9VHe7xLw2GTIYd8vec1J4Bshyt9q1Q/zpM5fOpGtBCvfhB8dWqPlwg4v3u
         fwsB9oFdWUPStNFc7FpAb7ZOYraW0M/IAKnohSDo6ST4XOKz18772ymn4FZykvRZd5
         BOdkwfoYWGf2A==
Subject: Re: [PATCH] v4l2-ctrl: add control for thumnails
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
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
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <544b19dd-4883-bae0-b488-46c856eb207d@xs4all.nl>
Date:   Thu, 4 Jun 2020 11:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d02c6cd0-a502-dc52-519e-54b6328d5373@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOu4u7+06bZWadT4Jj2h7ITjojpPgQdZS6iYuSScB0bwJDJKgOYDMWrCCgR3/hc+zzs9RxjvajWgWKm+2+ECdZPg2LTa7RSThVQS/dpGg1aydxRnlYLQ
 ds2ZbWaNfnyu00wa1qHKHkXmBp7ldPKGxJsito5iVTSnt3G//dag3X72ALBl8qZKlK8Yay55eRhqqjgmc7YmMntDQWDxHubleUnMd7PN7ZeZmVGTqEBUoxqA
 clljEZOnnkNcuK2+GIlc8GcI/EnIw15gzJM/KJwlhGyE7zcDwLm26NmrzWZ2spFLqoXgb9wo2AZ8Epade4OoAIBTZmpd9OMWiMebB+/A7rjmy+jShgF9QHp/
 vwoLSVfm3f6lREjN+mTpJqBi71csCXvTyMArAMRPQ4ZUjo2aQdssjO9W5mfmPULGsvuvK++3IF/97cw9caxBCpZ64PHy3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2020 11:02, Stanimir Varbanov wrote:
> Hi Hans,
> 
> On 5/27/20 12:53 AM, Stanimir Varbanov wrote:
>> Hi Hans,
>>
>> On 5/26/20 3:04 PM, Hans Verkuil wrote:
>>> On 26/05/2020 10:54, Stanimir Varbanov wrote:
>>>> Add v4l2 control for decoder thumbnail.
>>>>
>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>> ---
>>>>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 7 +++++++
>>>>  drivers/media/v4l2-core/v4l2-ctrls.c                      | 2 ++
>>>>  include/uapi/linux/v4l2-controls.h                        | 2 ++
>>>>  3 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> index d0d506a444b1..e838e410651b 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -3726,6 +3726,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>      disables generating SPS and PPS at every IDR. Setting it to one enables
>>>>      generating SPS and PPS at every IDR.
>>>>  
>>>> +``V4L2_CID_MPEG_VIDEO_DECODER_THUMBNAIL (button)``
>>>> +    Instructs the decoder to produce immediate output. The decoder should
>>>> +    consume first input buffer for progressive stream (or first two buffers
>>>> +    for interlace). Decoder should not allocate more output buffers that it
>>>> +    is required to consume one input frame. Usually the decoder input
>>>> +    buffers will contain only I/IDR frames but it is not mandatory.
>>>
>>> This is very vague. It doesn't explain why the control is called 'THUMBNAIL',
>>> but more importantly it doesn't explain how this relates to normal decoding.
>>
>> If in the normal decode the capture queue buffers are 5, in the
>> thumbnail mode the number of buffers will be only 1 (if the bitstream is
>> progressive) and this will guarantee low memory usage. The other
>> difference is that the decoder will produce decoded frames (without
>> errors) only for I/IDR (sync frames).

Isn't this really a "DECODE_SYNC_FRAMES_ONLY" control? That's what it does,
right? Skip any B/P frames and only decode sync frames.

That this is useful for creating thumbnails is just a specific use-case.

Regards,

	Hans

>>
>>>
>>> I.e. if you are decoding and 'press' this control, what happens then?
>>
>> Might be the button type wasn't great idea. In fact the control should
>> be set before streamon so that the driver returns min_capture_bufs 1.
>>
>>>
>>> What exactly is the use-case?
>>
>> It could be used to generate thumbnails of all video clips in a folder
>> or when you open a Gallery application on your phone.
>>
> 
> What is your opinion on that control? I could consider to make it Venus
> custom control but from the use-case it looks other drivers also can
> benefit of it.
> 
> I tried to make more generic one [1] but it looks it will be too difficult.
> 

