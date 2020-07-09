Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF850C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F0C207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hFbUxwkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGIPWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgGIPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:22:46 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1928C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:22:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id e15so1304718vsc.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlZV7q7oZfSsF7eZZwKOePXY88Q+axAbOXXuZcZlzCE=;
        b=hFbUxwkrUwczQtSXAxGKo0vdW2IUs0zf+zn25GxqMjc0mhWqQV+rAOaMJe31oBUkHg
         INzNLPLLe84Ksm2T8pEVrgP0fnOOez1gR9Gu3nmGD7M+NY4J9FPg2GOXGNRn2sdyUxcS
         gsU9lHLptI9Vtt2KL+FJDwLrLfmocJwZmDVfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlZV7q7oZfSsF7eZZwKOePXY88Q+axAbOXXuZcZlzCE=;
        b=ocqhgxyK4guPKCdj4xvZrdlEG5GCUIJheZU7Zk4ZW+WmAHkF8VzKNXAc5ule3feMcr
         i/i554Xt9qDO1o/03Q2k+OzWGB1hjhvGYu/Xo1iVHrJrheq4BXr0JiQilQVe2YgJ+6p1
         g4zpCZbckBu0eEFOwbjtoKz5xa/RFrwUtPqCb5XNqj8sTXb1k0kex+IVOo83eqpDu95t
         kPsidGfCafppvRpkRLQf8GNmMHa4p64BQmwG0TexLXO+STBpwyEQ7Gb7Pf38FqVq2JvB
         s4zGPdQuYameJeskHt3r2RaWeK31bmkisVf1i9sHz2IWKb0DdJ7QKMXhtohyhc2C/jeT
         Xqag==
X-Gm-Message-State: AOAM5328hmuHERJ1dKowkNDZHPphFk0VVWBbVsbDaOjbTjdXx7864UUS
        7BNVR5B9VIbkqm8doovhjCYGaKzKNEY=
X-Google-Smtp-Source: ABdhPJytcMrL8fYwgfJ6rhkMBXsQoTwHvnIDDvxYfG96CGn/78nHtCwhfH9dYwryPO7dI3kIMr/ssw==
X-Received: by 2002:a67:f114:: with SMTP id n20mr14112497vsk.10.1594308164875;
        Thu, 09 Jul 2020 08:22:44 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id j13sm448395vkj.33.2020.07.09.08.22.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:22:43 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id h190so525252vkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:22:42 -0700 (PDT)
X-Received: by 2002:a1f:61c2:: with SMTP id v185mr16966422vkb.42.1594308161819;
 Thu, 09 Jul 2020 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200707101712.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
 <CA+ASDXMXtwdV4BNL1GSj8DY-3z8-dZ=1hP8Xv_R-AjKvJs0NMw@mail.gmail.com>
 <CAD=FV=WU2dUFtG4W6o574DRN9VV+u_B5-ThqV3BogjztBibyLQ@mail.gmail.com> <CA+ASDXOwFnCcMC9g11FSVLvj2nepArJyihGvx3SU-XqySoJruw@mail.gmail.com>
In-Reply-To: <CA+ASDXOwFnCcMC9g11FSVLvj2nepArJyihGvx3SU-XqySoJruw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 9 Jul 2020 08:22:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WUpHGoLm+NG-_eGsVKO7X+SLObFCoQVBSCNEa6KRmpmA@mail.gmail.com>
Message-ID: <CAD=FV=WUpHGoLm+NG-_eGsVKO7X+SLObFCoQVBSCNEa6KRmpmA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Keep track of which interrupts fired, don't poll them
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 8, 2020 at 4:40 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Jul 8, 2020 at 4:14 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Wed, Jul 8, 2020 at 4:03 PM Brian Norris <briannorris@chromium.org> wrote:
> > > If I'm reading correctly, you're removing the only remaining use of
> > > 'per_ce_irq'. Should we kill the field entirely?
> >
> > Ah, you are indeed correct!  I hadn't noticed that.  Unless I hear
> > otherwise, I'll send a v2 tomorrow that removes the field entirely.
>
> A healthy middle ground might put that in a patch 2, so it's easily
> dropped if desired. *shrug*

Sure, sounds like a plan.


> > > Or perhaps we should
> > > leave some kind of WARN_ON() (BUG_ON()?) if this function is called
> > > erroneously with per_ce_irq==true? But I suppose this driver is full
> > > of landmines if the CE API is used incorrectly.
> >
> > Yeah, I originally had a WARN_ON() here and then took it out because
> > it seemed like extra overhead and, as you said, someone writing the
> > code has to know how the API works already I think.  ...but I'll add
> > it back in if people want.
>
> I believe WARN_ON() and friends have a built-in unlikely(), so it
> shouldn't have much overhead. But I don't really mind either way.

Since you don't feel strongly, leaving it off.


> > > Do you need to clear this map if the interface goes down or if there's
> > > a firmware crash? Right now, I don't think there's a guarantee that
> > > we'll run through a NAPI poll in those cases, which is the only place
> > > you clear the map, and if the hardware/firmware has been reset, the
> > > state map is probably not valid.
> >
> > Seems like a good idea.  Is the right place at the start of
> > ath10k_snoc_hif_start()?
>
> Either there or in .power_down()/.power_up(). I think either would be
> equally correct, but I'm not entirely sure if the semantic difference
> is meaningful for this.

Will choose ath10k_snoc_hif_start() since it's where napi_enable() is
and ath10k_snoc_irq_enable() are and those are related.


-Doug
