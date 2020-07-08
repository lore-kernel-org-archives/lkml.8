Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40376C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3DB20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjhiUnqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgGHN2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgGHN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:28:15 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06356C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:28:15 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dm19so35554517edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLdXECLtQR/Jw6PnNJBO5O7DiN9iPSyCU6LSlGREUDY=;
        b=sjhiUnqOgyku9GLu3mmz/Um7HUrzDAYJqAJxMNLm0sRIJhmQ7LHp4nt2gEXQd5wcHr
         XS4x1CQFpjLShiftGsXNL53GxV0RnsCMTevOP8ikkGWzQDS30K6+2IX4ZqV7u0jME2Ba
         dILkafio6QobeRnjg3uuNJuzZIyJS00+nCI7OAtYb9uft6T/mg+5OMqrqtVMyFkPrjxf
         CLK2tp9cL/LjyHla1IXqhYbRvMl5HX0mJV+6GTtZgmqiW9UWXNS+BdFdYsKd2vqXou5V
         PxoBaAzoLKBw2x4gJsFyxmcleZAn2GGdrLOuuHOBIA10QNDeMzxXg2Zx35tnuOfP+H/a
         +ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLdXECLtQR/Jw6PnNJBO5O7DiN9iPSyCU6LSlGREUDY=;
        b=M37blM3So+hqjoC+bFXGbpwMYR8m12vhQ5IQQZf+Ddb/wHt+lRdvEd47mZiTiKcWWV
         CcoVbSjPk6rMwywyCeqJ/bkhUUIADrAlXyQipO0TrCq0og7crOsbMxQ2WgJyahn05cHj
         DDwj2SNrYUgtfI3RijCGvEDsthq/U5QP4wjA67Yi621jg0gvUWxxfbFkB6afjmcrDJMJ
         +I+r/NnX0dZwHfyPllOfYFfDzamIjHp5ljd+h4Hq6OCvq+HHzDA2TiOCX0MYlteqJ+0z
         Bxvp1GImbevzLkrP74mOi+oTiiP9BP/xijpRvymJcbnm6uWO+QkuqRaw1lV9yURAcwbQ
         T9Dg==
X-Gm-Message-State: AOAM532yReaZSfLSDYnTeX2ZHFx4YpLnFxCziTQ3jrblirhPLYnlIo4t
        nY+ABl3rKA22oUL93aSZxZ7RgzRZrqFBLKk/zxDL7Q==
X-Google-Smtp-Source: ABdhPJx6BwBt/gJQ+AbYP2vcFUIQWAatTLW9ZAv8b7hfj0jRUd4HM83MoBiFzEowxIEE9I2S2ENP9XB/jZd+6e6YTp8=
X-Received: by 2002:a50:ed15:: with SMTP id j21mr41499564eds.246.1594214893469;
 Wed, 08 Jul 2020 06:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200708071117.3070707-1-yuhsuan@chromium.org> <f6a0ea44-3805-5901-9864-72d4a3a4562e@collabora.com>
In-Reply-To: <f6a0ea44-3805-5901-9864-72d4a3a4562e@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jul 2020 06:28:02 -0700
Message-ID: <CABXOdTfV_oGgZWbyP3o07obMuYGOLY87fou2h3_gowQkV7QVNw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Yicheng Li <yichengli@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 3:16 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Yu-Hsuan,
>
> Thank you for your patch.
>
> On 8/7/20 9:11, Yu-Hsuan Hsu wrote:
> > It is not guaranteed that I2S RX is disabled when the kernel booting.
> > For example, if the kernel crashes while it is enabled, it will keep
> > enabled until the next time EC reboots. Reset I2S RX when probing to
> > fix this issue.
> >
> > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > ---
> >  include/linux/platform_data/cros_ec_commands.h | 1 +
> >  sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> > index 69210881ebac8..11ce917ca924c 100644
> > --- a/include/linux/platform_data/cros_ec_commands.h
> > +++ b/include/linux/platform_data/cros_ec_commands.h
> > @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
> >       EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
> >       EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
> >       EC_CODEC_I2S_RX_SET_BCLK = 0x4,
> > +     EC_CODEC_I2S_RX_RESET = 0x5,
>
> Is this a new command not available in the firmware that is already in the field?
>
>
> >       EC_CODEC_I2S_RX_SUBCMD_COUNT,
> >  };
> >
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> > index 8d45c628e988e..5495214e73e68 100644
> > --- a/sound/soc/codecs/cros_ec_codec.c
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -1034,6 +1034,13 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
> >       }
> >       priv->ec_capabilities = r.capabilities;
> >
> > +     /* Reset EC codec I2S RX. */
> > +     p.cmd = EC_CODEC_I2S_RX_RESET;
> > +     ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> > +                                (uint8_t *)&p, sizeof(p), NULL, 0);
> > +     if (ret)
> > +             dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> > +
>
> With an old firmware I suspect this message will appear on every boot, right?
> So, to solve the issue and get rid of this error you're forced to upgrade the
> firmware. Is that true?
>

It might possibly make more sense to fail this silently and to send
EC_CODEC_I2S_RX_DISABLE as backup if it is not supported (-ENOTSUPP
can possibly be used as trigger if the call returns it).

Also, I don't accept dev_err() if the error is ignored for patches in
my scope of responsibility.

Guenter

> >       platform_set_drvdata(pdev, priv);
> >
> >       ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> >
