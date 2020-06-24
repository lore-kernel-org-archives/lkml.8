Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD71C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BA72076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="poono5pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391195AbgFXON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbgFXONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:13:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA6C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:13:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so1076026qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RKz3cdJXe2hoM5GIr6id15i/IZKe76FR3EXbaf6TXp4=;
        b=poono5pq6vhzbjvFd1OHrtxuikcrummcCc9v5GctMBp+PBK+7qT4Ah+iRf7eEmqxAo
         kyKRtRFGZcOpcEaJTzBCgMCNyx9vTN63XF3B5HeEUeah5Pc3bmj6Wwd7vBu4pjMlORv8
         vLc9wcXyue/fRjof9G4UbxEBkDsaG7i4TSQQdhkNN4fZGDN9qtV79HsbGjk6pMHB9aHm
         6YkdDuvB8qEN3smb8RHmwmyui58Azd/wuGnjgJi79zqlioBBBsKjTvE9CydYqpN1RC11
         ojjjRKfB4yh6PYC/udhxXDkilYPjZtPLTP4rxJAMakk+6xW7qzCvBTg3ZkWjX22yIj5t
         3+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RKz3cdJXe2hoM5GIr6id15i/IZKe76FR3EXbaf6TXp4=;
        b=XWIpNEDEnoOWKr600uKvXJJu4Ys73a4mkFYo6g45ye3NttQM15LXmlqqKrPaQ7v6Jm
         ZhMDtXgU8nFnZRZzh1Ji3PnXr8rCJB3QkV/DdLBMKwA+QP+3fwpNRcBIIYoUmgzu6e03
         w4+e+ony7+pw3zIzCepIH30oMNv9CM3lNGTxbKk9UF6Q8GfvzoGR94D20aGRA0hsUyD0
         sDNDF7LVH3/ovLZTEYy1ZnZlkxFePB128OMtZLfge+N5bXtQpTfQE8aeV8WAnKcdpn7f
         Egi1EVDCjWJV6KYl+aBk/RcK/dNQQAznioa/L8pDtswR2Jzjx3BQtA+HGHVgf4SWJMto
         jUZQ==
X-Gm-Message-State: AOAM531k5/D8tvPcz+BER/NI4FQEwVZxxXHcglP7loUNZemf0ZyTbruF
        NJzveZtrwGWs/tHiHJpIekWVaOw9FVtNL6TXQHgCwfdgJNg=
X-Google-Smtp-Source: ABdhPJzjZVkc+0RLZRhtJ29bxW4+QyWZnwLuZLqaiYpbA6r0BirJY7A4w8Ts5NlMx7xoDMQDxDjJkTSV0PixXgvXrUk=
X-Received: by 2002:ad4:580e:: with SMTP id dd14mr14998492qvb.96.1593008034313;
 Wed, 24 Jun 2020 07:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-13-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-13-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 16:13:43 +0200
Message-ID: <CAMpxmJUu2g7qORShk8C2WpGyh2btcyZsRqrQwP1JwKAhUW+CCA@mail.gmail.com>
Subject: Re: [PATCH 12/22] gpio: uapi: define GPIO_MAX_NAME_SIZE for array sizes
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 23 cze 2020 o 06:02 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Replace constant array sizes with a macro constant to clarify the source
> of array sizes, provide a place to document any constraints on the size,
> and to simplify array sizing in userspace if constructing structs
> from their composite fields.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
