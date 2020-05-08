Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A6C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B7721BE5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZx6F7Nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEHLQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgEHLQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:16:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855FC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 04:16:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so10206046wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+BWCInZJLlllgFf3o0Oo5p9zpHQZFgi8cpAFwwwQwMA=;
        b=qZx6F7Nx/tsYOJU0sb03gOTUbYXs9dDBP+FWpqmm5rm2OQy0oq+SvMBNFBYMwKMn52
         dbHnWELqeDhiKuIXO1UAszXykcqvqTUgOC5cOwQSgI6vgG0JA55A9drnRzn1TatjXrHj
         G+LUjikpAFwNXvHldzj2Pd99D/YGz9poh6tFO9WqULqR1VVhOTmhH2fW7GvqTvg9ZkYW
         /ykruFEZPucnnNWjzJktmJeXMj0S/9nB9wlSDXNRAPGnx4gYbBFturGockBaQLl6SeOh
         73JhEfKd5DxwrmKr+H7Wh+jtuRpb/XuZ7rWR8umXxbO0A87HCjduiUxn6ElNDHqKqDGq
         VQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BWCInZJLlllgFf3o0Oo5p9zpHQZFgi8cpAFwwwQwMA=;
        b=Lg9iBOgnydbeI/k7oH4WW35oeR7TkKwOZMuNQXR3AOG75rBw0lkVrIoXeluMXH+G8J
         gNp7rBFFcTzwfT97furq9FHcrqT20rv/ug0tqoWWSDOgs1GnHTXqsFBw/SCffGnQmjYU
         ZZYViVVhbdbCysQQ+7eYilfvDLrH94WkVc2s0+f41XyK+Z4a64lhB5FuoalniBEBh7vf
         0ZQFQhzsK2k2gL+56g8997uDV6PnkqKrG1xXTncVT0q3k2Lyg6fAUwqFi/NwdjIfCiw3
         rekLpwXDrCqTFvFE5afrIxaouO5EEuQKIwkxbmfM4ICuyqupS2850HVA15MGYSeGKLMW
         1NGA==
X-Gm-Message-State: AGi0PuYvVIPEFOoFu3f8PhYNL3p15vefNqYVpDovFlew5TtFR/RgWZsT
        Dk197+vn3T8lAvCYVTrEw6Iotw==
X-Google-Smtp-Source: APiQypL1Pa78pYlMIeecwXvbTPnO/ssMpR8vbcWKKxe6HHHvtKDEgIQ+0s+Hl+98kf7U1uhYEWBYVA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr15192211wmh.120.1588936576745;
        Fri, 08 May 2020 04:16:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id p190sm12522646wmp.38.2020.05.08.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:16:16 -0700 (PDT)
Date:   Fri, 8 May 2020 12:16:12 +0100
From:   Quentin Perret <qperret@google.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508111612.GA252673@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508103721.GA3860390@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 May 2020 at 12:37:21 (+0200), Greg KH wrote:
> On Fri, May 08, 2020 at 10:11:28AM +0200, Peter Zijlstra wrote:
> > On Thu, May 07, 2020 at 07:09:58PM +0100, Quentin Perret wrote:
> > > One challenge to implement GKI is to avoid bloating the kernel by
> > > compiling too many things in, especially given that different devices
> > > need different things. As such, anything that can be turned into a
> > > module helps GKI, by offering an alternative to having that component
> > > built-in. This is true for pretty much anything that can be made
> > > modular, including drivers as well as other kernel components, such as
> > > CPUFreq governors.
> > 
> > The idea is to move to 1 governor, schedutil. Also, I abhor all the
> > exports this thing does. Modules have no business touching most of that.
> > 
> > Look at every EXPORT you do and wonder ask yourself how you can abuse
> > it. Modules are not a good thing, they're horrible pieces of crap.
> 
> Quentin, what is missing from schedutil that warrants the need for a
> totally different governor?  Is there specific problems with the
> existing ones or is this just an instance of "we wrote our own a long
> time ago and never pushed it upstream" from various SoC companies?

In all honesty, this is probably a mix. Some vendors definitely have
their out of tree crap that they'll load anyways, and some others use
other mainline governors for semi-reasonable reasons (e.g, for lower
tier devices, they often don't want to go though the costly and tedious
process of tuning uclamp, so they'll go for a more 'aggressive' governor
like ondemand). Note that this is the minority, though. The majority in
Android use schedutil, and I'm quite happy with that.

However, the point I tried to make here is orthogonal to that. As of
today using another governor than schedutil is fully supported upstream,
and in fact it isn't even enabled by default for most archs. If vendors
feel like using something else makes their product better, then I don't
see why I need to argue with them about that. And frankly I don't see
that support being removed from upstream any time soon.

Don't get me wrong, I do think schedutil is the way to go. And we do
recommend it in Android. I'm simply saying that /mandating/ it in GKI
would only add more friction than really necessary. Making it modular,
OTOH, might ease things a bit.

I guess it all boils down to the code. If modularizing schedutil really
is too ugly, then I'll drop the series and we'll just build it in and
waste memory on devices that don't use it. It's not the end of the
world, but it's a shame if we don't have strong technical reasons to do
that -- all other governors _are_ modular.

IMO the changes in this series aren't *too* bad -- moving
schedutil_cpu_util to fair.c is probably a sensible change in its own
right for instance. The biggest 'issue' is probably the exports, but
these will need discussions on a case by case basis. And I'm happy to
try and rework the code to work around when possible (as is the case for
runqueues for instance).

I hope that helps!

Thanks,
Quentin
