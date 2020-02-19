Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2230FC3404E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1DA24658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9VOqdRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSH4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:56:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37592 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:56:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id t7so16404869edr.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 23:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q3+DgOutnfX7SsA3bKGScs4wmPyXe9VReVvuWS0M6eg=;
        b=B9VOqdReReZ1UeU791Rw1WlZRkQMxOMH6TE0rvZjCfwjN+5+ngZKvK/2vWeKPsgu1H
         WresiCidvXZl/lPZ3JAHrOVFjVeEVJgAg0DRYc5zt6o8PsAzA5tFX6WkErNRD2yX4SLB
         4uAaPOMgTexnB1rhFyLRX014eJi1auuXLhhMfMou7yd2UwKjZ6Uf1JVJiQJkm3HJD0HY
         A+v3aoFgp6011VlLTNW47C0ebBYxxZ90iLj86hn+EAGee2LEfaUMGIUlUnGeqnOAHEqs
         3nANbPVRpgxZokwGanYa2uaA8BX0zdb96rGRENEnAd0NpFcRNg9hRQbtLxCXcbjWvbnw
         EK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3+DgOutnfX7SsA3bKGScs4wmPyXe9VReVvuWS0M6eg=;
        b=n73DHZRRsju1KagHiJavLxvx/PY61GsCoU/OysnvndFhDWmiQvFmHrtiqSs0pvvrSP
         P+d9q501myS4UmbMhM+yc6ZN204m4HDIfFXLAWNbO6qL7qXzmG1RowMkAQFwtvitPhYD
         rUf73Y4VDzyEnrDId1FbJz4saJ/RhiWohqjl7yA1XGxqL3u0NGCdh0dHT6jDzV2Dj/rn
         75RFtYZTFQB+mK3bpZ8/7m3FXwmapQV54XWXItBgS3K4Q3Vh5mJKsS1sRTn8vKcm90XJ
         3ztSxQRuuyRNq4cAp3AIT3hBa/64djSA3rTlTgVqOMQRSg9uFrCPa/iUurP6MUjBfpJD
         gUyg==
X-Gm-Message-State: APjAAAURfUQwjVNXXO6IX5p/N1LDe6vwlDzy8wATjgzlu1nvjco4jX+9
        kYjVNd55W2VLxn1IGykii9srA7CxKo4=
X-Google-Smtp-Source: APXvYqzY1Ka4YmzayW0U4GzuX30KYCpJuQ7CVEnrnpvxHGnfC9YVDEwp3qO0A8Qn44H3AwHFDmYMjQ==
X-Received: by 2002:a17:906:e296:: with SMTP id gg22mr23367427ejb.7.1582098989740;
        Tue, 18 Feb 2020 23:56:29 -0800 (PST)
Received: from [192.168.27.209] ([94.155.124.210])
        by smtp.googlemail.com with ESMTPSA id qh18sm35942ejb.23.2020.02.18.23.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 23:56:28 -0800 (PST)
Subject: Re: [PATCH] media: venus: support frame rate control
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, Andy Gross <agross@kernel.org>,
        "Mauro Carvalho Chehab )" <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200213213007.17023-1-jkardatzke@google.com>
 <b471217a-1877-eaed-55c2-084f4b126bb4@linaro.org>
 <CA+ddPcPjtv_9s4+t_1jkoGSZihVu2cVLyW102WuoLMy-RGkKPw@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b0c8653a-314e-bab9-9dc8-8c33b8d1efc9@linaro.org>
Date:   Wed, 19 Feb 2020 09:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+ddPcPjtv_9s4+t_1jkoGSZihVu2cVLyW102WuoLMy-RGkKPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 2/18/20 9:09 PM, Jeffrey Kardatzke wrote:
> Sorry for the duplicate, accidentally used HTML format and it got
> bounced from the mailing lists so resending.
> 
> On Mon, Feb 17, 2020 at 2:15 AM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> Hi Jeff,
>>
>> Thanks for the patch!
>>
>> On 2/13/20 11:30 PM, Jeffrey Kardatzke wrote:
>>> Frame rate control is always enabled in this driver, so make it silently
>>> support the V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE.
>>>
>>> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
>>> ---
>>>  drivers/media/platform/qcom/venus/venc_ctrls.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>> index 877c0b3299e9..9ede692f77c5 100644
>>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>>> @@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>               }
>>>               mutex_unlock(&inst->lock);
>>>               break;
>>> +     case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
>>> +             // Silently ignore, it's always enabled.
>>
>> Please, use C comments and follow the kernel coding style.
> 
> OK, hopefully I've got that now. I didn't see any issues aside from
> the comment style though.
> I'll upload a new patch shortly.
>>
>>
>> I wonder shouldn't it be better to add rc_enable field in struct
>> venc_controls and give the user choice to disable the rate control? We
>> can keep the default to be "enabled".
>>
> That'd be fine. Is there a way to actually disable the rate control though?

The rate control property values are here [1], and [2] is where we set
the control.

-- 
regards,
Stan

[1]
https://elixir.bootlin.com/linux/v5.6-rc2/source/drivers/media/platform/qcom/venus/hfi_helper.h#L229
[2]
https://elixir.bootlin.com/linux/v5.6-rc2/source/drivers/media/platform/qcom/venus/venc.c#L734
