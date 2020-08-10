Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036372080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FR2zrXih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgHJSMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728062AbgHJSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:12:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F3EC061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 11:12:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so9242113qkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QgYtQ0nvpVp5fhNq6Bvi4E7+pTeN2jB4TjYNqQS0gag=;
        b=FR2zrXihy6D3nhs1ct5EvXKpFFv8/X/8ppPIYYdFMToMH8E5g9vRvtyRITLyi1aYD4
         qFve2SrwjFOk4YOBylAQ5gTTGJ3lSvmEkoR32EUPLXrZraiyNOisEwpnQR8GOOU9tjP3
         Y2py6RuA213m/Rvnw0IhJPMijSfYqjfZWJcNsFYJ7/lyPd55FWuAYxyXTUF9ESpv6YbM
         Zw9JeH8tyW/L9vftgbAD1pwA1ZVdSOvVzYsXpTJpascbwTyGsmtLI9t1ltPXrqYi7STX
         orxLdQUrP2NMJ61eNOIU2FmENuF8hkbuncXq4ZnxD6WOkJFuP333L4i8BzJDg8EEVeg/
         7LMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QgYtQ0nvpVp5fhNq6Bvi4E7+pTeN2jB4TjYNqQS0gag=;
        b=FQ65hVtzHyxPm7IJR+2ENlhYrld5q+g6ZzE4875Jd583AemUyRHTRN2LrGEM5OkB7D
         nScKgtUSUgtf/WfJA1SUWapa7SNbzpvfReJ9OmE1W26t/dqAXy+irxhNo59CKh9ncn1N
         ydP/ckdq1VLdrAax27J4jWP4u1tOFiQe0HFuQuJ5lRmNiuzyZ538IjZQ5xpGwJmaT9E5
         ty55VFdijb1WVakyNFCQ2HtreUn+LMDOLlD7Y+8ka1pbKzMgKA311yeS1UTIk05vgJ6H
         HgkTeYE6Yft5ysTAN2QYp6J/by+FUXVhfwnbI8KwQnMaYykRxxpQDOPaZdgiQ8gx6koD
         hYWg==
X-Gm-Message-State: AOAM533kBAaEuHLGhurIfZxH+dq0ZtgTbZIw1dL/7kkOTl3pfoibDRz3
        OLMH+0IlKn/QEA6xQng2UxYTIRkw+w5wa/vvFbsaig==
X-Google-Smtp-Source: ABdhPJzVZ0Mt67L/YycKJ+BfSO6D2a5cJbAo4OEZcWsLpeH4ANdkOsDGT7TO+eRhnKZmnPmdNsI1M/pIA69c/9oNGEo=
X-Received: by 2002:a37:9d97:: with SMTP id g145mr23363392qke.263.1597083131390;
 Mon, 10 Aug 2020 11:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200121134157.20396-1-sakari.ailus@linux.intel.com>
 <20200121134157.20396-6-sakari.ailus@linux.intel.com> <CAMpxmJU5dG49N2FA0oSQsOfKrCr3KQ1BisON4c+nUJJmZQG=bQ@mail.gmail.com>
 <20200311085555.GH5379@paasikivi.fi.intel.com> <CAMpxmJVPTKW+sYSJ3dnfF8nLAOKEa4Ob7bpxG0KD3Tkdm+rtYw@mail.gmail.com>
 <20200323213101.GB21174@kekkonen.localdomain> <CAMpxmJVdyTkZMVuhSy0Ux8VUYTmQN_YEfH-akQsAL3zrwiz8Dw@mail.gmail.com>
 <20200810082549.GD840@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200810082549.GD840@valkosipuli.retiisi.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 10 Aug 2020 20:12:00 +0200
Message-ID: <CAMpxmJUKSR-oCGnV1E5XiAMA2nYBy5f_f8=VSoMn0zf+qF39vg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org,
        Bingbu Cao <bingbu.cao@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 10:26 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
>

[snip]

> >
> > Rafael: I think that there are two issues with patch 1/5:
> > 1. It adds a very specific boolean flag to a structure that's meant to
> > be very general. As I pointed out in the i2c patch: at the very least
> > this could be made into an int storing flag values, instead of a
> > boolean field. But rather than that - it looks to me more like a
> > device (or bus) feature than a driver feature. Is there any ACPI flag
> > we could use to pass this information to the driver model without
> > changing the driver structure?
>
> To my knowledge there isn't. The fact that I=C2=B2C devices are powered o=
n for
> probe in ACPI based systems is specific to Linux kernel and not ACPI as
> such.
>
> The reason this needs to be in a generic struct is that the device's powe=
r
> state will be changed before any interaction with the driver takes place =
as
> it's the I=C2=B2C framework that powers on the device.
>

I'm not sure I'm following. Looking at patch 1/6 struct device already
exists so why can't this information be conveyed "per device" as
opposed to "per driver"?

[snip]

Bartosz
