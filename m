Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30845C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0DF2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I9QG+YiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgHaRVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgHaRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:21:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:21:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l63so6167280edl.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nU/5oe5+A3cUKVWl9Yx/iTqCnlQo0CnopBUHSvATE9w=;
        b=I9QG+YiLABt6ZlLm2Kf6dV+Z9Pz+ScDSNBEDf6zvxQnBmEMqsmG/vWcctjRlO9SDm8
         4bPnrQMFFDImHaWitXR4KtXte7QA7C8R7a1C5I4df2o5en+8A4LXYEBDRwJB/ceFXIzg
         +vAEman2dOd0j0r2O0PiLsSmpa2AJI3fN3mM7HK0rmBIIITTGe9OnUgU22JVy3J0EZLC
         wzeJNhese/gVsAO0jtlpdbcoGcauWjrmBFVCqTqvbjpIII6S3ZFyPQTjeE9ERlCm8A8w
         ZcKYHMPdZqle5o3RPDEwcWFztLNZxfDYdkGPGwPmJhtILqpRhN41+zTF14eEq080fzWH
         PDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nU/5oe5+A3cUKVWl9Yx/iTqCnlQo0CnopBUHSvATE9w=;
        b=kNMY7As/NIcJSbToqQmPADkdTpr3kuPzZswl2ef1+esynEYQJwT4raHtAxD0aMM3Fj
         JgEcz0apC1MBoCqpeboowyVJ7iKAfQrv/MbQc6HjAzCb/TSIe7pXajdMXt26hAVwAfbi
         5kDAvCaSPMOW+JPHOjrroIsxm4XGrddamgCsOtYxEpnAfavqcVOC+yQSymdhvCwuPfO0
         WhlMlzQ9ryk6v55q3G1xtBLzCEaoZ9cJoko/veFv0BEEUZn0f61SRM0IF2eExiNfGYtn
         0t0eV0NMWE5+4X6NdGZrTjNSZuS6HkmivjFNiE2gohlRqf4RdaWUKWUUkquQywYKqvNL
         ycuA==
X-Gm-Message-State: AOAM531Xu4dzYsdjdqZhfZ27/BAs9AZQOe4ujnmJko7prLMZf65ELxU0
        TFfGHIzW13lWwcemvtL1ky9MmzSJEm+fCWN+kPKuBg==
X-Google-Smtp-Source: ABdhPJyX9yFVGmSMpHH76zqQdkJMcCohiLE14tE/uN0FouPWzRdrlDf+mwZe03bax4NaYw/f0J/0DBYIHITNAazWlBQ=
X-Received: by 2002:a05:6402:10d7:: with SMTP id p23mr2026227edu.388.1598894510043;
 Mon, 31 Aug 2020 10:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200831015539.26811-1-vadym.kochan@plvision.eu> <20200831015539.26811-4-vadym.kochan@plvision.eu>
In-Reply-To: <20200831015539.26811-4-vadym.kochan@plvision.eu>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 31 Aug 2020 19:21:39 +0200
Message-ID: <CAMpxmJXzGPXwMYg6e+eCYck+nXnNqxSEBOwm5G-vmLYQA7cDpg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] misc: eeprom: at24: register nvmem only after
 eeprom is ready to use
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:56 AM Vadym Kochan <vadym.kochan@plvision.eu> wrote:
>
> During nvmem_register() the nvmem core sends notifications when:
>
>     - cell added
>     - nvmem added
>
> and during these notifications some callback func may access the nvmem
> device, which will fail in case of at24 eeprom because regulator and pm
> are enabled after nvmem_register().
>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v3:
>     1) at24 driver enables regulator and pm state machine after nvmem
>        registration which does not allow to use it on handing NVMEM_PRE_ADD event.
>
>  drivers/misc/eeprom/at24.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2591c21b2b5d..26a23abc053d 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -692,10 +692,6 @@ static int at24_probe(struct i2c_client *client)
>         nvmem_config.word_size = 1;
>         nvmem_config.size = byte_len;
>
> -       at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
> -       if (IS_ERR(at24->nvmem))
> -               return PTR_ERR(at24->nvmem);
> -
>         i2c_set_clientdata(client, at24);
>
>         err = regulator_enable(at24->vcc_reg);
> @@ -708,6 +704,13 @@ static int at24_probe(struct i2c_client *client)
>         pm_runtime_set_active(dev);
>         pm_runtime_enable(dev);
>
> +       at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
> +       if (IS_ERR(at24->nvmem)) {
> +               pm_runtime_disable(dev);
> +               regulator_disable(at24->vcc_reg);
> +               return PTR_ERR(at24->nvmem);
> +       }
> +
>         /*
>          * Perform a one-byte test read to verify that the
>          * chip is functional.
> --
> 2.17.1
>

Good catch! Thanks for the patch. Can I queue it for fixes
independently from the earlier patches in this series?

Bart
