Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BBEC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9833620657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6DDIKAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgGPRXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:23:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBF5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:23:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so7397876ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap6sCeX+vfsgknYFWUWzqHRMYIsUrhYyQY0OJzIHClo=;
        b=S6DDIKAesPw5Cjx89b0HuzwbTsFk9QhmWPt5VzTZ6wA2Uh4QVf36cFYxTJql64zLQA
         FLaSC6H2+WAaj2PpaonR0HyxRuPDL0NnUTJEY6UiUZ714K0v+omvP7NnEiex0K8R8B13
         F2CaY9/LU+DAdSIHZe1+/K45Rg3SIpYjxFlwNXp8wBNjT02Z3Gqhr19q4ptq39uYL196
         uE9UCQkcTzrI/LgOHoEeGt/diY69YXNked59X49Dh9ODuonOtSNYY/1TwCgELzM5YgwB
         wm64dM1NMTBfZJnZE0T/apcsaKb5ybLGpLp4bCw3RTjsNIpQrIzA07yUMfyVIlYTqTJ+
         ZfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap6sCeX+vfsgknYFWUWzqHRMYIsUrhYyQY0OJzIHClo=;
        b=ViPSoOHEyJ4LiVvzDprKk9Qi2sJ8rDj6imlHhBv/oQi71GcsnybT9b1Nf62wJSQcNp
         MtygoRataY0yGi6hMmt2Bn3x8dD+7oCeGKRBlPyRd1kciA0QGAdqIDZLp9+5sUT0Rw8P
         PPrIwlcvVy8wlAM1Dy/Ges9QptQ/W1YIhZ4wVH0R5vqjzAfNnPLLk7zxzdeVIzpNICHB
         n5XbYUX2c71UyC8iyGhSBKGxIbwSP9BA34UqwujS5tVlKtELe+It9OOnsNzJ51oHXV7Z
         snBJpzVzy2OqkhnPxg1OXBXa/t4NPM8Vn9QyeX/wyLtgBtWrHKtQxucQsP7ksmCEHSQi
         ubYg==
X-Gm-Message-State: AOAM5333i7gxUixzq0xmydQmasAxUVe5VkwHj7D9G/jopnr2gxD5rrBs
        GGekn3Ws4kuivGbKbMtNWEwIgN3KSs64QpIQcRNFGYnkKy8=
X-Google-Smtp-Source: ABdhPJx3Pr28goyATfKkhOboW9Yf3AuRpjqoPz5JRPqzOhfVY8Y15cuRcXN2WVSUOIPVUxZ8eX4WUlS+upYmdNP/ZEU=
X-Received: by 2002:a17:906:29d8:: with SMTP id y24mr4685468eje.212.1594920223732;
 Thu, 16 Jul 2020 10:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200716170914.3623060-1-yuhsuan@chromium.org>
In-Reply-To: <20200716170914.3623060-1-yuhsuan@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 16 Jul 2020 10:23:32 -0700
Message-ID: <CABXOdTffo_PoFytXTR0DthRgxrp9SLkTrg2Wp6dMDXXj060KFw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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

On Thu, Jul 16, 2020 at 10:09 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>
> It is not guaranteed that I2S RX is disabled when the kernel booting.
> For example, if the kernel crashes while it is enabled, it will keep
> enabled until the next time EC reboots. Reset I2S RX when probing to
> fix this issue.
>
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c        | 7 ++++++-
>  include/linux/platform_data/cros_ec_commands.h | 1 +
>  sound/soc/codecs/cros_ec_codec.c               | 9 +++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 3e745e0fe092c..2c60690d7147c 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -572,7 +572,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>                 return -ENOTSUPP;
>         } else if (msg->result != EC_RES_SUCCESS) {
>                 dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> -               return -EPROTO;
> +               switch (msg->result) {
> +               case EC_RES_INVALID_PARAM:
> +                       return -EINVAL;

As we have learned, this may impact other callers of
cros_ec_cmd_xfer_status() which only accept -EPROTO as error return
value. In addition to that, the code is odd:

    if (msg->result == EC_RES_INVALID_VERSION) {
        ...
    } else if (msg->result != EC_RES_SUCCESS) {
        switch (msg->result) {
        ....
        }
    }

I really dislike the notion of changing error return values of
cros_ec_cmd_xfer_status() one by one. That can only cause ongoing
trouble with callers expecting specific error return codes (as we have
already seen).

Guenter

> +               default:
> +                       return -EPROTO;
> +               }
>         }
>
>         return ret;
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 69210881ebac8..11ce917ca924c 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
>         EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
>         EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
>         EC_CODEC_I2S_RX_SET_BCLK = 0x4,
> +       EC_CODEC_I2S_RX_RESET = 0x5,
>         EC_CODEC_I2S_RX_SUBCMD_COUNT,
>  };
>
> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index f23956cf4ed84..b5ff30b7f1aa8 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -1034,6 +1034,15 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>         }
>         priv->ec_capabilities = r.capabilities;
>
> +       /* Reset EC codec I2S RX. */
> +       p.cmd = EC_CODEC_I2S_RX_RESET;
> +       ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
> +                                  (uint8_t *)&p, sizeof(p), NULL, 0);
> +       if (ret == -EINVAL)
> +               dev_info(dev, "Missing reset command. Please update your EC firmware.\n");
> +       else if (ret)
> +               dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> +
>         platform_set_drvdata(pdev, priv);
>
>         ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
> --
> 2.27.0.389.gc38d7665816-goog
>
