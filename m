Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C22C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DDF20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 07:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgoMNRGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHNHtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 03:49:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55736C061383
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:49:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z18so6933576otk.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tM95Vxd2Khpp+Je6XwUZFk05Xu1oLz5FvMscJoWvZJM=;
        b=VgoMNRGdUF60w2jPlxyGd0etnWM2I9HRQEs8j/aSh5GNcPu6XTojIB7qVbPTh03NHj
         fl/E5X5P2chlx/estorLBQWxLMQK92QxvjJL0HmzGkLnfkhmke7naKh5kqVivPP5Feb5
         WS1cRKS/amfKwHhgj0WRwm5LzMKAVsMqgA4rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tM95Vxd2Khpp+Je6XwUZFk05Xu1oLz5FvMscJoWvZJM=;
        b=rf9Ks+RcN3kWOg54QIl3gEDtXA4pPTlEqvJRSV1DsRxtIxcGxjUethpEOz3cToLx9X
         jamHkSXtsRjw4UhrTn1dAwWxkcN2zolOaADVYfUoFaLulQMSIz8J0fuMq/2P0yg3Gpjb
         qn8C7MjuTFhOJsjkPomWeGI+y9YeDWIFBiIRKHvpSxE2ZgZdg2BQPLwW/2xT863vLJPg
         FFzYvXvmmZZcSLU+j0g77iV6Y4CmxRY9Fz5ACLfOgXf/zp8ZysTeaCOAj+GBpW3U/TyC
         2ubq5PZsUc8hLdIfoiAqSWKXv8Rm/zXpne0e98G3Ey3njZs3vUJwFmvUgC6r1ZAz825Z
         FzXA==
X-Gm-Message-State: AOAM531ZdUKwL0sQUjfSYbKTh10vvN69jT6qqbW0hirIh0bwRsMqXDXC
        2I6RvKw0Paq4ry6Pbh68XzKP3ItdIH1XbQ==
X-Google-Smtp-Source: ABdhPJx7UyRa+8umMIwA+Ikld68F/xAE3AIg6lHn/605qePVPruXsE0l6HJcarc5GJFcIBkV1GJ9fA==
X-Received: by 2002:a05:6830:114e:: with SMTP id x14mr992744otq.41.1597391374869;
        Fri, 14 Aug 2020 00:49:34 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id b17sm1593546otp.21.2020.08.14.00.49.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 00:49:33 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id n128so3602727oif.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 00:49:33 -0700 (PDT)
X-Received: by 2002:a05:6808:196:: with SMTP id w22mr759354oic.55.1597391373031;
 Fri, 14 Aug 2020 00:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200804192939.2251988-1-helen.koike@collabora.com>
In-Reply-To: <20200804192939.2251988-1-helen.koike@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 14 Aug 2020 16:49:21 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUXndtxY96i+Bpr4kNgra-EhCLuwq6cFxiPqXevQ0zY6w@mail.gmail.com>
Message-ID: <CAPBb6MUXndtxY96i+Bpr4kNgra-EhCLuwq6cFxiPqXevQ0zY6w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] media: v4l2: Add extended fmt and buffer ioctls
To:     Helen Koike <helen.koike@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hirokazu Honda <hiroh@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Brian Starkey <Brian.Starkey@arm.com>, kernel@collabora.com,
        Boris Brezillon <boris.brezillon@collabora.com>,
        narmstrong@baylibre.com, LKML <linux-kernel@vger.kernel.org>,
        frkoenig@chromium.org, Maxime Jourdan <mjourdan@baylibre.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:32 AM Helen Koike <helen.koike@collabora.com> wrote:
>
> Hello,
>
> This is v5 of the Extended API for formats and buffers, which introduces
> the following new ioctls:
>
> int ioctl(int fd, VIDIOC_G_EXT_PIX_FMT, struct v4l2_ext_pix_format *argp)
> int ioctl(int fd, VIDIOC_S_EXT_PIX_FMT, struct v4l2_ext_pix_format *argp)
> int ioctl(int fd, VIDIOC_TRY_EXT_PIX_FMT, struct v4l2_ext_pix_format *argp)
>
> int ioctl(int fd, VIDIOC_EXT_CREATE_BUFS, struct v4l2_ext_create_buffers *argp)
> int ioctl(int fd, VIDIOC_EXT_QUERYBUF, struct v4l2_ext_buffer *argp)
> int ioctl(int fd, VIDIOC_EXT_QBUF, struct v4l2_ext_buffer *argp)
> int ioctl(int fd, VIDIOC_EXT_DQBUF, struct v4l2_ext_buffer *argp)
> int ioctl(int fd, VIDIOC_EXT_PREPARE_BUF, struct v4l2_ext_buffer *argp)
>
> Please check v4 cover letter specific topic past discussions
> https://patchwork.linuxtv.org/project/linux-media/cover/20200717115435.2632623-1-helen.koike@collabora.com/

Thanks for pushing this series! I have tried to find things to say but
only have rather superficial comments, sorry about that. On the other
hand this might mean that the series is mature enough to drop the RFC.

