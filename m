Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FAA215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RNFHOuKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCKDEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:04:48 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40601 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgCKDEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:04:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id h17so462779otn.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc/y94pTTaN3pV5By9oa68NXOY/kGNd87nE1UcwsCUE=;
        b=RNFHOuKi34s11GpOukBh0HStpY/JN8PkOaSp4edSPraYCR+bE5H3MFExHNG70W4/ZS
         Wi6cM54wXx2o7+uvDXOeQhRwwKbb3s+IIFkbRl20jsraFa0yA2qaWHC9Ekrw2jtt6YYD
         vinjAdl2j6XWm2IjDCGcbsde3IdY4JLpR68I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc/y94pTTaN3pV5By9oa68NXOY/kGNd87nE1UcwsCUE=;
        b=Cl20lEBLzJlcC9ZG/fMeCK58gvpJDaeoPT5pO0bmQimqKQXGwyeHXULJ5/e3FqtMaz
         NpKOHu/YGILgVDpS+i3T/No/jRrHDhBrpeg5JGJ8zYjJNBjVNrmpzu98VkWWzvzgxRN2
         PJZmwV/bA7esEo/OgCD4pSPBs9LQTFWA+Eu4rhZsDcZqB1k9XBdgtCgzHuE1p2Tzjhho
         8KrSDNnG2oVmRBMed33TMUNwDRckh4pSpdbMvAKEdlChEbCT+hqXEyRN0Z1l/GHp66bG
         YeRTFG7Rrj5/25oXrHfRhBbppRO+l/EJkPLIRYiI7hPmuUAgOMKIXemo8KnokB0hf0xg
         yURg==
X-Gm-Message-State: ANhLgQ2iaduh7+hScp+dbmSVjCX/AOUoOF7zv4zy1YidP8c8+TSVIg+7
        3ckG73c/VX0MK8cxp46tRhdCW6Yp7ss=
X-Google-Smtp-Source: ADFU+vtiDOwnpkQ49SNDDDsMkLnSoJogH8pglnKLgOMspaxXITOn3sZCURIUZivQ8TCQKWrYNydNgw==
X-Received: by 2002:a05:6830:193:: with SMTP id q19mr689208ota.164.1583895885236;
        Tue, 10 Mar 2020 20:04:45 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id t15sm2542500otl.62.2020.03.10.20.04.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 20:04:44 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id s15so456116otq.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:04:44 -0700 (PDT)
X-Received: by 2002:a05:6830:19e2:: with SMTP id t2mr642738ott.97.1583895883624;
 Tue, 10 Mar 2020 20:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <1583472756-7611-1-git-send-email-mansur@codeaurora.org>
 <CAPBb6MW-zxK+=HHUP5=+pO4Mswkhm=hDX7V56ABDm+BCzDaGHg@mail.gmail.com> <CA+ddPcNdC4r3XBd+dQmv2oHwF6MA3bTJrWZZpJthruBQR_THBA@mail.gmail.com>
In-Reply-To: <CA+ddPcNdC4r3XBd+dQmv2oHwF6MA3bTJrWZZpJthruBQR_THBA@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 11 Mar 2020 12:04:32 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVyTFqrVXAXqA6u=-0WtXcdWnozzN3gGk7y8TDK12-6Gg@mail.gmail.com>
Message-ID: <CAPBb6MVyTFqrVXAXqA6u=-0WtXcdWnozzN3gGk7y8TDK12-6Gg@mail.gmail.com>
Subject: Re: [PATCH] venus: avoid extra locking in driver
To:     Jeffrey Kardatzke <jkardatzke@google.com>
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

