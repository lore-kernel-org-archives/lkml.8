Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FABC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C994206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nID6AIEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHRTdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHRTdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:33:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805DC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:33:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so19377182qki.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9v9LH57+IfNt2arroNdfPSnoAN0s5S5MCTGnfuBn1wA=;
        b=nID6AIEUt87zPzVhsiu3zSRICoA8xdjdUmnpqUuhZDzIWO6fpU5q00kOORdeEDydV0
         +1pLQ+SOk2QtbtINMc46qLvmcGM1oX7xQVeE4tKTgqjnbI97bt5nXaj3Pn50/TQKbicn
         k7xX/uH3VKdJSYOWA53667Lh1bTJhecRepgu6hdfDY82F8HAvs8z2LIcaB4KmW4sHUIW
         YI+DvsiBHpEJMk45qfUo6ORkvcTLbS8LW3wzMW0mgPGdrL42G/P1KOESfw3YI17x1H8w
         AhzC0mI1zxDM9k0tpzD3QhbMKbs+16pKxNr6z0aVI+DL8DZaiU2PNbO4j/dWtdWVP4FH
         LaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9v9LH57+IfNt2arroNdfPSnoAN0s5S5MCTGnfuBn1wA=;
        b=s1kTiuKytx1mpOkuceCa1h3mpF7NYSioFhEJVRnUdFsLZJFrNh9iZouJUt4PC1OMWg
         dTfZ6/podtbbJwj5NGgRXHPZmI7bZjD5P/N01Ea5kG/mwgdPo6HFmluZ3QZmRwrE2ILE
         61g9o3dhPXS87UF+XSq5i/4tz1qRiFATI/Y5nTXQ6c+13Q0DCcLRwGTJzZ6l5aEWi+t+
         MhEhY8wnGq8UsyR3IBUIRJtVGUGOwTetKhBWtNWtDqlJ3ng1HCEL6zWJuu74usGyjtsn
         Z9VLVGQaRQ+hvZGrfEpDnx9Q9KF1epTuyu5O7O0aycI2j08WtOOMh6xjGTNoiLexdOSh
         9uJg==
X-Gm-Message-State: AOAM532EDrOmin5RC9v9LamaveSaB6bwu6jdBPIx283Bvubrmd5B6gf5
        WmRb8IiENvtdsaRPuqJ/VA0Gzd14cLM72JaoLgvkDw==
X-Google-Smtp-Source: ABdhPJwmnD0GkDIn2RBiNaYhiNXsC+hVsNBfaZCb7bBepphu0Bkn4ovqkFMtTO4UzpqXIrzQAxfXXRicf60+wy+pB8s=
X-Received: by 2002:a37:a495:: with SMTP id n143mr19052701qke.330.1597779185970;
 Tue, 18 Aug 2020 12:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200814194847.3171-1-olek2@wp.pl>
In-Reply-To: <20200814194847.3171-1-olek2@wp.pl>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 18 Aug 2020 21:32:55 +0200
Message-ID: <CAMpxmJX2RWUaGnntxwyR+yNkeYo79cWhPJV8F9i=_Nz0yn+w6g@mail.gmail.com>
Subject: Re: [PATCH] gpio: stp-xway: automatically drive GPHY leds on ar10 and grx390
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:49 PM Aleksander Jan Bajkowski <olek2@wp.pl> wrote:
>
> Ar10 (xr300) has 3 and grx390 (xrx330) has 4 built-in GPHY. PHY LEDs are
> connected via STP. STP is a peripheral controller used to drive external
> shift register cascades. The hardware is able to allow the GPHY to drive
> some GPIO of the cascade automatically.This patch allows for this on ar10
> and grx390.
>
> Tested on D-Link DWR-966 with OpenWRT.
>
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---

Queued for v5.10, thanks!

Bartosz
