Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4499C433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840B12065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yVzHSrOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGOXNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgGOXNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:13:46 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F00C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:13:46 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f23so4066886iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpM7iZGjlHMT36GUoTRhbvrdRBioSuqO7w4vuhft5qY=;
        b=yVzHSrOXwoYgeWhWxTJWWSAM1r1CTdo/IEZQTDxqvoFKTUNQFQHmLzHLCYc2Q6KUOI
         byy5V8OB336uMVpKdUMP7I9fUIzytEdw0j4rFnHZRboSYyYQYkjLbVe6KnJ82yY+ZMjy
         jV7P434+rCPUM2CqswmTxPMyOhyp/sYEHI+rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpM7iZGjlHMT36GUoTRhbvrdRBioSuqO7w4vuhft5qY=;
        b=HAJbCcp3RmzOsSQmzpZyfWVRJhyhFlYkr/AP8msjs243HsZU10HYaqlrp2L80+EjI1
         DmCoZkxrxBuHB9FgwbbM46Z/reWx9XNj5g/zo0BW/CZ2aYekXDYPCF7P+OKlnrqxXGp2
         xyR15eCOqxotghavbmYKS+dpbwmLTrlic9Qjt31FCBVxrhKAycnveMEha8Lgmf3CxmVl
         4T4fMt13VZkBUQDelBoYWSnfNpT5bvGXhtIqoteWr1F+EXI0yPZRfzc+odljY2H7YxmD
         7kHytbmN9mfVH1TeLk/3X5Lo/4DqzC9AQ5YZvgcHgeD6yVQD9AwdGZfYTBAV5d9iZvEy
         rK8w==
X-Gm-Message-State: AOAM533UHMQE2eGLyfTvRUFztztMJBZBywQoIyEi4CKnxoTcSPsKkEAs
        farpXfaqfTvIeC+esNppah83ZSNjQwj/FuayAPzrbQ==
X-Google-Smtp-Source: ABdhPJxjnwT+l42GfizHvUFFUJxyOdqilKyMo+sfvYz7uyJ/YcLLxfI/iaNVKjhp/otcw60dhs1w4MksE+Vo+gi+BNw=
X-Received: by 2002:a6b:c410:: with SMTP id y16mr1659605ioa.75.1594854824360;
 Wed, 15 Jul 2020 16:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200715183537.4010-1-urezki@gmail.com> <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
In-Reply-To: <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 15 Jul 2020 19:13:33 -0400
Message-ID: <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page allocator
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:56 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> >                       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                               return false;
> >
> > +                     preempt_disable();
> > +                     krc_this_cpu_unlock(*krcp, *flags);
>
> Now you enter memory allocator with disabled preemption. This isn't any
> better but we don't have a warning for this yet.
> What happened to the part where I asked for a spinlock_t?

Ulad,
Wouldn't the replacing of preempt_disable() with migrate_disable()
above resolve Sebastian's issue?

Or which scenario breaks?

thanks,

 - Joel


>
> > +
> >                       /*
> >                        * NOTE: For one argument of kvfree_rcu() we can
> >                        * drop the lock and get the page in sleepable
>
> Sebastian
