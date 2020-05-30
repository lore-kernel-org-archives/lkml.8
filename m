Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA05C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24734206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 10:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZnEd7jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgE3KaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 06:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3KaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 06:30:06 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F573C08C5C9;
        Sat, 30 May 2020 03:30:06 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id r10so2932359vsa.12;
        Sat, 30 May 2020 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hMMyvoJ6Hzq7k9EdwYSzipKdBEAp/8uFwI62KF47aTo=;
        b=eZnEd7jRFwVo6W9WehaNpAVhal5eoJNUL7m2gR3O02eJx/Fzt1Gi1CDflleRbuC9bp
         1CxtgGcejx2Wyq4PqJkKnwhI21ntOY6x/jpALKbXuTz/aFs2P+1q2wUfCPwujEZoQG1I
         dCYemBeEqb33RBygKp3JV/Uckr+uL6CS53uLVb0j8K42N9AoVvSvY/5VQsJj4ceMJVcR
         QIro+3sXBs23JTyZWwqlqJIvd2x49BfC4Fecf+v9g6Y/+NCuAzcFlyaK2uVsPeLsBaq1
         n0RczJtrVyLZyeYMHILqgyWvSEQS7dMZx69XuU3iSsDitSOzUUWsWt7FrI3sI88GzTxG
         8VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hMMyvoJ6Hzq7k9EdwYSzipKdBEAp/8uFwI62KF47aTo=;
        b=der+4oplS1SdP25FUIut3Dpj6TThlKDGpzq5t7De0hmN5jPrCEQ1O6iSgqZunoD62S
         QcbLIXfT2KJClMXNnqnru9iWWG7HysLuW4pE8XIi/dTPzgiL+p3uFKqUv2WH8ee71xNN
         aK89BSY+XINLMz5/O8uAHWHhXcx1SSXNCd9o5jwguif/eIMUUT0SHYTxH8hE92c5WfHm
         IV/UiBaAd1V8vYw41MBf8DT9bZcFoheo6XgbJh48z7cTn8/Lvha8ahEgabd6WJ4/qwvt
         IvKZ1PUmM4mDGXtUrzAuFG7no5/DNJ1CdR2x+lUPaZ7qbp5Hxa3x6F4PG7p0xDVN18jP
         WpJw==
X-Gm-Message-State: AOAM530PfG3zr6m5B6+v6npMXUYdme0wOGgSoyO6D7fEMqU9ENHHjg4L
        2uxM+b5eFSBtuEEq/2S7YtXZkpz6zCckAA2v0FR5AKDJUJg=
X-Google-Smtp-Source: ABdhPJxCQHWP1LqR1lDJ72kduPSRCOX8pxNwGhDxafimTUvAR8uGv1bjw3PqpER8mPJSQaz7oAmbvuzqPxHIjCyWmQ8=
X-Received: by 2002:a67:71c2:: with SMTP id m185mr9086492vsc.186.1590834604383;
 Sat, 30 May 2020 03:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200530040157.31038-1-john.stultz@linaro.org>
In-Reply-To: <20200530040157.31038-1-john.stultz@linaro.org>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Sat, 30 May 2020 18:29:53 +0800
Message-ID: <CAKgpwJXU9uuT6C0NMGhZRYQMxZ9b_cCZ8=8=Yb8DwQn7aZcV7g@mail.gmail.com>
Subject: Re: [RFC][PATCH] usb: typec: tcpci_rt1711h: Try to avoid screaming
 irq causing boot hangs
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

