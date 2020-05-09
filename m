Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3DC47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C4620746
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 03:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPTNqe5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgEIDni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 23:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgEIDnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 23:43:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632BCC061A0C;
        Fri,  8 May 2020 20:43:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r22so233814pga.12;
        Fri, 08 May 2020 20:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zwupl3WGz7M6JVBmi772VknIH5KdfnHALsH9I+tZ89U=;
        b=aPTNqe5WbqSNRyOKhg2DzNKpOUIEY2gNqFp9kNVjAlg4+kzztxJjt/Jaox/7Tv1pVA
         ZFZ+jRy4QFoIcy+zEdsSP1R6lDIQbBG+Pqi58hLFYbc80MGfm8y4dlllN68X9IGEeXwJ
         XeThMGj7ud1Zs+UIei8w43oFpPJZ+Iufk1mCKl2adhbDc0tOgsTzeTk5I8CwKcpj7WPW
         bhFWg+P1NvD059QRETkgG26mwwWTUnqQIuXazSrjry3TNuUb60G9wYt5ie22fWO1FhLY
         nwMJAxtvf3KCi/6suFpc+8enJXeL+NEzwC5g5vqys2pru4xj8XT7NgnEkemQ2syzMFlf
         GVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zwupl3WGz7M6JVBmi772VknIH5KdfnHALsH9I+tZ89U=;
        b=FilsuaPjo4QSWepRhA044XzqjlpVxP7lHwkYZ3ySnRnW5lC0x1HDoFwZ7Ufq0jEbA1
         8FOWxOTrwbhsTzR3MuxtesYOqH+8ucR2Adt9KRAuqyM+GXHea6+tz2K5419BZqQKkZKr
         uhDOHBsHQR25U8NbLJvXowrJGNzL3dF53zXpCcKsYj+zBO9MaTCfHK0G7hiIx3whcBg+
         4DMvfWHsRtUxyakQNGaO8Jzzc3JWj6heXvNEck93jcvqUUkjY6IrqzTXURaXTcGT61Qv
         8SpKydnthOPX0Fgu7Xd7CxmzaFkgvcq+p+T+b5HR1nxTWyXQsDfK+lDqo0OHVz93DC5I
         t0HQ==
X-Gm-Message-State: AGi0PuY68ITuimxF48TvvH8gDhb00xcefv0hTM+luL9/cV8ycZ8izEZK
        9vNPynx15NPfRAt+EptfPWs=
X-Google-Smtp-Source: APiQypJhEZpA+1sunLzyJ03wkE9n1DG4PJ7kXdlcEWYn/nx8Z9KxqQBGY3wxbfDHrzdtgXaqbYqF6Q==
X-Received: by 2002:aa7:80cf:: with SMTP id a15mr6551155pfn.124.1588995815945;
        Fri, 08 May 2020 20:43:35 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n9sm3583656pjt.29.2020.05.08.20.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 20:43:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] Documentation: LKMM: Move MP+onceassign+derefonce
 to new litmus-tests/rcu/
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Cc:     vpillai@digitalocean.com, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
Date:   Sat, 9 May 2020 12:43:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200323015735.236279-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Sorry for the late response but I've noticed some glitches.
 
On Sun, 22 Mar 2020 21:57:32 -0400, Joel Fernandes (Google) wrote:
> Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
> directory.

MP+onceassign+derefonce.litmus is called out in
tools/memory-model/Documentation/recipes.txt as a representative example
of RCU related litmus test.

So I think it should be kept under tools/memory-model/litmus-tests.

Further RCU-related litmus tests can be added under Documentation/litmus-tests/.

IIUC, this change is not picked up by tip tree yet. So we have time to respin
the series targeting v5.9.

> 
> More RCU-related litmus tests would be added here.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
> Cc: vpillai@digitalocean.com
> 
>  Documentation/litmus-tests/README                        | 9 +++++++++

Please note that later patches to add atomic litmus tests under
Documentation/litmus-tests/ by Boqun put README as
Documentation/litums-tests/atomic/README.

This patch's location of RCU's README as Documentation/litmus-tests/README
looks asymmetric to me.

I'm OK with either merging atomic's README with the top-level one or
moving RCU's README to under Documentation/litmus-tests/rcu.

Joel, Boqum, can you sort out the location of README?

        Thanks, Akira

>  .../litmus-tests/rcu}/MP+onceassign+derefonce.litmus     | 0
>  tools/memory-model/litmus-tests/README                   | 3 ---
>  3 files changed, 9 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/litmus-tests/README
>  rename {tools/memory-model/litmus-tests => Documentation/litmus-tests/rcu}/MP+onceassign+derefonce.litmus (100%)
> 
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> new file mode 100644
> index 0000000000000..84208bc197f2e
> --- /dev/null
> +++ b/Documentation/litmus-tests/README
> @@ -0,0 +1,9 @@
> +============
> +LITMUS TESTS
> +============
> +
> +RCU (/rcu directory)
> +--------------------
> +MP+onceassign+derefonce.litmus
> +    Demonstrates that rcu_assign_pointer() and rcu_dereference() to
> +    ensure that an RCU reader will not see pre-initialization garbage.
> diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
> similarity index 100%
> rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
> rename to Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 681f9067fa9ed..79e1b1ed4929a 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -63,9 +63,6 @@ LB+poonceonces.litmus
>  	As above, but with store-release replaced with WRITE_ONCE()
>  	and load-acquire replaced with READ_ONCE().
>  
> -MP+onceassign+derefonce.litmus
> -	As below, but with rcu_assign_pointer() and an rcu_dereference().
> -
>  MP+polockmbonce+poacquiresilsil.litmus
>  	Protect the access with a lock and an smp_mb__after_spinlock()
>  	in one process, and use an acquire load followed by a pair of
> 
