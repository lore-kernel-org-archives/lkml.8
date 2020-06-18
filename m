Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA213C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA89206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HW1Tipiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFRVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgFRVbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:31:35 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F203C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:31:35 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id s6so1806053vkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnvXnZQHRkFSp3+nnoBZSo/h988GlGZ2uvOYYP79VTo=;
        b=HW1Tipiz+3fXmY+92yju6UzqYt6/1x+/6EOhNeho+ovyIr/NcVXPsg6ausEZ96VNr+
         XWQB0jnpIVLngiIJvGw8RlpTmovrn2guTSkYP8kPn3sN4pfuxKpdW0BCanHPkeR17gT4
         LHi6n0LPxAxQzGWKVfDk+JG5cOOOO/TZN8odY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnvXnZQHRkFSp3+nnoBZSo/h988GlGZ2uvOYYP79VTo=;
        b=JmXPbwSdc7Ou9g1v/uorYLa+e1+7G7kTlagZUE9wLXNU5zrfsFcYRUe3y9WbTkuux2
         tZOMnTex2pG54F/mBWY1yIDl9oC+WwF24jwedUpRxw8pwhzWCnZluD5O21HNAPTHJBJX
         9wQ9Uh6A5lqogPJj8Pj7lKQGpQD/XFFTfKDn6Q3Q8f8qGZ66ThFuUe3dvXEwTEJsGlVJ
         yJlsHBzBXww/pMasZTIJwXKg2DzoXWkOyVj+f6Sm9X/ZQepyn/Z+eTob4DpMLG9X/zem
         jTMfDKTJhsZ+Q122bwBTmNyTXetcIWuFsAMc5U3drgqIoiHv5hy4xTb3EUj6iBMp3k11
         i2fA==
X-Gm-Message-State: AOAM533QVi6rg8O6doDfLV7zRQxMRBXmgYA4VNYPkSFbBfpS1MHKDE+m
        kgFHhiY5vf+wBteY28eEj8Yz0JyQ2Qg=
X-Google-Smtp-Source: ABdhPJzCzQJSqXbEYZqEa9evkm8Q3EDXoh8x5Sd+vnesopSxDt7RsN3Q7Cd+y+TaYqLCB422AyeT4A==
X-Received: by 2002:a1f:344f:: with SMTP id b76mr5218195vka.33.1592515894437;
        Thu, 18 Jun 2020 14:31:34 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id n12sm414001uap.8.2020.06.18.14.31.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 14:31:34 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id e1so1810528vkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:31:33 -0700 (PDT)
X-Received: by 2002:a1f:280c:: with SMTP id o12mr5129871vko.92.1592515892795;
 Thu, 18 Jun 2020 14:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com> <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
 <20200612092454.GA94228@google.com> <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 14:31:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UySLsTaUP3nOfQO98qPEUkY8tMhw25pJ4Yi7FVM5xU6g@mail.gmail.com>
Message-ID: <CAD=FV=UySLsTaUP3nOfQO98qPEUkY8tMhw25pJ4Yi7FVM5xU6g@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 5:34 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/12/20 10:24, Quentin Perret wrote:
> > +CC Qais [FYI]
>
> Thanks for the CC.
>
> >
> > On Thursday 11 Jun 2020 at 10:48:40 (-0700), Doug Anderson wrote:
> > > Hrm.  I guess my first instinct is to say that we still want this
> > > patch even if we have something that is applied more globally.
> >
> > Fair enough.
> >
> > > Specifically it sounds as if the patch you point at is suggesting that
> > > we'd tweak the boost value to something other than max but we'd still
> > > have a boost value.  In the case of cros_ec_spi I don't believe we
> > > need any boost value at all, so my patch would still be useful.  The
> > > computational needs of cros_ec_spi are very modest and it can do its
> > > work at lower CPU frequencies just fine.  It just can't be interrupted
> > > for large swaths of time.
> > >
> > >
> > > > IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?
> > >
> > > I'm not totally a fan, but I'm definitely not an expert in this area
> > > (I've also only read the patch description and not the patch or the
> > > whole thread).  I really don't want yet another value that I need to
> > > tune from board to board.  Even worse, this tuning value isn't
> > > board-specific but a combination of board and software specific.  By
> > > this, I'd imagine a scenario where you're using a real-time task to
> > > get audio decoding done within a certain latency.  I guess you'd tune
> > > this value to make sure that you can get all your audio decoding done
> > > in time but also not burn extra power.  Now, imagine that the OS
> > > upgrades and the audio task suddenly has to decode more complex
> > > streams.  You've got to go across all of your boards and re-tune every
> > > one?  ...or, nobody thinks about it and older boards start getting
> > > stuttery audio?  Perhaps the opposite happens and someone comes up
> > > with a newer lower-cpu-intensive codec and you could save power.
> > > Sounds like a bit of a nightmare.
>
> Generally I would expect this global tunable to be part of a vendor's SoC BSP.

I think I'm coming at this from a very different world than the one
you're thinking of.  The concept of a BSP makes me think of a SoC
vendor providing a drop of Linux with all their own weird hacks in it
that only ever works on that one SoC and will never, ever, ever be
updated.  5 years down the road if a software update is needed
(security fix?) some poor soul will be in charge of tracking down the
exact ancient code base that was used to build the original kernel,
making the tweak, and building a new kernel.  ;-)

In the world of Chrome OS we try very very hard to build everything
from a clean code base and are trying hard to stay even closer to
upstream and away from per-device weirdness...


> People tend to think of the flagship SoCs which are powerful, but if you
> consider the low and medium end devices there's a massive spectrum over there
> that this range is trying to cover.

Yeah, perhaps you're right.  When thinking about a laptop it's almost
always a fairly powerful device and things could certainly be
different for very low end chips trying to run Linux.


> I would expect older boards init script to be separate for newer boards init
> script. The OS by default boosts all RT tasks unless a platform specific script
> overrides that. So I can't see how an OS upgrade would affect older boards.

In the Chrome OS world I'm part of, the people supporting the boards
are not always the people adding new whizbang features.  We get new
versions of the OS every 6 weeks and those new versions may change the
way things work pretty significantly.  We ship those new versions off
to all boards.  Certainly they undergo testing, but there are a lot of
boards and if something is not tuned as well as it was when the device
first shipped it's likely nobody will really notice.  This is my bias
against needing per-board tuning.


> This knob still allows you to disable the max boosting and use the per-task
> uclamp interface to boost only those tasks you care about. AFAIK this is
> already done in a hacky way in android devices via special vendors provisions.

Yeah.  I don't think I have enough skin in the game to really say one
way or the other what the API should be so I'll probably stay off the
other, bigger thread and let others decide what the best API should
be.  For Chrome OS I'd probably advocate just disabling the default
boost but even there I'd be willing to defer to the folks doing the
actual work.


-Doug
