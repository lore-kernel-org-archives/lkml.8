Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A823BC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CBC20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgCWMsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:48:05 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43619 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgCWMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:48:05 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125so14547225oif.10;
        Mon, 23 Mar 2020 05:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUATCAccdBFsEvxYTRSzQkmirrWfcF+OZxTvChwiCAc=;
        b=mRUmoh3xttSU2GnBvtZpdYC6SqajGQJ1MdSqBwNeLOHaGzlYZ/gfqEv6aSJroudW3B
         azw+pTPES1bOKWwShgtpDx9DdFLYASUOYIvtoyOnwOrGiEmRrI6lYyIvwV+VEPHaPktg
         Pr78cUbHIIlHaDwWXN/e1jorWiDxsR5RoXvyu04qyHqONpUH4gp04EHaceM9M+yHtwma
         6ijK1zNtD+tMdMpFEPTzFpa3ovdQ8jIBpXSDInJjEleEkOH5ToQb7QBlS8mGzDe2JThw
         /r0wavEW4Jx4WTeAlRajeX2DH8JLZaJjPN+hFOcb3YzPw6B3lnNxIftdv+NIiyvwwWkb
         mH+g==
X-Gm-Message-State: ANhLgQ2i6HpiTdK6+2qi2Vm3XGwxecwB0BeVd9p/KLOYMkxT4VPE7Q0v
        yEMUlp6ORyeLeMz+vMGjZJvgN66faytMgxvb1JM=
X-Google-Smtp-Source: ADFU+vuDzdf9KozCn+I7f+CPyYdVM8nVCc2GFOdZiuzwvy15U9/cJJhCqw1ECmXC8hVU9HfQ4VacDWK/agbd/rdvsI8=
X-Received: by 2002:aca:4e57:: with SMTP id c84mr16142318oib.148.1584967684714;
 Mon, 23 Mar 2020 05:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200315140525.21780-1-zhengdejin5@gmail.com> <20200315140525.21780-6-zhengdejin5@gmail.com>
In-Reply-To: <20200315140525.21780-6-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Mar 2020 13:47:53 +0100
Message-ID: <CAMuHMdVwd0jztUc8Yo9Mh3UStve3A7Zkg7t74n=gB6Q-fjvAMA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] driver core: platform: Reimplement devm_platform_ioremap_resource
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 3:06 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> Reimplement devm_platform_ioremap_resource() by calling
> devm_platform_ioremap_and_get_resource() with res = NULL for

s/for/to/

> simplify the code.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
