Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFD6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EE12100A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgE2Nej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:34:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:59265 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgE2Neh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:34:37 -0400
IronPort-SDR: k3+lMqsNjrMOK7xGe87nXtVea2/fulQ0czJJNEgCaFrzaWMMzQ67GlePn2dbQyQRc2qhEejK/x
 DsYmbREfM5cg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 06:34:36 -0700
IronPort-SDR: tX3CfnNg48WxoJdOkXM+fYqy1MpVQrNOP0H7hntqGKQ1vly0LGowYZ79mz+5AG7gOQbt6g612A
 5l72LSds/vxA==
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="285533383"
Received: from rdvivi-losangeles.jf.intel.com (HELO intel.com) ([10.165.21.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 06:34:36 -0700
Date:   Fri, 29 May 2020 06:32:58 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [git pull] drm fixes for 5.7-rc8/final
Message-ID: <20200529133258.GA701871@intel.com>
References: <CAPM=9ty+Vyn8aSxNqWY+_KEnqj8nGZbp2PRJTvQLcV1iPhG7dA@mail.gmail.com>
 <CAHk-=wgo1HUhSj-kGO8u+iUCxp+QS+rNenbM8gywbF3pdQ_DQA@mail.gmail.com>
 <CAPM=9ty5ce2mm7Di6qvRKy2Jg2Tw-Cd8U6ypN=Abc2NCGmQWWQ@mail.gmail.com>
 <CAPM=9tza6oC3tBHaYq+nLGh0fwwZAKR3U-HVvn8jzN9myMz0dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tza6oC3tBHaYq+nLGh0fwwZAKR3U-HVvn8jzN9myMz0dA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:15:27PM +1000, Dave Airlie wrote:
> On Fri, 29 May 2020 at 12:02, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Fri, 29 May 2020 at 11:49, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, May 28, 2020 at 5:21 PM Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > Seems to have wound down nicely, a couple of i915 fixes, amdgpu fixes
> > > > and minor ingenic fixes.
> > >
> > > Dave, this doesn't even build. WTF?
> > >
> > > In drivers/gpu/drm/i915/gt/selftest_lrc.c, there's a
> > > engine_heartbeat_disable() function that takes two arguments, but the
> > > new "live_timeslice_nopreempt()" gives it only one.
> > >
> > > I'd blame a merge problem, since the failure is in new code, but the
> > > problem exists in your top-of-tree, not just my merge.
> > >
> > > In fact, it's not even your merge of the i915 tree that is the source
> > > of the problem (although the fact that you clearly didn't _test_ the
> > > end result most definitely is _part_ of the problem!).
> > >
> > > Because the problem exists in the commit that introduced that thing:
> > > commit 1f65efb624c4 ("drm/i915/gt: Prevent timeslicing into
> > > unpreemptable requests").
> > >
> > > It's garbage, and never compiled.
> >
> > I thought I'd dropped the ball completely. but I see it's a selftest
> > failure, I must not have selftests built in my config here, I don't do
> > exhaustive builds randconfig
> >
> > This has also been built by Intel, but I'm assuming they missed their
> > selftest bits as well.
> >
> > I'll revert that and resend.
> 
> I did drop the ball in one way, I see sfr reported it broken this morning
> 
> I normally expect stuff coming from Intel has been through their CI,
> even their fixes tree generally gets pushed through that system before
> I get it, and it usually catches these things.
> 
> I might have to push back on intel fixes this late in the day, as
> maybe the land on next and cherry-pick to fixes model has made them a
> bit lax on how much stuff goes through CI.
> 
> I've just drop the whole i915 fixes from the tree and will resend with
> it removed.

Yes, that was my fault. I also didn't have the selftest on my drm-intel-fixes
build and I confused the build run numbers when checking the
https://intel-gfx-ci.01.org/tree/drm-intel-fixes/index.html?
before sending...

If we have another round next week I will make sure CI runs well before
sending another pull request.

Sorry,
Rodrigo.


> 
> Dave.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
