Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BFA2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594411547;
	bh=MsrLkcAxZe0DiCjsGFWxSeRcSdyJLJSNunlCx/JC/xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=esb/OlHDfLIGHKRu4wNd4ZIVxZNybXzxWoRMzuiLWyPwvW4q8h7DINHL6576sz84S
	 onVoh9Xp8xnZfxfgAYDvfM6oS+7EZN0Gk9TZH5OsWthtwCpYJV1RET8oaj4Jh1eaGu
	 hk+8W1eXuLNHupf2xgTh7NlsjIVQZjBZNUrDvGt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgGJUFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJUFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:05:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72BC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:05:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r19so7772903ljn.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOjG8jOG5e2cka7UROrnmdRc1ZeKdWqp04+UTzezgXE=;
        b=WmpCdav5rACJPM1yVreaa5jhIE1Rj0RGr/bF1Qjr1pwf2439Iz5WoGFXdSi5O12Dr5
         IXWc1w8QTxV3dD+bOVtIv3lKjedZWexuqrhZTiipy7sQHNTW5whUuBZMflnCtZWXFq8v
         f4lJqs3GKRsPnpqvfmvNw1KFo/5w8EYLFRpdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOjG8jOG5e2cka7UROrnmdRc1ZeKdWqp04+UTzezgXE=;
        b=T4PBILgBZ54QB/FskolcX8EdwgI3b298jYAfv3A+bgh0NZsNtSARcvVBKVQE77bIkI
         2NjWSGqUy1Qu13ougaTD+T68ReEDsnQyDKv/4tUCbxLnDsNXRsyJGNm6hCvufL7+trUP
         vseXTO0HaYBx8MYJ4BGKuritgvcvwD9Whw66kPQ7beBpFBgNwAzleocLtygOOUFiPHmo
         tBzowUcyQe+lGYyqPrbIM97d6i6oUFW4C4lQ4Lai0W9hlGnhFr0N4t4H1mpfDPkazfjs
         OH+dwuMLeVIni+/k/YSpuZQgTC7BIFxhLDPZkcyxJeh3eEYDWgITHfIG6Icqpu7ZIHoS
         SUAw==
X-Gm-Message-State: AOAM530t3uKtxzTzHRAB/Q6V2ImviYwa37g+pwDFLDN04LGcEyJAswvI
        zvGCsexrzMs8hsZC2UDL8S/Zggdok/s=
X-Google-Smtp-Source: ABdhPJyyHM4ZfjNF6irBgwbwbObsblYapHHAAp2biTNlGp6+YIYpOS9d1aRR5+qXqhfHdH7ILbLUMQ==
X-Received: by 2002:a2e:880c:: with SMTP id x12mr42572642ljh.375.1594411544021;
        Fri, 10 Jul 2020 13:05:44 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id f4sm2515101lfh.38.2020.07.10.13.05.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 13:05:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id h22so7781978lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:05:43 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr40061229ljj.102.1594411542731;
 Fri, 10 Jul 2020 13:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com> <CA+G9fYudT63yZrkWG+mfKHTcn5mP+Ay6hraEQy3G_4jufztrrA@mail.gmail.com>
In-Reply-To: <CA+G9fYudT63yZrkWG+mfKHTcn5mP+Ay6hraEQy3G_4jufztrrA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 13:05:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPrCRZpXYKois-0t8MibxH9KVXn=+-O1YVvOA016fqhw@mail.gmail.com>
Message-ID: <CAHk-=whPrCRZpXYKois-0t8MibxH9KVXn=+-O1YVvOA016fqhw@mail.gmail.com>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:48 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> I have applied your patch and test started in a loop for a million times
> but the test ran for 35 times. Seems like the test got a timeout after 1 hour.

That just means that my test-case was wrong (in the sense that what it
was testing wasn't what was triggering things).

It might be wrong because I got the stack usage calculations wrong,
but it might be wrong simply because the bug you've triggered with LTP
needs something else to trigger.

> Re-running test with long timeouts 4 hours and will share findings.

That test was more intended to trigger the issue reliably, if it was
just a "stack is special, needs that exact 2MB aligned case to be
problematic".

So re-running my "t.c" the test for long times with that kernel patch
that removes the stack randomization isn't going to matter. Either it
triggers the case, or not.

I don't actually see any case where we play with vm_start the way we
used to (it was basically removed with commit 1be7107fbe18: "mm:
larger stack guard gap, between vmas"). So it was kind of a log shot
anyway.

              Linus
