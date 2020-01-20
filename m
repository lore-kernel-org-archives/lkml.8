Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06820684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgATKKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:10:50 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33836 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:10:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so28060644oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+qrvwPOgPvxahwyd5KQ9RV4ePgSqOg74nqe3gTMzKQ=;
        b=ht9klnZWl8O2GamZhWufGxLdYMNY5VClxaCfh645IjhWi/mCMs5MQDA0BMj5xjZF6P
         cRjjIuIYe3vgfVGIfJvD87ETKBMGnXfloWZuQv/2HXf959fTh9RWGteUL4a/2AW+TVxi
         wrgqf6jvT2t8127pTlYKyAHZ9/ZTys0keMrUVoO3p0cyC5I/CysnLcu+sBsda1OCuEsW
         vvq/AR15e/hviMIUM0GaS3UMFlsSoyvC2tpAIbnrB+6KWoMIfI8760KlBG5Ron059YU2
         UEWHJnI/DVmSg35jLbG/h4Pm6S/rmN3B0K35rzDnFzipaQ3cbuuGNduaB7OKMQOfgcra
         wLpA==
X-Gm-Message-State: APjAAAVy5RS5xfxgJU1bBJcWjI5IKtSt9i6/hhzyyoqZq+vDjyf2Br9C
        OqrUCJtV6FsoYZyN0sVfoyd/afHUfcb3iytLh0u3LYCp
X-Google-Smtp-Source: APXvYqxBD1lgBtsNPuNMqT1o27W7Ir+ePtVv464K7y/05wcGh/xr4/6RJVBUe/4BzfIfkFWOB49rWDJJVkncf5LeRX0=
X-Received: by 2002:aca:5905:: with SMTP id n5mr12459471oib.54.1579515048959;
 Mon, 20 Jan 2020 02:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20180802193909.GA11443@ravnborg.org> <20180802194536.10820-2-sam@ravnborg.org>
In-Reply-To: <20180802194536.10820-2-sam@ravnborg.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jan 2020 11:10:37 +0100
Message-ID: <CAMuHMdVP4UwGYuNcOphPO9F2pSCaHS1j-ODxYrv_LNOoo_4coA@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

(stumbled on this accidentally)

On Thu, Aug 2, 2018 at 9:46 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> The pardata supports implement a simple bus for devices
> that are connected using a parallel bus driven by GPIOs.
> The is often used in combination with simple displays
> that is often seen in older embedded designs.
> There is a demand for this support also in the linux
> kernel for HW designs that uses these kind of displays.
>
> The pardata bus uses a platfrom_driver that when probed
> creates devices for all child nodes in the DT,
> which are then supposed to be handled by pardata_drivers.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

> --- /dev/null
> +++ b/Documentation/driver-api/pardata.rst
> @@ -0,0 +1,60 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +Parallel Data Bus/Drivers
> +=========================
> +
> +Displays may be connected using a simple parallel bus.
> +This is often seen in embedded systems with a simple MCU, but is also
> +used in Linux based systems to a small extent.
> +
> +The bus looks like this:
> +
> +.. code-block:: none
> +
> +       ----+
> +           |  DB0-DB7 or DB4-DB7      +----
> +           ===/========================
> +           |  E - enable              |  D
> +           ----------------------------  I
> +        C  |  Reset                   |  S
> +        P  ----------------------------  P
> +        U  |  Read/Write (one or two) |  L
> +           ----------------------------  A
> +           |  RS - instruction/data   |  Y
> +           ----------------------------
> +           |                          +----
> +       ----+

Oh, cool!  Looks like this can be used by the hd44780 driver.

    Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
    drivers/auxdisplay/hd44780.c

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
