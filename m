Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD728C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2FE246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kh0IHMIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1XOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:14:15 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40898 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgB1XON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:14:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id 143so5151364ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RCFPQwGCfT36oBbvj50m2uhGBMYQU9mYzXWYujIs4Hg=;
        b=kh0IHMIo5od/nculv7hDPQMJFWDqd7L2ggdxa28vc2GbDL11KjY3AP7gBaaHvdYvgU
         ItJO0bOTaDyfOHKp6uuqoFuFDP+l83ZahPqIzY5/M6W8PgfmRtSng2UPsbV3zPSlusy7
         B2toKtW0M3bWb46BQIFEaYRuUSXStlOcIhjKByteCrDb4nRKYoAx2jYbOv5sLn3rHso7
         hLP7/bXCPT5nQTRx2MH+kHumisUwTDrS0qlR11C9lg+SvO6Vrk9FD26ExX3LlTrs0sHA
         w2EaYNYlEJr+G4zOl/vhjPaQ0qolNI0xoE5Ur5X5P37dbUdZcQh1aMo2P0k8A/3veynn
         jpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RCFPQwGCfT36oBbvj50m2uhGBMYQU9mYzXWYujIs4Hg=;
        b=Btq9mnWGAyZBTYcGxE+mfHfct4DvKbJYypq4FLDTnEUSW4VDUKu2wQz2Ui331q407O
         yvD5ZuMU6s0p91DdgvJaioEtdCjBBAQmSwmZ3gH+xZyozbVrH2L1CYqqsdmjDp2BRSMU
         uHaIX5P3mWPUraeR70h/JpxHb5LwL5G6HzSZObCbSSmCc892oPpfAP1/lY+GQrxwzSW/
         BDUc6Qa+uWttmremOpccwI9a00HiMOTL6tIuDmyEcrt57Tdev9QrpFW3diZ2GcpOex2x
         bzzjjUW3RfObfHc4SG9a8YoElFBqtDKC1U5SHxbC2TfPdkgtMh6dtdhDo2CQpMp68Slu
         In3w==
X-Gm-Message-State: ANhLgQ2ZGDkqLX+XbgIlddwuN0VNHd2m3OTQ8rY+J+TLa9iwKbDkUl1Y
        wRQL+oTjn+FSaCh3WvCapthU7I5rA9vg3iDq3d/NaQ==
X-Google-Smtp-Source: ADFU+vt57HUFay7Zyzi0sUqoX3MQ7XhyigC8Oy5ud//G8IeLLctZCnZPrRZW+5/WocYm1DlW4ITeot6fjbHBh7PuDu0=
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr4222255ljo.125.1582931651687;
 Fri, 28 Feb 2020 15:14:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582647809.git.Asmaa@mellanox.com> <7ef84476a00e8771cf1edf5745c378273b760f5d.1582647809.git.Asmaa@mellanox.com>
 <DB6PR0501MB27121431EA6DCCB476B73F1DDAED0@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB27121431EA6DCCB476B73F1DDAED0@DB6PR0501MB2712.eurprd05.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:14:00 +0100
Message-ID: <CACRpkdZhs=ZYkcYb5bNqK_ayWEVk9=J0w--ELW-vcvoSvG9cxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 5:42 PM Asmaa Mnebhi <Asmaa@mellanox.com> wrote:

> I have addressed your comments and tested the code. Please note
>  that the YU_ARM_GPIO_LOCK is a shared resource between the 3
>  gpio blocks instances.
> So now that we have split up the gpio_chip into 3 instances, we need to share
>  that LOCK resource accordingly. I have created a global variable for that purpose.

Fair enough, all looks so much nicer now :)

This:

+       /*
+        * Although the arm_gpio_lock was set in the probe function,
+        * check again it is still enabled to be able to write to the
+        * ModeX registers.
+        */
+       spin_lock(&gs->gc.bgpio_lock);
+       ret = mlxbf2_gpio_lock_acquire();
+       if (ret < 0) {
+               spin_unlock(&gs->gc.bgpio_lock);
+               return ret;
+       }

Is open-coded in two places, please create a helper function for this
or just merge it into mlbx2_gpio_lock_acquire() since it is done all the
time when that is called.

> Also note, that although it is not supported in this driver at the moment, some
> gpio interrupt registers will be similar to that LOCK i.e. they are shared among
> the  3 gpio block instances.

It's a good start like this.
The robot complains about devm_ioremap_nocache
which is now deleted, use devm_ioremap() simply, they are
all write-through.

Yours,
Linus Walleij