John Stultz <john.stultz@linaro.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=8830=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8812:02=E5=86=99=E9=81=93=EF=BC=9A
>
> I've recently (since 5.7-rc1) started noticing very rare hangs
> pretty early in bootup on my HiKey960 board.
>
> They have been particularly difficult to debug, as the system
> seems to not respond at all to sysrq- commands. However, the
> system is alive as I'll occaionally see firmware loading timeout
> errors after awhile. Adding changes like initcall_debug and
> lockdep weren't informative, as it tended to cause the problem
> to hide.
>
> I finally tried to dig in a bit more on this today, and noticed
> that the last dmesg output before the hang was usually:
>   "random: crng init done"
>
> So I dumped the stack at that point, and saw it was being called
> from the pl061 gpio irq, and the hang always occurred when the
> crng init finished on cpu 0. Instrumenting that more I could see
> that when the issue triggered, we were getting a stream of irqs.
>
> Chasing further, I found the screaming irq was for the rt1711h,
> and narrowed down that we were hitting the !chip->tcpci check
> which immediately returns IRQ_HANDLED, but does not stop the
> irq from triggering immediately afterwards.
>
> This patch slightly reworks the logic, so if we hit the irq
> before the chip->tcpci has been assigned, we still read and
> write the alert register, but just skip calling tcpci_irq().
>
> With this change, I haven't managed to trip over the problem
> (though it hasn't been super long - but I did confirm I hit
> the error case and it didn't hang the system).
>
> I still have some concern that I don't know why this cropped
> up since 5.7-rc, as there haven't been any changes to the
> driver since 5.4 (or before). It may just be the initialization
> timing has changed due to something else, and its just exposed
> this issue? I'm not sure, and that's not super re-assuring.
>
> Anyway, I'd love to hear your thoughts if this looks like a sane
> fix or not.

I think a better solution may be move the irq request after port register,
we should fire the irq after everything is setup.
does below change works for you?

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 0173890..b56a088 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -179,26 +179,6 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
        return tcpci_irq(chip->tcpci);
 }

-static int rt1711h_init_alert(struct rt1711h_chip *chip,
-                             struct i2c_client *client)
-{
-       int ret;
-
-       /* Disable chip interrupts before requesting irq */
-       ret =3D rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
-       if (ret < 0)
-               return ret;
-
-       ret =3D devm_request_threaded_irq(chip->dev, client->irq, NULL,
-                                       rt1711h_irq,
-                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,
-                                       dev_name(chip->dev), chip);
-       if (ret < 0)
-               return ret;
-       enable_irq_wake(client->irq);
-       return 0;
-}
-
 static int rt1711h_sw_reset(struct rt1711h_chip *chip)
 {
        int ret;
@@ -260,7 +240,8 @@ static int rt1711h_probe(struct i2c_client *client,
        if (ret < 0)
                return ret;

-       ret =3D rt1711h_init_alert(chip, client);
+       /* Disable chip interrupts before requesting irq */
+       ret =3D rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
        if (ret < 0)
                return ret;

@@ -271,6 +252,14 @@ static int rt1711h_probe(struct i2c_client *client,
        if (IS_ERR_OR_NULL(chip->tcpci))
                return PTR_ERR(chip->tcpci);

+       ret =3D devm_request_threaded_irq(chip->dev, client->irq, NULL,
+                                       rt1711h_irq,
+                                       IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+                                       dev_name(chip->dev), chip);
+       if (ret < 0)
+               return ret;
+       enable_irq_wake(client->irq);
+
        return 0;
 }

Li Jun
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/t=
cpm/tcpci_rt1711h.c
> index 017389021b96..530fd2c111ad 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -159,9 +159,6 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
>         u8 status;
>         struct rt1711h_chip *chip =3D dev_id;
>
> -       if (!chip->tcpci)
> -               return IRQ_HANDLED;
> -
>         ret =3D rt1711h_read16(chip, TCPC_ALERT, &alert);
>         if (ret < 0)
>                 goto out;
> @@ -176,6 +173,9 @@ static irqreturn_t rt1711h_irq(int irq, void *dev_id)
>         }
>
>  out:
> +       if (!chip->tcpci)
> +               return IRQ_HANDLED;
> +
>         return tcpci_irq(chip->tcpci);
>  }
>
> --
> 2.17.1
>
