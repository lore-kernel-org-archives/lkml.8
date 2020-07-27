Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7964C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C252522CB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hxLR76E4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgG0OxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgG0OxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:53:05 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37369C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:53:05 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id di22so5184224edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DMgN5tZMxqYrW7jQ12rF21saA28TBC0yxDThKi4Y2Xk=;
        b=hxLR76E4N9viPtHqqQtAE8b60wZVrZdsC9t3ff7Tm0CZxzG/syJaZW3kduG89h50wS
         tq6gKpMa4gYp4isW/rKyf+FqFfB0lxcdUASPxgL2r4qRijur9HU0j4xNot3v0YkOX+Pf
         JVNFga9Tzr/K51kVqTwHwtFqZLJDFRnbhVWN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DMgN5tZMxqYrW7jQ12rF21saA28TBC0yxDThKi4Y2Xk=;
        b=GPAiWOGkFoHNUAmUMmGVUnIkYCct2yTvvcNo06sW53giaAWcCFsAtSaPHZYQ4gjdl0
         uP9lxHzwDPIjpR09vnld/D23DsicbvnlJb/3UukFPR/5xAbWpYIucMvUxDqXWDeQm64y
         gwCXzDg4bR2p7sPKHEMYXwU8H8IbcVf7gQrrPWnZfPhrRKJaS48yLWVmsvdP8qvcDSrs
         gxaMwN9iUevoVfYGvK+pDsqBuMRpcQIctVQVWXABcOOkLEuO3KGO6L0bWIhtWb7FFqh2
         M6rnTf1/vAC71h7T0zsl8Rmn9wfmIHrOg3gQPrGEmFWzs/eyWSUKphv8pPkq57KEdZAT
         v7GQ==
X-Gm-Message-State: AOAM530sIZZl7utRzT5I7wn3aI2NaFqPfh+4qtosijcF+aQLZ+4amge7
        S+UZy2ld33onQHC2LLmD5dQsuFqPiibLVA==
X-Google-Smtp-Source: ABdhPJz5ntgoYJ76Jyq/FxV4F0M83mL32yDYbZG3MQKs1wbBmRzlKC55vZP/BxXULcwC6mP5uSrxkw==
X-Received: by 2002:a50:f19c:: with SMTP id x28mr19369236edl.295.1595861583522;
        Mon, 27 Jul 2020 07:53:03 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id k22sm3527437edo.24.2020.07.27.07.53.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:53:02 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id a15so15183588wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:53:02 -0700 (PDT)
X-Received: by 2002:adf:fe12:: with SMTP id n18mr20714835wrr.295.1595861581935;
 Mon, 27 Jul 2020 07:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200715202233.185680-1-ezequiel@collabora.com>
 <20200715202233.185680-9-ezequiel@collabora.com> <CAPBb6MVMXeTcUfb-98McYCKjh=eM=BTo2dSY=L1c6dv2jHqXcg@mail.gmail.com>
 <636aab0a2be83e751a82a84ac3946afec2c87a17.camel@collabora.com>
In-Reply-To: <636aab0a2be83e751a82a84ac3946afec2c87a17.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 27 Jul 2020 16:52:50 +0200
X-Gmail-Original-Message-ID: <CAAFQd5DVfroAXRw+OT=EktDtVzRjPZYxnUS8daWQ5=3LLwn=SA@mail.gmail.com>
Message-ID: <CAAFQd5DVfroAXRw+OT=EktDtVzRjPZYxnUS8daWQ5=3LLwn=SA@mail.gmail.com>
Subject: Re: [PATCH 08/10] media: uapi: h264: Clean slice invariants syntax elements
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 4:39 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Hi Alexandre,
>
> Thanks a lot for the review.
>
> On Sat, 2020-07-25 at 23:34 +0900, Alexandre Courbot wrote:
> > On Thu, Jul 16, 2020 at 5:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > The H.264 specification requires in its "Slice header semantics"
> > > section that the following values shall be the same in all slice headers:
> > >
> > >   pic_parameter_set_id
> > >   frame_num
> > >   field_pic_flag
> > >   bottom_field_flag
> > >   idr_pic_id
> > >   pic_order_cnt_lsb
> > >   delta_pic_order_cnt_bottom
> > >   delta_pic_order_cnt[ 0 ]
> > >   delta_pic_order_cnt[ 1 ]
> > >   sp_for_switch_flag
> > >   slice_group_change_cycle
> > >
> > > and can therefore be moved to the per-frame decode parameters control.
> >
> > I am really not a H.264 expert, so this question may not be relevant,
>
> All questions are welcome. I'm more than happy to discuss this patchset.
>
> > but are these values specified for every slice header in the
> > bitstream, or are they specified only once per frame?
> >
> > I am asking this because it would certainly make user-space code
> > simpler if we could remain as close to the bitstream as possible. If
> > these values are specified once per slice, then factorizing them would
> > leave user-space with the burden of deciding what to do if they change
> > across slices.
> >
> > Note that this is a double-edged sword, because it is not necessarily
> > better to leave the firmware in charge of deciding what to do in such
> > a case. :) So hopefully these are only specified once per frame in the
> > bitstream, in which case your proposal makes complete sense.
>
> Frame-based hardwares accelerators such as Hantro and Rockchip VDEC
> are doing the slice header parsing themselves. Therefore, the
> driver is not really parsing these fields on each slice header.
>
> Currently, we are already using only the first slice in a frame,
> as you can see from:
>
>         if (slices[0].flags & V4L2_H264_SLICE_FLAG_FIELD_PIC)
>                 reg |= G1_REG_DEC_CTRL0_PIC_FIELDMODE_E;
>
> Even if these fields are transported in the slice header,
> I think it makes sense for us to split them into the decode params
> (per-frame) control.
>
> They are really specified to be the same across all slices,
> so even I'd say if a bitstream violates this, it's likely
> either a corrupted bitstream or an encoder bug.
>
> OTOH, one thing this makes me realize is that the slice params control
> is wrongly specified as an array.

It is _not_.

> Namely, this text
> should be removed:
>
>        This structure is expected to be passed as an array, with one
>        entry for each slice included in the bitstream buffer.
>
> As the API is really not defined that way.
>
> I'll remove that on next iteration.

The v4l2_ctrl_h264_slice_params struct has more data than those that
are deemed to be the same across all the slices. A remarkable example
are the size and start_byte_offset fields.
