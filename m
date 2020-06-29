Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264022078A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUksazA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgF2Xpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgF2Xpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:45:44 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05063C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:45:44 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k7so8854537vso.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYI3mC1TPWWNCe5dapKUu8m35ZbqtEKTTLgsE9b3Fkw=;
        b=TUksazA+FGM3tucKqjgqZrt9NinjymNomhfIBEhZ4zMzZqHhHj+tz5ZLgmJ2Zd0pbP
         jOtLn2445dpX0VSLOa02xXSbZVWvTtP8p6O5h+oU67hNQPp3Kn8EbdweXGQly9MscT6r
         sNzdpzM4hLW9cT6jYanMVyeZC5rRI6yB6SolM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYI3mC1TPWWNCe5dapKUu8m35ZbqtEKTTLgsE9b3Fkw=;
        b=LE4nTC1nsXKcxrUByV7SDrJF7wUpEod0GCAuOuvcsNZCGbMqnNlLSBZO2T/a8EktH6
         L52F5tli9A2lnK1FNvNFx2V424QYHpksS4/rE62FbRbYRpfyygwDmBdjC1YcuB/2pmLG
         5JxSZ3Cl/Gm6NpXv6l76Z/ZcE81jO2bt9Cyr2fcbG94WdeWO9m2ku+lDwF95FoVor8uh
         9AR7V+UcAOLvXfdHTT724kFDDNYo/SN9C7/wh+9k6lJb0ia6Uyj5dJLXiJds+VwbYMjL
         ETEJ86L1mGuRG/9D7mgCexsReR1nlLflNcxsprHVO+0e9CIoFrb+ffVfGami4oBFL8tF
         ntmg==
X-Gm-Message-State: AOAM5303cSBtw9thE/QWUzy3CW433FfGNCdq3QvOWAfqrdnNTB8Gjtki
        pIMRfhhn8faT7IxCPPGjvzcF2Hcr4ks=
X-Google-Smtp-Source: ABdhPJxDcvBGN84xrZWc6Bv39V/+NlXm3zrFTk/301sQG19c15m+vOJwaw9g5xq/xVXXrGyTNZYvNg==
X-Received: by 2002:a67:841:: with SMTP id 62mr8531280vsi.226.1593474342981;
        Mon, 29 Jun 2020 16:45:42 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id u20sm129198vsk.6.2020.06.29.16.45.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 16:45:42 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id m25so10195997vsp.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:45:42 -0700 (PDT)
X-Received: by 2002:a67:ec58:: with SMTP id z24mr8146370vso.109.1593474341915;
 Mon, 29 Jun 2020 16:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200626151946.1.I06134fd669bf91fd387dc6ecfe21d44c202bd412@changeid>
 <20200629115316.GB5499@sirena.org.uk>
In-Reply-To: <20200629115316.GB5499@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Jun 2020 16:45:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULboyqRb1-1o1dq9Z7FGQ2gwb3oJi2bWLwZsXu6cybpw@mail.gmail.com>
Message-ID: <CAD=FV=ULboyqRb1-1o1dq9Z7FGQ2gwb3oJi2bWLwZsXu6cybpw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-geni-qcom: Don't set the cs if it was already right
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 29, 2020 at 4:53 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jun 26, 2020 at 03:19:50PM -0700, Douglas Anderson wrote:
> > Setting the chip select on the Qualcomm geni SPI controller isn't
> > exactly cheap.  Let's cache the current setting and avoid setting the
> > chip select if it's already right.
>
> Seems like it'd be worth pushing this up to the core - if we're
> constantly setting the same CS value then perhaps we ought to just stop
> doing that?

Posted:

spi: Avoid setting the chip select if we don't need to
https://lore.kernel.org/r/20200629164103.1.Ied8e8ad8bbb2df7f947e3bc5ea1c315e041785a2@changeid

I see that you applied my patch to "spi-geni-qcom".  If the patch to
the core looks OK to you and lands, I think the one for the driver can
be reverted (though it doesn't hurt).

-Doug
