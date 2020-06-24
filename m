Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9493DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF3220823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jbyBL2rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403982AbgFXOFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403979AbgFXOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:05:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A005C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:05:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r22so1847774qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FRVORTjqa/+9DcZnDp26I3NHb37aWoGaEMjOHVlHQMg=;
        b=jbyBL2rWyxn8MXrza0tPa/CArnHR7kI4gNj29oS2jJr50BwyZkRsKZjA3JMDZvPVrq
         EoDD6Ef0I4VD1SmtYGbL4oNs+SGiSJZg/sPg8SpmHI6x9gNGNSsy4Ux3kS9QJLmZZ6CQ
         nfvGXvaNrzcTZiyo/HR6ym7yyvQwvz5dNdqCykSehIGEm7CkLbPE/xWU5FrtnNlgvmfz
         SS05v1SdEH+dX8Y3s8m48NrJfl3mpy+Ul2Fvbem04v4G5IALaUTfM1qiCIs6UEuECrQU
         zJbN3MI2+dPwrKkhS+hepHxhJD9y0xfbuglxXK7nOAnGKxJl7M93UiodT4fW2IY2tEgD
         b42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FRVORTjqa/+9DcZnDp26I3NHb37aWoGaEMjOHVlHQMg=;
        b=MnlJxHxI7M5kVMS6nqcdvoQ1q75/eaP7bb2spsgwTGaFKWu9VguxO7fPKt3WA4+ta6
         qpqIVH6HUB69Tzn+TgTCQDbkUldl2NHq1251gCvKCiaJgYtCRG3fu87ZybtteAmNTXti
         KhqdG23RGKZl1DiP+6Qwc2tERHljNUDqw2jyrMo6fUnU5fbRzKcs4FhdW6a+ggWxlp/b
         QYI7VPKexm5ppsJabeaIiAEtxM1z/2PRVORauLYQa7oDd5ShjqG/RtnGNSvjxET1OBOg
         gkPk6CqJtN+iLIj0hLbT0LyVZbALmeyon9xnWGjD1IvsT9h9NFuml3rdP48SFCE8L7a2
         VJXw==
X-Gm-Message-State: AOAM533Nr5R6hHbw1y3k4JRKWMevIa2OlbH5GcAihuVlCTWCSUAWDZuk
        sDxFzu7vRNBV29gCXqQRBKdMo4LczOac+nrVXSzP+REE2Z4=
X-Google-Smtp-Source: ABdhPJyCdrudEswTFhDtUcrXSG3JdheRsImFD5tg333cqdp5wa4NI3anAkORe0gFYYWQRnfzVWqcTR6XI7sOpHo0IZA=
X-Received: by 2002:a37:9c81:: with SMTP id f123mr1967271qke.21.1593007515407;
 Wed, 24 Jun 2020 07:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-11-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-11-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 16:05:04 +0200
Message-ID: <CAMpxmJXajkf2F5KsWj2MpRsLjiuAdGT=XnLY_Ka3YN_WLsviiw@mail.gmail.com>
Subject: Re: [PATCH 10/22] gpiolib: cdev: fix minor race in GET_LINEINFO_WATCH
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
> Merge separate usage of test_bit/set_bit into test_and_set_bit to remove
> the possibility of a race between the test and set.
>
> Similarly test_bit and clear_bit.
>
> In the existing code it is possible for two threads to race past the
> test_bit and then set or clear the watch bit, and neither return EBUSY.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
