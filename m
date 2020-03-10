Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDC3C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63D321D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeDDa56L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCJTPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:15:55 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35168 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:15:55 -0400
Received: by mail-yw1-f67.google.com with SMTP id d79so13690053ywd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F5xmRnw3iFC1oYda1NXpjCom9qoXD1COhPg6AM6oC5Q=;
        b=OeDDa56LbrtZ/iuivK2RqEIuLiTlJkW8pxn0ko+UwBKoMOesqJQ6PVlyw9Rbh75ToK
         hHO+ME6MBDP/9/NjNg59gW9shlb+NJhSBMFYNsNQTiA+JsFCkhoxAvAv/0y1gSYgxU3t
         XPAHu5KNKXGzg/gh4Of+Tw/vfjeiesIHGiLWnTEcnERYTn7w/QYg5FL86aRvCVrjUHE6
         4x/arrxqf30CurWvr0Wi6szAz3eyILZfzmTv/2j9NUYYWg/KoWx8tbxTCHry4uELw3cm
         wic8fRrJlj6kTpB3MPT9nQUqGEyXtLF+hlWMnSg/vVkek0QLG/B0d6osg/Sz3og2wCmI
         637g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F5xmRnw3iFC1oYda1NXpjCom9qoXD1COhPg6AM6oC5Q=;
        b=PDLYQqjNsbjpr/ggDyCGnyGzvYxsuv84Epo7lCE9VRYksjv69MXeMyZTbMY4cGhGGX
         d9zxGaHt/vRS8XnOJ/oZUVT+wLLp9iqw5iftyccv0oElcNpxekpz2xWyrUD+FCLcn7IX
         Wqfx0e4+5NbFMK8n/LIHx2vTLiznlZP/OUhvO5ZuuR/fo7BPWmFzxVWQCvf5cK7RfQV5
         mhXbWKqhBBhvz+bPtD0eUoYqMWs5cnEk5BrdDoXeXFs7FL5tTpdFpxeo8k6wKHfy7002
         5lJOairrxA9AbDYU1KFlSUrOxTlV4+VE0PTF6xvd8FQzO1CfQVcj3IY9zdQiQAo4/aNe
         /uhg==
X-Gm-Message-State: ANhLgQ2/7b6PhyRJC//PoXcKTskxFRo5fJpj2Us4sME8IP3ixyYYv9jx
        vZu7v2EULf7eAQkYpOkcMXEfzbM/QLstVeeGXLAj
X-Google-Smtp-Source: ADFU+vsLObp+bwFbBCad7Abx+63o7qwR2TV/gkRJyhjDyyj9TQYojni7W2FH9WCmT9d5rkwFCM3keOU+MV575rYAsL8=
X-Received: by 2002:a81:85c1:: with SMTP id v184mr21039832ywf.53.1583867752301;
 Tue, 10 Mar 2020 12:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <1583472756-7611-1-git-send-email-mansur@codeaurora.org>
In-Reply-To: <1583472756-7611-1-git-send-email-mansur@codeaurora.org>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Tue, 10 Mar 2020 12:15:40 -0700
Message-ID: <CA+ddPcMPOWcnTkauDE7AmnfsyUu4psY343QTZR0WhS8QCEY2cg@mail.gmail.com>
Subject: Re: [PATCH] venus: avoid extra locking in driver
To:     Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Jeffrey Kardatzke <jkardatzke@google.com>

On Thu, Mar 5, 2020 at 9:34 PM Mansur Alisha Shaik
<mansur@codeaurora.org> wrote:
>
> This change will avoid extra locking in driver.
>
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  2 +-
>  drivers/media/platform/qcom/venus/core.h       |  2 +-
>  drivers/media/platform/qcom/venus/helpers.c    | 11 +++++++++--
>  drivers/media/platform/qcom/venus/pm_helpers.c |  8 ++++----
>  4 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 194b10b9..75d38b8 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -447,7 +447,7 @@ static const struct freq_tbl sdm845_freq_table[] = {
>         {  244800, 100000000 }, /* 1920x1080@30 */
>  };
>
> -static struct codec_freq_data sdm845_codec_freq_data[] =  {
> +static const struct codec_freq_data sdm845_codec_freq_data[] =  {
>         { V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
>         { V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
>         { V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index ab7c360..8c8d0e9 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -245,7 +245,7 @@ struct venus_buffer {
>  struct clock_data {
>         u32 core_id;
>         unsigned long freq;
> -       const struct codec_freq_data *codec_freq_data;
> +       struct codec_freq_data codec_freq_data;
>  };
>
>  #define to_venus_buffer(ptr)   container_of(ptr, struct venus_buffer, vb)
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index bcc6038..550c4ff 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -807,6 +807,7 @@ int venus_helper_init_codec_freq_data(struct venus_inst *inst)
>         unsigned int i, data_size;
>         u32 pixfmt;
>         int ret = 0;
> +       bool found = false;
>
>         if (!IS_V4(inst->core))
>                 return 0;
> @@ -816,16 +817,22 @@ int venus_helper_init_codec_freq_data(struct venus_inst *inst)
>         pixfmt = inst->session_type == VIDC_SESSION_TYPE_DEC ?
>                         inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
>
> +       memset(&inst->clk_data.codec_freq_data, 0,
> +               sizeof(inst->clk_data.codec_freq_data));
> +
>         for (i = 0; i < data_size; i++) {
>                 if (data[i].pixfmt == pixfmt &&
>                     data[i].session_type == inst->session_type) {
> -                       inst->clk_data.codec_freq_data = &data[i];
> +                       inst->clk_data.codec_freq_data = data[i];
> +                       found = true;
>                         break;
>                 }
>         }
>
> -       if (!inst->clk_data.codec_freq_data)
> +       if (!found) {
> +               dev_err(inst->core->dev, "cannot find codec freq data\n");
>                 ret = -EINVAL;
> +       }
>
>         return ret;
>  }
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index abf9315..240845e 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -496,7 +496,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load)
>         list_for_each_entry(inst_pos, &core->instances, list) {
>                 if (inst_pos == inst)
>                         continue;
> -               vpp_freq = inst_pos->clk_data.codec_freq_data->vpp_freq;
> +               vpp_freq = inst_pos->clk_data.codec_freq_data.vpp_freq;
>                 coreid = inst_pos->clk_data.core_id;
>
>                 mbs_per_sec = load_per_instance(inst_pos);
> @@ -545,7 +545,7 @@ static int decide_core(struct venus_inst *inst)
>                 return 0;
>
>         inst_load = load_per_instance(inst);
> -       inst_load *= inst->clk_data.codec_freq_data->vpp_freq;
> +       inst_load *= inst->clk_data.codec_freq_data.vpp_freq;
>         max_freq = core->res->freq_tbl[0].freq;
>
>         min_loaded_core(inst, &min_coreid, &min_load);
> @@ -848,10 +848,10 @@ static unsigned long calculate_inst_freq(struct venus_inst *inst,
>
>         mbs_per_sec = load_per_instance(inst) / fps;
>
> -       vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
> +       vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data.vpp_freq;
>         /* 21 / 20 is overhead factor */
>         vpp_freq += vpp_freq / 20;
> -       vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vsp_freq;
> +       vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data.vsp_freq;
>
>         /* 10 / 7 is overhead factor */
>         if (inst->session_type == VIDC_SESSION_TYPE_ENC)
> --
> 2.7.4
>


-- 
Jeffrey Kardatzke
jkardatzke@google.com
Google, Inc.
