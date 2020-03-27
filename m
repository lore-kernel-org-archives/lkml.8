Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E644C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510B720714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p46WdIT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgC0Vjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:39:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47043 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgC0Vjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:39:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so4116139ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Je8mtxcs84zdxjm91ykSFMqUo8LaITxZQqe+nRBzKN0=;
        b=p46WdIT7WUM+8lq5BljY7Us2B92LkhGlQpWgUmNi8VgndmqisVWKJCpnNJONl8zIjF
         WnhoiwRRuLKwALzSgg7mxo9263rh1e8DiY5MyaNZfyatrxjYtZoeglDbYGQv0+CS1DOh
         FPzQV6oLx3Q6AWCVjgrMCq4pI+7KyfI0QJbzrytAV5BJ2IBGM0xgdAGEnaqP+3up0FeW
         uzmCWroM5Q/jLCyQNvYELjhTtUbI0HYXA7TOn4s4zK0UOFrMfqtFH/PFvwlh/LuU5sLf
         rnqn0EuBY76FIus/SRwsaTZkj6ijeuWcHJi4RVqSaBXjtZW3fhb6XQexr7oDz25dvwg3
         NIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je8mtxcs84zdxjm91ykSFMqUo8LaITxZQqe+nRBzKN0=;
        b=mwjCR1Sfyg22LkGhXxWYLfmyg75Lv4ghAoCJvlfiXMjZB/Jg2cNkOHXW90Jt21Zh0w
         P2IlrS1vAfoC5T521ySL6CaF+30Yj39Q/G+tDkvMp4W73dEEyRyDcaaQJIs/9mgVJbcZ
         0fgYyn5rxDkb2Jg5Uux8cD2dyK9Mx2BRoXT+PzwwGnepxBsfHYYM25vcIl07lYcpi01q
         5yom4bU82gGwKmnp4G8PUTiJjIzkcdvCpmTryEG6UxWSb2DzocN/QvtD/dy81y/wYvEn
         DBzIq2kL67tYw2YXC/Mq9g1QZpMc8wRSqoy/73LQDuW72BMH3IPOHop3UtQ+AeHFO5gz
         NZjQ==
X-Gm-Message-State: AGi0PubCx7XF5vcOKIHCUmVJ3EVDmAyRVgzPLt3qvBvuRc1JCUoXqEuK
        EEQ8FtvAsDaybHJwp7dByG1B9ntO2aBrbhpzasCfCw==
X-Google-Smtp-Source: APiQypKvs6AyHW9t/QYsDDBil2QxnB2gGYCzDvaKDnk31e8soz/A3i2nOWFG+aEMqTx99zqIQddpZ7oQ7/O6U+ztSCg=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr549394ljh.258.1585345170980;
 Fri, 27 Mar 2020 14:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200325100439.14000-1-geert+renesas@glider.be> <20200325100439.14000-2-geert+renesas@glider.be>
In-Reply-To: <20200325100439.14000-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 22:39:20 +0100
Message-ID: <CACRpkdYBFBRFEzCUb19n0iHpJknn419aXdbgOAqG8h1P0J2YJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: Pass gpio_desc to gpio_set_config()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:04 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> All callers of gpio_set_config() have to convert a gpio_desc to a
> gpio_chip and offset.  Avoid these duplicated conversion steps by
> letting gpio_set_config() take a gpio_desc pointer directly.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
