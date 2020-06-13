Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D28C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3352074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="aY1yMWJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFMS7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMS7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 14:59:44 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F78C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 11:59:44 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id p70so11996339oic.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHp3qrFzAZu6HZVMid0W2pOjBshkDeU9xlOt9mdXqvM=;
        b=aY1yMWJGLq+1E5EPfg5IgveY8iWni0VF6IYCxb8Pq7Ae0t7lB+rXBf+7ULtQtP4NCZ
         d295eDXCZtkQt4/mqp7629t/rNbejzbpyd1pX3sZ4Y//NZXegDIMKVM90KqRHKvoRqou
         R0IDuGdLbmRRssyr6P48nOmv8dcfGg4wu+jU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHp3qrFzAZu6HZVMid0W2pOjBshkDeU9xlOt9mdXqvM=;
        b=ch7iNRDkYR7wHkCrKcELBXf2d0sd9Lha7xY4B386MUjj5zJswXYkTTl4YN/swYZVJQ
         qKfAosQUjlllI7eEb0hq4EHCI4pv9CKHrKlm5RqgMBUtvtCFT92Buh25grIkNSBQB33n
         JjEOEMCVqcRq4tYDLAaX/MvLJBAs/ARdW/yuSmJdyfNAh1PUOnY0zBRsxfKhmfh02qQ1
         4TqQfW+BTfs4Bs7RYaZJH0WkOFGRxS+VyLKwcHpsEgkillt8dyEi/pPHIIqJRZdS9/Ck
         dzaqq13G/82hgmKdZ3SrUmGRrgNQuttSFx3bf7hzssVBx0vGyzN1+WSvly/d7FXwEQfi
         RxZw==
X-Gm-Message-State: AOAM531l3KJh9XWLA/seVsT4Pa/BeAqvyRdItr443jK5MVTWnAs4tMKl
        pezO3yzVDmxPniTA53Qn5zFFYNqt86Z5nOPpABiZJQ==
X-Google-Smtp-Source: ABdhPJxW1Ao+Lml6R9nPfPrb5LhZGKtLV/2oS5LKGgWUez1wLRHj5HYvOFYls3itXLSvmX5SAqEvKvYhBj8lyGzxU1s=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr3435553oib.160.1592074783919;
 Sat, 13 Jun 2020 11:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
 <20200612132127.GA90012@google.com> <CANaguZDguzOCvNmO1u7CZQU2DSFW0+uPt7ZwL18w4bG=-_Xe3Q@mail.gmail.com>
 <20200613022530.GA110162@google.com>
In-Reply-To: <20200613022530.GA110162@google.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Sat, 13 Jun 2020 14:59:32 -0400
Message-ID: <CANaguZA2Ti1WfvZHO8NjuS==fzGXrni-qZw5OFZ-tmhcvXH+rA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] sched: migration changes for core scheduling
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:25 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Ok, so I take it that you will make it so in v6 then, unless of course
> someone else objects.
>
Yes, just wanted to hear from Aubrey, Tim and others as well to see
if we have not missed anything obvious. Will have this in v6 if
there are no objections.

Thanks for bringing this up!

~Vineeth
