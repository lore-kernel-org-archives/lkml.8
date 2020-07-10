Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8E3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619A920772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB3hp2BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGJMVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:21:53 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791FCC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:21:53 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id p6so1747792uaq.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TgeLsUmnXThRSQEB4YH187Eiq+CFVWS58pzrpKP+ZS0=;
        b=RB3hp2BEo+UwUaIjYC/Q8v6o1wEqM7gqrDFixlj3pyha6bqFMgRUN3EqxP1tRt2PkF
         5Wgdo7XU0hIcmKhSrmr42KqFKKgi5ccp/rl85g0G5C7J1iK0y0R2IHEN230FkUuO6aYX
         u5INsDbLPSplTDkv2TH9pvjcAULiqV967snj972sJR+S3rN15TB6yRNj6l3f1dkUBJAG
         r3sSjT0JxRs9qIrqIQ6Jh87LBJWI6v5/z85dJ/CxpwtnR33/2JdhCR9VL2bo8l0Hdu3c
         +YW15c+KV4RLcoThYWqu35dBpUUpzjAQ9xBrS9cfL83vpFx+CNxUKspUrJtJt+5qLocE
         epJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgeLsUmnXThRSQEB4YH187Eiq+CFVWS58pzrpKP+ZS0=;
        b=jkWltjDUdRowChPnFldbVOTdPoYOxzciM9D+O9nssa1w7hZV4ZQRfKXIVf2NymbSyK
         lKKU2Waot877233BRJBKViAa8UIeijC1FsAcdWf4Yg5PkOw147HBvZJCSK4zlo8lnq8C
         NLdI20cpqbPBimaZWrRQXkNe41hVe1YHN4guJQPUw8DH69r7gTuhWN7VlDnHmea2ehs5
         CWkNSNZA7PxH3zAm/vplBXSzNB2RY0Y1yPTiYl3Ib6Do6l7jROVDnjfF4sEZapCfELu8
         oqWIVpxJru7uuKiHyi4l1wWqK3/k66u1TF618tL4DIgbm8Q4YF/DSUPIMwA5hpIQQcKF
         1lGQ==
X-Gm-Message-State: AOAM533FtjxLWbKwxgnVY3IpZT6e+E2A8YH9yGx1BTlp7cog8ze8w5XP
        aFqctS/gFjP7L8K15+Ud4r1s9XNQK5MOWEu/by8=
X-Google-Smtp-Source: ABdhPJyyfDd2wiuB9CV7CAJ0532vQqPmz8MkL+LuqPhLdEyP/fWS6Vsgoep4ssp74KuTs4NdiHswa76kDE+CknfX3UU=
X-Received: by 2002:ab0:1461:: with SMTP id c30mr9003027uae.124.1594383712724;
 Fri, 10 Jul 2020 05:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200710074143.306787-1-christian.gmeiner@gmail.com>
 <58ef264448eb3ea75f846513210a5430b75b44c6.camel@pengutronix.de> <CAH9NwWfQfejtup6hHi68gE_VJs2RkL=298NURELqt3kVfc_AVA@mail.gmail.com>
In-Reply-To: <CAH9NwWfQfejtup6hHi68gE_VJs2RkL=298NURELqt3kVfc_AVA@mail.gmail.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 10 Jul 2020 14:21:41 +0200
Message-ID: <CAH9NwWe1XSY_HtYdn=TVMRQov0m5T2CNtKpY8UZqbf6OUZHV2Q@mail.gmail.com>
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

Hi Lucas,

Am Fr., 10. Juli 2020 um 10:44 Uhr schrieb Christian Gmeiner
<christian.gmeiner@gmail.com>:
>
> Hoi Lucas
>
> Am Fr., 10. Juli 2020 um 10:31 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
> >
> > Hi Christian,
> >
> > Am Freitag, den 10.07.2020, 09:41 +0200 schrieb Christian Gmeiner:
> > > This patch series add support for loadavg values for GPU
> > > sub-components. I am adding a SMA algorithm as I was not
> > > really sure if EWMA would be a good fit for this use case.
> >
> > 1 second is a pretty long window in GPU time. Why do you feel that a
> > simple moving average is more appropriate than a exponentially
> > weighted one here? Note that I haven't given this any thought myself
> > and haven't made up my mind yet, so this is a honest question to
> > understand the reasoning behind your choice.
> >
>

I have v2 ready except for this point. If you want to go with EWMA could you
provide me with a good weight reciprocal value to use?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
