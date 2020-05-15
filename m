Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746EBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F2C20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4PTtziT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEOLsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgEOLsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:48:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8DC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:48:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v5so1532772lfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmHQ5oi+w1dpbsygDsoRqF7sOTAFHFbBfzdldzAPp9o=;
        b=N4PTtziTxHqM1fDkdSXxCv8Jg8FAni3IghpbZsnhKCoXYREBuI/Djyf0QrCyZON2o3
         uW91HJZeyAEd7QFZvCfGBj6IW72RQH4ooap6ejFY8+n9ddzl+DfpVB1fW64c2Y7UtIoS
         NbbnTyQ80k6T3D4MKAX59EysQOijXofxIm8nIbEZds5DRzahgX7amx/0KCt+RtHmCn5L
         ERXm3vPNmV3j/VWceLYoBFbvkr+ueFUofBitvDj88tLWX6oa6wY6NEzcCs1YWpPDIxf9
         PAG7IjNvBlsuvvnbZXQI6j8FAcN/Q/rkLLQIg+GxAHMsj5J3UhaM8aSZKn8aSS+YMf/6
         J7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmHQ5oi+w1dpbsygDsoRqF7sOTAFHFbBfzdldzAPp9o=;
        b=PyHsh0serQQFBktq4JR6aTtQ77Xp4La6M+Riy/fzIwbKIG1WNDmfBfEVCQittua5nQ
         aaWT8B23zE1WWvftLWZpq1+fHYRHIunoR6fxSR+Pc5iijqgS7oBkaRTKfGyPnWayi7QE
         hiUgcwlRmTP58jEa3czC4CDFotUJqUtsT6N2Rzo0HpiiGdYch+CKPSp1kSZw1GZ2TxzK
         UyoMmYcCk/zviC3jA77Tr2GdVXQ665nB2SCqS0CIdywK0urb7sJlIr5MLU34V9OsqJga
         yZ+gH11+n77g4VvhgzRqpr6cBSczmP0//fGcbUB/5JNyerd6c9Xf+5b3owuFaEhoW4E5
         Jesg==
X-Gm-Message-State: AOAM530HUnnIfP4wgvBuYbhqoFTzQ2aBnecc/aiy9N3MeoMzFQbNP/Pk
        R3Nlfp0PvpMb6djhzog/1Yfdss4igw/i3rwqm7WUpQ==
X-Google-Smtp-Source: ABdhPJwtH+Xe/KX7TAFGDyQmYdkwB+GwNwnhINwGOKf6w5JzQCbvrgv8JDJazPsCnZbWVl7rRbd6+vTir3BwFcJbK04=
X-Received: by 2002:ac2:4823:: with SMTP id 3mr2156225lft.194.1589543322352;
 Fri, 15 May 2020 04:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200514204901.3199-1-xc-racer2@live.ca> <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660C7BA4CE07978AEC884E1A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 May 2020 13:48:31 +0200
Message-ID: <CACRpkdbucZ68KODd3shecm0uEkFgTzh4XiN08JdCM_chYApoXA@mail.gmail.com>
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

On Thu, May 14, 2020 at 10:49 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma150/smb380 are very similar to the bma023 but have a temperature
> channel as well.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

The temperature channel can be added later, let's go ahead with this!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
