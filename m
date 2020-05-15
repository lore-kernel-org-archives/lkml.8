Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971A2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7C920709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQKy1yfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOLtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOLte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:49:34 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FDCC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:49:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id e125so792911lfd.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWZJQisB640njiNbXdpel4cdg0AxhnskXdou47Rc1F4=;
        b=QQKy1yfKlgEVgZlxZnPSc4KobYi66fc37X5KZbTF709UgtKsHQ25iVQ9eGG7lceHe1
         +WSvipgrDudbGHKKMCHWyD8T0xl51RqwX11Hdj+avT7yhUOzlBLswGsVIHnI9/YCdr+1
         YhhcCmzMHLqe9+Eexqyiofuqtd0kCTc1kI9OZ6s1ss6V8PYkFSfmPFttGk9XKjYOPfOX
         B9fmecEHktSw/dsUZXOUYV+++WUjmjEEZF8oDmbn+Et3zf1bxOdSc7VFsetdcOOP/1ch
         BVps/p++Vr6PnYrFpc0uKvdfPNNFA2rnqOVc9C5xwPCo2ta1ZZm9TGpbNHzb8bIQmRMQ
         xIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWZJQisB640njiNbXdpel4cdg0AxhnskXdou47Rc1F4=;
        b=fedG9JIRe6lgA7fwRRv9Sqj0jSIe614NfV0DFYq83OcB5b8snRNwzxDsJkmMt9Q3us
         7rrFUFqCcpy02tk3wQBssnjyMG6RXXP1TBp62kvK/dCtBTlgEksxY9b27bQfgWoT5MYO
         kXLedkTVuot7k8UIJbMvpYatpV/+dAxB8EMFPGDkR4z0/AhgAWoiVWr8DVOg8vxz3CtP
         6/IDeKpkG382r15qC+qWaVd6VrvM5BfLYy5X8uiHQVxodVkpGriPr6xHh6ynm6Z31Hgz
         19y1Je7ngj6WCUpftCkupBqZTh/FW5hIJcEe2o9DsiJOz3w5g+20sT144FFlwdyqI0dR
         tS5g==
X-Gm-Message-State: AOAM532AspKW+PjkyXocRL1H0SlrwajPg1TSmW9Q/yIfSJ8TKSXfmm+h
        XKrFJNGOHijf6FpN1hGwvlNFFJa6l20I5IK/M55HoA==
X-Google-Smtp-Source: ABdhPJzHseX/OaTVLiyuLxZCQZIEnSA0EuKj5TIZhiEbuayaYYcvsEL+IwgXAnQZHChm/0jP+VL1Q+/k5OjYy9RKlo0=
X-Received: by 2002:ac2:54a8:: with SMTP id w8mr1066569lfk.89.1589543372862;
 Fri, 15 May 2020 04:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CACRpkdbucZ68KODd3shecm0uEkFgTzh4XiN08JdCM_chYApoXA@mail.gmail.com>
In-Reply-To: <CACRpkdbucZ68KODd3shecm0uEkFgTzh4XiN08JdCM_chYApoXA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:49:21 +0200
Message-ID: <CACRpkdaOZmHgbFckYifF7=_uMY3DcmoVOY_1WJXKP-6WvnZOug@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] iio: accel: Add bma150/smb380 support to bma180
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 1:48 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
>
> > The bma150/smb380 are very similar to the bma023 but have a temperature
> > channel as well.
> >
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
>
> The temperature channel can be added later, let's go ahead with this!

Oh I see you added it, missing things ... thanks Jonathan.

Yours,
Linus Walleij
