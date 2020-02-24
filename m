Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A22C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EDA20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ox/6EVcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBXLCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:02:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42237 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBXLCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:02:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id e10so11368300edv.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v6+UZmxrnWoPymq2fZLY8ej/xm1w9VrGB1cGqVaTeH8=;
        b=ox/6EVcmg03kjjKzslKAXHfUhpY7yew010kFA6FoNWR4JGhI9XWdxPaX2hb76ceYjr
         u/2+C/7bB1zOyWQcvtr2ygN/2iQqJmaGWlsdDUAwVOem7hXDSoOfFMXC5P33zaMCqTBq
         ehLIjKlkk6+aWCdwsY+YKZeHffJ0Ba479v55TeeeCS/HHGwx2qFVzyzTIWjRzreYnJu7
         WZVIpZPInHEm0OoLSgm1sYAN9OLDLO6zMt/dtQlNO2Jo4LKeN7xJkpF5oiP8SAA4ksjl
         ZV6+tQDbXINz3dI5HNqiucDo8fOvDGj4Fgt6aJoOYEGoCb8WyOCC71ruusByNRzHVmnj
         dz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v6+UZmxrnWoPymq2fZLY8ej/xm1w9VrGB1cGqVaTeH8=;
        b=CLxPhtddxYJkv4uJ+0pJTmkRICuYCRfDyptOjtgI3W5K3yRrf9ef2mHlRUX1muMJID
         QUUqEfCo2cfdBiYpOoFE/uucJU8zJ1b+D0heEkg8T+dLEKGerX9F0oTvG/wkPNE2tzrn
         tq8IR24f41pS4yMW1GZqx3vIKmQfzROskOvd+JlbXb17NZEqajPVVY+H5z7beIBPALfX
         YS5Z80EtuzoUPYo1pS3h+1H5tXL03OnsNjTBLjZQzLYNWUHdfqBZDquOAoHk8RrO2S1T
         uyUtY7cKd9okyK+ffx+5rutNe2NiaHkFzLHnC31/Er8QQntPNw+FPpmsSDw9INvDlf60
         v8UA==
X-Gm-Message-State: APjAAAX7g8/g3oRr/fcQpnFFnuwX0B+X4TQni+UsDvLzT2BWU4RO5AlX
        umJbSnnRvSEkyHRvIzknd5TIsw==
X-Google-Smtp-Source: APXvYqy9UIXeu7Ri4xxhUXbuG2/BOnDE6KCkJHZuAdpIHb3c0zKsYYh7mQybwKEMwN7el2uDEtwpSg==
X-Received: by 2002:aa7:c718:: with SMTP id i24mr45541300edq.195.1582542153017;
        Mon, 24 Feb 2020 03:02:33 -0800 (PST)
Received: from [192.168.27.209] ([94.155.124.210])
        by smtp.googlemail.com with ESMTPSA id cw15sm961788edb.44.2020.02.24.03.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 03:02:32 -0800 (PST)
Subject: Re: [PATCH v3] media: venus: add support for selection rectangles
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        linux-media@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20200218184220.139656-1-jkardatzke@google.com>
 <CA+ddPcOMpiHU=2bumCe93NzLe-uO04TnhCS+5CDDU4GyLXYCNA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <4e9cad3b-3e01-3b02-1050-b0428a632744@linaro.org>
Date:   Mon, 24 Feb 2020 13:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+ddPcOMpiHU=2bumCe93NzLe-uO04TnhCS+5CDDU4GyLXYCNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 2/18/20 9:14 PM, Jeffrey Kardatzke wrote:
> (again, sorry for duplicate to some people, didn't know the plain text
> email rule before)
> There were a few comments made when this patch was originally posted
> that were not addressed.  I left the patch as it last stood, except
> for removing the unused variables.
> 
> The outstanding comments were:
> 1. In venc_init_session, it is only using the inst->width/height
> rectangles and not the inst->out_width/out_height rectangles. So there
> was a question about whether the OUTUPT rectangle should be set to
> out_width/out_height. I'm looking for feedback here as I'm not
> familiar enough with this driver code yet.

Yes, the observant reader will see that out_width/height (the encoder
input resolution) is not changed in set_selection method, and that is
simply because currently the implementation for crop is missing. And it
is missing because the so-called extradata is not implemented and not
used in the driver, yet.

In fact the proposed patch will just fake the userspace application to
think that it sets the crop rectangle but the cropping will not happen
at all.

> 2. We should return EBUSY if the selection rectangles are changed
> after we are initialized (I will update it to do this)

Not sure we need that.

> 3. Support for non-zero top/left parameters. I'm suspicious that the
> HFI_INDEX_EXTRADATA_INPUT_CROP property is what should be used for
> that, but it's not currently used anywhere. Does anybody have details
> on if that's what it's for?

This is the right property to be used to set encoder crop on the input,
but unfortunately it is not that simple.

Actually this property is used to enable the crop extradata handling in
the firmware side, but we need to take care of that extradata population
in the v4l2 driver. For that purpose we need an extradata buffer which
should be filled with extradata header plus the extradata itself.

I'm not sure how to implement that, still. There is a bunch of extradata
types where some of them could be filled by the driver but the others
could be filled by userspace.

For reference you can see how the crop is set on Android [1].

[1]
https://android.googlesource.com/platform/hardware/qcom/sdm845/media/+/refs/heads/master/mm-video-v4l2/vidc/venc/src/video_encoder_device_v4l2.cpp#669

> 
> 
> On Tue, Feb 18, 2020 at 10:42 AM Jeffrey Kardatzke
> <jkardatzke@google.com> wrote:
>>
>> From: Malathi Gottam <>
>>
>> Handles target type crop by setting the new active rectangle
>> to hardware. The new rectangle should be within YUV size.
>>
>> This was taken from: https://lkml.org/lkml/2018/11/9/899
>>
>> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
>> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
>> ---
>>  drivers/media/platform/qcom/venus/venc.c | 24 ++++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
>> index 453edf966d4f..73b3181eed9a 100644
>> --- a/drivers/media/platform/qcom/venus/venc.c
>> +++ b/drivers/media/platform/qcom/venus/venc.c
>> @@ -479,10 +479,26 @@ venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>>
>>         switch (s->target) {
>>         case V4L2_SEL_TGT_CROP:
>> -               if (s->r.width != inst->out_width ||
>> -                   s->r.height != inst->out_height ||
>> -                   s->r.top != 0 || s->r.left != 0)
>> -                       return -EINVAL;
>> +               if (s->r.left != 0) {
>> +                       s->r.width += s->r.left;
>> +                       s->r.left = 0;
>> +               }
>> +
>> +               if (s->r.top != 0) {
>> +                       s->r.height += s->r.top;
>> +                       s->r.top = 0;
>> +               }
>> +
>> +               if (s->r.width > inst->width)
>> +                       s->r.width = inst->width;
>> +               else
>> +                       inst->width = s->r.width;
>> +
>> +               if (s->r.height > inst->height)
>> +                       s->r.height = inst->height;
>> +               else
>> +                       inst->height = s->r.height;
>> +
>>                 break;
>>         default:
>>                 return -EINVAL;
>> --
>> 2.25.0.265.gbab2e86ba0-goog
>>

-- 
regards,
Stan
