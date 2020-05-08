Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B6C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA479208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="avte0Gre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgEHNKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730448AbgEHNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32AC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:05:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j5so1771125wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mgb+elpG5rRocO3HltFPkQjaBpOGyLvzRk4WBy8PAxU=;
        b=avte0GreY98ChYX60EQHioHbWYFoHxkPBqNThycjj0bAXSB8OZZbe271eytzU9dx79
         C8FaQBxFUZ3GDTVvIT89VXFjpubyrMz3G19/1aOKdIXTn4vnb1ZfFmqw5fFPbuWq5W+7
         fcqkvekv1UgguYkRl/vJLoL7GHe8GeRdGahmEA1D5q7haPK3hPw/NTJTjop/8FgUb9Cu
         ZtUs2h0s5e6tX8bBwvwftZG29B6macEhAZBHu+SOo+SdXLM7r+Cf5OlIPqdOC42o/5EK
         r0nS1aOIpVSZdaGQKY9XMlRh19ORG1QdNiZPlngH8pXwdxZZtxNaGuyB1CbCDumVomaw
         UyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mgb+elpG5rRocO3HltFPkQjaBpOGyLvzRk4WBy8PAxU=;
        b=SjuJZiFkGBo5jI/K70QCVx5dn53cQkFBlS34Z+Pkr9UuZ5/76xbRCXPIpEl6bu2pYB
         LOhSkh+bYgC9iFt+nrgwmFXFVWIMKjLA288ozztc75zekuvD2FcHBkuoc8A0dLmUKHZL
         oWtfOl/SWQk7kQXIEcH4iQDOu2tZkNNQ4m/4uGLR2UzQeBdfq0FF5bSYQA5S7mH9nUZH
         nuQnUtborJ27HWPPeDK+OEoPQb5S5H4CqYU4Ow9qKGgm4YfgtCGKS+CXcbcAFDh4MCFc
         BcY+XP49uMRXjFHQuF8HS3q0I1eeKBaZ0p04bLTbaEG/7s8Emg67keHZeCEhRFJ49wDt
         v61g==
X-Gm-Message-State: AGi0PuZixTUuEfeL1h1YGl4VswKOZB72yVGvLvWwY/q7IjD7b0rQvhsx
        FxDKsg1bG3H90so54PUQtelRSg==
X-Google-Smtp-Source: APiQypLn2oiSKc2Okos29+vdEZOfH45zqdXlnILGJEI5IUubFXr251HgTQaCtZRYtPilMrWZhB6Vyw==
X-Received: by 2002:adf:d841:: with SMTP id k1mr2812214wrl.129.1588943111589;
        Fri, 08 May 2020 06:05:11 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 5sm11892425wmg.34.2020.05.08.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:05:10 -0700 (PDT)
Date:   Fri, 8 May 2020 14:05:07 +0100
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200508130507.GA10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508113141.GB5298@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 May 2020 at 13:31:41 (+0200), Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 12:16:12PM +0100, Quentin Perret wrote:
> > However, the point I tried to make here is orthogonal to that. As of
> > today using another governor than schedutil is fully supported upstream,
> > and in fact it isn't even enabled by default for most archs. If vendors
> > feel like using something else makes their product better, then I don't
> > see why I need to argue with them about that. And frankly I don't see
> > that support being removed from upstream any time soon.
> 
> Right, it'll take a while to get there. But that doesn't mean we
> shouldn't encourage schedutil usage wherever and whenever possible. That
> includes not making it easier to not use it.
> 
> In that respect making it modular goes against our ultimate goal (world
> domination, <mad giggles here>).

Right, I definitely understand the sentiment. OTOH, things like that
give vendors weapons against GKI ('you-force-us-to-build-in-things-we-dont't-want'
etc etc). That _is_ true to some extent, but it's important we make sure
to keep this to an absolute minimum, otherwise GKI just won't happen
(and I really think that'd be a shame, GKI _is_ a good thing for
upstream).

And sure, schedutil isn't that big, and we can make an exception. But
I'm sure you know what happens when you starting making exceptions ;)

So, all in all, I don't think the series actively makes schedutil worse
by adding out-of-line calls in the hot path or anything like that, and
having it as a module helps with GKI which I'm arguing is a good thing
in the grand scheme of things. That of course is only true if we can
agree on a reasonable set of exported symbols, so I'll give others some
time to complain and see if I can post a v2 addressing these issues!

Cheers,
Quentin
