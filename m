Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392DBC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E932072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgCWMr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:47:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45482 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgCWMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:47:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id c9so3022641otl.12;
        Mon, 23 Mar 2020 05:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E67n6CwTbk8RP7A9ScDb1eReUhjteCxGgL/uzVVjrZg=;
        b=q9p4EoRhbkJ3ySAbeTJSTPBszGK+8DLSMignjH35lM0oRnhz4fxfooBgf0LnGlt05y
         WS+ZhDIKPlICDhR7kaDx9e6PRRnBzxJ16x79sLToOUKOJrmDYo9i4LJbzQefaQVnOsCS
         U0blcRcH913vy8J7+nYplhvNqQ16tZrEFMtgijS9jLWKrrRtJu/y6ilfv4PV7p2uXoMC
         Krj2Vf9nd0xZ4bAR2/Aongjoi+a/HdbvCt8WyIbx8rHxSrF3xVGZuuwp5a0arqBukrWW
         4xi9Neeqa8FwkLeNMIA+RQEBMTqM7RcHRoU2mRPzMGHaoq2abOaTt1OOlKYZyo/+D58/
         Dk3A==
X-Gm-Message-State: ANhLgQ0Xo6pL/Lf3LpcgzLhcQW3B2t/QWCDkGk9wzC/0JYcJ8ZKGjs/8
        0IUV4mr3ehACTzhAojrdwHlM54n9z8nEmj9bZZk=
X-Google-Smtp-Source: ADFU+vvAIf5JWg/DzJeGvOtVmYVxfZJkH902ec3aDAMZKmCnAoMjdGGBc2PdZNlwrus/lBB6UZAOnUWk77vrIUskhew=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr17815859otk.145.1584967646401;
 Mon, 23 Mar 2020 05:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200315140525.21780-1-zhengdejin5@gmail.com> <20200315140525.21780-5-zhengdejin5@gmail.com>
In-Reply-To: <20200315140525.21780-5-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Mar 2020 13:47:15 +0100
Message-ID: <CAMuHMdWht-TGGZsrKetXEQ8VTMrZAz+0z3kS+XELu-Vr7HnwAw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] usb: dwc2: convert to devm_platform_get_and_ioremap_resource
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
