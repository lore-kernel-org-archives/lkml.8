Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0070C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED7D2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588199926;
	bh=vlQNsP7dAHVkcYkloa8JjBPvOJ835TBWE0k1u8gtsCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dK1AAPD15J1Z2j+pY7M99izNpMVoSAODfSzedo2M9fqmBhbMkYQ3ePKs/byRY6Op7
	 d15J13Uep6vq6tULaKGnM2rgleDXS/DBj1OfegxXDAYu6qNnt+raleUYjJhJRJ8WN+
	 JeqtDBLsnBGcBOsSk4OjAe8aHs+HVgIO0xWKsYsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgD2Wip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726164AbgD2Wip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:38:45 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E25EC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:38:43 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so3091141lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a189DpcB+cR0a9sR1cWjCHfr0hMEKTR3GgF8mFeUCs0=;
        b=LLd9jSr+Bqmzh6IHdgIqt/bdYR9XqhcRoXQb1O694fr+x8hPsgulwZSwk38Cmfh/TG
         /WtyJkaNdWvJaGMbaMjeU+mE2P68xJnC2IwfxBUrOB9bzPuoMIecaAUWsMK+67szAyVB
         jEJi7LLcwTgwKmTOYlQIgFOwXcjzAK6wd6wQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a189DpcB+cR0a9sR1cWjCHfr0hMEKTR3GgF8mFeUCs0=;
        b=jc38yLmHvgWNS/dmMsNN/J/sW15Vmkp4iD6yhzCWgtpdh2S10r4XN93W0GHXCQetUM
         ZwsYQSW+TwVTSEmIsfDHwKjuX7A5SKRh+P5Qu3E/R0f+BW4+hIeCj/MbPU7GB8WYcwjF
         cD0y8RUBv/jFnv46DBgkvzh6Fymjn/mX81aBCSgyjzIXfKOpkEVzFStyM8rjUSAAaCnf
         9tMH4UXRcMOLBHuq8xq96gMRzZdsHh2Ca9q+Idv9chzAuD2AzgiLs7Ej7Uvp15mvSXIV
         RSkL5dpE6cGDrRV6tC97Rs9IzCoFMwj8N4Gvn5Bd42qGW/w9UCj8Zj2Yf2Z2Mo8LmSox
         TnvA==
X-Gm-Message-State: AGi0PuZWxjIr0eZ1LhVVPXRVpju7x3DVn33UgJExGTlLQxeNB4Hf95ZY
        OFqHhC5QydRDZoU2hJXizO7EfR0hzxQ=
X-Google-Smtp-Source: APiQypKkBOsb2IhM3Dt4QPYnad+Kqmr1sn9Ziw26tNLxVsJZZ0Jc7y+9qWLwGfrhJvBHU7C91/oXZg==
X-Received: by 2002:a19:ee06:: with SMTP id g6mr59465lfb.90.1588199920814;
        Wed, 29 Apr 2020 15:38:40 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id p14sm3442551lfe.87.2020.04.29.15.38.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 15:38:39 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id w20so4440675ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:38:39 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr281196ljg.204.1588199918722;
 Wed, 29 Apr 2020 15:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com> <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 15:38:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
Message-ID: <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:23 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> By the way, all other attempts to fix it look much more dangerous
> than my initially proposed patch, you know the one you hated, but
> it does work and does not look overly complicated either.

I don't think it works.

The whole "take lock, release it in the middle, then re-take it" is
fundamentally a broken model. We've never had it work well, and it
tends to have subtle issues. That's particularly true when you then
open-core the (only) acceptable sequence something like five times.

> What was the reason why that cannot be done this way?

If it had introduced a new locking model, and new locking helpers for
that model, with a comment in _one_ place, and nobody doing the ad-hoc
locking on their own, that might be more acceptable.

But that's not what that patch did. No way will I take something that
is so fragile and hacky, and repeats the hack N times.

If you do it properly, with a helper function instead of repeating
that fragile nasty thing, maybe it will look better to me.

That said, locks that get released in the middle aren't really locks.
But at least if the only way to take that lock had the "oh, this lock
is in that inconsistent state, I will return -EAGAIN", that would be
one thing. But when you have N different users and rely on all of them
getting that special semantic right, you're doing something wrong.

                Linus
