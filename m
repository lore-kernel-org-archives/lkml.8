Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1869BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD459207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="N0VSuyhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGPS1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGPS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:27:09 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DBEC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:27:09 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so5656612qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5rsi6VXTy6zEAJKBUYV2Ht/nE3vN2e2bAz64X8s/LgM=;
        b=N0VSuyhp4KQTnN8AKh+O9e5uvpEO8KgGXe9kUGSjBlmgee2680KWI2CeitG7HLqBMw
         nNu+6VOtJWE9aNlpCsdUhELJxfymlhmSZmrxu5u01EVEM5Wx+bviIzg3IkoaZqjgXFCr
         Cef/uVXHi57sj5UOMqc/HtL+7aOvzOBEVYYUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5rsi6VXTy6zEAJKBUYV2Ht/nE3vN2e2bAz64X8s/LgM=;
        b=L18bzUKsV7jBw0KDcJR3I4N32C842B/O7MR0aZXYK9u0VC2mo59fBIQmhMH3DTANDZ
         z/92B4mfWskKzN8usHa4xNtkkbk7u500SJy8i49c1FabhuEAXMrHpTvOQ2vHJ64gMUXl
         uE6lIAjgRWhN1HK3NRvAqYZlSzcSMP0kTPTBHY+YgKBw9nt6E91fvr97CFScnJsFKuVe
         Tt7WsjnmUko256TokJuFYORzijRT6+9r2Y2zj+Kf3/e7aTb0JR9Ap1fDqT9WX9Z+FyRq
         vGgZcNLCFmUZd0qR+bOa6o1TATx3U41arM0ffvbC52JiuA8bdpRCeqjHJaL8XUk7EeLW
         auJg==
X-Gm-Message-State: AOAM531aPoYhhPolWA88rQKb5rhip8ebpy+/hQuTJbDotwgAUWWXsej+
        lU29CLdA3UT85grIVP4lt3f1pw==
X-Google-Smtp-Source: ABdhPJydThqBZRNpBVcE0X40Iw1AJZzZSHKvZIOL34vgx/2SYb5HpN8Bni+vPzlsOg+LdEyuVRQwqg==
X-Received: by 2002:ac8:2928:: with SMTP id y37mr6667933qty.245.1594924028628;
        Thu, 16 Jul 2020 11:27:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b22sm7511470qka.43.2020.07.16.11.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 11:27:07 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:27:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200716182707.GA552227@google.com>
References: <20200715183537.4010-1-urezki@gmail.com>
 <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
 <CAEXW_YRoTvQfqqcM9fi+MkMxCPEaoJh4zHRM3qNYkv=-nAVuBQ@mail.gmail.com>
 <20200716091913.GA28595@pc636>
 <20200716133647.GA242690@google.com>
 <20200716143714.GA30965@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716143714.GA30965@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:37:14PM +0200, Uladzislau Rezki wrote:
> On Thu, Jul 16, 2020 at 09:36:47AM -0400, Joel Fernandes wrote:
> > On Thu, Jul 16, 2020 at 11:19:13AM +0200, Uladzislau Rezki wrote:
> > > On Wed, Jul 15, 2020 at 07:13:33PM -0400, Joel Fernandes wrote:
> > > > On Wed, Jul 15, 2020 at 2:56 PM Sebastian Andrzej Siewior
> > > > <bigeasy@linutronix.de> wrote:
> > > > >
> > > > > On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> > > > > > @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
> > > > > >                       if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > > > >                               return false;
> > > > > >
> > > > > > +                     preempt_disable();
> > > > > > +                     krc_this_cpu_unlock(*krcp, *flags);
> > > > >
> > > > > Now you enter memory allocator with disabled preemption. This isn't any
> > > > > better but we don't have a warning for this yet.
> > > > > What happened to the part where I asked for a spinlock_t?
> > > > 
> > > > Ulad,
> > > > Wouldn't the replacing of preempt_disable() with migrate_disable()
> > > > above resolve Sebastian's issue?
> > > >
> > > This for regular kernel only. That means that migrate_disable() is
> > > equal to preempt_disable(). So, no difference.
> > 
> > But this will force preempt_disable() context into the low-level page
> > allocator on -RT kernels which I believe is not what Sebastian wants. The
> > whole reason why the spinlock vs raw-spinlock ordering matters is, because on
> > RT, the spinlock is sleeping. So if you have:
> > 
> > raw_spin_lock(..);
> > spin_lock(..);   <-- can sleep on RT, so Sleep while atomic (SWA) violation.
> > 
> > That's the main reason you are dropping the lock before calling the
> > allocator.
> > 
> No. Please read the commit message of this patch. This is for regular kernel.

Wait, so what is the hesitation to put migrate_disable() here? It is even
further documentation (annotation) that the goal here is to stay on the same
CPU - as you indicated in later emails.

And the documentation aspect is also something Sebastian brought. A plain
preempt_disable() is frowned up if there are alternative API that document
the usage.

> You did a patch:
> 
> <snip>
>    if (IS_ENABLED(CONFIG_PREEMPT_RT))
>        return false;
> <snip>

I know, that's what we're discussing.

So again, why the hatred for migrate_disable() ? :)

thanks,

 - Joel

