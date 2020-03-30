Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F11C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC720757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQY5YBav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgC3NUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:20:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39857 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgC3NUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:20:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id g32so2595410pgb.6;
        Mon, 30 Mar 2020 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjBjRtYcnrBIqzei4XmB/t8N/yfRCd7HSzl79/SnBXE=;
        b=DQY5YBav8MkWgKOYG5yRcFnBokPYvyDlZJQAqPniKVMUyCOJ1wQcIOingrJuhkT74V
         kHG6s4+2qZIJQQbi1LzmLDh1ksx2eRDUdh/MOIRPUKSGw5hgqoVaATzEEhn6PzE1ARmJ
         dFLg0kTnhhokVAnrNYLL1P8BYhmeZ6/2Zdh/w+N79PskjO1YbwZz/9W932/pEEi92YXw
         6GctpEb3xOIrQSTYohX5FqtEYxg+fKjwHVlD5EbCKtpPzt4TwRh1jc13azec9gCwzoJq
         9es6ctmrGZNKgROAVICY5yHEA9XF+591mZny0Gi9lV3BqupX2BgMi9B2cgv7E2azzmUK
         8xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjBjRtYcnrBIqzei4XmB/t8N/yfRCd7HSzl79/SnBXE=;
        b=Sw1uiysEXQDwDEk3FIP198KxTnkWdLj7z62mFEFq7ATkW3HXNZgpYdvflyldrzCfSC
         F4EaYLBzmCRr+lMYDC7oPfh8KKfdiQp4ucZyO0rC8xQXzNLI1OLFiDt4drLPJiuObPWz
         l5oi/c5TcfCuQxbEIJVGjomA7PtzWjM7S4GaAhK6Al2bfdH/l1sEz/0zPGa/5hXoMv8x
         dBM/4elSIuKVLzIzlJYzjbLayp0HwKGWABTybcLiPPZm+ebeeQKwF86xutl8c8jyiStK
         is6U3w1ayRz1n4/sjl9j6vREE3CB5QA78mMN8eYnRlvxcVzmLAJNNp3SaFMsf+wji2+g
         pEKg==
X-Gm-Message-State: AGi0PuYHGJGr2ClZ4KrhPf6EV+qdyQxI2t+zYzO/3Sn2qj/6zdWeHj3/
        Fjvv5UpKdMWaUf/73YHAaekV+LrykKU70v7WtHg=
X-Google-Smtp-Source: APiQypJYsuZydso5MeFZNsFwPFi5SQK5vTMnzAC7TjjBhLvOZpsLmkzPfg0LABGUktmF0G/f8LF7koKGckQJVzWOp0Q=
X-Received: by 2002:a63:7b1d:: with SMTP id w29mr386269pgc.4.1585574402975;
 Mon, 30 Mar 2020 06:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com> <20200330130757.GC2431644@ulmo>
In-Reply-To: <20200330130757.GC2431644@ulmo>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Mar 2020 16:19:55 +0300
Message-ID: <CAHp75VeY9ZGUD_=N=R2vsJFY-4P5-L1+ZzjKHU2cygcbML0zOw@mail.gmail.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 4:10 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> > The interaction of the ALL_LED PWM channel with the other channels was
> > not well-defined. As the ALL_LED feature does not seem very useful and
> > it was making the code significantly more complex, simply remove it.
> >
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
> >  1 file changed, 17 insertions(+), 98 deletions(-)
>
> Applied, thanks.

This seems to be ABI breakage.

Thierry, do you have hardware to test?


-- 
With Best Regards,
Andy Shevchenko
