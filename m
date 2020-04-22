Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A668DC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738B52074B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZ1a57gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgDVUQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDVUQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:16:41 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C283C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:16:40 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o139so1861792ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TlcY5+nXMt8aoLuh7/RkKsSkigBuT/6fNXDLCdCTOHc=;
        b=ZZ1a57gbsqBqYWco0IbtiGutsaHjGixI76yAo9JHMAuTSEeQaT7HKLSR+J07igl/xA
         gdV8Kcy05z0nSgP4x7iYteZ1swq6sILkusEcC2DeAHkjjPS3iQvyGjDJ5Wl18jgmNhXe
         3rQX3JZdqwYPJIp1I6OJmFGLew33YzpmSO7X14g0tDf8ZvDrv88YSqUpNg5EfM4+H19L
         2Dp5F/mwVl/TkUidph9MLC+OzRHNSuB6hrmLMQ/W8vKAM321vbS3wt7oGoYWQdhTlqBz
         dA/5exaFJUDfxitBwUmkNI7VPp9S8uCHyC40WpBqooKuq0Uehyc7bjH+ILF64BkWe7c5
         sWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TlcY5+nXMt8aoLuh7/RkKsSkigBuT/6fNXDLCdCTOHc=;
        b=cEoYGIhsY86EeycqySFhNVLJoaHUuv1a58XL+uAukP7CxREpEtqvpKpTYNW+9CEwmS
         DadNTKbIJQJSvXYq8Wg3pY7lIWUZWpWyz/Hl9IYYQJF9WWJr31CBYWi+XCqsjnY4uUe1
         zrSxPgXBVmGl45iZkUE5KFPIT9HRcg+xZEcx0pcnYhl2Eqxfx0/OQGuurwuIbPF05UxU
         fUJO8iYNh/OqNUMb+CKGSz7Gs2NsPhhfl2XY3t7f4o/eZJmuxBGKEaHmiZQ1VQU7pcKU
         UKOhI2TnHjsXO00zyZm8XgRS6mAbnV9i/mHGjtOG0owz5aDEWERlOgg2lQ/olrlUgRkL
         kwZw==
X-Gm-Message-State: AGi0PuaV5WB1qK/tYapVCyDZtVWonLZo79tDj1O0bnIa/GiVB2w68owh
        /SrG6ypJWvb6xmaPevwGSO/Sm+x1CZYlJp/Er62qtbj0aKnJ8A==
X-Google-Smtp-Source: APiQypKyQPOhoB/txafDuzZiv5qBVRYkGvJLjHs/nenlvAkHv1xGZAtMrhXoqCRTC3z43lLGYLQtK57i6tvl0N2EKQk=
X-Received: by 2002:a5b:38f:: with SMTP id k15mr1050130ybp.45.1587586599351;
 Wed, 22 Apr 2020 13:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.870192415@infradead.org>
 <20200422135628.GH4898@sirena.org.uk> <CAD=FV=VcbXoxtzyvLsFZuCDXJwCv8Y3pUdYBKMUmJaNcueBrqQ@mail.gmail.com>
 <CABXOdTd-ze8=s8nXNvPSjBBQKX9N3e4v3xQfs_mbJfKaUrvZ0g@mail.gmail.com> <CAD=FV=XWVk4UQPozEX1D6wKVXAd=JpGgvB74mcR=j+av+Qyv6w@mail.gmail.com>
In-Reply-To: <CAD=FV=XWVk4UQPozEX1D6wKVXAd=JpGgvB74mcR=j+av+Qyv6w@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 22 Apr 2020 13:16:28 -0700
Message-ID: <CABXOdTcErkfG4iFZ0t28YK5fuqLfaqR0gDf=umhounJYrKx_LA@mail.gmail.com>
Subject: Re: [PATCH 11/23] sched,spi: Convert to sched_set_fifo*()
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, qais.yousef@arm.com,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 9:41 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Apr 22, 2020 at 8:48 AM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Wed, Apr 22, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Apr 22, 2020 at 6:56 AM Mark Brown <broonie@kernel.org> wrote:
> > > >
> > > > On Wed, Apr 22, 2020 at 01:27:30PM +0200, Peter Zijlstra wrote:
> > > > > Because SCHED_FIFO is a broken scheduler model (see previous patches)
> > > > > take away the priority field, the kernel can't possibly make an
> > > > > informed decision.
> > > > >
> > > > > No effective change.
> > > >
> > > > Copying Doug who did this change and Guenter who reviewed it.  This
> > > > looks fine to me but I've no particular involvement with the code or
> > > > platforms that are affected here.
> > >
> > > Thanks!  Probably the maintainers of cros_ec_spi.c (Benson and Enric)
> > > should be aware of it, too.  CCing them.
> > >
> > > From my point of view, my response is pretty much identical to the one
> > > I wrote when the priority was reduced from "MAX_RT_PRIO - 1" to
> > > "MAX_RT_PRIO / 2" [1].  Basically, any priority that keeps us from
> > > being preempted by tasks that are only high priority for performance
> > > reasons (like dm crypt and loopback did when I last analyzed) is fine.
> > > Our priority needs to be high not for performance reasons but for
> > > correctness reasons (the other side will drop our data if we don't
> > > respond in time).
> > >
> > The crypto engine ends up running at the same priority level, so I am
> > a bit concerned that this patch series will re-introduce the problem
> > that Doug's initial patch tried to solve.
>
> Do you have a pointer to the code you're looking at?  Digging through

I was looking at crypto/crypto_engine.c:crypto_engine_alloc_init().
Maybe that is different code and I misunderstand its use, though.

Guenter

> my old investigation for dm-crypt showed the problem to be the code
> touched by commit a1b89132dc4f ("dm crypt: use
> WQ_HIGHPRI for the IO and crypt workqueues").  Interestingly enough,
> that's been reverted in commit f612b2132db5 ("Revert "dm crypt: use
> WQ_HIGHPRI for the IO and crypt workqueues"").
>
> Even if something is using WQ_HIGHPRI, last I checked WQ_HIGHPRI was
> the highest non-relatime priority.  Looking quickly I see
> "HIGHPRI_NICE_LEVEL" which is MIN_NICE.  I don't think that implies
> realtime, but I assume sched_fifo() still does.
>
> -Doug
