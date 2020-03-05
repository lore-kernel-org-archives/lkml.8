Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBD1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579C6207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxLqPg8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCET13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:27:29 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44425 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCET12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:27:28 -0500
Received: by mail-yw1-f67.google.com with SMTP id t141so6724738ywc.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 11:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcnY2pXvSaUXrKHRgMfKU75O0N02hAFvAYZPxEFfObk=;
        b=KxLqPg8zA4O+0XO28WNM77hDGtn9Vyai2zojVtcCE3PXfwpJXPwvhVcrAP7R8EX0/D
         2Bgs6dsB9ojO539AVzN4MNGpkhTd5kypHdVHMacYDmPmCPrR7DWLtHlgVUMaR+V/BK2Q
         +alGd2WGLFt2uCnXs+s4Wg/0ZD7bkGEJBcaZqiMJQPMcdDq2FrUq0R5y7LHaFchZvHSu
         BtSPU3VfSSieFSDIjmwzW5lbOzHr3ywxhIwOQN1xYdtakfZMli5DfQIPSqATo9Wp1YsV
         HCG5pTxUmXf7/KT6Slc4sWuxRpBbG70LynwPDiYienB8rF4hC7wyfipmn7lhRd2tS4sI
         JJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcnY2pXvSaUXrKHRgMfKU75O0N02hAFvAYZPxEFfObk=;
        b=rdXtI0Wb80F4maqXiFV80+VNgvMwSSLaq8vD3RM13geFl+AxLVnMzcE5c5ryXvs/cw
         8n1/+8MIE2xmkGTg5OFPn/LOX2YktTdnVksWHTg/fFvS6CreQPMpJ6OmIzh+qhHU9Y38
         EPLkXeZekRKAkm1ipG9LKPMfg9+bdpPkSjwG8rBw8KeqxgGTQKK+PaAzJLtRs+pY5MFF
         NImKSkFDXbRNY+ZF6nW/M3fEVvtvFtwgQ1/tFjY7QujPponKardMUGIzNfsFNuNkUQEw
         NpSDlf6tqhXXh1HBerF+t/gs/qbUaE5rLvnti+/xdJdppRKq2iXHR9fBcS03stD6Jgkl
         BdLQ==
X-Gm-Message-State: ANhLgQ31UAIuaVRJpngJ0ghxxXFGLxmoCophaEVZbVxlWoiWq17gtV0T
        resB9Wus+A8tHV+kXvABta9KR9+Yzya9kMvG3l0d
X-Google-Smtp-Source: ADFU+vsuBfkrSkSv+xYw88xsb6A2EflRXu6TrFSrybgPLkaZhdbDJxnQozmI8u77wTVFITjBYRVLkOJ4mQwPLlVls6w=
X-Received: by 2002:a25:7:: with SMTP id 7mr8961028yba.188.1583436447491; Thu,
 05 Mar 2020 11:27:27 -0800 (PST)
MIME-Version: 1.0
References: <20200222003311.106837-1-jkardatzke@google.com>
In-Reply-To: <20200222003311.106837-1-jkardatzke@google.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Thu, 5 Mar 2020 11:27:14 -0800
Message-ID: <CA+ddPcPtxK91FJJSYMcVyK0RZ7gN83sr5Aetnm+RiFbQv6ED4A@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: support frame rate control
To:     linux-media@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping for any feedback on the updated patch set. Thanks.

On Fri, Feb 21, 2020 at 4:33 PM Jeffrey Kardatzke <jkardatzke@google.com> wrote:
>
> Add encoder control for enabling/disabling frame rate control via
> V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE. It is enabled by default.
>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>  drivers/media/platform/qcom/venus/core.h       | 1 +
>  drivers/media/platform/qcom/venus/venc.c       | 4 +++-
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 8 +++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 11585fb3cae3..2b0649ffbd92 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -187,6 +187,7 @@ struct venc_controls {
>         u32 bitrate_mode;
>         u32 bitrate;
>         u32 bitrate_peak;
> +       u32 rc_enable;
>
>         u32 h264_i_period;
>         u32 h264_entropy_mode;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 453edf966d4f..56079c9d9900 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -731,7 +731,9 @@ static int venc_set_properties(struct venus_inst *inst)
>         if (ret)
>                 return ret;
>
> -       if (ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_VBR)
> +       if (!ctr->rc_enable)
> +               rate_control = HFI_RATE_CONTROL_OFF;
> +       else if (ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_VBR)
>                 rate_control = HFI_RATE_CONTROL_VBR_CFR;
>         else
>                 rate_control = HFI_RATE_CONTROL_CBR_CFR;
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index 877c0b3299e9..0572a00b8380 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -199,6 +199,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>                 }
>                 mutex_unlock(&inst->lock);
>                 break;
> +       case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> +               ctr->rc_enable = ctrl->val;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -214,7 +217,7 @@ int venc_ctrl_init(struct venus_inst *inst)
>  {
>         int ret;
>
> -       ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 30);
> +       ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 31);
>         if (ret)
>                 return ret;
>
> @@ -351,6 +354,9 @@ int venc_ctrl_init(struct venus_inst *inst)
>         v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>                           V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME, 0, 0, 0, 0);
>
> +       v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> +               V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE, 0, 1, 1, 1);
> +
>         ret = inst->ctrl_handler.error;
>         if (ret)
>                 goto err;
> --
> 2.25.0.265.gbab2e86ba0-goog
>


-- 
Jeffrey Kardatzke
jkardatzke@google.com
Google, Inc.
