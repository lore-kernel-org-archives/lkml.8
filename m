Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B93C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C43217A0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="OgzthXDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGNMT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNMT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:19:58 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6009C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:19:57 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a1so11384823edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Upvq0XTnNDqkoJtFc1NKNfRMzIAOX3/LGCieRj7keA0=;
        b=OgzthXDQQkSKENql4YztVr6tFQiY54k6p17Uy/5bcc7+0ujdY5rlF65bya2ugm/1k4
         hzNEqhYpj9g/Zq3XQF5qyl7U0HOvJ73Gh/4rNSG0PwfvemMNXstBpS9eNgrPPNU7UX77
         WhHatpJCe+PLBLssCm85nbfGfIxvpMVvj4FBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Upvq0XTnNDqkoJtFc1NKNfRMzIAOX3/LGCieRj7keA0=;
        b=i/M/MU45gAB8Q/Ooi5IVwLYaSx0Vhii9iHtgSsPdfJOBW2wZBMJFUV0kxfyrqFPbZr
         lUkbClZ23LEyubLIoucw6ywYyWVLKFCQB/gJeQa9KAOT/6o/TdNRGcQCcxjXeXaoXH7P
         5Lolj6jR24p+C1hkGI1IhLZ37ji9wzaxkdDNpPg6bWccaqA5pudGBiwnPgMf5MG7l4y+
         E6iQLt2FCRc4e1uQNAlwa9L4e/ubsqs4bk/KaLqK3+zja3Rl6YbmrUiLkiJDedVkN5ny
         AopsL9K2WYCfUs6F2515cu2t5jXN2l/CBtWoob/Gpk/T2tKPYdniW7xcuIlqKpB8qrYO
         Ad4w==
X-Gm-Message-State: AOAM5305BzCD4ZgY+/oghj/CXOyaGue3ap7etQu7OiZF6zFFWC5ggDF6
        iV9dl/0BXV/p/iI2X4RivkydHg==
X-Google-Smtp-Source: ABdhPJzKDJKgOVyW2LvwituaOpypnl46h37Y+mxK8+iWEJWcch9N/FMLfcDPk9lAh1tmX3XCw7wjtg==
X-Received: by 2002:a05:6402:b57:: with SMTP id bx23mr4056450edb.304.1594729196472;
        Tue, 14 Jul 2020 05:19:56 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6f85])
        by smtp.gmail.com with ESMTPSA id ai4sm11724577ejc.91.2020.07.14.05.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 05:19:56 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:19:55 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, x86@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714121955.GA2080@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200615063837.GA14668@zn.tnic>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

This is certainly a good idea, but I wonder whether we should be more pragmatic 
about the printk ratelimiting while we give userspace time to react and update 
their methodologies.

As one example, there is a common MSR hack which is verging on essential if 
you're doing thermally intensive work on some recent ThinkPads[0][1], and this 
drastically reduces the signal-to-noise ratio in kmsg (and this is only about 
five minutes after boot):

     % dmesg | wc -l
     2963
     % dmesg | grep -c 'unrecognized MSR'
     2411

That is, even with pr_err_ratelimited, we still end up logging on basically 
every single write, even though it's from the same TGID writing to the same 
MSRs, and end up becoming >80% of kmsg.

Of course, one can boot with `allow_writes=1` to avoid these messages at all, 
but that then has the downfall that one doesn't get _any_ notification at all 
about these problems in the first place, and so is much less likely to forget 
to fix it. One might rather it was less binary: it was still logged, just less 
often, so that application developers _do_ have the incentive to improve their 
current methods, without us having to push other useful stuff out of the kmsg 
buffer.

This one example isn't the point, of course: I'm sure there are plenty of other 
non-ideal-but-pragmatic cases where people are writing to MSRs from userspace 
right now, and it will take time for those people to find other solutions.

I completely agree with you that there should be a better solution for these 
cases, and that writing to MSRs from userspace is really not a good idea.  
However, going from zero to over 80% of dmesg in cases where these MSRs are 
repeatedly used seems too fast to me.

Have you considered perhaps making the ramping up of error logging more gradual 
by having this printk have its own, more conservative `struct ratelimit_state`, 
as we do in some other places with similar noise concerns? Then we could 
gradually make the warnings more aggressive as time goes on, up until the point 
where we make allow_writes=0 the default.

Thanks,

Chris

0: Lenovo is supposedly fixing this since last year, but no news yet.
1: https://github.com/erpalma/throttled
