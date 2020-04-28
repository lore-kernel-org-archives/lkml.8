Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065F6C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E10206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FkJkBtD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgD1KfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD1KfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:35:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939ECC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:35:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r17so16449522lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJeRnwA9amHTr9HBEW7mHHem3+zV44srWi4Z/fPkb/4=;
        b=FkJkBtD/KENicQYgV8/9KEdp8orrQgIFyT8zmHnW3Mmp+OnH1EUrSPkgFaAg7rlchX
         +x9wIx2GcWtef8yKRxW2LS2+lJhQzg4O7CvPlq35R9E/b77f5c3yVqjodC6AWLuIrjpC
         ZZ3Yv2dbBK4OV+W6SO3oy7dR13A6BBHvJAr094oN+JHE0yFTpbEG11D1hiAVxQDVmsG3
         u2rsoy++wB9s/xSFhf11yHvF6EgyXav/TWlMOgfJTVtgZYELJRT0juiYqxxpzQoGLnxE
         PlDm2IZvcXvllzW7RQ/ZPx6HDNBLisPgsdamz+sZ0J+VdUf8wgDn+ytmTx70QEXxeFPy
         l5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJeRnwA9amHTr9HBEW7mHHem3+zV44srWi4Z/fPkb/4=;
        b=A3mAdC3Fpz1tMwx+opo30/bAEOSCvu2omNAi5Efqz3Wz5OcmrHVeYnmT+btJMl3gay
         zdAXJETKdlTIicEVzup178r0Ii3Z50snZEl8c3pS6o2DnRIHdRiPYO/PEZ2TDDuZ+ZiM
         754p/SX0gW9Et0nQUQ5aHgLLomrCLmJeIB/3EUhXukxAzzM2CS9lNujq1bdboppmMuyq
         CPHoLheBoWGN5doncvDYlxLrcRj8bUTmgr8EOtHLWcc2XvkObyYc32eE87uoKihY8kVX
         huTa1Dak5DE/Ey0MSoKywt+d0fXhyiNesqyR8m7/eu6W7f80XOq4UjQJlFYQfkOZlIVF
         Wo+g==
X-Gm-Message-State: AGi0PuYklmo4xL4rESEw3ofKdzyzAoWQg46XaOpv2lb9e/ikdYrYRhGT
        r+/PJHnTWzl142o6EPdK3/lPAHf1xeD+S+VaJdJtwA==
X-Google-Smtp-Source: APiQypJQohGEauHOPeCAfh6CAKNLQi3MDZVRWRvhKmCXA8vccTfOzGPM5rSuUJLaL3HrFixXMly5E2pXIjeahpVHKf8=
X-Received: by 2002:a19:42c3:: with SMTP id p186mr548845lfa.194.1588070116907;
 Tue, 28 Apr 2020 03:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200419002220.105338-1-hector.bujanda@digi.com>
In-Reply-To: <20200419002220.105338-1-hector.bujanda@digi.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 12:35:05 +0200
Message-ID: <CACRpkdZgkKG04=MmRLjepYY+trGY3fQCx49iFk9aTC4axfaMyw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add GPIO_SET_DEBOUNCE_IOCTL
To:     Hector Bujanda <hector.bujanda@digi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Drew Fustini <drew@pdp7.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

thanks for your patch!

On Sun, Apr 19, 2020 at 2:22 AM Hector Bujanda <hector.bujanda@digi.com> wrote:

> This allows calling gpiod_set_debounce function through char device ioctl.
>
> Signed-off-by: Hector Bujanda <hector.bujanda@digi.com>

(...)
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
(...)
> @@ -154,5 +165,6 @@ struct gpioevent_data {
>  #define GPIO_GET_LINEINFO_IOCTL _IOWR(0xB4, 0x02, struct gpioline_info)
>  #define GPIO_GET_LINEHANDLE_IOCTL _IOWR(0xB4, 0x03, struct gpiohandle_request)
>  #define GPIO_GET_LINEEVENT_IOCTL _IOWR(0xB4, 0x04, struct gpioevent_request)
> +#define GPIO_SET_DEBOUNCE_IOCTL _IOW(0xB4, 0x05, struct gpioline_debounce)

Please do not define a new ioctl for this: since of commit
e588bb1eae31be73fbec2b731be986a7c09635a4
"gpio: add new SET_CONFIG ioctl() to gpio chardev"
by Kent Gibson we have this:

/**
 * struct gpiohandle_config - Configuration for a GPIO handle request
 * @flags: updated flags for the requested GPIO lines, such as
 * GPIOHANDLE_REQUEST_OUTPUT, GPIOHANDLE_REQUEST_ACTIVE_LOW etc, OR:ed
 * together
 * @default_values: if the GPIOHANDLE_REQUEST_OUTPUT is set in flags,
 * this specifies the default output value, should be 0 (low) or
 * 1 (high), anything else than 0 or 1 will be interpreted as 1 (high)
 * @padding: reserved for future use and should be zero filled
 */
struct gpiohandle_config {
        __u32 flags;
        __u8 default_values[GPIOHANDLES_MAX];
        __u32 padding[4]; /* padding for future use */
};

#define GPIOHANDLE_SET_CONFIG_IOCTL _IOWR(0xB4, 0x0a, struct gpiohandle_config)

Setting debounce is just another type of config, so please use Kent's
work as a base for this.

Yours,
Linus Walleij
