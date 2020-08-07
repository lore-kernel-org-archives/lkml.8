Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A842FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBDC2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 23:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dv1DEOfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHGXRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGXRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 19:17:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE47C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 16:17:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so2353422edv.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=uEfOm+DIoBJEQPRggKsqD/6K343VADgWw4J5soIp4mA=;
        b=dv1DEOfjuOxASatUB7O3COgLAdZmAgtyeMQhG54fA3/2ZjH9iClolbSINHdcnp/rHF
         JYFmq2+McWsQmT7AC4fDouu6tJ+Dr/S48tTQiuMj5WrOd+pDoWAOMKCkjyuQzCZHix0e
         joB/jrcDY0nyj73Qft4ycQk/jW642GmEK1NAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=uEfOm+DIoBJEQPRggKsqD/6K343VADgWw4J5soIp4mA=;
        b=GfVAQR6dXywEa+GBZ66HTBPKxkG7uUzrntuRNitej1/iaWpWcVbuslgpV6LJjvFF9v
         2Xa76mBIkS2OBwDZZHctcV6ylyNLWhh+DhD81j0luB3LVYJkx8ZQE1N4pRSUhJeH2ZwG
         eKJCISmQIzUuK0k1y4aHov+FbAxC3xF1T9L4koc1NAybJ+6f2ECpa12adMTWUHDxXOeS
         /6bc51UCU0p+yKqTL4ETranONWIufWX2XIBWeAqBdzbI+Og2XrVbWDtLrNsgHNYbKyEs
         OPo/7LOnNtFJNpCrmTO1L44lQFLkuKZ7xz0/bpPOUL0zMcYkErtWbc2UxcBPOkkJeyu5
         KaFQ==
X-Gm-Message-State: AOAM531O0X/h6AOEB8qcoDCZQVa/pLij8s0AICM/08ZHLUgn+/14ldp5
        ULpfUhAM3qIKWEbPPmxwiZ3226l7rwM=
X-Google-Smtp-Source: ABdhPJyrfeJzSjJZ6BROqSdwneuL5Xquxl35dtZyFI4vR8m/qNpFX+EOyp6R8w7FVQzWPcUa6erh7A==
X-Received: by 2002:a05:6402:1c09:: with SMTP id ck9mr4554181edb.74.1596842264372;
        Fri, 07 Aug 2020 16:17:44 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id m24sm6669979eje.80.2020.08.07.16.17.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 16:17:43 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id k20so3235359wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 16:17:43 -0700 (PDT)
X-Received: by 2002:a1c:6446:: with SMTP id y67mt9333958wmb.49.1596842262920;
 Fri, 07 Aug 2020 16:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200804114845.25086-1-user@vgarodia-linux>
In-Reply-To: <20200804114845.25086-1-user@vgarodia-linux>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Fri, 7 Aug 2020 16:17:30 -0700
X-Gmail-Original-Message-ID: <CAMfZQbxE1KAC03_7L1qqkb1gDr12SoO-UFs+UN9jAhQ6dCs0zQ@mail.gmail.com>
Message-ID: <CAMfZQbxE1KAC03_7L1qqkb1gDr12SoO-UFs+UN9jAhQ6dCs0zQ@mail.gmail.com>
Subject: Re: [PATCH] venus: fixes for list corruption
Cc:     linux-media@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, mansur@codeaurora.org,
        Rajeshwar Kurapaty <rkurapat@qti.qualcomm.com>,
        Giri Kapalli <gkapalli@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 5:23 AM Vikash Garodia <"Vikash
Garodia"@qti.qualcomm.com> wrote:
>
> From: Vikash Garodia <vgarodia@codeaurora.org>
>
> There are few list handling issues while adding and deleting
> node in the registered buf list in the driver.
> 1. list addition - buffer added into the list during buf_init
> while not deleted during cleanup.
> 2. list deletion - In capture streamoff, the list was reinitialized.
> As a result, if any node was present in the list, it would
> lead to issue while cleaning up that node during buf_cleanup.
>
> Corresponding call traces below:
> [  165.751014] Call trace:
> [  165.753541]  __list_add_valid+0x58/0x88
> [  165.757532]  venus_helper_vb2_buf_init+0x74/0xa8 [venus_core]
> [  165.763450]  vdec_buf_init+0x34/0xb4 [venus_dec]
> [  165.768271]  __buf_prepare+0x598/0x8a0 [videobuf2_common]
> [  165.773820]  vb2_core_qbuf+0xb4/0x334 [videobuf2_common]
> [  165.779298]  vb2_qbuf+0x78/0xb8 [videobuf2_v4l2]
> [  165.784053]  v4l2_m2m_qbuf+0x80/0xf8 [v4l2_mem2mem]
> [  165.789067]  v4l2_m2m_ioctl_qbuf+0x2c/0x38 [v4l2_mem2mem]
> [  165.794624]  v4l_qbuf+0x48/0x58
>
> [ 1797.556001] Call trace:
> [ 1797.558516]  __list_del_entry_valid+0x88/0x9c
> [ 1797.562989]  vdec_buf_cleanup+0x54/0x228 [venus_dec]
> [ 1797.568088]  __buf_prepare+0x270/0x8a0 [videobuf2_common]
> [ 1797.573625]  vb2_core_qbuf+0xb4/0x338 [videobuf2_common]
> [ 1797.579082]  vb2_qbuf+0x78/0xb8 [videobuf2_v4l2]
> [ 1797.583830]  v4l2_m2m_qbuf+0x80/0xf8 [v4l2_mem2mem]
> [ 1797.588843]  v4l2_m2m_ioctl_qbuf+0x2c/0x38 [v4l2_mem2mem]
> [ 1797.594389]  v4l_qbuf+0x48/0x58
>
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 7c4c483d5438..76be14efbfb0 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1088,8 +1088,6 @@ static int vdec_stop_capture(struct venus_inst *inst)
>                 break;
>         }
>
> -       INIT_LIST_HEAD(&inst->registeredbufs);
> -
>         return ret;
>  }
>
> @@ -1189,6 +1187,14 @@ static int vdec_buf_init(struct vb2_buffer *vb)
>  static void vdec_buf_cleanup(struct vb2_buffer *vb)
>  {
>         struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
> +       struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
> +       struct venus_buffer *buf = to_venus_buffer(vbuf);
> +
> +       mutex_lock(&inst->lock);
> +       if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +               if (!list_empty(&inst->registeredbufs))
> +                       list_del_init(&buf->reg_list);
> +       mutex_unlock(&inst->lock);
>
>         inst->buf_count--;
>         if (!inst->buf_count)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
Reviewed-by: Fritz Koenig <frkoenig@chromium.org>
