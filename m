Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D301EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE902206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhdpJDQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404759AbgE2CPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390679AbgE2CPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:15:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA644C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:15:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so453390eje.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoRZPQciUjW0VCWgrvWzNEBESY0jfZ3/WBQnF/AySco=;
        b=rhdpJDQQejWKnSlXPmeIE88URsUfXVm0a7+esvI8MRip1/sAbPXHD12VkPtq8exsUN
         Pk6dsRxsQSJ0V4BgyN9neaqH0/epkDX1VQwsfhvCSAPRxQC7TYMQLau0nfev15sHUsht
         vuhVpYwXiHwqN3ejc81Q/trn4wirmZvlagVbK2A349sGibnr4JpRh3o/SV2FGoVYQdHJ
         xuAC5WvvqyLLc/Hhwxr7OxWDashXsPKofGJ1J0WTBpB/lZ7hqiOhpvladh5e3L3fbmNQ
         papT9qREaDH1jUAcKHWcTAHaE9d5uV3B3ZrijCZPqLpdFmfIY4GTsKXzPr0VmbAlN1QD
         hrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoRZPQciUjW0VCWgrvWzNEBESY0jfZ3/WBQnF/AySco=;
        b=Vb/UfgkNGjCPnG+kXOIg1Oe2jT7ZaoYiH50KDpjG+ImUdbB6DcJXOake+TGK04pFMR
         BdiZTjwREW55xf2R5tIRu4OXkfc02wW/vcfFm3LKeHlrxVujtHfq4YABBgV8JsYoJAb7
         sByr+4FDPS+VlsN8qsuXdeMtAwHokiQUgEPCg1ptTwqGE27EbuqhhMUMQp+hIJnAT6QT
         XMvzI+VKn8mfJVGZ/O28tVPSQfsNUW1mfp/0m1tiuJ5Hag+SjtUqOXGbaMk+2U/zp5WS
         OHCfrPC0nBnDDv7DnjZ26CieC8SRDD6mhs3ywZEYR/wiGmuPSLA4rN52RHF0p51wP1LN
         QExw==
X-Gm-Message-State: AOAM531eqocrtmP9XYhFyExszrmSWsY5XAjyNYnxkoeFVNsZmk6pKHA6
        4fdRfv9Oz1E7CXTmOJglqkJmrcnNfUv5d9Vhj9E=
X-Google-Smtp-Source: ABdhPJw1xLHrMLHiUyZNFBHXB7bZmFXA7631wc1GNiTSKobEUFpMwo9k7uw0mmtHkMVjK+9TfVJe5Zy/uGKwSvQI/dw=
X-Received: by 2002:a17:906:c9d6:: with SMTP id hk22mr5608919ejb.101.1590718538464;
 Thu, 28 May 2020 19:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty+Vyn8aSxNqWY+_KEnqj8nGZbp2PRJTvQLcV1iPhG7dA@mail.gmail.com>
 <CAHk-=wgo1HUhSj-kGO8u+iUCxp+QS+rNenbM8gywbF3pdQ_DQA@mail.gmail.com> <CAPM=9ty5ce2mm7Di6qvRKy2Jg2Tw-Cd8U6ypN=Abc2NCGmQWWQ@mail.gmail.com>
In-Reply-To: <CAPM=9ty5ce2mm7Di6qvRKy2Jg2Tw-Cd8U6ypN=Abc2NCGmQWWQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 May 2020 12:15:27 +1000
Message-ID: <CAPM=9tza6oC3tBHaYq+nLGh0fwwZAKR3U-HVvn8jzN9myMz0dA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.7-rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 at 12:02, Dave Airlie <airlied@gmail.com> wrote:
>
> On Fri, 29 May 2020 at 11:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, May 28, 2020 at 5:21 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > Seems to have wound down nicely, a couple of i915 fixes, amdgpu fixes
> > > and minor ingenic fixes.
> >
> > Dave, this doesn't even build. WTF?
> >
> > In drivers/gpu/drm/i915/gt/selftest_lrc.c, there's a
> > engine_heartbeat_disable() function that takes two arguments, but the
> > new "live_timeslice_nopreempt()" gives it only one.
> >
> > I'd blame a merge problem, since the failure is in new code, but the
> > problem exists in your top-of-tree, not just my merge.
> >
> > In fact, it's not even your merge of the i915 tree that is the source
> > of the problem (although the fact that you clearly didn't _test_ the
> > end result most definitely is _part_ of the problem!).
> >
> > Because the problem exists in the commit that introduced that thing:
> > commit 1f65efb624c4 ("drm/i915/gt: Prevent timeslicing into
> > unpreemptable requests").
> >
> > It's garbage, and never compiled.
>
> I thought I'd dropped the ball completely. but I see it's a selftest
> failure, I must not have selftests built in my config here, I don't do
> exhaustive builds randconfig
>
> This has also been built by Intel, but I'm assuming they missed their
> selftest bits as well.
>
> I'll revert that and resend.

I did drop the ball in one way, I see sfr reported it broken this morning

I normally expect stuff coming from Intel has been through their CI,
even their fixes tree generally gets pushed through that system before
I get it, and it usually catches these things.

I might have to push back on intel fixes this late in the day, as
maybe the land on next and cherry-pick to fixes model has made them a
bit lax on how much stuff goes through CI.

I've just drop the whole i915 fixes from the tree and will resend with
it removed.

Dave.
