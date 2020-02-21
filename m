Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988FC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D55222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8W0bEvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgBUOXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:23:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37902 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgBUOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:23:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so2366848ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pQ13GX0tuFUs+LeyyUqLOlQKF1+pypsoV9dprzWCgw=;
        b=T8W0bEvEUBvwhJnzJxRqtW4kYOHvC9fA5NvmB/OAhDJ91/8vorpAOYioPwOh/bJadR
         1juaFW71eCJyITq8p1nkE8E7obrlc8W7NGMhuI2jsdTo4vzRJ90+3vCfXvCbNGLE06wR
         1mHe+nNRu5HEa0BWRjLn2Z91ipsjVkLW62xxluu2TWLU6o4icSQsZbgVpDY7TYtMLsrD
         S2Xeoe0Pj/783babZ6LHnwZIblBVKgbojdydPChjrgCzDzYuCvKvK4QldxMtNaKN5Y26
         u5InaKczJe3RMx5fKZUHVEfeXcPWAcVoejbuCNAJ+TXmEI3ULmxNT0g7r7TCGxQ7cMP0
         LTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pQ13GX0tuFUs+LeyyUqLOlQKF1+pypsoV9dprzWCgw=;
        b=BrmzwsLZY0+Q3oyYrBLfJIfCo+Bi+q1OF7oo78ey0qqZY9l1+/mpfnp0mLzcbNv+y2
         7Qgm78USeIVLYRn8aVqsVgeowonyvUmbpl7o/I8PYXlG+pVHOx3UN9KGfjtZswRICirJ
         b8S3nlHuVwpTRvA8/QEcjqP5LnADYHfKW776gIbsswIOgSe4BJmShCzthw8LT49Xo4WA
         NAvbuEdx7Y4WZmSFYoIBXCNHicmlN7IfjtqlUiM5HLAWvNoELfnMscMJbCrlSUM6V0az
         cJ8s8wGiHoMiGkGQE6IKpKzip8Mm+8zpGjsvrfORK0F5f/Gv8Na7XIcA2XBFjFzTB2si
         xIog==
X-Gm-Message-State: APjAAAWniUEv7plW6XQAp0gGhdv7jUDGQ8NHTQl0Up4p8+A+ViC21X/p
        qMJox/WUTsa8v+bA7WAYocbUJt5mTBZnooMd2Pq32A==
X-Google-Smtp-Source: APXvYqxXDosZW7eRkrxFvuk01sLi+6GdV9QpEgYDMq13ocnx8GkH+EweUEtb0BNdh+5hShtTWdFJKjHA45sWUfquawE=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr23140766ljc.39.1582294999444;
 Fri, 21 Feb 2020 06:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20200217004416.lhbl7rzvaf5q4fbz@shreyas_biamp.biamp.com>
In-Reply-To: <20200217004416.lhbl7rzvaf5q4fbz@shreyas_biamp.biamp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:23:08 +0100
Message-ID: <CACRpkdbkQVEm9n6wrJqSMNFSbqGkmi6eFU-=xc9Vui+4RXkMog@mail.gmail.com>
Subject: Re: [PATCH V5] mfd: da9062: add support for interrupt polarity
 defined in device tree
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        shreyasjoshi15@gmail.com,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 1:44 AM Shreyas Joshi <shreyas.joshi@biamp.com> wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined in the device tree.
> The allowable interrupt type is either low or high level trigger.
>
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>

This is how I imagine it must work and how I implemented this
kind of stuff in the past.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
