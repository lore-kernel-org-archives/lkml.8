Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166B3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E388520888
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590716979;
	bh=4osXx7/5kT+Af7EtvMqmKx2pRSpLnY7cbcMp3vG0FlE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WbuUooXjxtfp7XuEzi7dfuXtR76/imgiKPxyjbx6AVWcA4y+6DMHtlDBjlmZMhMZa
	 dXMfTkDbta4qnn+yqJReBzGbCvl2aufYq7SkCMRkIi8JhptiLow6F5m6pr+DphuLeo
	 hfmD6wOC3osVSwwE3d6ZWMXOdYfTCWnAnxMULzFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbgE2Bti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390018AbgE2Btf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:49:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01421C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:49:34 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so617386ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkwZFdug2ibfipHp51Hdh/MIpXAxoqnCWV3ptE8ypxM=;
        b=OQI7g/LZthfupWZGTaaD31P84Kb9G8XBQLwp0DDsDWA2HzBFoyGDMu31FtMKA9ET7J
         dDPGe9+x7OgAmQSeGW4sGXMu3sEUp7l35dkDgmSjURvllTM1xUIqeoN9hVSBQG1UpRgQ
         ta7w4tJ7XCis8TtVKRq2VSK4+I12I3r45wSLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkwZFdug2ibfipHp51Hdh/MIpXAxoqnCWV3ptE8ypxM=;
        b=q4SXt9AS8QakHPJQ1hk9hxcePFu4/NRide9gWl3Xj+/M8dJgWXNdCe9hn65Qt/lLyi
         26vP4A3lux4EHVBzRZtctt+CHR7SgPseI9ey74MhqW8SEaXntVuLBJ0buWQWQGkxKu7F
         XNUmqnfLVbjzIpsv9m+x4Qay9BtyxXXQjvL+H/mge0bo2B7v2brht4kVGCtA/amn/+Y8
         EGxWMoQ6Z5bZX++FNZcjwZfYKt8QNK2eUoYz4tJw+68WIXF5FRTtgMJVH3NGskh+3GlG
         fOSKXpVd1uvl79VqTb8k9DdawhiQ8UnPZxqZDzSIIbwRnT/1X8b2IUVwv05jpMmihAEo
         HoHg==
X-Gm-Message-State: AOAM531IJhAtRMt1RAGN6qgacELG4e/wKYc/M3+atp+OAZ71sZYV6LWc
        /sJqWMPjjvldJIcf5fyt711fjLrTvCQ=
X-Google-Smtp-Source: ABdhPJyJ6+wYAgLf4uvZZoxRfJaeNekI57oTTeCST+D+HNoph2FeK2O53bbyQqmKf3jQKYlPb05Wtw==
X-Received: by 2002:a2e:9b4d:: with SMTP id o13mr3085567ljj.363.1590716971425;
        Thu, 28 May 2020 18:49:31 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id w22sm977864ljj.53.2020.05.28.18.49.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 18:49:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x22so332479lfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:49:30 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr3133948lfn.10.1590716969967;
 Thu, 28 May 2020 18:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty+Vyn8aSxNqWY+_KEnqj8nGZbp2PRJTvQLcV1iPhG7dA@mail.gmail.com>
In-Reply-To: <CAPM=9ty+Vyn8aSxNqWY+_KEnqj8nGZbp2PRJTvQLcV1iPhG7dA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 18:49:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgo1HUhSj-kGO8u+iUCxp+QS+rNenbM8gywbF3pdQ_DQA@mail.gmail.com>
Message-ID: <CAHk-=wgo1HUhSj-kGO8u+iUCxp+QS+rNenbM8gywbF3pdQ_DQA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.7-rc8/final
To:     Dave Airlie <airlied@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 5:21 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Seems to have wound down nicely, a couple of i915 fixes, amdgpu fixes
> and minor ingenic fixes.

Dave, this doesn't even build. WTF?

In drivers/gpu/drm/i915/gt/selftest_lrc.c, there's a
engine_heartbeat_disable() function that takes two arguments, but the
new "live_timeslice_nopreempt()" gives it only one.

I'd blame a merge problem, since the failure is in new code, but the
problem exists in your top-of-tree, not just my merge.

In fact, it's not even your merge of the i915 tree that is the source
of the problem (although the fact that you clearly didn't _test_ the
end result most definitely is _part_ of the problem!).

Because the problem exists in the commit that introduced that thing:
commit 1f65efb624c4 ("drm/i915/gt: Prevent timeslicing into
unpreemptable requests").

It's garbage, and never compiled.

See here:

  git grep -1wh engine_heartbeat_disable 1f65efb62 \
        drivers/gpu/drm/i915/gt/selftest_lrc.c

and you'll see how the definition of that function looks like this:

  static void engine_heartbeat_disable(struct intel_engine_cs *engine,
                                       unsigned long *saved)

but then in the middle of that grep, you'll find

                engine_heartbeat_disable(engine);

WTF?

That commit seems to be a cherry-pick of another commit, and maybe it
worked in that other context (which I don't see), but it sure doesn't
work in the context it was then cherry-picked into.

So people took that thing, and it went through at least two different
people WHO NEVER EVEN BOTHERED TO TEST IF IT BUILDS!

Christ, people.

This is why I absolutely DO NOT WANT TO SEE random rebases or
cherry-picks and then sending the resulting untested crap on to me.

Because it's exactly that: untested crap.

It doesn't matter *how* well you have tested a commit in some original
context: the moment you rebase it (or cherry-pick it, which is just
another form of rebasing), it's a completely new commit in a
completely new environment, and all your old testing is null and void.

Guys, get your act together! I should not be getting these kinds of
shit pull requests days before a release!

And how the hell did this not get any build testing at any point
before asking me to pull?

                Linus
