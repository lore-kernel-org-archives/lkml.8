Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFFB20706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uiGkC43t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbgFXPt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404187AbgFXPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:49:57 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53325C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:49:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fc4so1266522qvb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YB/VOjPc5YWicqtfYydyIC2oPj65c/3S5cDnuaHR75A=;
        b=uiGkC43tGqYIbxyrXP/O6aihPMK+GNIimvblnP0eETC0kehsG3GRbIKjNQ4RwTs7JN
         Qd0MqNeJygg7B+8AfUu+OjG4gNJQ1lA+e4G7Tedb70JegIVMN0e2ZweRCnc0LJpcRQs3
         YcnYsU8hBwDJT09yYxpSNy6AG7ly9J1Yk6zlZJjyUoYnlPqk2kwPIYxO+nLRcKg6vrTd
         mYA4Is59wgiqa9GKtWevk9Ugrh9Ldy8/zk6VcdOIrqxXwzkWACQfrE3uYDB72M8A0wkO
         jkkdTJYsuEdhA5Mga56t5/uGgYlXzx0IZRljRWtqIJCAhYfo8rWVbyBPN9vF16qKWZ9P
         /yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YB/VOjPc5YWicqtfYydyIC2oPj65c/3S5cDnuaHR75A=;
        b=JC2Ifbuu0hsYANMsj1z92kWn8lvkZ2kpA5An/pJ4AGQhFZb3SwDgqL4/4vJiSM79lk
         q2ReiIBCHrMPs+as2xSsZUgbhL14XW6UKJPZC6WxQbaXpgebjhaN+zjgenkMgHr7ADdq
         N/ZGa0iKOWm31W32edJX8kj0JAEnHl8uq89GftJ8P9+CJOklcgM9pLTpq/B83y6OEmz3
         NObjHSptWAUd7XHcka+23KzUtWm06WsuEGNzGrSFXHnOzj6ahO9Z3clXyprPRXIbg4mZ
         SljSia24F3l5bWEHxLSNCpRGfsgnfgTXyLA5GfevxL2K7MLtzAWXc4bTVCjeiglK66BM
         dnfw==
X-Gm-Message-State: AOAM532I3CSCSfbXNNBcxiXs6N3k+dhDvovKmlPLiUGtwZBkSexTrDj3
        Poi605l/fQwdxdYms5ApZonBMUK44hinPa5b23WbKQ==
X-Google-Smtp-Source: ABdhPJziSIKd2Jz3JwCqB39ZgkqlvGMBcoa7/JiT+rH17uOmMyxDr8wMter6E6YoCK63JtOT4mhihox5ok9Op7F8CT0=
X-Received: by 2002:a0c:8e04:: with SMTP id v4mr32122396qvb.213.1593013796103;
 Wed, 24 Jun 2020 08:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com> <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 24 Jun 2020 11:49:44 -0400
Message-ID: <CAJWu+ooXdgqSGisZXnHBtYLo9oQBiaNR=HhKseBN+YFGz-L6Xg@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:40 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/22/20 11:21, Doug Anderson wrote:
>
> [...]
>
> > > If you propose something that will help the discussion. I think based on the
> > > same approach Peter has taken to prevent random RT priorities. In uclamp case
> > > I think we just want to allow driver to opt RT tasks out of the default
> > > boosting behavior.
> > >
> > > I'm a bit wary that this extra layer of tuning might create a confusion, but
> > > I can't reason about why is it bad for a driver to say I don't want my RT task
> > > to be boosted too.
> >
> > Right.  I was basically just trying to say "turn my boosting off".
> >
> > ...so I guess you're saying that doing a v2 of my patch with the
> > proper #ifdef protection wouldn't be a good way to go and I'd need to
> > propose some sort of API for this?
>
> It's up to Peter really.
>
> It concerns me in general to start having in-kernel users of uclamp that might
> end up setting random values (like we ended having random RT priorities), that
> really don't mean a lot outside the context of the specific system it was
> tested on. Given the kernel could run anywhere, it's hard to rationalize what's
> okay or not.
>
> Opting out of default RT boost for a specific task in the kernel, could make
> sense though it still concerns me for the same reasons. Is this okay for all
> possible systems this can run on?
>
> It feels better for userspace to turn RT boosting off for all tasks if you know
> your system is powerful, or use the per task API to switch off boosting for the
> tasks you know they don't need it.
>
> But if we want to allow in-kernel users, IMO it needs to be done in
> a controlled way, in a similar manner Peter changed how RT priority can be set
> in the kernel.
>
> It would be good hear what Peter thinks.

It seems a bit of a hack, but really the commit message says the
driver is not expected to take a lot of CPU capacity so it should be
expected to work across platforms. It is likely to behave better than
how it behaves now.
