Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6508AC10F26
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3316120728
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Itx8zTMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgCFHum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:50:42 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32987 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCFHul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:50:41 -0500
Received: by mail-oi1-f196.google.com with SMTP id q81so1710728oig.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfizMw1gHVA8a7jX1bd/CXPHIWKldysCQst/gnWycr8=;
        b=Itx8zTMHDoK8AjiybikbLdiHz8Vvg1UQLtLAGL2M6I+odVJdygPQZAjTo/t4/2bcwq
         8B+3+RRuU4ENd8vccI+es9b2I/w5xdt+MJKCC3GhT36uutXgK6V1NnO/megAFZU5kSkQ
         fF2Vs97DcP/btA3YpMZbMyMgdtbhLFa0WyfjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfizMw1gHVA8a7jX1bd/CXPHIWKldysCQst/gnWycr8=;
        b=iEAW/x4n1Ei+YT+ToPTa0eVo4zVCcCX4ZUQFU4/pL20+XRXuaQQCtmrxKwwxqFTtQI
         abHa/GVrGGsITJ5mrhOk+gYojTFhuUd+B7rNqt1ikr/uqwARU38XSzQ92WmbGDvF9a6g
         KI9LzHfG9G8RgUx50HXZ3RzThiEUCfT09zUQUp0gTUHBZXzlsL3VXZ6oROOmETqvRI+q
         0AHOodzzZgbowRaOjqSh/6QfkErSg1HIF3sB/ICepUFfZ2dyWCTdtYa4tbe1PP+FQTNw
         cspWZKXfwuiCuiIa5bNKbPnpdNygKmIBIu7hlb9CQqXhOu9bbfwS6CvqWCqc4kyi7OM9
         9qmg==
X-Gm-Message-State: ANhLgQ3pfZkWWRPDc6msy46GMgEtxn9vFz5p1EZ1ROGkJkaz8QezuFYI
        1V2JyvNqsZHryT9b+FRr4LNuRr1yzD8=
X-Google-Smtp-Source: ADFU+vsQp6lt4YFeF/d/jMZt/hD/YwpYGyx0dpGRBQ4dVkRXnSKDJvr+MFkbItYglO48IvwaoRijoQ==
X-Received: by 2002:aca:57ce:: with SMTP id l197mr1733959oib.76.1583481039407;
        Thu, 05 Mar 2020 23:50:39 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id v1sm8212439ota.48.2020.03.05.23.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 23:50:38 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id v22so1526610otq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:50:38 -0800 (PST)
X-Received: by 2002:a05:6830:2105:: with SMTP id i5mr1419255otc.141.1583481037437;
 Thu, 05 Mar 2020 23:50:37 -0800 (PST)
MIME-Version: 1.0
References: <1583472756-7611-1-git-send-email-mansur@codeaurora.org>
In-Reply-To: <1583472756-7611-1-git-send-email-mansur@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 6 Mar 2020 16:50:25 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW-zxK+=HHUP5=+pO4Mswkhm=hDX7V56ABDm+BCzDaGHg@mail.gmail.com>
Message-ID: <CAPBb6MW-zxK+=HHUP5=+pO4Mswkhm=hDX7V56ABDm+BCzDaGHg@mail.gmail.com>
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

On Fri, Mar 6, 2020 at 2:34 PM Mansur Alisha Shaik
<mansur@codeaurora.org> wrote:
>
> This change will avoid extra locking in driver.

Could you elaborate a bit more on the problem that this patch solves?

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

From the patch I'd infer that inst->clk_data.codec_freq_data needs to
change at runtime. Is this what happens? Why? I'd expect that
frequency tables remain constant, and thus that the global
sdm845_codec_freq_data can remain constant while
clock_data::codec_freq_data is a const reference to it. What prevents
this from happening?

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
