Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B16C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795B02067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OstnAz+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgGPFW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgGPFW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:22:58 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:22:58 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d4so4263797pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aw4OnsBnQ1ZIF1KX9lKuewx7m/jmsDZj2NNKkOvAmmo=;
        b=OstnAz+kmVxmVY/pV/REV0jbtqLRwPw8QmSZNb7DyqWS5efrtsTr5dXHD1jMz94Kzy
         7feHtFTcHS4mdfpN1EEfwwzm81QIHzCk/SE52lfYe5kLAoU/EM/Sx5LiupOUsvAeX31F
         fxhfzpYagDFZNVe767d03rY6Mk3BzieN8OOgtC1PrLymM0JXNh+VRjInChygocN2gUSO
         JJSZn6Fzz0Pl2jKhTiELdjXrnGtSMRYOL76tYeBa2zWuwvuSDfSoHoT9DC7NVDqqg1E0
         NQD4Z21GCwjV1GHJc7w76zxZBEVgGCa3+cMLSJpcaUPTwPQf3TmyHsO1bzk6zHPJN74Y
         ebxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aw4OnsBnQ1ZIF1KX9lKuewx7m/jmsDZj2NNKkOvAmmo=;
        b=OHTZoXLYo8Nl6bXs8VcVMnat1sqVOktsV0OezTHLBpnLFz1ld7F8Y1x098kMGQB2op
         fCnRmEkjgTmU90gwXQVURyIPesBO38fWeJ3oYBXKE0HWl4rc+Q7Y6EmB/id0A0Cc0gS+
         xcRrH9WNRZawwZ3KRQRWTsQF+2xaZC4bVc/KD/JUqHqtEZrfl5o5bbHBpuFh/XrvlBr7
         wZCHU8c6fc+M84IP59hTkfgDCEzvcKLmvTWHprVO0qfDnyadQOHFwEd0Xqxjx+zs94sh
         O8+t2jksZA4dKKRCntbNKrHqA2GTL5fgbYftKiiP3kvY++/UD87zhUfSItwIclE6pHhA
         zHRw==
X-Gm-Message-State: AOAM532dtYPLJv2pAlQ2g+Cp4/9lFy6i8oUNqvjLX9tPM7CKWhjfsQmm
        0l+U+tJngSEn0K0Fwme1mblqhA==
X-Google-Smtp-Source: ABdhPJxNS3pgzDl97JFTDGbzH4ABBUnQVIs7N/AYeuFcDWEnn+XYab5nOhXpMtE23d76Im8PSkpEig==
X-Received: by 2002:a63:84c3:: with SMTP id k186mr2705193pgd.394.1594876977998;
        Wed, 15 Jul 2020 22:22:57 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d18sm3584122pjz.11.2020.07.15.22.22.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:22:57 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:22:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        John Ogness <jogness@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] time/sched_clock: Use raw_read_seqcount_latch()
Message-ID: <20200716052259.GA4660@leoy-ThinkPad-X240s>
References: <20200715095220.GH10769@hirez.programming.kicks-ass.net>
 <20200715115901.515956-1-a.darwish@linutronix.de>
 <20200715152926.GA16686@leoy-ThinkPad-X240s>
 <20200715155850.GL10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715155850.GL10769@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ahemd,

On Wed, Jul 15, 2020 at 05:58:50PM +0200, Peter Zijlstra wrote:

[...]

> > > diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> > > index fa3f800d7d76..ea007928d681 100644
> > > --- a/kernel/time/sched_clock.c
> > > +++ b/kernel/time/sched_clock.c
> > > @@ -100,7 +100,7 @@ unsigned long long notrace sched_clock(void)
> > >  	struct clock_read_data *rd;
> > > 
> > >  	do {
> > > -		seq = raw_read_seqcount(&cd.seq);
> > > +		seq = raw_read_seqcount_latch(&cd.seq);
> > 
> > Understand this is doing the same thing with __ktime_get_fast_ns() and
> > I saw Peter acked to make change for this.
> > 
> > Just want to confirm, since this patch introduces conflict with the
> > patch set "arm64: perf: Proper cap_user_time* support" [1], I should
> > rebase the patch set on top of this patch, right?
> 
> Or rebase this patch on top of yours and include it, either way.

Have rebased this patch and included it in the patch set v3 for
"arm64: perf: Proper cap_user_time* support" [1].

Thanks!
Leo

[1] https://lore.kernel.org/linux-arm-kernel/20200716051130.4359-3-leo.yan@linaro.org/T/#u
