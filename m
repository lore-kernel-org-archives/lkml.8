Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ADAC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED542072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgCWMpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:45:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45693 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgCWMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:45:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id l22so3762752oii.12;
        Mon, 23 Mar 2020 05:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E67n6CwTbk8RP7A9ScDb1eReUhjteCxGgL/uzVVjrZg=;
        b=VHshIcIKfc2tjMqfN8ek6uB0/pfnsHvLldslSS5C4uU3tDyD77xR4mw2ofXtYK7hGY
         wW6GBXqvha7rChxhrRHhOUJFw51KOuz/F9TasQm8HDPMyAlgEviVLrKWVM6bn7IE8JpR
         pgvxF+YFO56QKNvTsxaBrr3mNQcuq8Iu7khyrJwDskx7OALvhWdTT5TfysfprWlpWoxs
         SFgt+DtDC2SHQmwebFgTLL5/pYH/1d4QM1XbUj4cB+8JQjpAG5UJw57x74ordsmykSX1
         kQ2YMEmLPYdLxgKrk9cYUKJGNR5ycvnTeIha9/B/Rzh3ufYVL6YRayLdEKiruOk85080
         nhHw==
X-Gm-Message-State: ANhLgQ02h380ZYWfBpLE7aXeWq6YPG6vWiP7o4SmrGaQbqMGxcPXD6Bt
        Jsdo7mzPVYFyPAyeGkeVVMPO+VSvi3SL3QDyHIY=
X-Google-Smtp-Source: ADFU+vuc52PWSUy0x1awcFBXPyzHgRGJzlHiZW3NspcX07XmbIo+/viMmkiqEKebjzt77gQkHX66zQfspmX+ZHwA/5k=
X-Received: by 2002:aca:4e57:: with SMTP id c84mr16135586oib.148.1584967530847;
 Mon, 23 Mar 2020 05:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200315140525.21780-1-zhengdejin5@gmail.com> <20200315140525.21780-3-zhengdejin5@gmail.com>
In-Reply-To: <20200315140525.21780-3-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Mar 2020 13:45:19 +0100
Message-ID: <CAMuHMdWxpgrQ3uXoM76PbYxdcm=i7xy5iBVq1449P8-M=-2h7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] usb: host: xhci-plat: convert to devm_platform_get_and_ioremap_resource
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

On Sun, Mar 15, 2020 at 3:05 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify code, which
> contains platform_get_resource() and devm_ioremap_resource(), it also
> get the resource for use by the following code.
>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
