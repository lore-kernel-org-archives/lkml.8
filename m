Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FBB206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="e3hvcYNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgEEQZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgEEQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:25:41 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8477BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:25:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so2880954qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UY/NVbvy0jUH1oe5m6J3EeGv70DJDE0UW3gaQi7+53w=;
        b=e3hvcYNBhR3uTaY0xynvVRREMNwCB9JyCpaPGbngvSzrXREV7mL8g3lpQR3wWaJXwS
         WYXIIaBJ+uUME2tO0kkCco4KPee3tHN39eQD/RiIEcNPbpNrnNVwtH1qC3y7KCBbDezC
         ARWqaMZIEWTIjbA6ahAhOHIyz5CyMCy6pUjJnhFb+yAWjwF0OZKUNrMGFsIuezFKh73Q
         eLDKmL86IOksgBJJjNLVcW3NhW/tUJWX3dO/tj4egwmZPmcWaWOJVZZGMoGafcc7DILr
         QMD29OC2vBKKDjruk7piNzZOUrpgLPxjbQPJct8iI2t2FmSl/iWBoScSKlgqVD0eD6uy
         9u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UY/NVbvy0jUH1oe5m6J3EeGv70DJDE0UW3gaQi7+53w=;
        b=RznfiLo1axlU2Kd/h7jmjJiS6clPnspkkPN4gKS9X/dzDTS7KKihpuLAH40J4XSaIX
         G7zMEgzNB0nFW2gpfDCkds7oM8+9i2Dn3nFe4CGIicSAtd0hsBrIIHuF8pYEGTF/EE5l
         pryaRbe2PMTC2wuJqUBQDsE+BvvI5M5Tp5/5lpBEen1yrUYH5Sfu3RIfzxEiiIAL971X
         dRpsIs8yqDVYDoyoN4usTNM7gUbPemo8DWa9dXoyvxbL+i8Vd/e4WM4ALUlHPVDLvI21
         FG2ZFcqGxfVRUF+jnwWWS86lgwC/M/WxkSjOTggPY8KxhakAqwvNsCqs3vi3CezKUUzE
         phqg==
X-Gm-Message-State: AGi0PuYCO9lLykNuRRHmIWas+d/dngMO3CH/9/KtyQBxT2JUwXZxRfgk
        lpaELe/xdQWK6GtYRYvqnztbvW/J+6iNRKZwmvK8hw==
X-Google-Smtp-Source: APiQypLqgtPcnpgxGc2jGD8qsguBpbnG6jZ+F/5eo+Igm20nElK33fVb7JZ0XLKsuSa6Op7louZ3zMNi3nNYiXFZwu0=
X-Received: by 2002:a05:620a:1395:: with SMTP id k21mr4346176qki.120.1588695940818;
 Tue, 05 May 2020 09:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200429135654.30120-1-tiwai@suse.de>
In-Reply-To: <20200429135654.30120-1-tiwai@suse.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 5 May 2020 18:25:30 +0200
Message-ID: <CAMpxmJU+6K-tGMCoTsz-6RzbNqhL-hnuTnY5T7Y0jQ4rr5u62A@mail.gmail.com>
Subject: Re: [PATCH] gpio: exar: Fix bad handling for ida_simple_get error path
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kangjie Lu <kjlu@umn.edu>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 29 kwi 2020 o 15:56 Takashi Iwai <tiwai@suse.de> napisa=C5=82(a):
>
> The commit 7ecced0934e5 ("gpio: exar: add a check for the return value
> of ida_simple_get fails") added a goto jump to the common error
> handler for ida_simple_get() error, but this is wrong in two ways:
> it doesn't set the proper return code and, more badly, it invokes
> ida_simple_remove() with a negative index that shall lead to a kernel
> panic via BUG_ON().
>
> This patch addresses those two issues.
>
> Fixes: 7ecced0934e5 ("gpio: exar: add a check for the return value of ida=
_simple_get fails")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Patch applied for fixes, thanks!

Bart
