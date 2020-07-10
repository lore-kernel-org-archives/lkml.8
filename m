Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29A1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5C02078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEQvmCMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgGJIpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJIo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:44:59 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F5BC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:44:59 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id d11so68856vsq.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHXlflOXGuztUVgAtLl/DuS9kIGjLj5v35ORjMrhjPE=;
        b=EEQvmCMHjyclSAhI44+gIuqzh+C/J5qzex5wrhW9B0YcxTb/LLpF2j1KmeCXe3r1cs
         sSzo+IO+LroLSEAqbmoNWnJeHHsHwKtxjXCPXTXIx/dtxX2R92YsUyhmIv9SqHInHdWN
         zpvdll5+a8KMZUmi4mN0LMQojweykbDStLGfxo3v1iN7LL3YxO0IfawqU4lEAtU7H0b4
         qILzAEgOGEM4ndIV7zfhHvsn9H2m1aqXXJw3XF1xGsjZXyQDAo1mn6k9lTSNxFB50avF
         h7lL1geyw6ipxhGJV/fCtnr0uYt4rbxqEF73WVGPaCbs4q+Yr+6GXnvtXZUT4Hc30MAq
         ji4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHXlflOXGuztUVgAtLl/DuS9kIGjLj5v35ORjMrhjPE=;
        b=Xw/65IaY4hzHkk78Qhu+rteqXgdBPDWfLi2xoqIDDSFMwNytv1sl196VXsiAL7OFh7
         Ov/YxLf4qyHCIXdeQZwMa/0cCwKaQn6YlxyhS/UrJEa9tmmksndAafHgFi+vyqxAQV0o
         aL+xCZMyKkopMXg4P+3Qh8yJaZd+PnotkMfyTt6FQqfYRnHdiID1oXtZLuFR505mbWsv
         7UByEgBEGU26MqlT4nYrubP/8vi0yOnGnejEj6eiiRR3eIXDeAV54HiyCQY7A+Iz9hA0
         oDgDWbP69v303YWI5SB0/vtjUlsFKbtLx9ka71HUlmm7NCEO3Cnz0hmesbucSW0A3+pV
         mW7A==
X-Gm-Message-State: AOAM531QPZQOwoMoSXqBXpHVpSr3Slw4/QbwCTLSqKpr84wO7qc2xm/H
        RyOYnUsWfVZkD0yQP+rOkNeUDIpTxC/8n+DOgok=
X-Google-Smtp-Source: ABdhPJzIYoseFJB38+HV5mT96b+B83dWVVvKzIDLfH7eNTLgMVXIfXPCAJ9zwTfECX3rxBx84h1GzMhh0nzGD75UN+4=
X-Received: by 2002:a67:fa5a:: with SMTP id j26mr11750292vsq.95.1594370698604;
 Fri, 10 Jul 2020 01:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200710074143.306787-1-christian.gmeiner@gmail.com> <58ef264448eb3ea75f846513210a5430b75b44c6.camel@pengutronix.de>
In-Reply-To: <58ef264448eb3ea75f846513210a5430b75b44c6.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 10 Jul 2020 10:44:47 +0200
Message-ID: <CAH9NwWfQfejtup6hHi68gE_VJs2RkL=298NURELqt3kVfc_AVA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add support for GPU load values
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoi Lucas

Am Fr., 10. Juli 2020 um 10:31 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> Hi Christian,
>
> Am Freitag, den 10.07.2020, 09:41 +0200 schrieb Christian Gmeiner:
> > This patch series add support for loadavg values for GPU
> > sub-components. I am adding a SMA algorithm as I was not
> > really sure if EWMA would be a good fit for this use case.
>
> 1 second is a pretty long window in GPU time. Why do you feel that a
> simple moving average is more appropriate than a exponentially
> weighted one here? Note that I haven't given this any thought myself
> and haven't made up my mind yet, so this is a honest question to
> understand the reasoning behind your choice.
>

I played with both variants but I 'feel' that SMA might be a better
fit. To be honest I
have no background in signal processing and stuff like this so.. I
will go the route you
guide me to :) I have kept the "interface" for SMA equal to the one EWMA uses
so I can easily switch between them.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
