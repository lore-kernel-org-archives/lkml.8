Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DAC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDCD206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHTf3EVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgELMjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:39:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BDEC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:39:41 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d22so4380650lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=25aT1ziSREt2eMOH6nsVJvOqQf6doh6zTNEBSQtRoDU=;
        b=iHTf3EVIIRiEb72XuGUomprsvnNGQ+UeAARBK2vWrskrSY0EB2+77Riro6pz/huYPp
         bXc9r/+Y7EzoPKPQtijEmDicF54n5WvN/plSpdFoE2+gM/c78SqKRKjvQ/sLjpJRPiwT
         2yNiOguiUBXgJYmxtkF9E+o9p+T6xno22cTWEOXs5HEdjSxOWkJcnc+WoGT1+GnZ+rXp
         BbamOfNgs59p25Gqv+z7pErjw7nLuJfvgDlxiwfxdGHmTpppohL1szGatZT8AThk1793
         KnYzculIZWcuF0Jh7O1Khd9V2wJ9y6anBy7F5P1rGWvPRTS5u5M+LOOzKXFtauObR6zQ
         mtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25aT1ziSREt2eMOH6nsVJvOqQf6doh6zTNEBSQtRoDU=;
        b=eVzYqPKQ2PEJ6On+UYeG+8Bd1kqK6mjiyn65uNrxZgNuuVxKXYyVLse7Apu/zUe+v8
         4pubMUEOzUWVVvdAf+fO5SLP8PNiKvMmSwyhkV4qZ0VJoreI0UOGbIEGkEKDku7NwOMW
         SV8noqTpXrk+OXkTndIm3bM7QzWBibc2M+jo1QlsWykvg2HITOw5wVnMSghQNOzw2M57
         yNRZycvp2BQsX+b9HwCcOjcvCkHtxjBoQGCZJFpurhVncF/qFgdKJq7Gz8bWzshS7+tG
         rKhR/19XFnn1OXZewe0szMMaSNBtyfZXy+vbY5gDcYp15KE1ZUpKLLFdAgD7F7aP6LCb
         6bgA==
X-Gm-Message-State: AOAM53116thfKUPJRHY7lrIBGIW0VHDu7TxJv+o2MHcK56Y2I9dZ8yc8
        2AKfZP2SOSN7yzNtZzWqeeOx8Ua82yf29Y3Ojoegdw==
X-Google-Smtp-Source: ABdhPJy982LB8WEWnoxD748+g+BE0ldEg+fuodtryc5lutvhkFozBxxrxRYRJy4YQkWQ3F5aEx64rkO/sq7gk+PeqNs=
X-Received: by 2002:a19:42c3:: with SMTP id p186mr14256672lfa.194.1589287179678;
 Tue, 12 May 2020 05:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200503164549.163884-1-paul@crapouillou.net>
In-Reply-To: <20200503164549.163884-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:39:28 +0200
Message-ID: <CACRpkdaZzDXxuKnCiXpaWabO_ZDzmgGRVWAGXh9X_0+stii8Mw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Add irq_{request,release}_resources callbacks
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 6:45 PM Paul Cercueil <paul@crapouillou.net> wrote:

> These are called when a GPIO is to be used as IRQ.
>
> Without these custom callbacks, when an interrupt is requested directly
> and not through gpiod_to_irq(), the request fails because the GPIO is
> not necesarily in input mode. These callbacks simply enforce that the
> requested GPIO is in input mode.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied.

Yours,
Linus Walleij
