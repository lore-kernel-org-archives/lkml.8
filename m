Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163FF20702
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAXHvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:51:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38495 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:51:03 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so1057758oii.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 23:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HT2x788AM1A0+5HwkBHH4G8cjfc7f1MBnQHIXAFoYnI=;
        b=Cf9qleF0HFvK1GPVdbnpWXecqZTX+KHInyOtV0X1ML+gTg0qMaJaHR+69kRRXALNm3
         StPZ03V5mlrDXhKFletHkNzcSnlFcPyKZm2qSOGfNG5jATrEvA6VBhqinckLLwMPEQZy
         jKmckqwH74iJNbFF8NJjwo7w5grIbTH0/XvwdXgz/ZMELCLm9oa+OsQ6wduJ6nL0UQRZ
         YlVW2BIkWAiJdC7YT25kCVNfwgTfiIGEhB+conoLdjwiFCWqBlcCZGDuuWhX0QZKbYlZ
         jxf3ClQl52YkUsfiyM/uy7+qQW1Bym+RFtVs6W/i80uIqkEtFXfXl1xva0C1IL8qOoun
         s+Fw==
X-Gm-Message-State: APjAAAWTVeESmlQdb9aW6XaKtBdRyaHKar1NU9vHWOx6Xl8VXUQRgOvy
        fWbgIcaU3rvV+cUUSpznersb+eT8VbgjWpiKy8Y=
X-Google-Smtp-Source: APXvYqxJaLWdwe0RsmxfvQT+clUM3Yv9RXsCnLaveOqiQ7fXlM1Pe5Surtf6FmC+XS21csvE3aA1QZhj3B5AHfJ27SY=
X-Received: by 2002:aca:5905:: with SMTP id n5mr1256281oib.54.1579852262583;
 Thu, 23 Jan 2020 23:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20200123235914.223178-1-brendanhiggins@google.com>
In-Reply-To: <20200123235914.223178-1-brendanhiggins@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Jan 2020 08:50:51 +0100
Message-ID: <CAMuHMdVLcMXyxnoFvoqkt3KbdmXXk+6Swveez9+A_yowFsWRAg@mail.gmail.com>
Subject: Re: [PATCH v2] uml: make CONFIG_STATIC_LINK actually static
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        James McMechan <james_mcmechan@hotmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On Fri, Jan 24, 2020 at 12:59 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> UML_NET_PCAP; this is because glibc tries to load NSS which does not
> support being statically linked. So make CONFIG_STATIC_LINK depend on
> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>
> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes since last revision:
>
> Incorporated Geert Uytterhoeven's suggestion of using a separate
> FORBID_STATIC_LINK config option that each driver incompatible with
> static linking selects.
> ---
>  arch/um/Kconfig         | 7 +++++++
>  arch/um/drivers/Kconfig | 3 +++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c285..27a51e7dd59c6 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,8 +62,12 @@ config NR_CPUS
>
>  source "arch/$(HEADER_ARCH)/um/Kconfig"
>
> +config FORBID_STATIC_LINK
> +       def_bool n

    bool

("n" is the default)

> +
>  config STATIC_LINK
>         bool "Force a static link"
> +       depends on !FORBID_STATIC_LINK
>         default n

"default n" is the default (preexisting)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
