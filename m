Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FEC3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3A324654
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LAEzQUym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgBNJbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:31:44 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42173 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBNJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:31:43 -0500
Received: by mail-io1-f66.google.com with SMTP id z1so9247282iom.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tPGqxqvdQIhvmCHA0qJcJLxvA46GSGZbYEshxyswMHk=;
        b=LAEzQUymZYHQzHIb9KLXBgTvu1GhHWdK3lcFClPuOFFxVz1/n00hEyHq+3Kg/WtJ6K
         f2dxhdzI/4NhpY8t3E02STwh5tFXtLO3otX/IudN+uflSPxQP8qRdVGtoEIdH5fkjcR1
         bzH544qsiZNyC3sqDcHyr0P0N/L+pM5Q1FDjzotlPO3ETr1nwOjV49sQdFbkqDWvw9Y+
         WNKm0ztqCnktapqC1/0/6G3fYPs3EvSACT4q8cnA81ZeuL7ahQVELh3UMcgKYFJV1wc6
         SIzyzoJTJ7Be4qbtHd/P52McOCwW2Qn/YZPpDf7pn9Lkvc1lpMz8Go1xhOgnOyR146qX
         0isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tPGqxqvdQIhvmCHA0qJcJLxvA46GSGZbYEshxyswMHk=;
        b=Uf7wLG6qKqXPOnou6B5bVGpRBkIkiRvZCZF4eyHO+/zy4JOAG+yim4TaU/iYX4U2sl
         c95SYE519DrechKeiZHI058Yl0CDT1QDIZg7N1kruc9CURVSDfueszZjeN9ycCcKsvp6
         A6t9su590uxHefmdaBwuTma3+pEko/1MmEjNGwXLCWFdMJQmvT9xVEOvdHSVLXq8tqWj
         36it7BlJAi36TwkzXDKQ0TdyLkKYHBrd0EzyYtnB9srfR1Vp0h6pkoVwQ/K8moP8qgIL
         M5jfleMnWmmChDEpWJiObDiDnl8ok4QlLxheH49ODEepITKBKEvm9h/GD73BplpMYPxv
         3nww==
X-Gm-Message-State: APjAAAVxOXuJyGYrUV5RvjPQI/asKHt9WEC3U5lWwZsr03Kj7mH6Rhrl
        n6NQ9qaBxKZZTl1WStuGzTq/xRGrftkpgbLdCU51TA==
X-Google-Smtp-Source: APXvYqxgWJOyIbYagJnnKVzHLeqCoVORg5daCP/H8O5LA9jMWCkLYmTdfMLLEPEQlGIgJGX6ZnseQLN17UMD32HHcz0=
X-Received: by 2002:a05:6602:220b:: with SMTP id n11mr1608407ion.6.1581672701495;
 Fri, 14 Feb 2020 01:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20200211131240.15853-1-brgl@bgdev.pl> <20200211131240.15853-2-brgl@bgdev.pl>
 <87eeuxh789.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eeuxh789.fsf@nanos.tec.linutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Feb 2020 10:31:30 +0100
Message-ID: <CAMRc=Mfgq_HF8-uGxY0Qh6aN320CLBBX3gu-uXVSH6Y=ZvXOqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] irq: make irq_domain_reset_irq_data() available
 even for non-V2 users
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 14 lut 2020 o 10:02 Thomas Gleixner <tglx@linutronix.de> napisa=C5=82(=
a):
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > irq_domain_reset_irq_data() doesn't modify the parent data, so it can b=
e
> > made available even if irq domain hierarchy is not being built.
>
> Yes, it can be made available, but WHY?
>
> Thanks,
>
>         tglx

Duh, I forgot to clarify this. After my previous submission, Marc
suggested I use irq_domain_reset_irq_data() in the unmap() callback
for the simulator domain. I noticed I can't do this because I don't
select the V2 irq domain API, so I added this patch.

Bartosz
