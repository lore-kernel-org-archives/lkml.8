Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21624C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F148B2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlEZbxDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgGBLwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgGBLwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:52:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:52:42 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so14333994edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EiqTap8T6Zb+qWW/TbyjpdKcbIGKuEupmyMffGohwBI=;
        b=jlEZbxDkbdFHua2NcVeFcU9j07KAJ1AV6iVAdwpSsU4Xi3sbCwV0Ns4iKR7ZvokUDt
         H5PjUdx+7KKJd0d/mLLmAZoxsQfULGfq1jDMkjrEGhlPVCI4uoL75Hs10/bu6lkUGQ2K
         vxMKSXI1v4xmi5RKkwOMveJtLCUWIng+rzgVBe2yoCBJaQh5/Yzyz57iOb2KhlI3qlvl
         LZ2l+DMABjJNRKMkPQMM6kUW/j2wo7W1pyGGewBD22Zb2Rxc2SJO18BSaY2Z7fEZmfdv
         OvqDB/n4J/vYBaBBsV8PSA1zGLYtXQIwZgkzqqR3MtueiF8VBXT4MhTTot/jBvq8Gwo4
         eycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EiqTap8T6Zb+qWW/TbyjpdKcbIGKuEupmyMffGohwBI=;
        b=Tts5TU9LpytY98GiGxyDDH+/XE4dUtnJRVcC+MXPPtXkCmPgpk5BZMga58H8+CySp9
         SC5ExxsfCLN99Zx4ew46Th2bYQpAGNr7LX9eMif1C+iTsj7/kDqE4yzGOtJLUtTetO+G
         9R8c64dpvzViKH6VCPJZZ2jaPVYR3Lu43jNQ2LowoIf2ZxmWH9JjV4AsKIsgYe5SudwL
         gAFG8IRoIMiRiq0moMKHmNO4HOYqwgDINPIRgr1ZlS+cDXbsFPEnWfgvzDDYvnucoHaG
         xB0NPZV9YTfSQ5FhVK1XnpzoG0bBAkxBAfJLXbWB9SSuJMx0vhQyZdIxiTMEBUiGVTCf
         hOgg==
X-Gm-Message-State: AOAM531DH+c/uuBgk3tG9ibXURSFu0uq94BMjednTXy4K/Unyz6Dtn/p
        Sm5sp8YSBzq0ne56WSn5Ajt2wg==
X-Google-Smtp-Source: ABdhPJx2stqBIdudxKApNBtpS5VGy6/jeoYUnvSCAdbJw3W4lYG3Ok4K++EQ7nbQuuIOs5pq/UA3vQ==
X-Received: by 2002:a05:6402:1c96:: with SMTP id cy22mr33538816edb.79.1593690761145;
        Thu, 02 Jul 2020 04:52:41 -0700 (PDT)
Received: from [192.168.1.4] (212-5-158-220.ip.btc-net.bg. [212.5.158.220])
        by smtp.googlemail.com with ESMTPSA id a5sm4564402eda.35.2020.07.02.04.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 04:52:40 -0700 (PDT)
Subject: Re: [PATCH] v4l: Add source change event for colorimetry
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20200702100017.24700-1-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <8dafbb4b-4626-5191-c57a-f3ef19c14618@linaro.org>
Date:   Thu, 2 Jul 2020 14:52:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702100017.24700-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Once we have this event there is still open question how the client will
know the data buffer on which the new colorspace is valid/applied.

The options could be:
 * a new buffer flag and
 * some information in the v4l2_event structure.

Thoughts?

On 7/2/20 1:00 PM, Stanimir Varbanov wrote:
> This event indicate that the source colorspace is changed
> during run-time. The client has to retrieve the new colorspace
> identifiers by getting the format (G_FMT).
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../userspace-api/media/v4l/vidioc-dqevent.rst        | 11 ++++++++++-
>  .../userspace-api/media/videodev2.h.rst.exceptions    |  1 +
>  include/uapi/linux/videodev2.h                        |  1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> index a9a176d5256d..3f69c753db58 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
> @@ -381,7 +381,16 @@ call.
>  	that many Video Capture devices are not able to recover from a temporary
>  	loss of signal and so restarting streaming I/O is required in order for
>  	the hardware to synchronize to the video signal.
> -
> +    * - ``V4L2_EVENT_SRC_CH_COLORIMETRY``
> +      - 0x0002
> +      - This event gets triggered when a colorspace change is detected at
> +	an input. By colorspace change here we include also changes in the
> +	colorspace specifiers (transfer function, Y'CbCr encoding and
> +	quantization). This event can come from an input or from video decoder.
> +	Once the event has been send to the client the driver has to update
> +	the colorspace specifiers internally so that they could be retrieved by
> +	client. In that case queue re-negotiation is not needed as this change
> +	only reflects on the interpretation of the data.
>  
>  Return Value
>  ============
> diff --git a/Documentation/userspace-api/media/videodev2.h.rst.exceptions b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> index ca05e4e126b2..54fc21af852d 100644
> --- a/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> +++ b/Documentation/userspace-api/media/videodev2.h.rst.exceptions
> @@ -492,6 +492,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
>  replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
>  
>  replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
> +replace define V4L2_EVENT_SRC_CH_COLORIMETRY src-changes-flags
>  
>  replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
>  
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 303805438814..b5838bc4e3a3 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -2351,6 +2351,7 @@ struct v4l2_event_frame_sync {
>  };
>  
>  #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
> +#define V4L2_EVENT_SRC_CH_COLORIMETRY		(1 << 1)
>  
>  struct v4l2_event_src_change {
>  	__u32 changes;
> 

-- 
regards,
Stan
