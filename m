Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB7C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70056206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jdZzWMt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgIAIGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:06:29 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61435C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:06:29 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a26so371935ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9PZ44CsMNp2O1iCfUt1GNqsXkjLGaZaqcdauTW8vgA=;
        b=jdZzWMt1fZwpET6FEqQGu3uZKO3sL/KJThZn5wGwkQJYVJ5ogDtWhLBXg2Bu7QcfVn
         kBB50QtUGJgUB3m7zfj3fNIdFmzO8ZOyCAhuyiWx8Ao0d3p1oh0Dy6+rWm5698ZVMPqa
         Ya2iJiPepv7T43bH4NhfGRdbYA50pfJnMxMb98wqh9Ov4XsSuny/Y9zqXPjf+8JXw2X/
         VMRs/Dq+CCbuyB8CilL372ohlHewI+nWIZ67s5lv5gN3EvLCleWZsXH1vi+4n3/nd2pl
         x9JxTT37+tfRiHBV0aAYcmRA99LF8EqySzQ4tFRnXlr2n8vn8rrcu3nlWr8i3dA/NGpO
         7dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9PZ44CsMNp2O1iCfUt1GNqsXkjLGaZaqcdauTW8vgA=;
        b=qZvSI/lXEGy2NsKf8ENUPa4g+KAw0fV7INMCmhLvVH5HK94FuKZq9IKiDLeY1n1Yab
         19TdLe5GHJFNGRNkBOj5VSswMHGw6yYI2Qywl5zx/hAWv/wdawp2VAB78tY9xBwSHbw5
         BgyHffZ2QGWbDS1I6badDwz7+9WU8EQhtsPH4CI1R7HCHLElpYUT8VU/poY1RA2crDTY
         6g1MCwXYgs69HQanp7zLxmwpmUOiUTt9D6Gpq1HbBnbIRaJcOnFDA7s8ma6rZa1fs+3X
         6tCtVbTQLQk6caRan34TkNMjusFLzVuSQ1F4zHAZp9UlBuVI1XowShli1ax2Zbev1XQl
         Pfhg==
X-Gm-Message-State: AOAM532pBwxap3W1Wx2c9eMP08xKXkq8wZ5bVKZrxm9uVKSo7maV+W6Q
        mpwz+IwzfEKfsbBFWTb3Z/JOLH+YKvC6hqLJxWOAug==
X-Google-Smtp-Source: ABdhPJzoZ06x+Fk7b3d7jAbkDX49d7qqNZ7DzYlgDEfNI7H8zRlIC7bBE/iecwkRl7kRgYQXMW6QqNsxxgNvQIqBHMc=
X-Received: by 2002:a17:906:941a:: with SMTP id q26mr413877ejx.496.1598947588025;
 Tue, 01 Sep 2020 01:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200831015539.26811-1-vadym.kochan@plvision.eu> <20200831015539.26811-4-vadym.kochan@plvision.eu>
In-Reply-To: <20200831015539.26811-4-vadym.kochan@plvision.eu>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Sep 2020 10:06:17 +0200
Message-ID: <CAMpxmJVzaK8JSVZ_wGnQO_+1TLTSG-NBAhLOtHsf3g4x2u_TzQ@mail.gmail.com>
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

Queued for fixes, Cc'ed stable and added Fixes: tag.

Thanks!
Bart
