Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6647C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2BD20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCWMqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:46:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36920 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgCWMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:46:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12so13204724otp.4;
        Mon, 23 Mar 2020 05:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E67n6CwTbk8RP7A9ScDb1eReUhjteCxGgL/uzVVjrZg=;
        b=lHUp7MW/kVwMoij0ECvMZOt1KPsFxh72I4EQFexeGf8AaBiSqNICGTVzAfPOCXkNfq
         NSYirrCmgN5iy2KZiIUiqpTehUtLKlNlzEBCQNeZTA7HNNIpIQsg2k8piuOgSgihLVDg
         T9YF1z0KKgbJ2+FOiFB9utqruXdWvF9Yz0KJ9wNUdsd9vdYsNRIhyaA12gXlkn8A38Bj
         s0NhaJPcTfGRezOa4tiwA3ALqxnchQCSDrXcFsMkuFxX7ZLWuZGlpo5NyTq9tQ+IE6hd
         TrUCkjFgBPSdmjhRYqpkfc+ysljyoCyu1dxl4vCnCLADLLNKe89hLDYcNBIUqAoU2yWe
         Kx+g==
X-Gm-Message-State: ANhLgQ0Jm9RT/+uu/gpNMxJnMGazXTWIfxKE9o8q6rNIBfKSP6TTKJgB
        jL5TtmOsPi84RvY5gqk4RNNWbDliqBsU7P0j0dA=
X-Google-Smtp-Source: ADFU+vsTKtBJiPZEOjxUvJge1cwM8SkNr/CMnNaoFoqd9vb48i+soOhAsbl/RbovK58KkjGCuHNVKqHFFssNSSY4Kss=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr321387otk.250.1584967565718;
 Mon, 23 Mar 2020 05:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200315140525.21780-1-zhengdejin5@gmail.com> <20200315140525.21780-4-zhengdejin5@gmail.com>
In-Reply-To: <20200315140525.21780-4-zhengdejin5@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Mar 2020 13:45:54 +0100
Message-ID: <CAMuHMdVKgRAeXHaHf9Ce9bxKzxgn63qDvpT6HwepdX7-p-s87Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] usb: host: hisilicon: convert to devm_platform_get_and_ioremap_resource
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
