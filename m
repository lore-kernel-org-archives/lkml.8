Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CDCC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D3220678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgDGHZw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:25:52 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60584 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgDGHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:25:52 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20823561-1500050 
        for multiple; Tue, 07 Apr 2020 08:24:27 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200407072047.GA18532@amd.ucw.cz>
References: <20200407072047.GA18532@amd.ucw.cz>
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, airlied@redhat.com,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.auld@intel.com, rodrigo.vivi@intel.com
Subject: Re: Linus, please revert 7dc8f11437: regression in 5.7-rc0, hangs while attempting to run X
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Message-ID: <158624426770.4794.6070200474948860768@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Tue, 07 Apr 2020 08:24:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (2020-04-07 08:20:47)
> 
> On Fri 2020-04-03 15:00:31, Pavel Machek wrote:
> > Hi!
> > 
> > 7dc8f1143778a35b190f9413f228b3cf28f67f8d
> > 
> >     drm/i915/gem: Drop relocation slowpath
> >     
> >     Since the relocations are no longer performed under a global
> >     struct_mutex, or any other lock, that is also held by pagefault handlers,
> >     we can relax and allow our fast path to take a fault. As we no longer
> >     need to abort the fast path for lock avoidance, we no longer need the
> >     slow path handling at all.
> > 
> > causes regression on thinkpad x220: instead of starting X, I'm looking
> > at blinking cursor.
> > 
> > Reverting the patch on too of 919dce24701f7b3 fixes things for me.
> 
> I have received no feedback from patch authors, and I believe we don't
> want to break boot in -rc1 on Intel hardware... so the commit should
> be simply reverted.

Beyond the fix already submitted?
-Chris
