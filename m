Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73843C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCDB206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKHEb0nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405886AbgFXRzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbgFXRzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:55:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BB9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:55:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so2694658qke.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9BdZndT5XAkVJtNXMNabTllEoKCflUHdOvuDrXPuaY=;
        b=rKHEb0ntIPgA5kDAoA+ehfm3WrNsuUcAvfwD/0F1Wk3L55ThAECtU9i3knaacGKZRx
         8x9/zY4/e8BTbDAAgj3LLQTskoQliX4rd/u2gf9qLdO+UhdKNMVSwdyhEQolb76oFmdh
         mT6cOykeEd0XdSDsflEPsr2rXP863t1Gn2jgyHFZ/rqICXjVcJcyPEPGbRopLZNn5MYh
         D7OmaxgJhxY88Lcgj79TPcpdKvlG9Y1cQrM6+Hc+kRvGYsLKn8D5PVtFXZNHmLTN/A31
         9ffQnEL1J3B4Mg6bgUlWiP96BDIXoZ62EQP+0NOhaL1jkvwgWoESqNzHNYnMPfB8uh4+
         TdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9BdZndT5XAkVJtNXMNabTllEoKCflUHdOvuDrXPuaY=;
        b=k1dYJOUtyI0GUdhoDyAINgDlPF/p+JZU9GHS26LzCSNJmTv7+aeEofTUf0FsZ7Rm8h
         2GPjtIiHWv7qNe1t2FHMS4PNXI92QM8vIqeWq+Ypu6qIIGSSMn058Yum6GxdIq9DRjqS
         8cXwlezPqk1L8gTw590cavO+TnS5yrj+jj4lwv2AuiwvgRiZGhejGSWVHJ7SV2qondaW
         vG5AwdsEJfp77iJIELMQi/CFAo6jvHI4mWRVj0M1L0Dv6SaqqY853PrA707Eu6RlbYZr
         /1QWpLtgQ3u0IHq5x7njNMLCAcNmREMqGD6p7IZBtvTWoWNqKHOWO0wlbxAA3lF8HKiK
         Q0pA==
X-Gm-Message-State: AOAM532TFhU+Y6BSTjS+YcbsUzK9LYXT8GUF777GUp3UddriQ0cOUuAs
        Cc5Wh/9GjBJP1NjvggDTMbhQLRkyyD90zXkVV2MQ/Q==
X-Google-Smtp-Source: ABdhPJxQORu2pJpL/BpRXFGSjl5EUKUFp+9sJ8Bp03EHXQbUHab1xU/HzsPqiVq6XykVRIL+XiIgIOtG07n+M4CXOrc=
X-Received: by 2002:ae9:eb0a:: with SMTP id b10mr5491372qkg.198.1593021314218;
 Wed, 24 Jun 2020 10:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
 <CAJWu+ooXdgqSGisZXnHBtYLo9oQBiaNR=HhKseBN+YFGz-L6Xg@mail.gmail.com>
 <20200624165500.idrugfgplqgi654v@e107158-lin.cambridge.arm.com>
 <CAJWu+oqHUq6fvkfRgAx4qx8x1dm-J-h6moeVskCU3gkRybCPqQ@mail.gmail.com> <20200624175236.nblndmg6dfq2vr2u@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200624175236.nblndmg6dfq2vr2u@e107158-lin.cambridge.arm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 24 Jun 2020 13:55:02 -0400
Message-ID: <CAJWu+oreQRCAkBhNQ-n6BPjYsdOL074ff8551sF3r7OxsseEVQ@mail.gmail.com>
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

On Wed, Jun 24, 2020 at 1:52 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/24/20 13:35, Joel Fernandes wrote:
>
> [...]
>
> > > Doing the in-kernel opt-out via API should be fine, I think. But this will
> > > need to be discussed in the wider circle. It will already clash with this for
> > > example
> > >
> > > https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/
> >
> > Have not yet looked closer at that patch, but are you saying this
> > patch clashes with that work? Sorry I am operating on 2 hours of sleep
> > here.
>
> The series is an optimization to remove the uclamp overhead from the scheduler
> fastpath until the userspace uses it. It introduces a static key that is
> disabled by default and will cause uclamp logic not to execute in the fast
> path. Once the userspace starts using util clamp, which we detect by either
>
>         1. Changing uclamp value of a task with sched_setattr()
>         2. Modifying the default sysctl_sched_util_clamp_{min, max}
>         3. Modifying the default cpu.uclamp.{min, max} value in cgroup
>
> If we start having in-kernel users changing uclamp value this means drivers
> will cause the system to opt-in into uclamp automatically even if the
> userspace doesn't actually use it.
>
> I think we can solve this by providing a special API to opt-out safely. Which
> is the right thing to do anyway even if we didn't have this clash.

Makes sense, thanks.

 - Joel
