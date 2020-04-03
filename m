Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE4C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4FA20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbgDCJQw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:16:52 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62410 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727774AbgDCJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:16:52 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20785495-1500050 
        for multiple; Fri, 03 Apr 2020 10:16:45 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200403091430.GA3845@duo.ucw.cz>
References: <20200402213253.GA2691@duo.ucw.cz> <20200402213506.GA2767@duo.ucw.cz> <20200403073720.GA23229@duo.ucw.cz> <20200403091430.GA3845@duo.ucw.cz>
Subject: Re: [Intel-gfx] 5.7-rc0: hangs while attempting to run X
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
To:     Pavel Machek <pavel@ucw.cz>, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        rodrigo.vivi@intel.com
Message-ID: <158590540341.5852.3933814252282882685@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Fri, 03 Apr 2020 10:16:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pavel Machek (2020-04-03 10:14:30)
> Hi!
> 
> > > > Hardware is thinkpad x220. I had this crash few days ago. And today I
> > > > have similar-looking one, with slightly newer kernel. (Will post
> > > > as a follow-up).
> > 
> > As part of quest for working system, I tried 5.7-rc0, based on
> > 
> > Merge: 50a5de895dbe b4d8ddf8356d
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed Apr 1 18:18:18 2020 -0700
> > 
> > It hangs in userspace, at a time when X should be starting, and I'm
> > looking at blinking cursor.
> > 
> > 5.6-rcs worked, I'll test 5.6-final.
> 
> 5.6-final works.
> 
> Hmm...
> 
> commit f365ab31efacb70bed1e821f7435626e0b2528a6
> Merge: 4646de87d325 59e7a8cc2dcf
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Apr 1 15:24:20 2020 -0700
> 
>     Merge tag 'drm-next-2020-04-01' of git://anongit.freedesktop.org/drm/drm
> 
> Let me test 4646de87d32526ee87b46c2e0130413367fb5362...that one works.
> 
> Ok, so obviously... I should
> test... f365ab31efacb70bed1e821f7435626e0b2528a6
> 
> Now, this is anti-social:
> 
> Busywait for request completion limit (ns)
> (DRM_I915_MAX_REQUEST_BUSYWAIT) [8000] (NEW)
> 
> How should I know what to answer here (or the others)
> 
> Interval between heartbeat pulses (ms) (DRM_I915_HEARTBEAT_INTERVAL) [2500] 2500
> Preempt timeout (ms, jiffy granularity) (DRM_I915_PREEMPT_TIMEOUT) [640] 640
> 
> I just took the defaults.. but... 

It is _deep_ under EXPERT.
-Chris
