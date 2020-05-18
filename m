Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEF020643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 20:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z1AP4zi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgERUhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgERUhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:37:17 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:37:17 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b91so9695101edf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07U9JgzItnQ21O3cGWVkQXvBXHI4OBd4+wXXui3XRR0=;
        b=Z1AP4zi61x3wo9PxT/phHkmzA3EL3TiC2l4ce5QYnRI+gNaIBCtZsusW5TnU2XKX8k
         u4dN0vnaZyFrVTywHk/jJGtJbXwUO6MtJzW2sDNSukwbQMetMsYIOSyW63CCr1qRhuHr
         PbKaHJb4k4yJIM8bIrmaSl4NodDBLaiz9tMyihW0DJN9l0pg802XJdP8mm3EllBmK0fD
         g4KLJY4jEtoaezDx1LWVKEYWU7xXWMp01XJGicRTj2vG+YCCJRA9ITE/VNAgg+mYYW8z
         0CwP+Gyp0DfGvUZP/SE0X3uYsznT0nE0bv4XTXqMdAeh4WQ3iqzaD0XLulU/wWdkmWQz
         H0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07U9JgzItnQ21O3cGWVkQXvBXHI4OBd4+wXXui3XRR0=;
        b=MZCLXKp2+8hxwDTg/5578ntbidGQy+wqWB9wRNp9TtWQBcyC66GZ52QUdj2tmR5r9j
         6EuXfts8wqDM9m6QnAho2l1uqJ7XAqB66aKL/HpdJaxI5L9zWjOLno8lreQEq5FuVoxi
         UQC6Tq/V2Q9LArhmV2kwckGhczSR9QUKYoYAaJGk3EjL6t2/Dj8HWQWvOVl3LDZrSvoF
         s2Q1zvNZum/gMnBd+OxrEAckaJbdJ+0hdgjBGJr7BgqBNlpO/c7y0zU/hbSwCqHs8WC5
         P/c0cjMui/ha7pdeeUpzC5QoiDtrYG/qmELo8mGn6F0bNhvZ7QH50Nyfa+J4JvqyB+Qg
         QRmA==
X-Gm-Message-State: AOAM532daIqSEQdP7fIIjma8rMH0+g5aqIQLSfw8a1cQL83c8xLLgb0k
        rizK5Sb2aXfDA6ACoGYI14EWgGCnWLVirGa1Cwg=
X-Google-Smtp-Source: ABdhPJy5JXiayrpQcj/jHe174FGQYD6A3Gu5IvH/UisH5NSWucd/M4A20R9xxjUK69lv7FRQy5b2OYjITsgwLhYY8YA=
X-Received: by 2002:a50:a985:: with SMTP id n5mr15258638edc.338.1589834235965;
 Mon, 18 May 2020 13:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
 <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
 <22af498b-44a0-ced3-86f3-114427a73910@o2online.de> <CAFBinCCGAkhPCwOW=mAvsV2qdixq8Gf8yQw1gYErHpz7KmuAZg@mail.gmail.com>
 <5de6db87-a71f-d14c-390d-b0caeab5d650@o2online.de> <CAFBinCDB9c2uMRXO9DKSX4hC7EBgnRfBa+BM5-VdEPZeieKn_w@mail.gmail.com>
 <813dfc08-f13a-dcac-0bd9-821d188bba08@o2online.de> <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
 <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de> <CAFBinCBukGbzgO-Y1dCRYXZHhX2PcSEQQ_XvhHqLcnw0fGDP8w@mail.gmail.com>
 <a95f5fe1-4376-f872-961a-c2237c36811c@o2online.de>
In-Reply-To: <a95f5fe1-4376-f872-961a-c2237c36811c@o2online.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 May 2020 22:37:05 +0200
Message-ID: <CAFBinCCgFtv=u4ZKW3rdoDPZ_jh3jU03MDxHoDk=pbi+4pxB_w@mail.gmail.com>
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
To:     Tobias Baumann <017623705678@o2online.de>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

On Mon, May 18, 2020 at 7:59 AM Tobias Baumann <017623705678@o2online.de> wrote:
>
> hi martin
>
> i activate your patch ; wlan works ;  also with only  edit GPIOX_11 wlan
> works
>
> its now GPIO-402 out high ACTIVE_LOW  ( 3.3V on pin12)
great, thank you for doing the research!

did you find out if GPIOAO_6 is needed at all?
the 3.10 kernel enables it and sets it to HIGH. my understanding is
that you didn't change this one so the output is still LOW.
so I'm wondering if it is needed at all (I wouldn't be surprised if it
was not needed, these 3.10 kernel .dts files seem to be copy&pasted
from various vendors and do not necessarily reflect the actual
hardware setup inside the box)

> i also attached the performance infos  Wlan0->Router and RAM->SDHC
that's pretty good, great to see that it works fine for you :-)


Martin
