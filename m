Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD27C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D50220714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dumtdY0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgG0SKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgG0SKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:10:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D671BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:10:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o10so3152193edh.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n4QxOm62T7cLBVumNmkxBcX70WS+ZyLV/uGeaA5Yi0I=;
        b=dumtdY0VczqQ+QU6R96PDWCDuvnG1h/EJf1eTVn/O7/cMDaPpwJQvx9cc9LSm3YIzu
         OIQ7k2Z5xfyGXJMIxqjaV1eT/3eYIK7NMC4RCpiycEE0LNebpVExO9dhqVy1XRlmDNUw
         N3nxV0RTtOjNMa7GFQ3ggM/4HbC7D4yh20LNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n4QxOm62T7cLBVumNmkxBcX70WS+ZyLV/uGeaA5Yi0I=;
        b=AdQfqArRstTpZf/1SOPt4kas8BfA8eTev6atdcOBhdRVWEE3JTXPOmU5ZK+J5mXTv7
         ur1DOA5neTFbYlzd/EFlJVeG7WAn9ivBWAB45WQckUvdhLogGrkKK+hnN9UcI2op3AeO
         sKHmPOQWvUMVVm7WiDSU68HhOCJnNDqpB1rRFBD/YCMM2W++9dj4h4M/3rK9G2vu/dIK
         SBMrMYpjiZ3v4W8wLat1+CaqbRXl/5A6RVWT2FixJXzcnlPtLgd2tNJcxQ0NY9ytz7v0
         5emZuNZUv7F/r5bR2Qs3vZ0Bos8DW0QwPHNKcuupTxE4PC4PBbWgv8xfohqPX01KfvIK
         5JPA==
X-Gm-Message-State: AOAM531W/OvZpBoeESCf9tZfsPTPos9eh4E16E3lTC15EVUaVtN/Polb
        mZM2uRqnlp7Gmprpcmw246FmM0W0sLntjg==
X-Google-Smtp-Source: ABdhPJwB4fjK3XuWTNwyeh36JL645AvoKNK+oJGa4lZrUYQ/2dVFsqE05Kh2+/x4CxhZ10R2Hj5b3Q==
X-Received: by 2002:a50:e60d:: with SMTP id y13mr21927481edm.225.1595873416012;
        Mon, 27 Jul 2020 11:10:16 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id qc23sm5439137ejb.97.2020.07.27.11.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:10:15 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id a5so5830149wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:10:14 -0700 (PDT)
X-Received: by 2002:adf:fe12:: with SMTP id n18mr21409892wrr.295.1595873414404;
 Mon, 27 Jul 2020 11:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200715202233.185680-1-ezequiel@collabora.com>
 <20200715202233.185680-9-ezequiel@collabora.com> <CAPBb6MVMXeTcUfb-98McYCKjh=eM=BTo2dSY=L1c6dv2jHqXcg@mail.gmail.com>
 <636aab0a2be83e751a82a84ac3946afec2c87a17.camel@collabora.com>
 <CAAFQd5DVfroAXRw+OT=EktDtVzRjPZYxnUS8daWQ5=3LLwn=SA@mail.gmail.com> <e49635b95db0e295a85f1be9a3909f7f29495e3a.camel@collabora.com>
In-Reply-To: <e49635b95db0e295a85f1be9a3909f7f29495e3a.camel@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 27 Jul 2020 20:10:01 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AeMcqk1MpWNeh1Vgt2rBOxjFj8Ar7=LLo80e8QKhYn3g@mail.gmail.com>
Message-ID: <CAAFQd5AeMcqk1MpWNeh1Vgt2rBOxjFj8Ar7=LLo80e8QKhYn3g@mail.gmail.com>
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

