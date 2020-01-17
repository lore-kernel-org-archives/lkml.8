Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5E3C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE66720728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="QhKrB7Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAQQAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:00:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33661 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgAQQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:00:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so22969841otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 08:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2mCzkaBoSjp4ax/u/7yJRNZf30sJQ+UFusTmbbH5+XU=;
        b=QhKrB7ZytQuqYL/a0rM2rb3we6OwlvtYtUsVc4gKVMHA8mcao04zGTQRpFdPFubZAF
         VPROzhxqo4/SZV7SL11q93SOlwjl4ixPjsNMvPGI721pply23sTI4PMTCSohnHaGwjS9
         MBYI02wpxrfRws3alh4rzo/zr9CuqQYHrHSJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2mCzkaBoSjp4ax/u/7yJRNZf30sJQ+UFusTmbbH5+XU=;
        b=BpanoB5Vyva9xIu2L4mmAGym+uN721CJn6KZb3+GY5Uy7e2ZSGdON3Q0viN4wZ/ACl
         Qkh4Q8HM/zjlqxUpivsQxU9K42tCZDxKe2gOUtH0V6fFKfKH1by02LUIcE0F3rhKvT/p
         NljTXTJsY65D/O614v7r5JPh1d3e13ExmgZsVhnkOyOMFjVqFygM27VLag0mwJMv06rp
         nTKIBYfhwuHyVqYudCskNmF+CE0UrFZH8wxVDZ9ATiZW8cOfEou+AZUqHo7oMFZnPyQR
         OeXaME0LOy9RHjk0auz7qEahmlc09GX+8AdjVhV1WSfEp9vvKvuDRbzhLWxV5Btf+Elc
         3LVg==
X-Gm-Message-State: APjAAAUVFnGkesuqPolXzTqhiK/fq8jePkr5xUVsixl9jMUo6SgrqDxl
        r+1GNK7FXxWkbIKJGy2PKfX/asHLzyeAWc0eRvLaMw==
X-Google-Smtp-Source: APXvYqz1JJS2wOXuy9w21zPYi1cJ9SQ3i83FRBkemV9RJ8cj7ooL+36hBOIFBeGU4DFI7syebPVuLJM8lw/4BV47j/M=
X-Received: by 2002:a05:6830:1f13:: with SMTP id u19mr6355704otg.237.1579276850423;
 Fri, 17 Jan 2020 08:00:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <8f9acfb3-28e0-8d3e-08e0-77f04410cf38@linux.intel.com> <1cc62dbe-348e-affa-8740-c162e1454510@linux.intel.com>
 <CAERHkrsaXAgE4MyE6ZehZ8cSq0bVrjc5uJnE9GwLCk4dp1hS9g@mail.gmail.com>
In-Reply-To: <CAERHkrsaXAgE4MyE6ZehZ8cSq0bVrjc5uJnE9GwLCk4dp1hS9g@mail.gmail.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 17 Jan 2020 11:00:39 -0500
Message-ID: <CANaguZB3_vYpYtymGNk9=SQCdL7nFPukGBAo2VcDuQDZip-cDw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Aubrey's attached patch should replace his previous patch
> > sched/fair: don't migrate task if cookie not match
> >
> > I've also added a fix below for Aubrey's patch
> > sched/fair: find cookie matched idlest CPU.
> >
> > Aubrey, can you merge this fix into that patch when you update
> > your patches?
>
> Thanks Tim, I'll include your fix when I update my patches.
>
We have included both these changes in our branch rebased to 5.4.y:
https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.4.y

This is our testing branch.

Many Thanks,
Vineeth
