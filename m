Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14182C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD44204EF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgFCIa4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:30:56 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37400 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCIaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:30:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id v13so1239366otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 01:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U6qZ93VvGwXru+l0dh2qEs4p2XfkbRBPXJmEOvvmIVU=;
        b=OLIaQzbLoVKbF0/2yV4sEpFgYtrNrZcQwyTZOZ0aQbgiCdU9xmRDertBf/KWPV4o6n
         HU5wEZ0vpX5UOye1+YkW9FLSGo8X3xdGCwu/1qgjLIegBhlZI/cKqmKqEP2asYhcPUOX
         HKUmcWtUUVELmfKHkkw76LE0ofcPtHEsGTLghmby9tYBbwzgjrK9FbJcxwYSKSwu//Qa
         TTebEBaQ97hkoVEQz241UN1tweVQC0E6Jd0P6RTzBdYsXiuiF5D2L1/K+5fAUn4g36YF
         Y80XnjTpjZYNZ+SmieYRHkxe1UEasWY68L9wb+9cBDZ6ZWgAqCRVERf79TE2uNH5unpV
         i8XA==
X-Gm-Message-State: AOAM532GcXZPNNI5l+oQ2Hs2iT61mLTu6qE2skZ3vSsQEquACybdZzvp
        rdcpyHJ8aRGwRzmBeSLV4XfhJP+byoVtdZcvRGg=
X-Google-Smtp-Source: ABdhPJwOkUOdFLHPzhf+sPNm4OOhjm+fa/c66A3/ZZc8PG07CHs1PLX4qokComSCrrRobOmbxLY+eqvr7YhEuPVaCVQ=
X-Received: by 2002:a05:6830:141a:: with SMTP id v26mr2408163otp.250.1591173054754;
 Wed, 03 Jun 2020 01:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200603064509.32736-1-hpeter+linux_kernel@gmail.com>
 <CAMuHMdV3sNojXqaxLmVjK3ziGugd3cWEKfLXikDwvaOmocTCzQ@mail.gmail.com> <65b25d4b-39ad-e5be-ecfd-39bdc7ae9458@gmail.com>
In-Reply-To: <65b25d4b-39ad-e5be-ecfd-39bdc7ae9458@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Jun 2020 10:30:43 +0200
Message-ID: <CAMuHMdW8ZcrMaABaR0th493bo+f3dPwWB+BWfD_LaWwOHO3-Sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] driver core: Fix unbalance probe_count in really_probe()
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, peter_hong@fintek.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji-Ze,

On Wed, Jun 3, 2020 at 9:35 AM Ji-Ze Hong (Peter Hong) <hpeter@gmail.com> wrote:
> Geert Uytterhoeven 於 2020/6/3 下午 03:13 寫道:
> > If devres_head is not empty, you have a serious problem on your system,
> > as those resources may be in an unknown state (e.g. freed but still in
> > use).  While I had missed the probe_count imbalance when implementing
> > the original change, it may actually be safer to not decrease
> > probe_count, to prevent further probes from happening.  But I guess it
> > doesn't matter: if you get here, your system is in a bad state anyway.
>
> We want to fix the shutdown/reboot freeze issue and bisect to this
> patch and found if the probe_count != 0, the PC will stuck with
> wait_for_device_probe() with shutdown/reboot forever. So we just
> change the increment after return -EBUSY.

IC. And before my change, you got a big fat warning backtrace, telling you
something is seriously wrong? ;-)

> In this case, it maybe 8250_PNP & serial 8250 platform driver resources
> conflict. I'll try to dump more message to debug.

OK.

> IMO, the shutdown/reboot operation should not block.

Well, it depends.  If there's an issue with resources, the system may crash,
too.

> >> with serial8250 platform driver. e.g. AOPEN DE6200. The conflict boot
> >> dmesg below:
> >>
> >>          Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> >>          00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 921600) is a 16550A
> >>          00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 921600) is a 16550A
> >>          00:05: ttyS2 at I/O 0x3e8 (irq = 5, base_baud = 921600) is a 16550A
> >>          serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 921600) is a 16550A
> >>
> >> Reboot/Shutdown will freeze in wait_for_device_probe(), message as
> >> following:
> >>          INFQ: task systemd-shutdown: 1 blocked for more than 120 seconds.
> >
> > Now, how did you get to this state, i.e. which driver triggered the
> > "Resources present before probing" message? Because that is the root
> > issue that must be fixed, and the probe_count imbalance is IMHO just a
> > red herring.
> >
>
> Sorry for lost important dmesg:
>
> Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 921600) is a 16550A
> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 921600) is a 16550A
> 00:05: ttyS2 at I/O 0x3e8 (irq = 5, base_baud = 921600) is a 16550A
> serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 921600) is a 16550A
> platform serial8250: Resources present before probing
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OK. So the serial8250 driver does something fishy.

When the warning triggered for me, it was due to a driver calling a devm_*()
function on a different device than the one being probed, cfr.
https://lore.kernel.org/r/alpine.DEB.2.21.1911201053330.25420@ramsan.of.borg
which was fixed by commit 32085f25d7b68404 ("mdio_bus: don't use managed
reset-controller").

The serial8250 driver, or the subdriver for an SoC-specific variant, may
do something similar.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
