Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83D4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD98E2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X86ZIrwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFRArH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgFRArG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:47:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90A3C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:47:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so1955251pfw.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 17:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=f6j4+8YevQh47RsT4brCAj4c/xJHHLkwlwNASfer+2E=;
        b=X86ZIrwRyriUEhya6GQsS4aS4zYZCHlE8tAyb4UEPbu//ePFnoKFuqF52QqvCi81rp
         YmX+NUVf2xGP0/eOvc+Vb2H3I0GGzcN2CaZ61yDCMwJCk+TPGkRC+8RjODPnC2GAD90o
         H76jrftuLRumrNeEyfIxhCeRCQHiCEOXmZAU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=f6j4+8YevQh47RsT4brCAj4c/xJHHLkwlwNASfer+2E=;
        b=poncwZ6k9kga84NRhoPft4/ipxOLB06SSWOAAoEq77Ommi3LSu0LslBo+lpGedG3q9
         +RX+fJb5IoGdXX/C5aTeqsGtPnsCavcsBetGZGEfmvUUUePpEMEBAE56QiFCVKRkvMXL
         DIvbNLfUICHcn5wfJH2AIDoxjSv/UpnrosffZJqkkDHGXmG4JWAjDR/A73RwDFGlgUuQ
         LwfRNKiKu8mvHHd7nmlGqft4SdUGWrgomi5OarRBDPW+AtsE+G6ZPVVIb6Ml/5+Ta9tA
         p90HBbgKRxb/wD4AOA5Spa/llF7sSTfuky0w+KapNAFmtZr/N8OK1VqamBXYgHdE1bVG
         kC5Q==
X-Gm-Message-State: AOAM530PljLrBDTmvZxD5eYAA7gRsfIgBtHkYe7c/trchzNk7mjV1AH+
        XoVgD2pn1/cMH0kBgdYZ2PxZrg==
X-Google-Smtp-Source: ABdhPJxXLLCHetyZa/AzIkbmdiT4LYl0lQi6uP/TkG15L0lSnrBpz2tToB6Z776bsazLXRqsoEkPwA==
X-Received: by 2002:a63:ff52:: with SMTP id s18mr1267367pgk.203.1592441226154;
        Wed, 17 Jun 2020 17:47:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q11sm608773pjq.52.2020.06.17.17.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 17:47:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=UmH2WwhyZZSyuYE2n2BzaS8486Bu2fMHu+RFfX5x3MUg@mail.gmail.com>
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.2.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid> <159242718864.62212.18160698526818943096@swboyd.mtv.corp.google.com> <CAD=FV=UmH2WwhyZZSyuYE2n2BzaS8486Bu2fMHu+RFfX5x3MUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] spi: spi-geni-qcom: Mo' betta locking
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Jun 2020 17:47:04 -0700
Message-ID: <159244122443.62212.12188134609709828571@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-06-17 14:19:29)
> On Wed, Jun 17, 2020 at 1:53 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2020-06-16 03:40:47)
> > > If you added a bit of a delay (like a trace_printk) into the ISR for
> > > the spi-geni-qcom driver, you would suddenly start seeing some errors
> > > spit out.  The problem was that, though the ISR itself held a lock,
> > > other parts of the driver didn't always grab the lock.
> > >
> > > One example race was this:
> > > a) Driver queues off a command to set a Chip Select (CS).
> > > b) ISR fires indicating the CS is done.
> > > c) Done bit is set, so we complete().
> > > d) Second CPU gallops off and starts a transfer.
> > > e) Second CPU starts messing with hardware / software state (not under
> > >    spinlock).
> > > f) ISR now does things like set "mas->cur_mcmd" to CMD_NONE, prints
> > >    errors if "tx_rem_bytes" / "rx_rem_bytes" have been set, and also
> > >    Acks all interrupts it handled.
> >
> > Can we get a CPU0/CPU1 diagram here? At point e) I got sort of lost. And
> > maybe it's not even a dual CPU problem? i.e. it can happen on one CPU?
> >
> >     CPU0
> >     ----
> >  a) spi_geni_set_cs()
> >      mas->cur_mcmd =3D CMD_CS
> >      wait_for_completion_timeout(&xfer_done)
> >  b)  <INTERRUPT>
> >      geni_spi_isr()
> >  c)   complete(&xfer_done);
> >      <END INTERRUPT>
> >      pm_runtime_put(mas->dev);
> >  d) galloping?
> >
> > I got lost... Sorry!
>=20
> I think you need two CPUs, at least for the race I'm thinking of.
> Maybe this is clearer?

With threaded irqs I think you only need one CPU, but that's just a
minor detail. Drawing it with two CPUs is clearer and easier to
understand.

>=20
> CPU1:
> =3D> spi_geni_set_cs() starts
> =3D> spi_geni_set_cs() calls wait_for_completion_timeout(&xfer_done)
> CPU0:
> =3D> geni_spi_isr() starts
> =3D> geni_spi_isr() calls complete(&xfer_done)
> =3D> geni_spi_isr() stalls
> CPU1:
> =3D> spi_geni_set_cs() call to wait_for_completion_timeout() finishes
> =3D> spi_geni_set_cs() exits.
> =3D> spi_geni_transfer_one() is called
> =3D> spi_geni_transfer_one() calls setup_fifo_xfer()
> =3D> setup_fifo_xfer() sets "cur_mcmd"
> =3D> setup_fifo_xfer() sets "tx_rem_bytes"
> =3D> setup_fifo_xfer() sets "rx_rem_bytes"
> =3D> setup_fifo_xfer() kicks off a transfer
> CPU0:
> =3D> geni_spi_isr() finishes stalling
> =3D> geni_spi_isr() sets "cur_mcmd" to NULL
> =3D> geni_spi_isr() checks "tx_rem_bytes" to confirm it's 0.
> =3D> geni_spi_isr() checks "rx_rem_bytes" to confirm it's 0.
> =3D> geni_spi_isr() clears any "DONE" interrupt that is pending
>=20
> I can update the commit message to have that if it's helpful and makes
> sense.  In the above example I have a fake "stall" that wouldn't
> really happen, but in general if adding a delay somewhere creates a
> race condition then the race condition was there anyway.  Also, with
> weakly ordered memory it's possible that a write on one CPU could
> clobber a write made by another CPU even if they happened in opposite
> orders.
>=20
> The race is fixed by my patch because when CPU1 starts
> setup_fifo_xfer() it won't be able to grab the spinlock until the ISR
> is totally done.

Ok. This would be the diagram then if it looked like this:

  CPU0                                         CPU1
  ----                                         ----
  spi_geni_set_cs()
   mas->cur_mcmd =3D CMD_CS;
   geni_se_setup_m_cmd(...)
   wait_for_completion_timeout(&xfer_done);
                                              <INTERRUPT>
                                               geni_spi_isr()
                                                complete(&xfer_done);
   <wakeup>
   pm_runtime_put(mas->dev);
  ... // back to SPI core
  spi_geni_transfer_one()
   setup_fifo_xfer() =20
    mas->cur_mcmd =3D CMD_XFER;
                                                mas->cur_cmd =3D CMD_NONE; =
// bad!
                                                return IRQ_HANDLED;

    =20
Time flows down as it usually does in these diagrams. No need to put
stalls in. Reading all those lines and holding which CPU they're running
on makes it harder for me to see the two running in parallel like is
shown above.
