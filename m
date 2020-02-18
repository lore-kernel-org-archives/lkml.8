Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D5C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA9424125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiWhYhgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBRTOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:14:41 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33145 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgBRTOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:14:41 -0500
Received: by mail-yb1-f193.google.com with SMTP id b6so11052005ybr.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qbRzATD5sutq255fFLobWusPpsD5IFD+RDlh/TSP+8=;
        b=fiWhYhgk4RtwbMq3KgO6gqJ2qrLgUGu7m+wU2iXAKzo20Rhwm6g1Op9pLPveUsreKx
         Oe2ojtXrLbpSbzVGc5Olv1G81NlmsoBWaM+WODjhQ6m1UvLufgf9Sf6SVXIU35fbYKVo
         MWwY3KEfyoPgIxosNupieMeUQtcwzsSWFffNzW0MpiTJEIeD4uYJ17s0bZOCijRKsVR0
         zQipaWpECsphgF2VH1q/5M7tLzynZsQsgr3YT2vAfNMBvzdiNT6kfg0Y3Doe/mK/h4+s
         5la2+xesRXuj/xohkDHnqPeuEY3FCb7tgNw/jlNvtkluZa12kzeKNU5MxzRXzRYIOuTP
         STqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qbRzATD5sutq255fFLobWusPpsD5IFD+RDlh/TSP+8=;
        b=WHuSyfEUcsJnaR2SS5h1f0hJnOzF83jjSpK0MD962plzOwaInE08LILhZo+KAuPHLz
         opnA1CkQloJODrgunkFnqH791r6Si6G9tD1tOJBsotoinLx8HT7UbCl9ZbxKZQsomZ2i
         Kydgrpw1/00AUI/iHnx4UNsJzkZGtZdomcdE+nB4o+Kc8GF7IOXyJ4tIIia0p0Rs1eDk
         PKGUQC1YYZ3DGP3GdsVlFazQUzAJPFp8fGorVvmnSFL9FDwE5zefVgcASnS1JcOGS989
         bREfFIKdOTRaAULjl1Dfulj4tddr3lglIMIvQ2/+VtYgBsXmraZuQE+OOEogVG/jMnb0
         khoQ==
X-Gm-Message-State: APjAAAVqu1UWRp5TudlgTdo6IYrWN5pjMssbVDK3T2AHsDwvJiriCWpK
        Iz1WjVfpxXwADpuwVGJ0/iiQW/lnPvQJ+wOnQbOy
X-Google-Smtp-Source: APXvYqzpS0jkMP8BPPQQdEQn15MFM3qm6i8U6VUqn84Rd/lSlr+NzyFYGes7UtJnf5ax1Li9ysJHS/H/w4nYlDEPDjE=
X-Received: by 2002:a25:d48b:: with SMTP id m133mr19705282ybf.499.1582053279851;
 Tue, 18 Feb 2020 11:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20200218184220.139656-1-jkardatzke@google.com>
In-Reply-To: <20200218184220.139656-1-jkardatzke@google.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Tue, 18 Feb 2020 11:14:28 -0800
Message-ID: <CA+ddPcOMpiHU=2bumCe93NzLe-uO04TnhCS+5CDDU4GyLXYCNA@mail.gmail.com>
Subject: Re: [PATCH v3] media: venus: add support for selection rectangles
To:     linux-media@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(again, sorry for duplicate to some people, didn't know the plain text
email rule before)
There were a few comments made when this patch was originally posted
that were not addressed.  I left the patch as it last stood, except
for removing the unused variables.

The outstanding comments were:
1. In venc_init_session, it is only using the inst->width/height
rectangles and not the inst->out_width/out_height rectangles. So there
was a question about whether the OUTUPT rectangle should be set to
out_width/out_height. I'm looking for feedback here as I'm not
familiar enough with this driver code yet.
2. We should return EBUSY if the selection rectangles are changed
after we are initialized (I will update it to do this)
3. Support for non-zero top/left parameters. I'm suspicious that the
HFI_INDEX_EXTRADATA_INPUT_CROP property is what should be used for
that, but it's not currently used anywhere. Does anybody have details
on if that's what it's for?


On Tue, Feb 18, 2020 at 10:42 AM Jeffrey Kardatzke
<jkardatzke@google.com> wrote:
>
> From: Malathi Gottam <>
>
> Handles target type crop by setting the new active rectangle
> to hardware. The new rectangle should be within YUV size.
>
> This was taken from: https://lkml.org/lkml/2018/11/9/899
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 453edf966d4f..73b3181eed9a 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -479,10 +479,26 @@ venc_s_selection(struct file *file, void *fh, struct v4l2_selection *s)
>
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP:
> -               if (s->r.width != inst->out_width ||
> -                   s->r.height != inst->out_height ||
> -                   s->r.top != 0 || s->r.left != 0)
> -                       return -EINVAL;
> +               if (s->r.left != 0) {
> +                       s->r.width += s->r.left;
> +                       s->r.left = 0;
> +               }
> +
> +               if (s->r.top != 0) {
> +                       s->r.height += s->r.top;
> +                       s->r.top = 0;
> +               }
> +
> +               if (s->r.width > inst->width)
> +                       s->r.width = inst->width;
> +               else
> +                       inst->width = s->r.width;
> +
> +               if (s->r.height > inst->height)
> +                       s->r.height = inst->height;
> +               else
> +                       inst->height = s->r.height;
> +
>                 break;
>         default:
>                 return -EINVAL;
> --
> 2.25.0.265.gbab2e86ba0-goog
>
