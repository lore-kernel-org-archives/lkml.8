Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B37C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B752078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="INguoyub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgIJIqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgIJIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:44:13 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A2CC061799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:39 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a3so5205941oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RM+6YCueDPy1nkorG5jfOVGfbj1m5UCHBF4PF2PU/iI=;
        b=INguoyube130+8WwnXu/RYMh/Ju9WC30cNYDrviHqjIJBbZccMMVak/rSrOZ3ijhHR
         OmyS41tmWGU9bUjUr28yjCNpFgi3MHy2KYoaUXyZmwIZPZiIiwAojnfIKdvrGosGbjPA
         JydJiXyNitT7guWnNfOTvv7Z4wIAc2T/tudn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RM+6YCueDPy1nkorG5jfOVGfbj1m5UCHBF4PF2PU/iI=;
        b=G4nQtatGcrwTb/d8jh/9IqF/GiZl2G5j0ccKHin/M+lbgS62S12FnKj5yWLw4vN0LS
         cZAt61p6EtilCeznrQoF6d4jYTPkGOKt1nUeGVMbLTjl60OHI47YoUyVILSwLKYviz1G
         5EM7+8YpWiHs9cTZFbka1VQi7o2wPZRna4j/Yu6vEDAGNjBy3dDn28ydelKbSAHKPs+R
         6pXMdgkWlGioTbRmunXdCE03C50T8rauMS58TQGAh8IclrMo/ruE3KxBBRjOROSMMmLy
         uJmuGPOphP7n65DNqd5Sh7Xbe8+tMuLQYNDORRjbU4uTc+TkMiTXVN8C0AL7XHH1o9dA
         1V6g==
X-Gm-Message-State: AOAM530MXiElTejmYpo7v8qL7Q2Rt8tNihMeIslJ3X4E9lXPwHhErAc1
        ReciBZ8h4iVnRKMOI5YCzUo7P3YdY8ImwQ==
X-Google-Smtp-Source: ABdhPJyOIgCy8bTT4F2F5B/dmdOHcoUL5mm7txNmA2slzYvEjfaq7NiBwgcqAqxP7Nw8xddEtE5Xrw==
X-Received: by 2002:aca:da06:: with SMTP id r6mr3091923oig.88.1599727418170;
        Thu, 10 Sep 2020 01:43:38 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id z5sm749795otp.16.2020.09.10.01.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 01:43:37 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id i17so5184172oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:36 -0700 (PDT)
X-Received: by 2002:aca:1209:: with SMTP id 9mr2982017ois.94.1599727416353;
 Thu, 10 Sep 2020 01:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200518174011.15543-1-ezequiel@collabora.com>
 <20200518174011.15543-3-ezequiel@collabora.com> <CAPBb6MXezNVxPrJ05mpS1=yE8V81DjeQ2gA4pGfC8QQzgfUi8A@mail.gmail.com>
In-Reply-To: <CAPBb6MXezNVxPrJ05mpS1=yE8V81DjeQ2gA4pGfC8QQzgfUi8A@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 10 Sep 2020 17:43:24 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVqq-3JLBe9k5WtYL-LHmXYwj7HFt8tAVLNnuqKJA0p9Q@mail.gmail.com>
Message-ID: <CAPBb6MVqq-3JLBe9k5WtYL-LHmXYwj7HFt8tAVLNnuqKJA0p9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] media: uapi: Add VP9 stateless decoder controls
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:04 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> Hi Ezequiel, sorry for the late review!
>
> On Tue, May 19, 2020 at 2:40 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> >
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > Add the VP9 stateless decoder controls plus the documentation that goes
> > with it.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > ---
> >  .../userspace-api/media/v4l/biblio.rst        |  10 +
> >  .../media/v4l/ext-ctrls-codec.rst             | 550 ++++++++++++++++++
> >  drivers/media/v4l2-core/v4l2-ctrls.c          | 239 ++++++++
> >  drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
> >  include/media/v4l2-ctrls.h                    |   1 +
> >  include/media/vp9-ctrls.h                     | 485 +++++++++++++++

Also another thing I missed: shouldn't the new pointer controls be
added to union v4l2_ctrl_ptr in v4l2-ctrls.h?
