Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B4C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB242465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzKtLxXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCIWHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:07:25 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36010 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgCIWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:07:24 -0400
Received: by mail-yw1-f66.google.com with SMTP id j71so11810340ywb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2C2IyR8ADVQXo6q1zpX2vt9Gg5duZt3BO1njA9FKss=;
        b=hzKtLxXOYKMEfxDYep/kUlMuXGnaSBQQwbXE0PdylQNjl880YZVe5LQnjdkKWRBeRe
         1krPhRDjkJBW54vBntLvB/5tAcvcz4+j9o2Kqq5WWqJkbr92goEQplWBUtZ6y7+fOfCr
         RNgupV59pQcE5IMLuCkj8vnYNz9cCwS8Z89LQSEzBV+weHY0mPKdyxu9CIQOx3bc1SVT
         o8z5UwdXavYLslQShe+bYedaNiocKz8P2hPQ68OBGxacOuL/mp4rKyYt0boE4Ya0U8+n
         zzIsSrHkQkJ+tgTU18rZn4hZYkkQV/ia4sLAXR4KoZ/IUov85T2zM59XpzLYPiqakz+Q
         DTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2C2IyR8ADVQXo6q1zpX2vt9Gg5duZt3BO1njA9FKss=;
        b=plRdYVyjYoGVzanQqvBq6Llijoa/jmRlIz7gs+CUxMY+SDsbObZtwf5nY6D00MAdu+
         ojQ8hRrTwrkcXs+NhwG77IO7KjtnW9V8KL3LUJLJlDjukEqogR/X27SXrGjZW+5CudN/
         YFKzssV2cK9SBtCZ1/dmVji09zBb+0TN9Tz6WmN5biS52U82gjrI/dPr/dGsw08Zvgpu
         Tp5FlrKcAjN+H8iOV1oPV2oRzN9llVNWHpKDI6H1zYMkjLYu71slL6KlLeem8VvKm+Yf
         pfw4wwjmO5Ef84tdOaduNxLLrp7/6MfIFbsKt3xYWU6HdYAmWDXFeh8oD2aFqb/udlw5
         M8tQ==
X-Gm-Message-State: ANhLgQ3IR0ZMcMiA/JF0eA0Eoj1CtahcByekta7cAJyHPV+tAbBjvhzD
        X9602v9Snoxtui7g48ewuhTfWEs02wtn9+x1HdIyfEc=
X-Google-Smtp-Source: ADFU+vuoelPKbp3P8CWhPi+RqgvmvUoBO9h7BgOIMQhjAKzFvKXLYQa4eBwhg4rbdH3YDsQPttGT9D8NPxUlkVKEdMw=
X-Received: by 2002:a0d:ddc7:: with SMTP id g190mr19393852ywe.147.1583791643313;
 Mon, 09 Mar 2020 15:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <1583472756-7611-1-git-send-email-mansur@codeaurora.org> <CAPBb6MW-zxK+=HHUP5=+pO4Mswkhm=hDX7V56ABDm+BCzDaGHg@mail.gmail.com>
In-Reply-To: <CAPBb6MW-zxK+=HHUP5=+pO4Mswkhm=hDX7V56ABDm+BCzDaGHg@mail.gmail.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Mon, 9 Mar 2020 15:07:11 -0700
Message-ID: <CA+ddPcNdC4r3XBd+dQmv2oHwF6MA3bTJrWZZpJthruBQR_THBA@mail.gmail.com>
Subject: Re: [PATCH] venus: avoid extra locking in driver
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 11:50 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> On Fri, Mar 6, 2020 at 2:34 PM Mansur Alisha Shaik
> <mansur@codeaurora.org> wrote:
> >
> > This change will avoid extra locking in driver.
>
> Could you elaborate a bit more on the problem that this patch solves?

