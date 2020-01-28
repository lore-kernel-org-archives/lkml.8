Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D80C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqhrNAkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgA1REe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:04:34 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40024 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgA1REd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:04:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so1306937pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hrpqq0qmt055ivxYOcya64V22z0guJQnRikudWo5V1o=;
        b=iqhrNAkJpBFY77ZafhxIj7/QWP5/5H0XpYl+CIOJr/+f2wTff1CP8cck3B8bty4sn7
         sG+/tQWqexrTeQz7O4GW9hOAcXhKLvR1IHuiCOTlRV0DFn2VF6SHbaGjIV6utMs6iFuM
         oEr9RL7i8cidbU2te1StqRlY/EJOwtGpLvvueWiYpQCn2cA3L3nAx7S1t8HvxNsRWL/q
         bjX7ex8PEBlJg7GYQgzO+zbHQJXNeVWTuBEL/gNPpjIcEraxBumR+5wExUIYRdM2erw/
         TuKcE7LqDH8zojXUKiuM1YNcXOFxNE4oRaT+RQkxO3mCNirPJgELGXjfbb2ZWdgKy6Hi
         u3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hrpqq0qmt055ivxYOcya64V22z0guJQnRikudWo5V1o=;
        b=mLSy9bmExHZmlyOGM4mRYFY2lXx6afo6oFblZy0SqgVQx7qoZ0u/8mxfI132chUDpi
         fhd0zrSAktC0R37g/IjmdLIw7EhWdZp3f2MzhWqJZRi2ieo4hUaVEIVIF3g6frMPBBPk
         h/IVuICtq8HygBa2hY4gl17Zqgq11kgYRR7xunDb3V+iYg5LYibqvBaKsNbAGFPhCw5x
         EcoF9v4lm0z4EtaixDiFxg17jUiB3Xk88BxnRslyFEOU+Z8ehvewdnIObktzRJQ9AYdj
         8sT74tAV66F92mUyMWJ5O5G2EC6ch/IdItBW4XDNS2Rnfa5e/pl8koqh0lteuXpYXc7s
         mnqA==
X-Gm-Message-State: APjAAAVfsyYeMrimvkz72woslVQT7ozX7eGKV/YTvoxOrbThfztb5Bis
        O9c4YPE/pPKi7fEEkQ3fZDM=
X-Google-Smtp-Source: APXvYqwpWnWtmFhyZIcUf/4vhrtU1X6d2/NVeAtGcn6K7tfLSxaEpAwaH5kohS15m/ziPT5y5v6L6Q==
X-Received: by 2002:a17:902:e789:: with SMTP id cp9mr23713546plb.85.1580231073104;
        Tue, 28 Jan 2020 09:04:33 -0800 (PST)
Received: from workstation-portable ([103.211.17.252])
        by smtp.gmail.com with ESMTPSA id a195sm20701932pfa.120.2020.01.28.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:04:32 -0800 (PST)
Date:   Tue, 28 Jan 2020 22:34:26 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
Message-ID: <20200128170426.GA10277@workstation-portable>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:30:19AM +0100, Jann Horn wrote:
> On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> 
> task_struct.cred doesn't actually have RCU semantics though, see
> commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> it would probably be more correct to remove the __rcu annotation?
> 

Hi Jann,

I went through the commit you mentioned. If I understand it correctly,
->cred was not being accessed concurrently (via RCU), hence, a non_rcu
flag was introduced, which determined if the clean-up should wait for
RCU grace-periods or not. And since, the changes were 'thread local'
there was no need to wait for an entire RCU GP to elapse.

The commit too, as you said, mentions the removal of __rcu annotation.
However, simply removing the annotation won't work, as there are quite a
few instances where RCU primitives are used. Even get_current_cred()
uses RCU APIs to get a reference to ->cred. So, currently, maybe we
should continue to use RCU APIs and leave the __rcu annotation in?
(Until someone who takes it on himself to remove __rcu annotation and
fix all the instances). Does that sound good? Or do you want me to
remove __rcu annotation and get the process started?

Thanks
Amol

> > hence use rcu_access_pointer to access them.
