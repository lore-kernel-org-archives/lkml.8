Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825D4C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE52080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBJLQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:16:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40139 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBJLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:16:48 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so8821098oii.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 03:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qf+RmXtVHoM2BJ7K3B9+KMPmOAjpiwg3jHQkAh5p0gk=;
        b=kVu/wiV+HkOthyfcCczcYMzxL7KZUkrsVWirEG2jtoDsknAtruvpLvK9KvCQHYY21c
         Jju+DblEn3wbF0f+bVaP7JmkqRAdKWbpsp0yOblyb7mxba4r/C/PHcdIUkktMFGYv6Bb
         lpzW27aMfwmLf+XXOv7ROCibIOcZKMhKWHRFcqxWQ77XewYISO4F6JAh0Er8zShsqdp/
         mRnYmwQmvQFI/jacJBjwm9A9Ll5q6C7ihZijhkopnQPws/uRy88I6GDyzgYtdfSoTVkv
         BO5VOAgeC/j5HslgTZG4Xc9HvBch/hrd+LSceDmJq3nfb9ADkATMOcklJVHIpA+reUTX
         l7Dg==
X-Gm-Message-State: APjAAAWBwT4zPWdbJShXY+I2JyyLqFvUX8tf8QPvTA35ZQ6dg1QilP3V
        qY4A6iu2Y/kljRsCPvJ9Bv/VG4cGCOPUWzsG6lZi2A==
X-Google-Smtp-Source: APXvYqxrrT+8agXt+fAds9QqA4tgY4isM2JF5hIB6pYYkxVBUlFbw2No+3wvWZ2Cpv3KgPESTHi6YlSF/M+iCSeY+DM=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr523520oia.102.1581333406509;
 Mon, 10 Feb 2020 03:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20191120133721.12178-1-krzk@kernel.org>
In-Reply-To: <20191120133721.12178-1-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Feb 2020 12:16:35 +0100
Message-ID: <CAMuHMdWhOOo8d2a48icSRBdhkNP1x5xMqs8u30FYO6MTY8YNBA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 2:37 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v5.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
