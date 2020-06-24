Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C319C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12E820823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ODW6ajaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391015AbgFXNeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388320AbgFXNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:34:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8F7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:34:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g13so1632212qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hK1IldVTAJkUSG2i1NKkDEtiFL1eMHy1/PWV8892Edk=;
        b=ODW6ajaEBcy+/pnOhDn1P1jgUCqjH2F2tkfmbUwgEuXK0Yc9FhQgEeZypfu4LwzTEt
         9ijv6CCflSEt8ZOQPfJ8q96qEBnfVW3fv6zyCIvAfv/O1intnyyWjBdvaNRmjz8kWBCw
         NMN6iyKmO9/lpffcKzqG5lWFB+4PkNWl2EXS3SozDzoZ3Lq7uN+0w+Vnu3BygINcMUj+
         pkGx4nGHRieYLqBLGIZNR7xIJQ/8+eqYhk2YUms2adyyTDXTl51KJxjP7jV3LL1yrxgG
         M1CuMcrSsRG2o7vIXMQzCpVqYdwTu8XNDCSRw/ACfc5XL3Bnjatqm5weYoyqTF3+w/1g
         vBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hK1IldVTAJkUSG2i1NKkDEtiFL1eMHy1/PWV8892Edk=;
        b=etH2h4Hq54+QQOCTABj5h6AtOGmcj/VmeJpfIHN8JwHZmtUaYVqfh7f8jv7os/q+xN
         ZRLpogsnCp/d+gqr4EKT/mn7AEjz8an8VYTsEE6SX12XYXHFgGPFWqhZQhqYwfpBSdKG
         WQWrs9yTQMFS77L73vpE2pDX6FUrQeXyd2hpAnFFh+L+RXYI0hEbAHFB40bBj4LzQkbz
         OppGbe795513q1/LY9z9Zgbm5F8vlsMjID7rdTQLFIri4pRR+CX3HUyChM7iq0oGuQNh
         kPWLdtfzmK5Lf3zK5DXUOlZyk9W/xyW4HSAvQp2Vkw9l1fdFQRyhyODEgehXtheLCq17
         oZ+A==
X-Gm-Message-State: AOAM531M6UuwhNNrzWthtfPYl5E2xBkNrmp1MP2nOa3iFcuf2sSmmZRB
        rwbRaKG+ID0vraNCBbiswLaOLTPsvIOzkOeIOiJH1WHl
X-Google-Smtp-Source: ABdhPJxvNF2K7aWqHL5AbnR2LzCQaglgIaehA79sWIBw6uVxFG83CmwovHyaMD/vW8Pf4cokbEgf5RkSOe09JphobP4=
X-Received: by 2002:aed:2684:: with SMTP id q4mr2627101qtd.208.1593005662713;
 Wed, 24 Jun 2020 06:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-2-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-2-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 15:34:11 +0200
Message-ID: <CAMpxmJXF94CM4DdnZW+gsjj=qRF7u9bV2Oy+ndznSbtD=eV8UA@mail.gmail.com>
Subject: Re: [PATCH 01/22] gpiolib: move gpiolib-sysfs function declarations
 into their own header
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

wt., 23 cze 2020 o 06:01 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> Move gpiolib-sysfs function declarations into their own header.
>
> These functions are in gpiolib-sysfs.c, and are only required by gpiolib.=
c,
> and so should be in a module header, not giolib.h.
>
> This brings gpiolib-sysfs into line with gpiolib-cdev, and is another ste=
p
> towards removing the sysfs inferface.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
