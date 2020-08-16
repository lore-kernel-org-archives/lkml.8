Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3490C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D6F206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="16o+su7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgHPO6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgHPO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:58:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA0AC061385
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 07:58:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so10619850qtp.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5JJqt1APXPHxbtVoU6OKZdS8Pw8Z7UXTRp846o51gBs=;
        b=16o+su7NJwI6TUCXIeseG3eoCdstKxdg/xp9hg5LxSCRLM0KuKRs5sFTgTnohECrBU
         X3YaXEBUUucPQ2XF602mJ8MgtUkuBGLDo/Z8ZHQRylzHvcvTmoZVlA5wDugnWaniZT4p
         Ej54DVgjZB5WQgPquRfZ7vayxaTpJO7dub5u8xV05SEPVxyi3cvGrrnIi2NlbjEoqGjo
         dtnJtBXG5eD28eajaod3WF8Z1ScJqIDk80jP8/3ILoVCmAQro8aaW/FCpIv6BfcB68nj
         oR00WuFuznFCSuDeU5SssNrfmdM1Ll39goEqnCcIL1N9RX/+1VTmCkUk9zwiaBOtwMWj
         sQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5JJqt1APXPHxbtVoU6OKZdS8Pw8Z7UXTRp846o51gBs=;
        b=Do1Ez4Mll4vZjT83PJdmmviFEJ6E8vrGwhOP581PQnlfTk8b2zsWHKYXzmcjMHs8WS
         sO4dWutTAUTTTbz/QGf1HOJbjdXRC16mgmhAn4TqMqXZ73vEhiTZjBPPuBika7V7JCGt
         mLwWbeXELkc8g8AUO7+HSnMYDPjJHCHTmHkZKqpyVn4iUsLus9VmTKMSDFmw57PDoQTV
         +vdI3Erc+Y+VfOhknzfNjmU2AE4LzVHavoKbJ7TkUep0/OYzRH0DO2wlbvt+JgldiaNi
         KKn/VTEtsxaVxhHUtSPJJaKNKm94zAJpWs4pyZuJ8KhI3vILhgXJew+hJQ+BYVlbQdUY
         pfFA==
X-Gm-Message-State: AOAM531EBNUdgeQoO8ocp2Zj3dZxmja8kR8fVb59L2kiC7sakl3quNR4
        FfbhLGR6X7wrDPsTu9ihT9OxLDdHPJ69p/emqjSgl0NwvaI=
X-Google-Smtp-Source: ABdhPJyAhemQhIGBpMloGbr4pTeOBWkIeCoRs1JtA0L7VE29Fib1JEaRqz6qVjX87rmsZ2nZKYBUIf7ndDlBQbKDOyg=
X-Received: by 2002:ac8:6952:: with SMTP id n18mr9620818qtr.27.1597589883110;
 Sun, 16 Aug 2020 07:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200814030257.135463-1-warthog618@gmail.com> <20200814030257.135463-12-warthog618@gmail.com>
In-Reply-To: <20200814030257.135463-12-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 16 Aug 2020 16:57:52 +0200
Message-ID: <CAMpxmJVFJBGDwLB3+8y9dk4pQkf=T+9igdMdAbvYnY8jT4df8Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/20] gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 5:04 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add support for the GPIO_V2_LINE_SET_VALUES_IOCTL.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---

Just the same thing as with patch 10/20 regarding the
_locked/_unlocked suffix. I don't have other comments, looks good to
me.

Bart

[snip]