For us it fixes a kernel null deref that happens when we run the
MultipleEncoders test (I've verified this to be true).

>
> >
> > Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> > ---
> >  drivers/media/platform/qcom/venus/core.c       |  2 +-
> >  drivers/media/platform/qcom/venus/core.h       |  2 +-
> >  drivers/media/platform/qcom/venus/helpers.c    | 11 +++++++++--
> >  drivers/media/platform/qcom/venus/pm_helpers.c |  8 ++++----
> >  4 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> > index 194b10b9..75d38b8 100644
> > --- a/drivers/media/platform/qcom/venus/core.c
> > +++ b/drivers/media/platform/qcom/venus/core.c
> > @@ -447,7 +447,7 @@ static const struct freq_tbl sdm845_freq_table[] = {
> >         {  244800, 100000000 }, /* 1920x1080@30 */
> >  };
> >
> > -static struct codec_freq_data sdm845_codec_freq_data[] =  {
> > +static const struct codec_freq_data sdm845_codec_freq_data[] =  {
> >         { V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
> >         { V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
> >         { V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > index ab7c360..8c8d0e9 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -245,7 +245,7 @@ struct venus_buffer {
> >  struct clock_data {
> >         u32 core_id;
> >         unsigned long freq;
> > -       const struct codec_freq_data *codec_freq_data;
> > +       struct codec_freq_data codec_freq_data;
> >  };
> >
> >  #define to_venus_buffer(ptr)   container_of(ptr, struct venus_buffer, vb)
> > diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> > index bcc6038..550c4ff 100644
> > --- a/drivers/media/platform/qcom/venus/helpers.c
> > +++ b/drivers/media/platform/qcom/venus/helpers.c
> > @@ -807,6 +807,7 @@ int venus_helper_init_codec_freq_data(struct venus_inst *inst)
> >         unsigned int i, data_size;
> >         u32 pixfmt;
> >         int ret = 0;
> > +       bool found = false;
> >
> >         if (!IS_V4(inst->core))
> >                 return 0;
> > @@ -816,16 +817,22 @@ int venus_helper_init_codec_freq_data(struct venus_inst *inst)
> >         pixfmt = inst->session_type == VIDC_SESSION_TYPE_DEC ?
> >                         inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
> >
> > +       memset(&inst->clk_data.codec_freq_data, 0,
> > +               sizeof(inst->clk_data.codec_freq_data));
> > +
> >         for (i = 0; i < data_size; i++) {
> >                 if (data[i].pixfmt == pixfmt &&
> >                     data[i].session_type == inst->session_type) {
> > -                       inst->clk_data.codec_freq_data = &data[i];
> > +                       inst->clk_data.codec_freq_data = data[i];
>
> From the patch I'd infer that inst->clk_data.codec_freq_data needs to
> change at runtime. Is this what happens? Why? I'd expect that
> frequency tables remain constant, and thus that the global
> sdm845_codec_freq_data can remain constant while
> clock_data::codec_freq_data is a const reference to it. What prevents
> this from happening?
>
> > +                       found = true;
> >                         break;
> >                 }
> >         }
> >
> > -       if (!inst->clk_data.codec_freq_data)
> > +       if (!found) {
> > +               dev_err(inst->core->dev, "cannot find codec freq data\n");
> >                 ret = -EINVAL;
> > +       }
> >
> >         return ret;
> >  }
> > diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> > index abf9315..240845e 100644
> > --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> > +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> > @@ -496,7 +496,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load)
> >         list_for_each_entry(inst_pos, &core->instances, list) {
> >                 if (inst_pos == inst)
> >                         continue;
> > -               vpp_freq = inst_pos->clk_data.codec_freq_data->vpp_freq;
> > +               vpp_freq = inst_pos->clk_data.codec_freq_data.vpp_freq;

This is the main thing it fixes (this is where the null deref occurs).
If there's multiple instances in use and the other instance hasn't
populated the codec_freq_data pointer then we'll hit a null deref
here.

> >                 coreid = inst_pos->clk_data.core_id;
> >
> >                 mbs_per_sec = load_per_instance(inst_pos);
> > @@ -545,7 +545,7 @@ static int decide_core(struct venus_inst *inst)
> >                 return 0;
> >
> >         inst_load = load_per_instance(inst);
> > -       inst_load *= inst->clk_data.codec_freq_data->vpp_freq;
> > +       inst_load *= inst->clk_data.codec_freq_data.vpp_freq;
> >         max_freq = core->res->freq_tbl[0].freq;
> >
> >         min_loaded_core(inst, &min_coreid, &min_load);
> > @@ -848,10 +848,10 @@ static unsigned long calculate_inst_freq(struct venus_inst *inst,
> >
> >         mbs_per_sec = load_per_instance(inst) / fps;
> >
> > -       vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vpp_freq;
> > +       vpp_freq = mbs_per_sec * inst->clk_data.codec_freq_data.vpp_freq;
> >         /* 21 / 20 is overhead factor */
> >         vpp_freq += vpp_freq / 20;
> > -       vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data->vsp_freq;
> > +       vsp_freq = mbs_per_sec * inst->clk_data.codec_freq_data.vsp_freq;
> >
> >         /* 10 / 7 is overhead factor */
> >         if (inst->session_type == VIDC_SESSION_TYPE_ENC)
> > --
> > 2.7.4
> >



-- 
Jeffrey Kardatzke
jkardatzke@google.com
Google, Inc.
