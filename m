Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DD7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DAA206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rftMDQzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgF3JNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgF3JNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:13:43 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00044C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:13:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so14982706qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 02:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NiaAQZb6e16RNNwC58Ig+5aKFcoVz1kh1EE7z1LSbO0=;
        b=rftMDQzUsnWJRbvKE710N3N7H9ymntoND40Bj8Ft2pc4kSO8W04Lgrv1xzvY4J1Bl3
         +UWCCL6JciQsaoJ9MYKzReREtjBH/5Vl3Ud5qy7a4wEeAYLdv6wj91fUKIrLN8n7/ezw
         +Ltt3x9iRmvM3jA9EIlBfNtZgnKX81F5Z7I5V+V3WCZjT2UJICp+to6FrKLrVor2qhwr
         GNl7MdqXujhtJRgAOotb0YWeIIB1l4mYzYdh1+htIRnPUUSrWMDhrr+c/VxhbE6LQtlj
         34481H7fX2umXtLGDhf4IQzN82CzNThDoMuanmdbBt6GDpPV7h5przEpZXJ5xZgfIKCH
         BsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NiaAQZb6e16RNNwC58Ig+5aKFcoVz1kh1EE7z1LSbO0=;
        b=fwazgiiqJ05wMzIGH9WiiXP0VadxPRw5U23mbmyDNgRhTIKGNNDyladg7hkcatWI5j
         Am74pZVgdVOpk+PHtqDLKkDl0GDNK0mXI78xtWHBAfN7fJCXsxqNkjZtGygxcVlWuxuI
         x5twhoi0YrMLg+JKq09EKppMUzl9adJSW90+ann3XEEp2mBx4wofE+sqx3gUWqVgjc5f
         2YZWFd5LoI6bw7qBv23GR1RindJFA9ax/UDzq3sI1620PUNc5z5GD1QBa0YHmpvWLf4j
         8z/LFT37MfdWGO2XW0qtTvB48yizTMp4fIUSbCCllXyRGFpmY0VT9gRqmIn45oXng0KD
         nBdw==
X-Gm-Message-State: AOAM530eNxXE+Er+AxvCTeNDWBRuP3EPAF021FLVQIePJ4tnNS6q2fUQ
        zM4T3k2T7HitMYpYRQHYRc2DJZUBHnFxXuHt8ergJQ==
X-Google-Smtp-Source: ABdhPJzDAAzCHsuXTek0a114336cynJGittTkzm51tTWGOlNq0w2PjNG7rgt5mcKicjSeSki0XFVAa7qvDKPbbdt2IY=
X-Received: by 2002:aed:2a75:: with SMTP id k50mr19148818qtf.27.1593508422149;
 Tue, 30 Jun 2020 02:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13> <20200629195044.uvgma53cajiko3gf@pengutronix.de>
 <20200630085828.1aebdf99@xps13>
In-Reply-To: <20200630085828.1aebdf99@xps13>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 30 Jun 2020 11:13:31 +0200
Message-ID: <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 8:58 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Uwe,
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote on Mon, 29 J=
un
> 2020 21:50:44 +0200:
>
> > On Mon, Jun 29, 2020 at 04:08:44PM +0200, Miquel Raynal wrote:
> > > Hello Uwe, Thierry,
> > >
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> > > 12:54:53 +0200:
> > >
> > > > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > > > functions but can also manage the intensity on each of its ports wi=
th
> > > > PWM. Each output is independent and may be tuned with 16 values (4
> > > > bits per output). The period is always 32kHz, only the duty-cycle m=
ay
> > > > be changed. One can use any output as GPIO or PWM.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > >
> > > Can I have a status on this patch please?
> > >
> > > If it was forgotten, I would be good to have it queued now, otherwise=
,
> > > may I know the reason?
> >
> > You could reply to my feedback ... If you could say there: "What you
> > want isn't possible" I'd count this as a strong indication to not ask t=
o
> > implement Andy's suggestion. (Even if this would be possible, I'm not
> > sure this is a good idea, but still ...)
>
> Sorry for the misunderstanding, but I already replied twice to Andy
> about this. Once in October, again in November, then I gave a shot to
> the idea of splitting the drivers (GPIO vs. PWM) in January. So I
> thought you were sharing your thoughts out loud but was not expecting
> any specific feedback on it.
>
> So, no, even if the idea might make sense, it is not doable in a
> reasonable amount of time. I am not saying it is impossible, but someone
> has to think about it deeper and propose a core structure to handle it
> in a generic and clean way so that other drivers sharing the same
> properties can rely on it. I am not qualified enough to do it the proper
> way in a reasonable time frame.
>
> Thanks,
> Miqu=C3=A8l

Hi Miqu=C3=A8l,

I can't find anything in any of the previous threads. What was the
reason to not go the MFD way here?

Bartosz
