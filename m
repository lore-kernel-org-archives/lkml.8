Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54633C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC55208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Tp+w2+Fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgD2MGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgD2MGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:06:49 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA50C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:06:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q10so2180463ile.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TIqAcmi3CCZVVh/ji2pLzKpj1uM3+1gSxtRQTFT+Ouk=;
        b=Tp+w2+FrdLCJUimSTjGqniD+POTP8Os4cX486cB0qDkka4hhqdPfOJWY9YoDvPAQFe
         XkDm5r9ZM7a6Lq8zxoyMgXVbk30i01oBPgeqLUAwUnLZDeJXBwfQKmdWCyfHpCldLYFv
         54scgDOznbzd7zvIAWzX+KvmvjR69fm7Nm5V08kbuLqN2feqwyXft7lhaKXA2CY2Bdbl
         vj/PKmeRtaHJbMsByKL+nWzKh+lXkf8A0kuJRO6QySs9q/lihh4q5QdGxcOtgx5ukFEP
         l/x3lBQZusexGrwS9IHzA1+DdxAFhPAxx2kXz7sIHleBDojf/s7/z5mNRLDxsL3rJUkJ
         tL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TIqAcmi3CCZVVh/ji2pLzKpj1uM3+1gSxtRQTFT+Ouk=;
        b=Bscaol64lR/pRK8+1lRCZrrJt9EKD5BWqBoUcTo3fHkKmYhfRbGTA9t2xkKE0qOfQ7
         nwb/YEsvl4jZmkajSv3TBC2nlLVDmJcf4cLS4at9SqxWDlMgFVnUehBtDx7H9nuUT7Lm
         XkZ9kf75oJD6pWsfSsl047FySLWzYvEnseFXX2jCGxZ9KSPp7skzev2zc084vdYjfwgL
         NJdrPZADClnsFDuW16Q8pSCV9DdKmR3leNTMPk0mP+c2bfXI53b3wWvRASRvUyicKf2l
         OrvQGmVpLLDri0/1ytQP6XQ3vygKrBg8iM/MkHlL11syYlS8iHqT86yOZ2gZcxLF2D54
         FH+g==
X-Gm-Message-State: AGi0Pua7QoQgbsIZYvwpKUQeyRfISy5SJeE53W361N1hdWBy48Px3vyT
        PoeFuyymokY1+jrS5rIRgansKEWcvgRskNpKHxTEVg==
X-Google-Smtp-Source: APiQypIE3Tg4mcSCiwE/iB03Y0Syj4+SRctek6gVLNmjr+m0P85VcB3LsK0kWpqeyvAfdT9Rd5Fm0ty07/W0W/Um4h0=
X-Received: by 2002:a92:cac7:: with SMTP id m7mr31904269ilq.6.1588162006553;
 Wed, 29 Apr 2020 05:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200419001858.105281-1-hector.bujanda@digi.com>
In-Reply-To: <20200419001858.105281-1-hector.bujanda@digi.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Apr 2020 14:06:35 +0200
Message-ID: <CAMRc=MeHun_WEApEXP59ZszGa2n+wbU9qq3wU1VO9o590rO-Pw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add GPIO_SET_DEBOUNCE_IOCTL
To:     Hector Bujanda <hector.bujanda@digi.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 19 kwi 2020 o 02:19 Hector Bujanda <hector.bujanda@digi.com> napisa=
=C5=82(a):
>
> This allows calling gpiod_set_debounce function through char device ioctl=
.
>
> Signed-off-by: Hector Bujanda <hector.bujanda@digi.com>
> ---

Hi Hector,

please keep in mind to Cc me on GPIO patches - especially when
touching uAPI. For uAPI you can also Cc Kent Gibson for a second
opinion.

>  drivers/gpio/gpiolib.c    | 12 ++++++++++++
>  include/uapi/linux/gpio.h | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 70f0dedca59f..c959c2962f15 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1073,6 +1073,18 @@ static long gpio_ioctl(struct file *filp, unsigned=
 int cmd, unsigned long arg)
>                 if (copy_to_user(ip, &lineinfo, sizeof(lineinfo)))
>                         return -EFAULT;
>                 return 0;
> +       } else if (cmd =3D=3D GPIO_SET_DEBOUNCE_IOCTL) {
> +               struct gpioline_debounce linedebounce;
> +               struct gpio_desc *desc;
> +
> +               if (copy_from_user(&linedebounce, ip, sizeof(linedebounce=
)))
> +                       return -EFAULT;
> +               if (linedebounce.line_offset >=3D gdev->ngpio)
> +                       return -EINVAL;
> +
> +               desc =3D &gdev->descs[linedebounce.line_offset];
> +
> +               return gpiod_set_debounce(desc, linedebounce.debounce_use=
c);

As Linus pointed out: adding a new ioctl() for this is out of question
- especially if this new ioctl() would be called on the chip file
descriptor. Modifying any config settings can only happen on lines
previously requested too in user-space.

>         } else if (cmd =3D=3D GPIO_GET_LINEHANDLE_IOCTL) {
>                 return linehandle_create(gdev, ip);
>         } else if (cmd =3D=3D GPIO_GET_LINEEVENT_IOCTL) {
> diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
> index 1bf6e6df084b..4b092990d4c8 100644
> --- a/include/uapi/linux/gpio.h
> +++ b/include/uapi/linux/gpio.h
> @@ -53,6 +53,17 @@ struct gpioline_info {
>         char consumer[32];
>  };
>
> +/**
> + * struct gpioline_debounce - GPIO line debounce
> + * @line_offset: the local offset on this GPIO device, fill this in when
> + * requesting the line information from the kernel
> + * @debounce_usec: debounce in uSeconds to set for this line
> + */
> +struct gpioline_debounce {
> +       __u32 line_offset;
> +       __u32 debounce_usec;
> +};
> +
>  /* Maximum number of requested handles */
>  #define GPIOHANDLES_MAX 64
>
> @@ -154,5 +165,6 @@ struct gpioevent_data {
>  #define GPIO_GET_LINEINFO_IOCTL _IOWR(0xB4, 0x02, struct gpioline_info)
>  #define GPIO_GET_LINEHANDLE_IOCTL _IOWR(0xB4, 0x03, struct gpiohandle_re=
quest)
>  #define GPIO_GET_LINEEVENT_IOCTL _IOWR(0xB4, 0x04, struct gpioevent_requ=
est)
> +#define GPIO_SET_DEBOUNCE_IOCTL _IOW(0xB4, 0x05, struct gpioline_debounc=
e)
>
>  #endif /* _UAPI_GPIO_H_ */
> --
> 2.17.1
>

I understand the need to set debounce time to make line events
reliable. As I see it: there'll be a couple steps to add this.

First: this information (debounce setting) isn't exported to
user-space in any way yet. While we can't extend the gpioline_info
structure because there's no padding for future use (unfortunately :(
) we should at least have a flag coming after
GPIOHANDLE_REQUEST_BIAS_DISABLE that would indicate to user-space that
the line is debounced at all e.g. GPIOHANDLE_REQUEST_DEBOUNCED.

At the same time as the above: the line state change notifier chain
must be called from gpiod_set_debounce() - in the end: if we export
this information to the user-space, we also need to notify it when it
changes.

Next: the SET_CONFIG ioctl() should be extended to work with lineevent
file descriptors too (of course - not all options would make sense
here and they'd need to be properly filtered).

Finally: we can extend the gpiohandle_config structure with a field
containing the debounce time which would be read by the kernel if the
debounce flag is set in gpiohandle_config.flags.

Does this make sense?

Bart
