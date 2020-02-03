Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23049C3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EBE20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBCUeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:34:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39750 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCUeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:34:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so14968921oty.6;
        Mon, 03 Feb 2020 12:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1awlRyPQngN92Q+vn5EkE9rkC6ipnhyywHAiRBkgK0=;
        b=TdC8u13ERt/GxQVrYYOmZSCif2pi8WMarg2Bfevxx0cXFc6GpNHsVqX4IXRvJL9LUs
         IO6BzfXBH7BQSeWMmolfE1RCl53QUAr4Sfq/jUQvvrlWJCnlv9UhQBkEct4v7yZqcDvM
         Zo5u4inGnoQ0AV+LDbAQ0y1m6h1iZLuYkvAhN7S5R2gqUYyjt2jA8LL9pE4acIwhMiTk
         oKD8pINIejaQOOFKIPRHJjfuWoIov3MB0zHYgyrjhqkYJVdR0aVj/QEHmtwIeRfpiDqK
         aLQQtho2xoMn9ryv+kl2y83Q2Ngwgke7CxBoKsQrMbMAtvByopl+QfzgqB8Yj7/d6N3H
         iIJw==
X-Gm-Message-State: APjAAAVbBRN616vbTX3ivrQQzJlDDJ5aPrahtuvn475sw+53hUMGNSdh
        2nKUSFYiH+1Cn0AOz17Ay7jaW5Urkuzw4PSJcYB6tA==
X-Google-Smtp-Source: APXvYqzT4DAhJUbzklykFKYFQH3361LGrRkSFLHH5wFwmhHfw2/RxLkfBpujmNveOkbPSZwrV8fr8F6SeIhx7UaQeQc=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr19131655oth.145.1580762063293;
 Mon, 03 Feb 2020 12:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20200203101806.2441-1-peter.ujfalusi@ti.com> <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com> <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com> <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
In-Reply-To: <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Feb 2020 21:34:12 +0100
Message-ID: <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards dma_request_slave_chan()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
> > Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>
> FWIW, there is a patch set by Yoshinori Sato to add device tree support
> for classical SuperH hardware. It was never merged, unfortunately :(.

True.

> > Anyone who cares for DMA on SuperH?
>
> What is DMA used for on SuperH? Wouldn't dropping it cut support for
> essential hardware features?

It may make a few things slower.

Does any of your SuperH boards use DMA?
Anything interesting in /proc or /sys w.r.t. DMA?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
