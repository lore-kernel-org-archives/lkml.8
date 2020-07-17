Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D7A2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtQUJdXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGQOcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:32:38 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FDC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:32:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so11109892ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zW8Tx5F9J8OHnFWh/HH8a3bm9XWpmViZ4XegdyqY93E=;
        b=jtQUJdXblGi/ryS3Z6ju0NFNquil2t7oPz+mOIhqRlB4n+GfCiVVFAt70VBEuVEOem
         cPhV/I5KS+5BsUt7ORCFroCirTq5B5yUvVKEMue3guU8lcD2N5dTh/MxIJK5U52DB5hW
         zjsODvitaaWNmUA4vh1bWfvs0gJmBas/XDonDhN9kLnbFY0TwUVVi9Te1XV0iaOVKG/0
         6qZO9eBqXauhvJS+buYBg6K54EUu7JI19FodzDRNpFYeGhK/SHRQbxxbYaNTvnArQOkW
         AhD4ngtgayXc8OeJSgQiHBnOGgt6uxlfcTkElwzfr3sm9mr6QnDsxRU/Vif4CImCz5Rw
         XoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zW8Tx5F9J8OHnFWh/HH8a3bm9XWpmViZ4XegdyqY93E=;
        b=rlOAPOfZrqY/nMnuqdUCXd8A12WCV60W0bvJed29CeiHLKwLXEXOPlJufLya1JTUku
         eGbDBLfBUrzv4iG8AtPKJo/AZsA09dunB4POr3njzfhiQYX5uEcpk6rNQ6T3zP8/mF1b
         j1/KM/052fZvSam6IJi2u3hgzwaGtn5q0p0ZjXir2ucOkE3cw/ruL2IGV+L2OYnwnCZe
         Pp6oKWaX0UrqfnkWL3zHPp3khwRbp8uNpL+LED44MLIyqF5mG9W2wQDL93HQgsaOIPwW
         seIpKgkwSSAhdhTI/7K8DUhMH+rgWTdxZvytnccG5Vp72jkSfsQal2uv++qz+bYFjtVQ
         I/wA==
X-Gm-Message-State: AOAM530YtOaI7OXyuTSKf4zCEnzePpG+i3zHQ7b/CO6Fldb7F2L8bs+M
        Gj3Xu9nTp42Eq859nBrSge/TAbkeVNTkknFge1E8SA==
X-Google-Smtp-Source: ABdhPJz41kh9hSIhYD17HeWveunMqSPLym8stDGAavsGB1Z7MZ1iLP/s0rm/f8zSOq7UO1YjQjTwaiiMKoIgd5jKgiE=
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr9208765ejb.183.1594996356749;
 Fri, 17 Jul 2020 07:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200716170914.3623060-1-yuhsuan@chromium.org>
 <CABXOdTffo_PoFytXTR0DthRgxrp9SLkTrg2Wp6dMDXXj060KFw@mail.gmail.com> <f53d5f7b-6d9a-af68-7a48-fbb411625336@collabora.com>
In-Reply-To: <f53d5f7b-6d9a-af68-7a48-fbb411625336@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 17 Jul 2020 07:32:25 -0700
Message-ID: <CABXOdTf2x4zK9n0WN2djLxCbfQynF4p5v_opwB-DsEyRnRAd4g@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:47 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 16/7/20 19:23, Guenter Roeck wrote:
> > On Thu, Jul 16, 2020 at 10:09 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
> >>
> >> It is not guaranteed that I2S RX is disabled when the kernel booting.
> >> For example, if the kernel crashes while it is enabled, it will keep
> >> enabled until the next time EC reboots. Reset I2S RX when probing to
> >> fix this issue.
> >>
> >> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> >> ---
> >>  drivers/platform/chrome/cros_ec_proto.c        | 7 ++++++-
> >>  include/linux/platform_data/cros_ec_commands.h | 1 +
> >>  sound/soc/codecs/cros_ec_codec.c               | 9 +++++++++
> >>  3 files changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> >> index 3e745e0fe092c..2c60690d7147c 100644
> >> --- a/drivers/platform/chrome/cros_ec_proto.c
> >> +++ b/drivers/platform/chrome/cros_ec_proto.c
> >> @@ -572,7 +572,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >>                 return -ENOTSUPP;
> >>         } else if (msg->result != EC_RES_SUCCESS) {
> >>                 dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> >> -               return -EPROTO;
> >> +               switch (msg->result) {
> >> +               case EC_RES_INVALID_PARAM:
> >> +                       return -EINVAL;
> >
> > As we have learned, this may impact other callers of
> > cros_ec_cmd_xfer_status() which only accept -EPROTO as error return
> > value. In addition to that, the code is odd:
> >
> >     if (msg->result == EC_RES_INVALID_VERSION) {
> >         ...
> >     } else if (msg->result != EC_RES_SUCCESS) {
> >         switch (msg->result) {
> >         ....
> >         }
> >     }
> >
>
> Ack, this is odd.
>
> > I really dislike the notion of changing error return values of
> > cros_ec_cmd_xfer_status() one by one. That can only cause ongoing
> > trouble with callers expecting specific error return codes (as we have
> > already seen).
> >
>
> Hmm, that's a good point. Ok.
>
> Let's apply the Guenter's patch that maps the errors *and* fix the callers of
> cros_ec_cmd_xfer_status which only accept -EPROTO (there are few).
>
> Yu-Hsuan, can you take care of this and send a patch series with all the
> required patches? If not, I can work on this next week.
>

I can look into it as well. Let me know - I don't want to duplicate work.

Guenter

> Thanks,
>   Enric
>
> > Guenter
> >
> >> +               default:
> >> +                       return -EPROTO;
> >> +               }
> >>         }
> >>
> >>         return ret;
> >> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> >> index 69210881ebac8..11ce917ca924c 100644
> >> --- a/include/linux/platform_data/cros_ec_commands.h
> >> +++ b/include/linux/platform_data/cros_ec_commands.h
> >> @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
> >>         EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
> >>         EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
> >>         EC_CODEC_I2S_RX_SET_BCLK = 0x4,
> >> +       EC_CODEC_I2S_RX_RESET = 0x5,
> >>         EC_CODEC_I2S_RX_SUBCMD_COUNT,
> >>  };
> >>
> >> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> >> index f23956cf4ed84..b5ff30b7f1aa8 100644
> >> --- a/sound/soc/codecs/cros_ec_codec.c
> >> +++ b/sound/soc/codecs/cros_ec_codec.c
> >> @@ -1034,6 +1034,15 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
> >>         }
> >>         priv->ec_capabilities = r.capabilities;
> >>
> >> +       /* Reset EC codec I2S RX. */
> >> +       p.cmd = EC_CODEC_I2S_RX_RESET;
> >> +       ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> >> +                                  (uint8_t *)&p, sizeof(p), NULL, 0);
> >> +       if (ret == -EINVAL)
> >> +               dev_info(dev, "Missing reset command. Please update your EC firmware.\n");
> >> +       else if (ret)
> >> +               dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> >> +
> >>         platform_set_drvdata(pdev, priv);
> >>
> >>         ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> >> --
> >> 2.27.0.389.gc38d7665816-goog
> >>