>
> Documentation
> =============
> I added a first version of the documentation.
> I would appreciate some tips in how to organize this better, since there are
> several parts of the docs which reference the "old" API, and for now
> I just added a note pointing to the Extended API.
>
> Instead of duplicating documentation from the code to the Docs (as used by
> most part of v4l2 documentation), I just added a reference to let Sphinx get
> the structs documentation from the code, so we can avoid duplicating.
>
> For reviewing convenience, I uploaded the generated html docs at
> https://people.collabora.com/~koike/ext-doc-v5/userspace-api/media/v4l/ext-api.html
>
> There is room for improvements, it would be great to get your suggestions.
>
> uAPI
> ====
> This version have some minor changes in the uAPI structs, highlight to the
> mem_offset that was returned to struct v4l2_ext_plane, memory field that now
> is per plane, and some adjustments in field sizes and re-ordering to make
> structs the same for 32 and 64 bits (which I verified with pahole tool).
>
> I also updated v4l2-compliance:
> https://gitlab.collabora.com/koike/v4l-utils/-/tree/ext-api/wip
>
> We need to decide the size of the reserved fields left, how much reserved
> fields do you think we should leave for each struct?

Considering that the cost of a reserved field is not much compared to
the pain of not being able to extend the ABI when we need to, I'd say
that too much is preferable over not enough. :) I don't have a precise
number to give though. Formats in particular are structs that could
potentially need to carry new information. For v4l2_buffer I suppose
the request API gives us a way to extend using controls.

>
> What is next
> ============
> I would like to improve implementation (for the kernel and v4l2-compliane) and
> drop the RFC tag for next version, so please review the uAPI.
>
>
> List of changes in v5:
> ======================
> * first version of Documentation
> * migrate memory from v4l2_ext_buffer to v4l2_ext_plane
> * return mem_offset to struct v4l2_ext_plane
> * change sizes and reorder fields to avoid holes in the struct and make it
>   the same for 32 and 64 bits
> * removed __attribute__ ((packed)) from uapi structs
> * set request_fd to signed
> * add documentation
> * updated some commit messages
>
> Hans Verkuil (1):
>   media: v4l2: Add extended buffer operations
>
> Helen Koike (6):
>   media: v4l2: Extend pixel formats to unify single/multi-planar
>     handling (and more)
>   media: videobuf2: Expose helpers to implement the _ext_fmt and
>     _ext_buf hooks
>   media: mediabus: Add helpers to convert a ext_pix format to/from a
>     mbus_fmt
>   media: vivid: Convert the capture and output drivers to
>     EXT_FMT/EXT_BUF
>   media: vimc: Implement the ext_fmt and ext_buf hooks
>   media: docs: add documentation for the Extended API
>
>  .../userspace-api/media/v4l/buffer.rst        |   5 +
>  .../userspace-api/media/v4l/common.rst        |   1 +
>  .../userspace-api/media/v4l/dev-capture.rst   |   5 +
>  .../userspace-api/media/v4l/dev-output.rst    |   5 +
>  .../userspace-api/media/v4l/ext-api.rst       | 107 ++
>  .../userspace-api/media/v4l/format.rst        |  16 +-
>  .../userspace-api/media/v4l/user-func.rst     |   5 +
>  .../media/v4l/vidioc-ext-create-bufs.rst      |  95 ++
>  .../media/v4l/vidioc-ext-prepare-buf.rst      |  62 ++
>  .../media/v4l/vidioc-ext-qbuf.rst             | 204 ++++
>  .../media/v4l/vidioc-ext-querybuf.rst         |  79 ++
>  .../media/v4l/vidioc-g-ext-pix-fmt.rst        | 117 +++
>  .../media/common/videobuf2/videobuf2-core.c   |   2 +
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 560 ++++++-----
>  .../media/test-drivers/vimc/vimc-capture.c    |  61 +-
>  drivers/media/test-drivers/vimc/vimc-common.c |   6 +-
>  drivers/media/test-drivers/vimc/vimc-common.h |   2 +-
>  drivers/media/test-drivers/vivid/vivid-core.c |  70 +-
>  .../test-drivers/vivid/vivid-touch-cap.c      |  26 +-
>  .../test-drivers/vivid/vivid-touch-cap.h      |   3 +-
>  .../media/test-drivers/vivid/vivid-vid-cap.c  | 169 +---
>  .../media/test-drivers/vivid/vivid-vid-cap.h  |  15 +-
>  .../media/test-drivers/vivid/vivid-vid-out.c  | 193 ++--
>  .../media/test-drivers/vivid/vivid-vid-out.h  |  15 +-
>  drivers/media/v4l2-core/v4l2-dev.c            |  50 +-
>  drivers/media/v4l2-core/v4l2-ioctl.c          | 938 ++++++++++++++++--
>  include/media/v4l2-ioctl.h                    |  60 ++
>  include/media/v4l2-mediabus.h                 |  42 +
>  include/media/videobuf2-core.h                |   6 +-
>  include/media/videobuf2-v4l2.h                |  21 +-
>  include/uapi/linux/videodev2.h                | 146 +++
>  31 files changed, 2363 insertions(+), 723 deletions(-)
>  create mode 100644 Documentation/userspace-api/media/v4l/ext-api.rst
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-ext-create-bufs.rst
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-ext-prepare-buf.rst
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-ext-qbuf.rst
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-ext-querybuf.rst
>  create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-ext-pix-fmt.rst
>
> --
> 2.28.0.rc2
>
