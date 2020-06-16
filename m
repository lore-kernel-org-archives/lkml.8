Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E3120707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 09:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPEIR5HB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgFPJ2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 05:28:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88914C05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:28:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so8119934plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdcE3h12ioGr+7hsW5IVLEYOXezdbxNAFqbfrmJLRSE=;
        b=wPEIR5HB/ax8TnnqwOu3J6pC5s+9o0t3fzwRMbe0RIKWhsaPFHD1lqrV2tFTrsClYy
         fXJkkXXdUZRoLueisJyweahorxY75fMc3H0ThyA1LxjDI73N17olVG41cQQCKCdd0O+h
         r7CUz9eI4ZVzMpTIFpSxI0mIPvhl8qO85r/XMjg22vS3Ov3d8uAg7JEEGXGLqFjbB4jM
         +jLlfrPxEuG6Ujf7eDhe/obXkCYuFKN6vvjJFb7tzS1cRU7lDb/sEr2/4Fm9k7wR0Jez
         0SBvCXqtCJGTsyc0ZpZhkEPxr1q62rjUaEbuxcB+tb+lozLn/3eymIlUzcXcG3n+Gnye
         0aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdcE3h12ioGr+7hsW5IVLEYOXezdbxNAFqbfrmJLRSE=;
        b=LDJ1wS3F+SeNSDSVwiA6ZBnlPwtpYg68/LQKDgVVvBx9e0p+tVnPZwhPQekAAxN7jC
         8bjNI/uVvwoE1T3RQ74d+q0UjgOFCGcXHiO/nJUwpTJHxjn2yIoSLXEgzfqXRjv7cjDc
         +dTanKbXVzUQ+5rQl6Q5wnMkGF3bqBNRifycYMKjFXinsHT365nw14pVWwbsNxozwv92
         hphzjgCXiZY5Hk46zeElml9/DiO6cR8W2GIpYFSrxBXoLsyEp6xuhrEp+PJKIyXHS8Hr
         ixiwDq9/mMC09IG3vKJly/gs0w/Atmx27gTBfCvqNOH8Y2GYEeciKde8m+u5GTuiEuXf
         ONsQ==
X-Gm-Message-State: AOAM5315AwfLJfQ+kUhj8q5lsmqG8l1GFqmykaziwsFVtFkxdfTsybdG
        JcX8Ke1QxjbdMoOrlk1kjze66w==
X-Google-Smtp-Source: ABdhPJwsq5ESQOf7eSEAjznxqn8WuPCsn7fjszcUwCqSP6x8q4k9NAQZ5Lzj/jzTj5RJh+yG7ZljTA==
X-Received: by 2002:a17:90a:39ce:: with SMTP id k14mr1903225pjf.39.1592299681986;
        Tue, 16 Jun 2020 02:28:01 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id n4sm17088638pfq.9.2020.06.16.02.28.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 02:28:01 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:57:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616092759.rjnk3lef4tedfust@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
 <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
 <20200616083107.GA122049@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616083107.GA122049@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-20, 09:31, Quentin Perret wrote:
> Right, so the reason I avoided cpufreq_core_init() was because it is
> called at core_initcall() time, which means I can't really assume the
> governors have been loaded by that time. By waiting for the driver to
> probe before detecting the default gov, we get that nice ordering. But
> yes, it feels odd to have it here :/
> 
> Thinking about it more, the natural fit for this would rather be the
> register/unregister path for governors directly. If that sounds good to
> you (?) I'll try to move it there in v2.

There is another problem here which we need to look at. Any governor
which is built as a module and isn't currently used, should be allowed
to unload. And this needs to be tested by you as well, should be easy
enough.

With the current implementation, you take a reference to the default
governor when the driver is registered and drop it only when the
driver goes away. Which means we won't be able to unload the module of
the governor even if it isn't used. Which is wrong. The solution I
proposed had the same issue as well.

You need to figure out a way where we don't need to keep holding the
module hostage even when it isn't used. I see two ways at least for
the same:

- Do that from the existing place: cpufreq_init_policy().

- And I think this can be done from governor-register/unregister as
  well.

Second one sounds good, if it is feasible to do that.

-- 
viresh
