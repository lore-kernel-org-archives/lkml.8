Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF98206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgGFJyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:54:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47945 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:54:20 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGzDv-1k5G8n2R3T-00E1bd for <linux-kernel@vger.kernel.org>; Mon, 06 Jul
 2020 11:54:18 +0200
Received: by mail-qk1-f172.google.com with SMTP id b185so23571340qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 02:54:18 -0700 (PDT)
X-Gm-Message-State: AOAM5308NGPfl05De0IDhrJYkS8+WPNTfOHTrNmpxYM0sfHRL8isZUwX
        KIzD9MreFfQ9BKTQC7rBMSRxfxc0cvbY+W0sEuw=
X-Google-Smtp-Source: ABdhPJyI+T0XwLNN+frxQL1BscXmAJg7nv/4NCAKtRRhcWmBGieWiHxBlU3HK4v/EGx8e/2Vj/78baWXJ4QgU6Zm3Xc=
X-Received: by 2002:a37:a496:: with SMTP id n144mr45967200qke.286.1594029257459;
 Mon, 06 Jul 2020 02:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2zzXHNB7CX8efpKeQF2gJkF2J4FwafU58wT2RGvjjTxw@mail.gmail.com>
 <CAFmMkTHrQ4LZk4+-3kdJ+dc47MXR1Jd76AXbO-ceT2zsfDRFGQ@mail.gmail.com>
 <CAK8P3a1bbpmD0wJkhkjqW9YttBpMmdn8Z5oTLm0cr-0gjyU2zA@mail.gmail.com>
 <CAFmMkTE3z6OZQ_v3jx-4MzMr8v+4qcF2uLn0ASGydj5oqDnfjg@mail.gmail.com> <CAK8P3a2G_UzKv5HmQk1gyaHXY+YzVedknwof+9fmCjQuF+hu2A@mail.gmail.com>
In-Reply-To: <CAK8P3a2G_UzKv5HmQk1gyaHXY+YzVedknwof+9fmCjQuF+hu2A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Jul 2020 11:54:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2TUAfhdoAL7u2fun7ZztrjGLxAGAX-WWDqsyNqP2=gZA@mail.gmail.com>
Message-ID: <CAK8P3a2TUAfhdoAL7u2fun7ZztrjGLxAGAX-WWDqsyNqP2=gZA@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LX/ZL4RL97tfg5BTf5fkFx/XD/SJ9nQeZ3mhU+HpDDffkkVefQA
 g7jaIcSW7M4xwyDveoAyWgCTiWAQPMsKDnw8BI54zMf5s1Wk/9iu/fERvE1KM+Bp2s9la0+
 D5Hpyp/MPgoXCYdSbLbdo2AO6RqnEzj0c59kEc+g0OAajORvrL85IASRHNOJBK6x0FJ0VL0
 qOrsa4eETYeQdpHXLm+HA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BIqU10ElbOo=:mTMzrlXygrGqlIziKIBWwo
 SW1D9bdfuqXNsZjC+T/rM7bGdD/8l5HHEoGoMHQv213fYNM1PgE7I6HtfTjvaeHT7M4PJ+jzl
 ibVHcLx+0B02LXvqWjYFsIBve70ZrMBwKpj2sNs1U++2PqGPhA4dT45K4nvj3PL7lnwKMqE/s
 qZ5Ri591lUoRs02DOPrzGwnjoSVdgOSPsGk0Uw+dH9/g+SSyU8hTbG2ctQY8nBZOR9M9I+1jx
 5byU5sWfiIRh+RS3bUOlvQRR5ILSnTwEJ3qvPi8BljRZQP0nYo0eaq+QkqRsWmlNZljPQRHnh
 eyTx2CzYitq9FZWzr5DPj3QmGZmG9c0Pppt7NpZTlvQkvXP9wB+Z3MDR5+4L2MhBtzZeBkRRX
 7lzxOepvMKyfkeNHAwuEv9OWZFpjuGez8o9KRSKEWew3wbjlr+e65neGm0sPMVcOcs7ii/Mv1
 QUjBHvQ3gql3qXcTVSOWB4saCtnVsXVm7VTsyjjHXpi7+PiW1295eNdzXoBRIc9JW6wh0dVg3
 sQXqhyXCnm/HiFerJPzgDXCTO/uY/nPTdLr5DhdrLMCnILLBQWoc0fzahxEUtPb6L8lXdFsVe
 /vBDW9FwOGp9mCoVO5QQgfYMxmJ2mNLrcSFOySxhu22Kj9qVN1LvGFQGxTi8THU8TzBpE/Pol
 RkMOuJZglbamvFKFywvuXkHN9cFuJiqo/09eRsYSC94En4nP4tGwrsAuZ5FbreIoiXswTOUlJ
 fWzmg2O5JJSVHg9sOlijGgS4OH91XrDXPX15xDB8JxfpDY4oMor4TNMOeVedOUTbgvwH1AZKT
 bNyrw11IYIeLMClyzWcRE2sZb4ck+856R2AOPBY2lePXsH1Fsg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 11:20 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Because of these reasons, I'm proposing a misc (not-device) driver that supports
> > many Intel architectures (and families) to expose the information.
> > I understand your proposal to first enhance existing _device_ drivers, but I
> > couldn't find suitable options.
>
> Maybe try adding an interface to one of the drivers at first, and then extend
> it to the other hardware after an initial code review. Do not bypass the driver
> model or try to do everything at once with a single module that knows
> details of multiple unrelated hardware implementations.

To clarify further how I think you can have a chance of getting the
interface you want, here's a step-by-step list:

1. keep the current securityfs interface (or any other user space
  ABI if you have already changed it), but put it into a separate loadable
  module with a pair of exported functions:
  spi_lpc_register_info(struct spi_lpc_data *info);
  spi_lpc_unregister_info(struct spi_lpc_data *info);
  The names will have to change later, but the idea is that any driver
  can just pass the information you want to export to user space,
  and the interface module does not care where those values came
  from.

2. For any PCI device ID that is handled by drivers/mtd/spi-nor/intel-spi-pci.c,
  move the code to call the function from your driver into that file,
  reading the registers with pci_read_config_dword() or
  readl(ispi->base + CONSTANT).

3. For any PCI device ID that is handled by drivers/mfd/lpc_ich.c,
  do the same by moving the code to
  drivers/mtd/spi-nor/controllers/intel-spi-platform.c.

4. For any remaining PCI device ID you look at that does not have
  a driver, create a new PCI driver that binds to those IDs and
  does the same thing. If you have multiple device IDs that
  use the same register layout, then handle those with a common
  driver.

      Arnd
