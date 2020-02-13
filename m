Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C83C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A30F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SV6pNZyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgBMHI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:08:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33875 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbgBMHIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:08:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id r18so5574657edl.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXCrPbdofUne5OpnOTH4+A4IsQ6aP6l5yadrAQp4F68=;
        b=SV6pNZyT/EPGectN6pXxwiJPU8ZRunYBpTu1FSRW/3ZP6mZsWrm0ksgrhKcZwbi/bF
         THW1P8G6C+/jdQVV+sJBkRvePjRbroiJnkZAPTQI5xHnFLkTXX/FXmYldlBToK/xr8Z1
         Rsf6dTUVJCzQ9mqtFCVYYtEM2cTlcx7YFEQGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXCrPbdofUne5OpnOTH4+A4IsQ6aP6l5yadrAQp4F68=;
        b=HiTXZ51qXSQNaYOuGXJqk+iqnWKkgAw5gpkbmMaQ9viXuj3AiroaPZwTUEv5iJlxPP
         2XByTu1/6H7doli4I1mVj9FM61LKySa0h/lEyAvfHt+C1rq13ZOfdss1kxQ7LUnlbPfr
         blqn2YMDP7USJhCHEJHPNulYr94xSO3Ho2Z5EZgD4Ars+OOP3B7vGifGmNl/A6KQeRrl
         /uHuJIBzhNC+tBd+R7Uv/jw823rL0ge4m5pUXQo9E9Mz+V/ZAP8rTIvHQHwGxAvc2m4F
         deR4r+b3/rZ80bj9qP0xSYctcnJCMiS720LjO9Y6ReqUlABjLPFINRBYmvYjvR2Cmokq
         6lrw==
X-Gm-Message-State: APjAAAVv/gUzDjjH1cpFzmYLPPSrHI0USWIUX+tusR84vFyI4gimnbXd
        82OGmlJ7QOd6clzSHpyE+yiDnM4crZHShg==
X-Google-Smtp-Source: APXvYqxKBP38j+dOekYv4TXMNKzJHkwRgFJgEuZ031QKvO17ZMeb9mPNjnRy2EYrXv1bZ7I/t2bf6w==
X-Received: by 2002:a17:906:4bd1:: with SMTP id x17mr14864680ejv.181.1581577702739;
        Wed, 12 Feb 2020 23:08:22 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id k11sm122983ejq.24.2020.02.12.23.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:08:21 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id q9so4942336wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:08:21 -0800 (PST)
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr3985579wml.55.1581577700504;
 Wed, 12 Feb 2020 23:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20200204025641.218376-1-senozhatsky@chromium.org> <20200204025641.218376-4-senozhatsky@chromium.org>
In-Reply-To: <20200204025641.218376-4-senozhatsky@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 13 Feb 2020 16:08:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B3NbUO9dD9GjeCE5BCD9d74XLdqoSF5K45hWKLHwJHMA@mail.gmail.com>
Message-ID: <CAAFQd5B3NbUO9dD9GjeCE5BCD9d74XLdqoSF5K45hWKLHwJHMA@mail.gmail.com>
Subject: Re: [RFC][PATCHv2 03/12] videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT
 flag
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 11:57 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> By setting or clearing V4L2_FLAG_MEMORY_NON_CONSISTENT flag
> user-space should be able to set or clear queue's NON_CONSISTENT
> ->dma_attrs. Queue's ->dma_attrs are passed to the underlying
> allocator in __vb2_buf_mem_alloc(), so thus user-space is able
> to request vb2 buffer's memory to be either consistent (coherent)
> or non-consistent.
>
> Change-Id: Ib333081c482e23c9a89386078293e19c3fd59076
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  Documentation/media/uapi/v4l/buffer.rst | 27 +++++++++++++++++++++++++
>  include/uapi/linux/videodev2.h          |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/Documentation/media/uapi/v4l/buffer.rst b/Documentation/media/uapi/v4l/buffer.rst
> index 9149b57728e5..af007daf0591 100644
> --- a/Documentation/media/uapi/v4l/buffer.rst
> +++ b/Documentation/media/uapi/v4l/buffer.rst
> @@ -705,6 +705,33 @@ Buffer Flags
>
>  .. c:type:: v4l2_memory
>
> +Memory Consistency Flags
> +========================
> +
> +.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
> +
> +.. cssclass:: longtable
> +
> +.. flat-table::
> +    :header-rows:  0
> +    :stub-columns: 0
> +    :widths:       3 1 4
> +
> +    * .. _`V4L2_FLAG_MEMORY_NON_CONSISTENT`:
> +
> +      - ``V4L2_FLAG_MEMORY_NON_CONSISTENT``
> +      - 0x00000001
> +      - vb2 buffer is allocated either in consistent (it will be automatically
> +       coherent between CPU and bus) or non-consistent memory. The latter
> +       can provide performance gains, for instance CPU cache sync/flush
> +       operations can be avoided if the buffer is accesed by the corresponding
> +       device only and CPU does not read/write to/from that buffer. However,
> +       this requires extra care from the driver -- it must guarantee memory
> +       consistency by issuing cache flush/sync when consistency is needed.
> +       If this flag is set V4L2 will attempt to allocate vb2 buffer in
> +       non-consistent memory. This flag is ignored if queue does not report
> +        :ret:`V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS` capability.

nit: Should the patch adding the capability flag precede this one?

> +
>  enum v4l2_memory
>  ================
>
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 5f9357dcb060..72efc1c544cd 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -189,6 +189,8 @@ enum v4l2_memory {
>         V4L2_MEMORY_DMABUF           = 4,
>  };
>
> +#define V4L2_FLAG_MEMORY_NON_CONSISTENT                (1 << 0)
> +
>  /* see also http://vektor.theorem.ca/graphics/ycbcr/ */
>  enum v4l2_colorspace {
>         /*
> --
> 2.25.0.341.g760bfbb309-goog
>
