Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9BAC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457A72464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzGjtdrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCIVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:20:04 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42089 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCIVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:20:03 -0400
Received: by mail-yw1-f66.google.com with SMTP id v138so11638481ywa.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbdPktGGdhSa0fdAltZGMNjLk0feQx2/0Wzgw4gLSJ0=;
        b=vzGjtdrImJJq1vkc6W31Pey18zIS7hxBMoHk1Gtg3sQy9b55uMGT6CycSIHlZuQLNk
         QpJ5EHvr1BSKZQtMbKWO5KPTa4+ZZsV1byLQIZdnU7veoTiMWyBHa4z+dfdaQvo0kXXX
         w0akyXnEzOD7PFPy8pufrAK0quaVQ4vzn5sr6VI2ZGIu0svHtrZzdI3omEBLZnyi+f3s
         /vEeBPfrRs3A4xYd0FwAoUJp977ZFxisEbhNf17s6mj8PUFqTkZrsObqty3hbWalgj52
         t+7OYVo2J3/9uI/gRUIpCBQWuugpLZc8DqeX2oJFbISwHFHstzV7lblDUv0hW8pc9SoW
         lKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbdPktGGdhSa0fdAltZGMNjLk0feQx2/0Wzgw4gLSJ0=;
        b=LhyiARLFvDJiaH/o6TlzLxips3l0vYbvmlNBVbGWIdPIpFkcE4Zw8L1uH5a4c+qNk4
         dwkgnHqMqqn8m1yGZuzs+mPs6/jgaucUoA1ASddMhP/HlCKTwTbnkXQ1vdIhCROyslWh
         lhjEwvtd3Ol3NOWAUaNG0WKAmT9H/awyUoUfYcYuTYAI9UgJPwrd57HsFnQ+ms/Sa/lK
         5lZCaAodSEk6vJLL+G+TUUJx2d6US/0ndF4pymqigXeBr7x+IHxqJBfDSNhEWoly9rw+
         aKSL0GeGv2wiiM6sb2hTIDzbAMvd9cFHqx07SSGKsFtwb4isC7MsW+TLex78L5sv0SdJ
         SGTA==
X-Gm-Message-State: ANhLgQ3Aln3ASpptLSuZ/HvnJZTOiDF0FxfYPwzr22rvzU+AKogSq7rj
        VJs3b3Ue+3uKDeRMO/65hXZjUchg2gw54Ne02qfd
X-Google-Smtp-Source: ADFU+vuS2ei1/C80RpZzwWQjQTqIjynwNBZ+QPy5vXasEbidU7tUyFh4qkppSfdPPZnycOFxArLUmVt89jDHKpWBMcE=
X-Received: by 2002:a25:aa03:: with SMTP id s3mr18796052ybi.499.1583788800218;
 Mon, 09 Mar 2020 14:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200306002321.3344-1-jkardatzke@google.com> <892a0548-df6d-a4db-921f-7f4cfd69dc06@linaro.org>
 <CA+ddPcPg_LrxdgxhOjrzkkBBawWoP0+6ijBx6CSy+CpQtP6vbQ@mail.gmail.com> <7edd7feb-80d2-de8b-44cd-84ee63201ab5@linaro.org>
In-Reply-To: <7edd7feb-80d2-de8b-44cd-84ee63201ab5@linaro.org>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Mon, 9 Mar 2020 14:19:48 -0700
Message-ID: <CA+ddPcNr7e8-+sCWQFHeFj=j3fr-KSCPYxYMCGzE+_VR78SZwg@mail.gmail.com>
Subject: Re: [PATCH] media: venus: fix use after free for registeredbufs
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 7, 2020 at 9:24 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Jeff,
>
> On 3/6/20 10:10 PM, Jeffrey Kardatzke wrote:
> > On Fri, Mar 6, 2020 at 1:03 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> Hi Jeff,
> >>
> >> Thanks for the patch!
> >>
> >> On 3/6/20 2:23 AM, Jeffrey Kardatzke wrote:
> >>> In dynamic bufmode we do not manage the buffers in the registeredbufs
> >>> list, so do not add them there when they are initialized. Adding them
> >>> there was causing a use after free of the list_head struct in the buffer
> >>> when new buffers were allocated after existing buffers were freed.
> >>
> >> Is this fixing a real issue? How you come to it?
> >>
> > In our code we were allocating 64x64 capture queue buffers initially,
> > then got a resolution change event for the actual video resolution of
> > 320x256 so we freed all the existing capture buffers and allocated new
> > ones. I had noticed memory poisoning warnings in dmesg and tracked it
> > down to the patch I created here. This is only a problem when the
> > capture queue has its buffers freed and reallocated (which would
> > happen during any resolution change).
>
> Do you call STREAMOFF(CAPTURE) ?
>

Yes, we call STREAMOFF before we destroy the existing buffers and
allocate new ones.

> Better, could you share v4l2 debug logs:
>
> echo 0x3f > /sys/class/video4linux/videoX/dev_debug
>

I'll email you these off list since they are rather large.

> >
> >>>
> >>> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> >>> ---
> >>>  drivers/media/platform/qcom/venus/helpers.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> >>> index bcc603804041..688a3593b49b 100644
> >>> --- a/drivers/media/platform/qcom/venus/helpers.c
> >>> +++ b/drivers/media/platform/qcom/venus/helpers.c
> >>> @@ -1054,8 +1054,10 @@ int venus_helper_vb2_buf_init(struct vb2_buffer *vb)
> >>>       buf->size = vb2_plane_size(vb, 0);
> >>>       buf->dma_addr = sg_dma_address(sgt->sgl);
> >>>
> >>> -     if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> >>> +     if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
> >>> +         !is_dynamic_bufmode(inst)) {
> >>
> >> If you add !is_dynamic_bufmode here, we will loose the reference frames
> >> mechanism (see venus_helper_release_buf_ref()) which is not good.
> >
> > In my testing, I never see venus_helper_release_buf_ref called.  I
> > think something is wrong with reference frame management. I'm also
>
> The mechanism is valid for Venus v1 and v3, might be you tried on v4
> where we have a set of DPB buffers and use them for reference frames.
>

We are using V4.

> > seeing failure in my tests that very much look like reference frames
> > that were dropped in the decoder (with or without my patch); but they
> > are not consistent.
> >
> >>
> >> Thus, I wonder (depending on when you observe the use-after-free issue)
> >> does this is the correct resolution of the problem.
> >
> > I agree this is likely not the right solution to the problem, there's
> > something deeper that's wrong I think because I never see events
> > coming back from hfi with the release buffer reference event.
> >>
> >>>               list_add_tail(&buf->reg_list, &inst->registeredbufs);
> >>> +     }
> >>>
> >>>       return 0;
> >>>  }
> >>>
> >>
> >> --
> >> regards,
> >> Stan
>
> --
> regards,
> Stan
