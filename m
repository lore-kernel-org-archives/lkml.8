Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603002072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vUXMPXXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbgFXOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389668AbgFXOA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:00:56 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A96C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:00:54 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id t7so1051833qvl.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IHUFmFa+PERILwSWl+mXNut/vkPHclyZKqXAUx/99u4=;
        b=vUXMPXXq8Zw5TkXeHV4MZ7HPDHkvugAyM9PvNdF5sQ0X9X/y5xDdWI0eOuPqS9MLRn
         CLyTd3RTJJNfD4ec/t+xppt3SM7P8qheiP/tZ+l+UuSAT84i4lRyFqJfXzMHRxi9yLZx
         TL+WEvKnvzFFvzHsiJ3ttZaNdkHPMx6wwlC9ZmOT+DExbI4IKVdGCBvgNw0CE7Df9Urb
         fsKb4LetTAWs0d6WH6QufVofUMmr61BnGKBY3PbwlSdEEMY8OuMN7bEWxCd0INJH3zs3
         8kXkqXAjOZEoggqsXGkYBXFf/TFyobF1d76m++X/tO2QWZogFrKqMq1S8uI1P3/XZOpc
         ymcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IHUFmFa+PERILwSWl+mXNut/vkPHclyZKqXAUx/99u4=;
        b=HLJpbcS0OBRJPqCLvvCTo/zjlhLidpMZfzb+WH0pG4/IGXWSpE1fM+tVGN4IW9qCGI
         4tq9+5MrPIWNWIMK924/k+vjRVycM1M36noqehfSf1u/n+7kDv2cswdOTcvvtoFFlR56
         vCwGb7Q3bProNkyQI7PCQQl682x/bJLln++2bma+EUEmiCyHtyqDoyyf4rzXxNOv/dny
         t5MMf08jqLZE8Bg8OSDD2Ljpoo/SzeCXs43i1U7hmJWkzP2eqylCD7WcWLmhaZQJGB9f
         jqU5FfsTnAIJMLwFuxm3XH/AwdONryOhppUpTPLQ/hTMfQgQkkpUwpbcPUpcK2jNPmvi
         0PaA==
X-Gm-Message-State: AOAM533qdnB5WHOgqT6DvzfEYwILdvaXO7cLVoxvzR21WfVe3ZIE++/Q
        mlQGsne32sUXo5KSyf0xVsl7mjTVcw/LLbvByoznapHi
X-Google-Smtp-Source: ABdhPJwc+N7OLcgF2n6s7AYzvFq1sI6X0oMw7s/cuElNqvpPqyRyd7bBZnFfZ22kg8kVyDwekNyPWQtA2v0Bw1QGcu8=
X-Received: by 2002:ad4:55b4:: with SMTP id f20mr30749529qvx.148.1593007253628;
 Wed, 24 Jun 2020 07:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-9-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-9-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 16:00:42 +0200
Message-ID: <CAMpxmJVbiH9mh2c8aAS+GG9a76w9c0Nrrv-VDVhpo+wSyQ2NeQ@mail.gmail.com>
Subject: Re: [PATCH 08/22] gpiolib: cdev: complete the irq/thread timestamp handshake
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
> Reset the timestamp field to 0 after using it in lineevent_irq_thread.
>
> The timestamp is set by lineevent_irq_handler and is tested by
> lineevent_irq_thread to determine if it is called from a nested theaded
> interrupt.
> lineevent_irq_thread is assuming that the nested, or otherwise, status
> of the IRQ is static, i.e. it is either always nested or never nested.
> This change removes that assumption, resetting the timestamp so it can
> be re-used to determine the nested state of subsequent interrupts.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

This change makes sense to me but I'm having a hard time processing
the explanation. If we're requesting the interrupt and allocating the
lineevent state in the same function - how can we run into a situation
here the status of the irq would change like what you describe?

Bart
