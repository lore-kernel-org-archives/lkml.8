Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265A322D2C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596646722;
	bh=s4M9z0PpUaC78g2FBmcWjmoek0lH37PmXjd+aXtbWdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qamyQzfhjI3K8/R+p9ks1jmUHuBWUHsBLxhDyaplH58yq8CGOaX/GleI5l+p2MUW3
	 JNWnNh+LAidmSglpxvVNoSTUYsBX+ODBDR5O5+gbfcdlREhpKD0kDw4kcWdPYmCYVX
	 HxJNAm2MjgPzkJTAqStUplWVo36Qhqqq47q4HQsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgHEQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgHEQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:56:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B0CC061757
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 09:51:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so24970448ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKgJ87tlQurrZfrQYEXodAO8OzBfJ9TRYjwrwCi61/U=;
        b=Olb3V+ArUyt0OGqFt/v2uUo/5e1lC5R9fiJfpnbkZ/1hkrUJuQ9U+awiv/FWz0zxRU
         QLt5Xjiyk5jNC0IE5H2855C1ZLlcXbu4to/gW3c03vbsYmHn9d8pcxIdlUAc4Km2VHWa
         fGVwwxbiecbT2soul1jwPZgwNIkYwmYIK46Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKgJ87tlQurrZfrQYEXodAO8OzBfJ9TRYjwrwCi61/U=;
        b=Hm0gqXCwU7Bm/5bf9oRypEIyHv4zFQZ7q9a0+N6+yO5ObYCo8ul5p+ckFP+Zun5sDP
         EWouBmPA26RqTf/mbh2Z9yhwd5fNyv74UlmGKqJS9e81Pg02vjVr5TZ54BHUMIRs68RP
         xnhRSJqTK0cSrjjgAlSXa+RDLaczvuiY4GiNSN4GsiCozvR7N5HVCmnPFoOdht86A/jC
         G/avxPxsYzDDGYymcPmEHmi8hqsGfRdpqCXj2+HgR7zqWo6JmHOOYmAkaATA7PuGa9mD
         dvZs39i2BwYDnKNlO1To5vcano85/VJNpsTGZrLi5R8JK47w/j8x1orsdTZEfkyCfYAe
         3Kpg==
X-Gm-Message-State: AOAM533f7Ert+JWUIRw7nhm9KsPclpCjpoBYUaGfe3bKbQJbH6OVkpFH
        d0ibO/XrWfhdfBKJ87Cd7APPivdx+Zg=
X-Google-Smtp-Source: ABdhPJwsOrtBMuyTe74k32fC2wedbdBmYhztLBWFnc62gWVz3eFBjqZdNQ9ShugJI042w70RcqIdog==
X-Received: by 2002:a2e:b175:: with SMTP id a21mr1806724ljm.423.1596646289189;
        Wed, 05 Aug 2020 09:51:29 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m20sm1426285lfb.72.2020.08.05.09.51.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 09:51:27 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h19so48487952ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:51:27 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr1821083lji.314.1596646286874;
 Wed, 05 Aug 2020 09:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200804072435.385370289@linuxfoundation.org> <CA+G9fYs35Eiq1QFM0MOj6Y7gC=YKaiknCPgcJpJ5NMW4Y7qnYQ@mail.gmail.com>
 <20200804082130.GA1768075@kroah.com> <CAHk-=whJ=shbf-guMGZkGvxh9fVmbrvUuiWO48+PDFG7J9A9qw@mail.gmail.com>
 <c32ad2216ca3dd83d6d3d740512db9de@kernel.org> <20200805095439.GB1634853@kroah.com>
 <813c64c8dbe037b9d84763f56c4dbb7d@kernel.org>
In-Reply-To: <813c64c8dbe037b9d84763f56c4dbb7d@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 09:51:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUEonP7tyAfYv=dja4i3b1oBtHL=KY=j8x55x3AFoZZw@mail.gmail.com>
Message-ID: <CAHk-=wiUEonP7tyAfYv=dja4i3b1oBtHL=KY=j8x55x3AFoZZw@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/121] 5.7.13-rc2 review
To:     Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:20 AM Marc Zyngier <maz@kernel.org> wrote:
>
> I came up with yet another "quality" hack, which gets the job done,
> see below. It is obviously much simpler, but also terribly ugly.

This is effectively what the approach of commit c0842fbc1b18
("random32: move the pseudo-random 32-bit definitions to prandom.h")
was too. It has the prandom include in the middle of random.h - which
makes sense in the context of that patch (because it's where all the
prandom stuff used to live there), but the real secret is that as it
does that, it basically moves the percpu.h include down there too.

This mess has caused me to seriously look at making sparse generate a
"defined here, used here" list, and do a topo-sort on it all, and warn
about unused includes but also about stupidities like this.

But I won't have time to do that until after the merge window, and it
may turn out nastier than expected. But I did add all the include
chaining information to the sparse position logic recently in a fairly
easy to digest form, so my gut feel is that something that doesn't try
to actually optimize or solve the problem - just point out the obvious
errors - might be more reasonably doable than doing something that is
theoretically the RightThing(tm) to do.

IOW, a tool only to help find and figure these things out, rather than
a tool to do all the minimization for you automatically.

We'll see. No promises. And if somebody else beats me to it, I won't complain.

            Linus
