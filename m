Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EE6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC07C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cXxIKXww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404076AbgFXOEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404002AbgFXOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:04:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8B8C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:04:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so1716849qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wyf+7sUhkjsKJxaULvE9OAhhFZnODU9DJn8C1+YEqPI=;
        b=cXxIKXwweoNm7jUxo3j6FamJztE0yljarsX8GyAAsL6cx9yc0VoyPcG/hnRxHwbv0y
         DjTHXF8Xwq/OoVtEnZ9kz9yUD/x5NsEA0QQPQeZgu7eJLBoEb+uCLyiNvbCOuotce6di
         zI2f0LlMTY1wfe0aBE4BOLt6yKoSZfk7yVP05KTA351ZCMsyQFQ33KRpCFuGVj8XO8eV
         xMANoZW1miE4JY/qdjwJdI1GNuY5UC8N3kI11TzAiRZUrrc16rFtA2ynu0d6IM0erW4f
         KY1o6hVej2DSDBfXmRtvnz9nxzfaUgdW3+nNJWCiYnffV3xpSlxhEsP1gCVBuoDz0ZlD
         Vt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wyf+7sUhkjsKJxaULvE9OAhhFZnODU9DJn8C1+YEqPI=;
        b=emd4EY5JOaIWot9bkIl4eJlv72AJByzBr4p+cr+jKyQypW3YvKDmdbu3XwQonC2aG1
         ohVySUIHtnS90gh04aA1vdoLdmEU6purZhkCRD9oByRGS881OTTPLUbnHGijwCdeZzhB
         NNOmc7TNWjxWLFOmQjvOyrU0F4gbsIF0kfRiTlxdxG7Pz15chayqb/sqvkMCX0atsWfv
         OdNhuQO1tIZpTGYzjTvLA1MU0XXd0ik2ehinKLZqS/hMuAa+kdpwgimsAgnOp1SGW7zp
         U6fgX/JIcRE1+HQSrQy5dozs21AyQHzbj9d/dVxE87a7f6hCr3x6qPCTctgQ3eETMDYY
         xNiA==
X-Gm-Message-State: AOAM533TFuYtMU4flAVlD1X2RkwuaPk1mDdPOrb22qij9EOw3Ap5NFDY
        iEKV3ZUUJ170UY/H9HtnynaUOtAwAuqrSI6Q3Hwxsj9P
X-Google-Smtp-Source: ABdhPJybmC5BLMGFTdpruNk2xDNIAJPKBYy2FAGJKzSZAkzlkL6PjHrYmHCM2GwTqDZ7l2u2hGEefTp0G6+v4YF00j0=
X-Received: by 2002:aed:2684:: with SMTP id q4mr2768445qtd.208.1593007460464;
 Wed, 24 Jun 2020 07:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200623040107.22270-1-warthog618@gmail.com> <20200623040107.22270-10-warthog618@gmail.com>
In-Reply-To: <20200623040107.22270-10-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 24 Jun 2020 16:04:09 +0200
Message-ID: <CAMpxmJUWZGhB3eeSquOJZQegTAwyb7yyKzBSeOjG7FSzq=BAkg@mail.gmail.com>
Subject: Re: [PATCH 09/22] gpiolib: cdev: rename priv to gcdev
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
> Rename priv to gcdev to improve readability.
>
> The name "priv" indicates that the object is pointed to by
> file->private_data, not what the object is actually is.
> It is always used to point to a struct gpio_chardev_data so renaming
> it to gcdev seemed as good as anything, and certainly clearer than "priv"=
.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>

Ugh now it's gcdev and gdev everywhere and it doesn't really make it
more readable. Maybe chardev_data or cdev_data?

Bart
