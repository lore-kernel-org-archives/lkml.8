Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EC7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637A020672
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="D1PbfnB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgGSJfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:35:17 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC303C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 02:35:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so8231401lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2myl3rrfsZfV3B1/6+71zukNw223HefPvrzFOXka6Y=;
        b=D1PbfnB/cEtXs1YHmkD9RddChOxmhJyhVH7iGXhG+BYAeAwPU2w2DpeoyQESG8fNEq
         jQAAwnhp5JxDEiKq8xVTqcop2XD7UHyJGpoS8tZKKQaYjer25q2JhkjmYMCgk5lMIq4V
         taNXGxUGeuwHr6fC3phAuLrd7EhtA0rG4nQzmS/Y0V+onBW3EALw9nZY5YzjDpnTuXZY
         cnEzmEV+36Tghawmvo/yLYIjwu236QaxvKakFvcM9cl5WCyCBFUyxVZMMaBq1Km1zEMt
         yOSqiDp9QD++GhF8rcl5TWkPhC6Xk7jykRJh0AE259skpd+R3wXJG0tHhg2pCx83cKWe
         csOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2myl3rrfsZfV3B1/6+71zukNw223HefPvrzFOXka6Y=;
        b=WZwDJ29u/N7IShut1K1CkAV3Xsloh4SLIYssq7m9fPf1pkhCpN5mcm/o3CxSAyLsE4
         hgzrAZV+CaxyqxnNrFyRKNjadGI8Anvw1CWZ++6DUHYBXPnqfvCf23bx+tp2Vp0eWehX
         ZzKYRmGUwtqfOA8fCY1nx7zMs3MTA5L6Yvf+6/0UbYZO/r4INrBZzNpmbfIIUIQYcE5o
         UqJtx1QlUq7myz1CaLBkm0MnO7j52F6J+uE9WeX81wpISDFDbNz/JjquPhaR0JUhqy+n
         WcvmXaS3kgl8NFevJ8kDma54o1aZj/lE6nNlW4+iud5YNnXHW4GNXWpyCaroLT8s9hJv
         4I6Q==
X-Gm-Message-State: AOAM533rcLf50QhEnzMs3UMY7xV+Nj1GXj7vRAwXw4brnOIAiraC080g
        r+v09E++wf/3rlc1uM5k4hUQD/9FstTRG63O6lSyOg==
X-Google-Smtp-Source: ABdhPJwGUxA5J2lZn92NVAcIQz99hfWezqmmL6bbBZf1zp7nN9Zk8v9gaz/86rItRldOJL9/DispxniIILk/6y370P8=
X-Received: by 2002:a19:8452:: with SMTP id g79mr134333lfd.29.1595151315205;
 Sun, 19 Jul 2020 02:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200718091626.uflhdcgkmhqij5b7@pesu-pes-edu> <20200719092652.GA257887@kroah.com>
In-Reply-To: <20200719092652.GA257887@kroah.com>
From:   B K Karthik <bkkarthik@pesu.pes.edu>
Date:   Sun, 19 Jul 2020 05:35:04 -0400
Message-ID: <CAAhDqq1LNQ=UfCaNojZ+wf2+njQ+7jD8Yvr1AG1TSrcByfMo+g@mail.gmail.com>
Subject: Re: [PATCH 2/4] staging: rtl8188eu: include: fixed multiple
 parentheses coding style issues
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 5:26 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 18, 2020 at 05:16:26AM -0400, B K Karthik wrote:
> > fixed multiple parentheses coding style issues reported by checkpatch.
> >
> > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > ---
> >  drivers/staging/rtl8188eu/include/ieee80211.h |  4 +--
> >  .../staging/rtl8188eu/include/osdep_service.h |  4 +--
> >  drivers/staging/rtl8188eu/include/wifi.h      | 34 +++++++++----------
> >  3 files changed, 21 insertions(+), 21 deletions(-)
>
> You can never add warnings to the build, like this patch did.  Always
> test-build your patches at the very least...

understood, I will definitely do that.
but these warnings are (mostly) [-Wunused-value] and [-Wformat].
that should not have (?) occurred due to the usage of parentheses.

anyways, I will try to fix these up and send a v2.
sorry if i wasted your time

karthik
