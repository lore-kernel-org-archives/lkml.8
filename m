Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F9AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0C4208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTATOuPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGCHcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:32:04 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62259C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:32:04 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so11362814ilk.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+/vW+OeCuUFfmZ33bKp2kdfIMTrI96qZvK5nkkiTS8=;
        b=vTATOuPQzML5zSoilwoHzw3DAL41OliM6zI+kKVgVVsC0Q2hSUkdoudQe7Zj/AsBBy
         QIZR6MeIAocScr5kByrRZdLf8L7FzZTjU+0btvYZB+U2e4NI8exHoKYz8wdsx3i683k6
         0jdVR4MmHk/GYYB5JTbd/elg1rvm8T/U+/QDu7Hv5Ekj/jYHjLLOZrkV3mkhN2ZzN+Bo
         qCWbEKd41cX4C0unh44Qvb2A/7l9/+zIRCWB6vqECnFKuNSLzvsBFQruh/BHY25cBH3p
         WN9nVnin0cV2XgKukA9RuGEQfNzq2dznlPgj9EFbpHzkoU2K5ABbq6+PAahe4ex7GHje
         5/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+/vW+OeCuUFfmZ33bKp2kdfIMTrI96qZvK5nkkiTS8=;
        b=HpPXGeNxCvfkkbUBDMjiQxFtpyTAdxseSmNzVnJtkdc+aq9vFJIf1vy9QKgh/fwGEy
         twAqALxMvQJ/MVa2BaEvFzPHWcnZKYDYBe1aEJKRSGZ5rks565axx2iudHzYOhODXv4X
         dlAIzhmPnhl4cuNh6o26YYKyGrm/SMMoS8ul00wnvZ4KeAsUmh5iTojYrTLgIhL1GFyo
         utLAo7FojdJt/zGVhLhMYcBAVUN1/8Q/wSLY/gve7s3LfnphTyOcwDBucfisXWTcIrof
         ZmG2HIN+0+i1Cia+sJya+iBr/M5gsD6857mTORPweI/CM7sqjaJ8dxGLsUMz8t/nZ9iZ
         eTdQ==
X-Gm-Message-State: AOAM533masnS5EurutM2r9t7LsV4aoj+sUY9mj6ibI6VZf665P45NJT6
        O6ZpJdudtymEunZNKtUX91lMV/yulWujmfOBftpLdA==
X-Google-Smtp-Source: ABdhPJzWzMZA3AtErhTkdyYBW8iBKoGbRxKNeoaVF3URlnVrwKsdXGH9YXH56hFuzbiryQV9r7LZj72JExxKvSQ2WF4=
X-Received: by 2002:a92:8947:: with SMTP id n68mr16903165ild.235.1593761523450;
 Fri, 03 Jul 2020 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200703071913.2358882-1-yuhsuan@chromium.org>
In-Reply-To: <20200703071913.2358882-1-yuhsuan@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 3 Jul 2020 15:31:52 +0800
Message-ID: <CA+Px+wVQC0vu5osOECC+x9JdsxdS8VpN+ni6y1k6YvOErsmKqA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Fri, Jul 3, 2020 at 3:19 PM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
> Log results of failed EC commands to identify a problem more easily.
>
> Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the result
> has already been checked in this function. The wrapper is not needed.

Alternatively, you can still use cros_ec_cmd_xfer_status( ).  I guess
it is okay to have 2 logs for an error.

> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
> index 8d45c628e988e..a4ab62f59efa6 100644
> --- a/sound/soc/codecs/cros_ec_codec.c
> +++ b/sound/soc/codecs/cros_ec_codec.c
> @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
>         if (outsize)
>                 memcpy(msg->data, out, outsize);
>
> -       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> +       ret = cros_ec_cmd_xfer(ec_dev, msg);
>         if (ret < 0)
I am thinking of if it is a better solution to print msg->result here.

>                 goto error;
>
> +       if (msg->result != EC_RES_SUCCESS) {
> +               dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
> +                       msg->result);
> +               ret = -EPROTO;
> +               goto error;
> +       }
So that you don't need this block.