On Tue, Mar 10, 2020 at 7:07 AM Jeffrey Kardatzke <jkardatzke@google.com> wrote:
>
> On Thu, Mar 5, 2020 at 11:50 PM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > On Fri, Mar 6, 2020 at 2:34 PM Mansur Alisha Shaik
> > <mansur@codeaurora.org> wrote:
> > >
> > > This change will avoid extra locking in driver.
> >
> > Could you elaborate a bit more on the problem that this patch solves?
>
> For us it fixes a kernel null deref that happens when we run the
> MultipleEncoders test (I've verified this to be true).
>
> >
> > >
> > > Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> > > ---
> > >  drivers/media/platform/qcom/venus/core.c       |  2 +-
> > >  drivers/media/platform/qcom/venus/core.h       |  2 +-
> > >  drivers/media/platform/qcom/venus/helpers.c    | 11 +++++++++--
> > >  drivers/media/platform/qcom/venus/pm_helpers.c |  8 ++++----
> > >  4 files changed, 15 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> > > index 194b10b9..75d38b8 100644
> > > --- a/drivers/media/platform/qcom/venus/core.c
> > > +++ b/drivers/media/platform/qcom/venus/core.c
> > > @@ -447,7 +447,7 @@ static const struct freq_tbl sdm845_freq_table[] = {
> > >         {  244800, 100000000 }, /* 1920x1080@30 */
> > >  };
> > >
> > > -static struct codec_freq_data sdm845_codec_freq_data[] =  {
> > > +static const struct codec_freq_data sdm845_codec_freq_data[] =  {
> > >         { V4L2_PIX_FMT_H264, VIDC_SESSION_TYPE_ENC, 675, 10 },
> > >         { V4L2_PIX_FMT_HEVC, VIDC_SESSION_TYPE_ENC, 675, 10 },
> > >         { V4L2_PIX_FMT_VP8, VIDC_SESSION_TYPE_ENC, 675, 10 },
> > > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > > index ab7c360..8c8d0e9 100644
> > > --- a/drivers/media/platform/qcom/venus/core.h
> > > +++ b/drivers/media/platform/qcom/venus/core.h
> > > @@ -245,7 +245,7 @@ struct venus_buffer {
> > >  struct clock_data {
> > >         u32 core_id;
> > >         unsigned long freq;
> > > -       const struct codec_freq_data *codec_freq_data;
> > > +       struct codec_freq_data codec_freq_data;
> > >  };
> > >
> > >  #define to_venus_buffer(ptr)   container_of(ptr, struct venus_buffer, vb)
> > > diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> > > index bcc6038..550c4ff 100644
> > > --- a/drivers/media/platform/qcom/venus/helpers.c
> > > +++ b/drivers/media/platform/qcom/venus/helpers.c
> > > @@ -807,6 +807,7 @@ int venus_helper_init_codec_freq_data(struct venus_inst *inst)
> > >         unsigned int i, data_size;
> > >         u32 pixfmt;
> > >         int ret = 0;
> > > +       bool found = false;
> > >
> > >         if (!IS_V4(inst->core))
> > >                 return 0;
> > > @@ -816,16 +817,22 @@ int venus_helper_init_codec_freq_data(struct venus_inst *inst)
> > >         pixfmt = inst->session_type == VIDC_SESSION_TYPE_DEC ?
> > >                         inst->fmt_out->pixfmt : inst->fmt_cap->pixfmt;
> > >
> > > +       memset(&inst->clk_data.codec_freq_data, 0,
> > > +               sizeof(inst->clk_data.codec_freq_data));
> > > +
> > >         for (i = 0; i < data_size; i++) {
> > >                 if (data[i].pixfmt == pixfmt &&
> > >                     data[i].session_type == inst->session_type) {
> > > -                       inst->clk_data.codec_freq_data = &data[i];
> > > +                       inst->clk_data.codec_freq_data = data[i];
> >
> > From the patch I'd infer that inst->clk_data.codec_freq_data needs to
> > change at runtime. Is this what happens? Why? I'd expect that
> > frequency tables remain constant, and thus that the global
> > sdm845_codec_freq_data can remain constant while
> > clock_data::codec_freq_data is a const reference to it. What prevents
> > this from happening?
> >
> > > +                       found = true;
> > >                         break;
> > >                 }
> > >         }
> > >
> > > -       if (!inst->clk_data.codec_freq_data)
> > > +       if (!found) {
> > > +               dev_err(inst->core->dev, "cannot find codec freq data\n");
> > >                 ret = -EINVAL;
> > > +       }
> > >
> > >         return ret;
> > >  }
> > > diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> > > index abf9315..240845e 100644
> > > --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> > > +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> > > @@ -496,7 +496,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load)
> > >         list_for_each_entry(inst_pos, &core->instances, list) {
> > >                 if (inst_pos == inst)
> > >                         continue;
> > > -               vpp_freq = inst_pos->clk_data.codec_freq_data->vpp_freq;
> > > +               vpp_freq = inst_pos->clk_data.codec_freq_data.vpp_freq;
>
> This is the main thing it fixes (this is where the null deref occurs).
> If there's multiple instances in use and the other instance hasn't
> populated the codec_freq_data pointer then we'll hit a null deref
> here.

Couldn't this be fixed by checking the pointer for NULL here or
(probably better) populating codec_freq_data earlier so that it is
always valid?

This fix looks like it is replacing a NULL pointer dereference with
access to data initialized to fallback values (which may or may not be
meaningful), and I don't see the need to copy what is effectively
constant data into each instance.
