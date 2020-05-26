Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C99C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54DC2065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590529642;
	bh=dcIHjHJWdwKnqbdVZczS9+zy7LYQtoAbGPXy80hcZ1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WQO/MPCNpHhBTFjRtEhR9gViYAbz/iLK8+m8wZRrcOAvees/lGXg4DchIsk2WA+sd
	 XBiH4Kes4ZPfH7ASGOK1p0K0DeEM52PA12m0CQLBXxCyl0MTdWplz6yLCZFmrj7ZVz
	 Fux22uVVYb8XtpvCWP327dpcjwOT3lpelz1nu9s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbgEZVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgEZVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:47:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:47:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q2so26392077ljm.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n63YcKhXogkg1d1eZRZGRx0yx0Ihs+RPPuD/yDkZeyw=;
        b=DLzP5VY2StTVDhhiR3QPdnOJA9EgOERtp0ASCK6J1xhQK0vXV7Su5JZYyGDTalP5oq
         L6x6Ww1jwzwjfaXLS/9diFskHmL3s2ztkgpvbNREk/veOUYEZJB7Mk9Rk9S8IuyFLzuz
         lx7ytuWPBXmofG0D0qqt6HHw9h0tliEl9a5gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n63YcKhXogkg1d1eZRZGRx0yx0Ihs+RPPuD/yDkZeyw=;
        b=ktEhf3DRtuiPPTZMULAqX1SFHDwN7xn8kETH/ZmhUeuXyIkIse9mQTRwu64iHsBCpy
         ZlRNX+ufwhctNDtqXHiT1DZ51AHgthfmWuso1VnTBLdCVnqiyLZil8/4KBQ6wOShB/oC
         rEOocXnth0ajTzDWJhnfCep0F5rlzczf+7wLdWhxb71dLXsYX5+spr5+0goxWzbI12th
         FNOVH8UinjkH9e7G4CJ9ILP2zShe+aLJSgM2yfx8YJeXNToiJMYVb8IrtSfuIFNd9hb0
         7HbJLsud2BVy0vC3QSqmYRaXAYfB1+5hnVHikuSlCzeioc0h5CJIKplTABPEtkuCQe8r
         BqCg==
X-Gm-Message-State: AOAM533FuJJ8DBR7qFMtF3DAcUcUD7LIZoBv606mkJ9DM8ua6PVGii+P
        es1jL/zPwXuMuCz3kVWKE47d/xL0nnc=
X-Google-Smtp-Source: ABdhPJxjItVrchHsJQHGOYAdLIby2qzKBORdeNMJl5n9gg3SFWj+WE05d5OFbXjh9YJcgRpbvf6zGg==
X-Received: by 2002:a2e:a48d:: with SMTP id h13mr1519097lji.120.1590529636628;
        Tue, 26 May 2020 14:47:16 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t15sm263025lfg.57.2020.05.26.14.47.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 14:47:15 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id c12so13223433lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:47:15 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr1459830lfn.142.1590529634933;
 Tue, 26 May 2020 14:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200513162732.977489-1-bigeasy@linutronix.de>
 <20200526194641.GF83516@mtj.thefacebook.com> <CAHk-=wjHgkama3SYOcYCYt_F-sxV8h4+kQ5aQSMgK7PtiQ=Nkw@mail.gmail.com>
In-Reply-To: <CAHk-=wjHgkama3SYOcYCYt_F-sxV8h4+kQ5aQSMgK7PtiQ=Nkw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 May 2020 14:46:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrG--AdCUBF9jR=zMm=cUn+6VaeOmmbbRFxx1YOx3RiA@mail.gmail.com>
Message-ID: <CAHk-=wgrG--AdCUBF9jR=zMm=cUn+6VaeOmmbbRFxx1YOx3RiA@mail.gmail.com>
Subject: Re: [PATCH 0/3] workqueue: Make the workqueue code PREEMPT_RT safe
To:     Tejun Heo <tj@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Almost all users of swait have historically been buggy and/or
> pointless.

Yeah, looking at this one, it really seems to fundamentally fall in
the "pointless" category.

So yeah - instead of extending swait with a new primitive that nobody
else wants than this pointless case, just don't use swait at all.

We have better models. We have "rcuwait", and we have
"wake_up_process()". Either of which is simpler and more efficient
than swait, and are actually useful. rcuwait isn't exactly widely
used, but it has very nice semantics for when that is what you want.
And wake_up_process() is both simple and straightforward, particularly
when you already have a spinlock for protecting whatever state it is
you're waking up on or waiting for.

                 Linus