On Mon, Jul 27, 2020 at 6:18 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> On Mon, 2020-07-27 at 16:52 +0200, Tomasz Figa wrote:
> > On Mon, Jul 27, 2020 at 4:39 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > Hi Alexandre,
> > >
> > > Thanks a lot for the review.
> > >
> > > On Sat, 2020-07-25 at 23:34 +0900, Alexandre Courbot wrote:
> > > > On Thu, Jul 16, 2020 at 5:23 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > > > The H.264 specification requires in its "Slice header semantics"
> > > > > section that the following values shall be the same in all slice headers:
> > > > >
> > > > >   pic_parameter_set_id
> > > > >   frame_num
> > > > >   field_pic_flag
> > > > >   bottom_field_flag
> > > > >   idr_pic_id
> > > > >   pic_order_cnt_lsb
> > > > >   delta_pic_order_cnt_bottom
> > > > >   delta_pic_order_cnt[ 0 ]
> > > > >   delta_pic_order_cnt[ 1 ]
> > > > >   sp_for_switch_flag
> > > > >   slice_group_change_cycle
> > > > >
> > > > > and can therefore be moved to the per-frame decode parameters control.
> > > >
> > > > I am really not a H.264 expert, so this question may not be relevant,
> > >
> > > All questions are welcome. I'm more than happy to discuss this patchset.
> > >
> > > > but are these values specified for every slice header in the
> > > > bitstream, or are they specified only once per frame?
> > > >
> > > > I am asking this because it would certainly make user-space code
> > > > simpler if we could remain as close to the bitstream as possible. If
> > > > these values are specified once per slice, then factorizing them would
> > > > leave user-space with the burden of deciding what to do if they change
> > > > across slices.
> > > >
> > > > Note that this is a double-edged sword, because it is not necessarily
> > > > better to leave the firmware in charge of deciding what to do in such
> > > > a case. :) So hopefully these are only specified once per frame in the
> > > > bitstream, in which case your proposal makes complete sense.
> > >
> > > Frame-based hardwares accelerators such as Hantro and Rockchip VDEC
> > > are doing the slice header parsing themselves. Therefore, the
> > > driver is not really parsing these fields on each slice header.
> > >
> > > Currently, we are already using only the first slice in a frame,
> > > as you can see from:
> > >
> > >         if (slices[0].flags & V4L2_H264_SLICE_FLAG_FIELD_PIC)
> > >                 reg |= G1_REG_DEC_CTRL0_PIC_FIELDMODE_E;
> > >
> > > Even if these fields are transported in the slice header,
> > > I think it makes sense for us to split them into the decode params
> > > (per-frame) control.
> > >
> > > They are really specified to be the same across all slices,
> > > so even I'd say if a bitstream violates this, it's likely
> > > either a corrupted bitstream or an encoder bug.
> > >
> > > OTOH, one thing this makes me realize is that the slice params control
> > > is wrongly specified as an array.
> >
> > It is _not_.
> >
>
> We introduced the hold capture buffer specifically to support
> this without having a slice array.
>
> I don't think we have a plan to support this control properly
> as an array.
>
> If we decide to support the slice control as an array,
> we would have to implement a mechanism to specify the array size,
> which we currently don't have AFAIK.
>

That wasn't the conclusion when we discussed this last time on IRC.
+Nicolas Dufresne

Currently the 1-slice per buffer model is quite impractical:
1) the maximum number of buffers is 32, which for some streams can be
less than needed to queue a single frame,
2) even more system call overhead due to the need to repeat various
operations (e.g. qbuf/dqbuf) per-slice rather than per-frame,
3) no way to do hardware batching for hardware which supports queuing
multiple slices at a time,
4) waste of memory - one needs to allocate all the OUTPUT buffers
pessimistically to accommodate the biggest possible slice, while with
all-slices-per-frame 1 buffer could be just heuristically allocated to
be enough for the whole frame.

These need to be carefully evaluated, with some proper testing done to
confirm whether they are really a problem or not.

> > > Namely, this text
> > > should be removed:
> > >
> > >        This structure is expected to be passed as an array, with one
> > >        entry for each slice included in the bitstream buffer.
> > >
> > > As the API is really not defined that way.
> > >
> > > I'll remove that on next iteration.
> >
> > The v4l2_ctrl_h264_slice_params struct has more data than those that
> > are deemed to be the same across all the slices. A remarkable example
> > are the size and start_byte_offset fields.
>
> Not sure how this applies to this discussion.

These fields need to be specified for each slice in the buffer to make
it possible to handle multiple slices per buffer.

Best regards,
Tomasz
