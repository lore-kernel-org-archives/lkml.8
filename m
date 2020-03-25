Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB56C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C353D20719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNZW1PD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgCYXdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:33:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45193 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCYXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:33:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id v4so3261889lfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fq+rH4YE72x0k6vRBalpeRHnZGOCdmKPprbP9ia4MOM=;
        b=SNZW1PD3VW0c1h12/8mpMh7w/sIRy8tamsLzdz1LCfbU6hfQlo6W347kP/HwYMVR1F
         Qc3yQZxk2Q6Ac3hySPQRuUUIwmpgB6X/EVSlxyyQNguRk2dl6pjGMgclgPV2raGbzK9K
         s59O7jhtZLpU2H5VUcs/tWXFwDu7pd96OmcSlz6AjBg6aNFsyXNjjm+mTP00meS7lENx
         30l18riTd02UZ0+iUuspw9fB5iqhvl4NzVmod84EmrphxF5y+4nSuUukkIRM/Yu9tVby
         Q6rqikN8GIdZXWqgKQlp9hlkE1iRyVFIljrbqfzTgsWv9pAU/0VmpnsJ149VCt+YWN23
         o4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fq+rH4YE72x0k6vRBalpeRHnZGOCdmKPprbP9ia4MOM=;
        b=RgYmm+Ys/+5VK6Xwm4TvtZuVt0zBWLQOOJxhTr5QzjNYMkKcIMw8wgZCPt7lD6X5kq
         I21ZYRRByjULNZjXAbinRrevwRE10/XDnHEmMpje7gTzqvSeEZ2kjG2bBfbQyz11YiIm
         4O664oIc+EVtfQVQg7GvJdf2ZZcp+ikw/CCob1GTVYHUtH8Jl3lTMOBJmf/bryvcmhjr
         EOs1x0CasuUpRIk/agifpsnq+VIA/LtEfrIWlSVyYfPrEbZEkbGP4KWgU6uXV4FCPo+9
         Ik9a/HCe2J3VvJ1DSdxkgh40tNveVMEw7DHh1ALV4xq0/PYOVY3yMJ+tiFtoVAf6gX5v
         ITCg==
X-Gm-Message-State: ANhLgQ3+xOTg2aHPWIfpmMzCPeKvusAieR/u7/ePH4tEwbzPlRicT13v
        Z/LOzDn8dA7E1bAJxhMQoX1McnnEqsc9hTvUGyHWzckTaYU=
X-Google-Smtp-Source: ADFU+vuRDjYt3cPfXr2YkUhRSV2AIb2Y7M3IIMYmQtgu1PjJAXlpar+ygRx9KVGiGad0CHgJv35Duhka07JGj4GSRfE=
X-Received: by 2002:a19:ac8:: with SMTP id 191mr3760382lfk.77.1585179191616;
 Wed, 25 Mar 2020 16:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <1583941433-15876-1-git-send-email-tharvey@gateworks.com>
 <CACRpkdb3VzOFmnZkXXopsbKAAiQ9nzsqm6fMpcsCfmuvmaeOmg@mail.gmail.com>
 <CAJ+vNU0U9jKDoZLBdC2aRrCCQkKmWATk6G6XAzQcF03tQY9r8g@mail.gmail.com> <20200313150105.GF1349@sasha-vm>
In-Reply-To: <20200313150105.GF1349@sasha-vm>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 00:33:00 +0100
Message-ID: <CACRpkdZmTi5xfiNRX6i1JKT_kxP0G1c=+SiqRi_eWb6YQ3NZ7Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: thunderx: fix irq_request_resources
To:     Sasha Levin <sashal@kernel.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        stable <stable@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 4:01 PM Sasha Levin <sashal@kernel.org> wrote:
> On Thu, Mar 12, 2020 at 10:16:40AM -0700, Tim Harvey wrote:
> >On Thu, Mar 12, 2020 at 6:42 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >>
> >> On Wed, Mar 11, 2020 at 4:43 PM Tim Harvey <tharvey@gateworks.com> wrote:
> >>
> >> > If there are no parent resources do not call irq_chip_request_resources_parent
> >> > at all as this will return an error.
> >> >
> >> > This resolves a regression where devices using a thunderx gpio as an interrupt
> >> > would fail probing.
> >> >
> >> > Fixes: 0d04d0c ("gpio: thunderx: Use the default parent apis for {request,release}_resources")
> >> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >>
> >> This patch does not apply to the mainline kernel or v5.6-rc1.
> >>
> >> Please verify:
> >> 1. If the problem is still in v5.6 (we refactored the driver to
> >>    use GPIOLIB_IRQCHIP)
> >
> >Linus,
> >
> >Sorry, another issue was keeping me from being able to boot 5.6-rc but
> >that's now understood and I can confirm the issue is not present in
> >v5.6-rc5
> >
> >>
> >> 2. If not, only propose it for linux-stable v5.5 etc.
> >>
> >
> >Yes, needs to be applied to v5.2, v5.3, v5.4, v5.5. I cc'd stable. If
> >I need to re-submit please let me know.
> >
> >Cc: stable@vger.kernel.org
>
> Linus, could you ack this patch for stable?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sorry for the delay :/

Yours,
Linus Walleij
