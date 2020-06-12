Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC32BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999CA207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yf/VXXjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFLQcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLQcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:32:53 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD684C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:32:51 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id y13so5177363ybj.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zabfBP1pg2tNim+1vjkeMscLKnVu7/KPrta1MhgcgyQ=;
        b=Yf/VXXjj3fSOZHK6EIDIz/1TXQFuDjGymK4LlVlHSjbdDApthlI7vKqb0ID/lGnDiO
         Wvx+5O0CDvc6ZesKfGw9SJ6Uk0pmvm86j6UGSlDJxxWQn1UuBnnuR2tm2JiCGfYW1gms
         UlfaRap7fmeWj+soLcwj3C9g+Gskcx8Xx1wtp9UPI+6oSR7VMBwAZRsxrYuTsLAFEZul
         q/gkdEk+3/Sv1E2MRuMHCXGUY8EkKEw5awbPafNBSw6we5MDGNgUIB49YZAxI38uJ2/o
         /jdIh9FUU0c2DfCtd5yTvGnpAhw8vZ9CXKqZ8xuBUTdLBA3GDj4Xs6/eFq+O0HH32Vt0
         JC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zabfBP1pg2tNim+1vjkeMscLKnVu7/KPrta1MhgcgyQ=;
        b=rgm5qwbAJQvJ+ouXdA/AQ+x3BSGJbj5jxOCkWnZJrQYqRokAqWoLRFPVUDT4fyVJhB
         9LaZIrbeB0IP4/q0s6PPkJga2kO3YVTGbbSKzxaCKz/Zmbp9fSdjeeJzHjtRSPa7c59R
         gb6UAjliNo37ywB4aD4bZ80T4EH7MMFCgUFRTRKnl0Q31qu58VA4IqSMkuS33TND4/1Z
         PVd6E/bpGCNqbKovY7Xr6JXyAY7gbJ060bTwngwedoZDCLTy/+n8bGM5GF18XV61mmIU
         wx5A+gMzTNrMVMTu8CXcpkthIuDFNyKY1+yBdv6LYgggyCZhCQZuvTcbp2DEcO8DZ/Cv
         5bOw==
X-Gm-Message-State: AOAM530oApixskq0/CbA36ZNS9IajM+UOan3SYwdNHQ4yK4ALLEfFfDv
        09S6MGIVfHWWIOMB3Mki+Rsobsi4PG+kTxLKBfL9Yw==
X-Google-Smtp-Source: ABdhPJwdWPcakynTnJkIkhy1EzVJhtDxAQ1B9FhX7PjYPkSX+AmmM7nesJcaHXe9xIgC63UvqcKijweyBpkC5rRlreU=
X-Received: by 2002:a25:9bc6:: with SMTP id w6mr23911166ybo.408.1591979570381;
 Fri, 12 Jun 2020 09:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
In-Reply-To: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 12 Jun 2020 09:32:39 -0700
Message-ID: <CANn89i+yWQ_rO29NDuXZ7XWho_gTShUpujUN+jZop46W7e2qyw@mail.gmail.com>
Subject: Re: [PATCH RFC] cred: Add WARN to detect wrong use of get/put_cred
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Shakeel Butt <shakeelb@google.com>,
        jamorris@linux.microsoft.com, alex.huangjianhui@huawei.com,
        dylix.dailei@huawei.com, chenzefeng2@huawei.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 3:28 AM Xiaoming Ni <nixiaoming@huawei.com> wrote:
>
> Cred release and usage check code flow:
>         1. put_cred()
>                 if (atomic_dec_and_test(&(cred)->usage))
>                         __put_cred(cred);
>
>         2. __put_cred()
>                 BUG_ON(atomic_read(&cred->usage) != 0);
>                 call_rcu(&cred->rcu, put_cred_rcu);
>
>         3. put_cred_rcu()
>                 if (atomic_read(&cred->usage) != 0)
>                         panic("CRED: put_cred_rcu() sees %p with usage %d\n",
>                                cred, atomic_read(&cred->usage));
>                 kmem_cache_free(cred_jar, cred);
>
> If panic is triggered on put_cred_rcu(), there are two possibilities
>         1. Call get_cred() after __put_cred(), usage > 0
>         2. Call put_cred() after __put_cred(), usage < 0
> Since put_cred_rcu is an asynchronous behavior, it is no longer the first
> scene when panic, there is no information about the murderer in the panic
> call stack...
>
> So, add WARN() in get_cred()/put_cred(), and pray to catch the murderer
> at the first scene.
>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---


It seems you reinvented refcount_t ?
