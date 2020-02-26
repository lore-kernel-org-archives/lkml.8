Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE5C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C8621744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0RRnNpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgBZCOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:14:00 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40355 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBZCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:14:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so1459113oii.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 18:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJC4mlslET9V3IuYmEEX9Cjes6kXcianVh7OiRR3yKs=;
        b=d0RRnNpncoFvqVEOoPn57Cq0cQ6PP9iVVlgC459m4EF5RlkVaZq4Vyp5rsQf6f20qJ
         pULtmfEK3Rjsw6M3LZ7+RAEf64JSLzN+gBP8dXqFagLo4ItQJSuBGBIysYwWLWcX2dUw
         qBSF11x36vp5nfLUa3chKy7OyHBXhVu6ceBQT2DJISVIlsQ5MUNX4YQjtIMWz6C7H4/t
         OI5a/ft8aQ+gGx+ar7p2TnQNMQVY/hogBsjShOxD1j5BFZk3IgBjKYOjMeTnny7ETs0a
         AdQgP3XXeBX3AMMfl9Qms/YL+VskXMWz0wEmmvrv6spZdsuJEWKbAFEYOSoliE24xo7q
         JZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJC4mlslET9V3IuYmEEX9Cjes6kXcianVh7OiRR3yKs=;
        b=HT+K5qnLgyozTHlzr+QyfGZjYtBfr/8bXntQpNJ1eqaUTaikWWhvpp06e+3frjsvve
         svVf09a01dVcosAenvY/ObXluyKegZ7ROAo9D218H81qIFQbUP7Kahfov1x4VrTn6RKL
         faI7IwxuXDuMZI5Y0tPBigja2Qb5j/K+5YdtsQH0hKVOT7r77fnIQSUKa2dZneWqF9Hy
         rQYYcVw2KDp00DkBnZye0mjgDgWMSQhHfUFnj4JphSq2RPMb4Ij1rfYzgHgvLS4obHRx
         V9/9IrQvUu+798gMSJz/C/8iS437OKoBBwU/xvlJVxvdvnukBUJrwPHwyMW2PVrSDBhl
         5g/A==
X-Gm-Message-State: APjAAAXgrcAqWdKQcUXEvU/b8tdD4/lNsT7I9l0SIiTyyTWmAv+HBWuK
        vVECayYBneMgKuNkYGTnjvbO+rFZI6ontn/nZuFIUDoRhbM=
X-Google-Smtp-Source: APXvYqyyvLae4My4lNLNDs9nPDn8upLsZw9bgLJTlpOIxxkhcVnvBO6xnKhinNtsF6ILSLQo1EgLO08HJPbQisL58MQ=
X-Received: by 2002:aca:c0c5:: with SMTP id q188mr1315752oif.169.1582683239774;
 Tue, 25 Feb 2020 18:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20200225050828.56458-1-john.stultz@linaro.org>
 <20200225050828.56458-4-john.stultz@linaro.org> <CAGETcx_x4O_M4OJvCSZNu_wroYoyog9nAW7OivS56qzEhFmnHg@mail.gmail.com>
In-Reply-To: <CAGETcx_x4O_M4OJvCSZNu_wroYoyog9nAW7OivS56qzEhFmnHg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 25 Feb 2020 18:13:48 -0800
Message-ID: <CALAqxLUMjF4vx0EAd0bQOixyP5SLZ0pESpC0TXoHbSTyTqQLYg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     Saravana Kannan <saravanak@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 6:11 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 24, 2020 at 9:08 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > With the earlier sanity fixes to
> > driver_deferred_probe_check_state() it should be usable for the
> > pinctrl logic here.
> >
> > So tweak the logic to use driver_deferred_probe_check_state()
> > instead of driver_deferred_probe_check_state_continue()
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/pinctrl/devicetree.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> > index 9357f7c46cf3..1ed20ac2243f 100644
> > --- a/drivers/pinctrl/devicetree.c
> > +++ b/drivers/pinctrl/devicetree.c
> > @@ -127,11 +127,12 @@ static int dt_to_map_one_config(struct pinctrl *p,
> >                 np_pctldev = of_get_next_parent(np_pctldev);
> >                 if (!np_pctldev || of_node_is_root(np_pctldev)) {
> >                         of_node_put(np_pctldev);
> > +                       ret = driver_deferred_probe_check_state(p->dev);
> >                         /* keep deferring if modules are enabled unless we've timed out */
> > -                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
> > -                               return driver_deferred_probe_check_state_continue(p->dev);
> > -
> > -                       return driver_deferred_probe_check_state(p->dev);
> > +                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default &&
>
> Is this IS_ENABLED(CONFIG_MODULES) still necessary? At the end of this
> series, doesn't driver_deferred_probe_check_state() already return
> -EPROBE_DEFER if modules are enabled and timeout hasn't happened?
>

Yea, good point. With the reworked logic in v5, the
IS_ENABLED(CONFIG_MODULES) check could go.

thanks
-john
