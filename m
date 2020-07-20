Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF3BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E71A2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgGTTpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:45:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42420 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGTTpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:45:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id e12so14196575qtr.9;
        Mon, 20 Jul 2020 12:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bavtckn1WyzFQoRWH68yz7FBW4WoeSboORTTPjJ1+DI=;
        b=n2ybXWOiFPwgj3AisokN1EopE4YvqEF8A6EXrGOqB2gFtcUR9gS2FvrkW9eC4ldvwE
         gS04cLpDFTQLS2Q5pia+5XDxTIj1Ncgwqw7xq2IqSTbeyvRSOuxw/hHquKlEK7yuqBzm
         DbQ8f9KnyGy8maxlebTmTCC2zGWWbXqea3vOEm0z8aXYL6xGMlVq8/9bShra6Vs8asCV
         Tc86NJFAYCn9yZjnEu7M503IqdsJ5M5Luguh58R4DdQfNOYSFwVCZRj6HhNWAP1M96YF
         v898ocKUIeqz4frhO8+SnJW8u827/9+tiWhOknalmWAOO8nuwVeH/SlhGSQZgDrF/N6R
         hchw==
X-Gm-Message-State: AOAM531u5kzloC2WiFbhtPepRfkHKpcj4Hjpo2RwzUoJ3rYZtUa896+K
        VlwYWyiE9qBbwQ8iq3PAVa5MoTAVYHI=
X-Google-Smtp-Source: ABdhPJz143ZPTCs4XxM45mqUSP48zVY7+Yi4FbP1Mr8IF6Ua9Ax2JGltg+WO+dkM56JH1ieXgDdT6A==
X-Received: by 2002:ac8:4c86:: with SMTP id j6mr400631qtv.56.1595274330691;
        Mon, 20 Jul 2020 12:45:30 -0700 (PDT)
Received: from [192.168.1.113] ([179.159.57.76])
        by smtp.gmail.com with ESMTPSA id u58sm22200713qth.77.2020.07.20.12.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 12:45:30 -0700 (PDT)
Subject: Re: [PATCH] media: v4l2-dev/ioctl: Fix document for VIDIOC_QUERYCAP
To:     Jian-Jia Su <jjsu@chromium.org>, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-kernel@vger.kernel.org
References: <20200720092933.2089288-1-jjsu@chromium.org>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <91e92ed1-5364-884d-79ab-20d64594deb2@koikeco.de>
Date:   Mon, 20 Jul 2020 16:45:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200720092933.2089288-1-jjsu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/20/20 6:29 AM, Jian-Jia Su wrote:
> V4L2_CAP_VIDEO_M2M is documented as 0x00004000
> V4L2_CAP_VIDEO_M2M_MPLANE is documented as 0x00008000
> This is different from the definition in include/uapi/linux/videodev2.h
> 

Nice catch, they are swapped in the docs indeed.

From videodev2.h:

/* Is a video mem-to-mem device that supports multiplanar formats */
#define V4L2_CAP_VIDEO_M2M_MPLANE	0x00004000
/* Is a video mem-to-mem device */
#define V4L2_CAP_VIDEO_M2M		0x00008000

> Signed-off-by: Jian-Jia Su <jjsu@chromium.org>

Reviewed-by: Helen Koike <helen.koike@collabora.com>

Regards,
Helen

> ---
>  Documentation/userspace-api/media/v4l/vidioc-querycap.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
> index 666ac4d420519..90347367ef06a 100644
> --- a/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
> +++ b/Documentation/userspace-api/media/v4l/vidioc-querycap.rst
> @@ -168,11 +168,11 @@ specification the ioctl returns an ``EINVAL`` error code.
>        - The device supports the :ref:`multi-planar API <planar-apis>`
>  	through the :ref:`Video Output <output>` interface.
>      * - ``V4L2_CAP_VIDEO_M2M``
> -      - 0x00004000
> +      - 0x00008000
>        - The device supports the single-planar API through the Video
>  	Memory-To-Memory interface.
>      * - ``V4L2_CAP_VIDEO_M2M_MPLANE``
> -      - 0x00008000
> +      - 0x00004000
>        - The device supports the :ref:`multi-planar API <planar-apis>`
>  	through the Video Memory-To-Memory interface.
>      * - ``V4L2_CAP_VIDEO_OVERLAY``
> 
