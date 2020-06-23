Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F83C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847CC20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="O84lAlQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733307AbgFWSoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733165AbgFWSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:44:24 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:44:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so17118844eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHRfY/482pH60fZPQJikxqae/P0Z6lDDbQXNlIRp7tc=;
        b=O84lAlQtan6g3BHHHf7sIEL60Tt8VsrCeEVE8CQeBdNfZtWiEkIBf5EnEBTSnOIYhV
         EPdW4t8kcLvZ9LhfuTnNxdMsJ721WftZAm2YfItBlw7ZCfjOPOaCPgEhEUNc/LV9MpMT
         UfTabuopH1KekbGurNoL/s3jNY+zFWjIe+weZsQUyV611kaMJC6SyKOGCy0LGyPBBocU
         I6eEwuTw3L5JxgW9yX5wsfKT5IEMwvCDD1gcvJX0Dzz/DeyHX3FjI/lPlo2zl6EOxPbC
         oaCdMzn5EhGGffrjqZGBaLeDIrHSd1fkpJvfsTmFDUL3W1alvsulTjb0gLAndKmgvLhD
         JFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHRfY/482pH60fZPQJikxqae/P0Z6lDDbQXNlIRp7tc=;
        b=WIcMRcv0gKZ3zpS/35yKi61bCk1mt4SZp3H/Tz/VfrnVo5iNvO9amU14eCg5ez5VlA
         LBVid9yCLq6aOZO1TsD63nUnKyyHV08ywc5I6zWzFckWUPUjM0A+J+OgLuvjZ5g+uxG+
         mFsu3vjcBwsTZca4uFBNlEwL4/Ky3RQRQPh2OAu63HoOYxjMBf1vaK654tcfM/AVzW7M
         TTvUo8RY8UgTpnj5fleH2pBByKwfoNxOdVxXtD9G7W5UYDbtmMaDFEFVOC6n3VetEWsc
         J9eYJkIYhIwwKEarlVqWIHQn8fPFXg2p8Fq07jchip0iFPogbpQTxsUmxnk/OBe/pbGu
         chkQ==
X-Gm-Message-State: AOAM533FRlbTjKk1mk3yXMr1wjUbGK7eWbgRaa16TyUM6ezKgWMqg8bw
        QZCkYzWdWILAoxUo8pTarurKhiahux0U1C2JSzmufCuh
X-Google-Smtp-Source: ABdhPJyPUIlDVH1n7pGFYZ5aO9aLZJphcDUMccOXmcIiaLZUxDvA5Dpv5o3A65C6wRy4Z9PcnkaV9feKOmD03dYG9P4=
X-Received: by 2002:a05:6402:1247:: with SMTP id l7mr22177355edw.61.1592937862811;
 Tue, 23 Jun 2020 11:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200622015227.24134-1-yunfei.dong@mediatek.com>
In-Reply-To: <20200622015227.24134-1-yunfei.dong@mediatek.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 23 Jun 2020 15:43:47 -0300
Message-ID: <CAAEAJfBtuZUn-LxiwCZ75rwT_oEuM-_QEXCH4-vFhV6X+8=4SA@mail.gmail.com>
Subject: Re: [PATCH v2, 0/2] This patchset add Read-only(Ro) request for
 capture queue
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

Thanks for the patch.

On Sun, 21 Jun 2020 at 22:55, Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> User driver need to get HDR10+ information for each capture buffer;
> For some encoder cases, user driver need to get encoded message for
> each frame. So add support read-only(Ro) request for capture queue.
>
> Ro request mean that user driver just can get ext ctrls, set ext ctrls
> is not not allowed. Ro Request also can be used in output queue.
>
> There is not upstream driver to use this feature at now, but we are
> developing internal driver to use it. If it is ready, we will try to
> upstream vdec/venc driver based on this feature.
>

An upstream driver using the feature would be important, but it would
be nice to also have: an open-source userspace application,
and a proper explanation in the stateless decoder interface specification.

Thanks,
Ezequiel

> Change compared to v1:
> -change commit message of patch 01/02
> -change commit message of patch 02/02
>
> Yunfei Dong (2):
>   media: v4l UAPI: add V4L2_BUF_CAP_SUPPORTS_RO_REQUESTS
>   media: v4l: Add Ro request api for capture queue
>
>  .../media/v4l/vidioc-reqbufs.rst              |   4 +
>  .../media/common/videobuf2/videobuf2-v4l2.c   |   7 ++
>  drivers/media/mc/mc-request.c                 |  10 +-
>  drivers/media/v4l2-core/v4l2-ctrls.c          | 107 +++++++++++++++---
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  22 ++++
>  drivers/media/v4l2-core/v4l2-mem2mem.c        |  19 ++--
>  include/media/v4l2-ctrls.h                    |  22 +++-
>  include/media/v4l2-fh.h                       |   2 +
>  include/media/videobuf2-core.h                |   2 +
>  include/uapi/linux/videodev2.h                |   1 +
>  10 files changed, 158 insertions(+), 38 deletions(-)
>
