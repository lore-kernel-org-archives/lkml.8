Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841DAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9335020675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjADHcKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbgENAqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728354AbgENAqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:46:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF8EC061A0C;
        Wed, 13 May 2020 17:46:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j2so1492151qtr.12;
        Wed, 13 May 2020 17:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SBZNKCTlXKPNvYjvW2URDR5wK8m+yCBs9TljI6y4G4I=;
        b=rjADHcKoYGmTlw3+istuqr2suFQ5KDoJ+p45uw+xyRevM3oY6I79itY0/oRwiJdPdU
         v8qH1lo7WrTKJUfT8L00kGL3I9Yybqud7Xibl4N01Au6Z0nYYxJfn3H8FojTnluDFZjq
         VEjJKtRZSHiKRhLhg7nCXO88I5tCIz/rbT1PWsP1k9XJ2Jx9hRqhS1MjXcUHUW+aXNnU
         SK/OJYi37FyekmTWytOAcrdhE4aAtUfN+aR7q72Tg+amIKSHzXIU0gZSjOM5NqTUOTKO
         ksbvILkJJN9OHvHmtd2qP0rMZzO6PrcZ19kyf+aotLxJWBw0l8poA5V3YnJlftDDjllo
         HDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SBZNKCTlXKPNvYjvW2URDR5wK8m+yCBs9TljI6y4G4I=;
        b=MFvDgVshZ1gX/htrmjmTVqB9C8eivMKRPLKstbuIbOZuX5cZNCR8xB0nN4s8TUdxXo
         cRDdEBHC5QanOLdnu1mJSoNckuR8J9M9V3puWEyV6nqWDDhZ4wNniRcM5Kz1KSVcGHo2
         xkz6hVD1IrdxOOTFMvzGMp9pMnjLHpnyeWwGqrsJ04z2bUBcSv4A6QEf4amtYBjrqH0N
         SgHVn7PFGBqPy8vcEujcn94scxtBs24fPfKBpbUKreHpQ5sDlYePSy6mRKu43H+7zfk7
         CanmaibxQipPssXiI4g9M4puRerVDjwt4kaWv54qe7J4gI0KI156kdMy4AIxjfmuzNhI
         hHUQ==
X-Gm-Message-State: AOAM531rws3oUfcO89fGZIRYXXgU8xEe9IC3u0c7Cwe1QmVdAvgfNBKP
        EK2bAulnInuhlgIkqpObSXY=
X-Google-Smtp-Source: ABdhPJwnXYA7utByM2+X/eRMuKOdGJnVo0klOB3KDTfpPV9vkgFBQdAIWdJBpz7ClCWmjcvQ5xksZw==
X-Received: by 2002:ac8:2dbc:: with SMTP id p57mr1892105qta.280.1589417190748;
        Wed, 13 May 2020 17:46:30 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o3sm1171433qtt.56.2020.05.13.17.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 17:46:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 73F7327C005A;
        Wed, 13 May 2020 20:46:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 13 May 2020 20:46:28 -0400
X-ME-Sender: <xms:3JS8XnK67Elw8uAGd9il9oMuSHzrkyS6YhVvsPHh5FTVSTzPl04f5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleehgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:3JS8XrLqWy71qGqVoB6JOWY6MWXtp0Ny3Rrfo917-RpwPRY1b1Tgbg>
    <xmx:3JS8XvsxdwE1aKWF5ZOGgWN0yWiy0KJB9DyybpXJFhoOYTBuWnrlDQ>
    <xmx:3JS8XgY277g8U0uIqkME2srB5fBhJraTlKzKwxpkWRyxYAOhQyycNg>
    <xmx:5JS8Xmr1bKQO2cg42T__h4DuDlUxSML1Kh-DPm6cw3-vfEiZ1Qalfn1sDRk>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16C4A3066330;
        Wed, 13 May 2020 20:46:19 -0400 (EDT)
Date:   Thu, 14 May 2020 08:46:18 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's
 README into top-level one
Message-ID: <20200514004618.GA94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
 <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:39:03AM +0900, Akira Yokosawa wrote:
> From 96fa6680e3b990633ecbb6d11acf03a161b790bd Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Sun, 10 May 2020 15:12:57 +0900
> Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README into top-level one
> 
> Where Documentation/litmus-tests/README lists RCU litmus tests,
> Documentation/litmus-tests/atomic/README lists atomic litmus tests.
> For symmetry, merge the latter into former, with some context
> adjustment in the introduction.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Regards,
Boqun

> ---
>  Documentation/litmus-tests/README        | 19 +++++++++++++++++++
>  Documentation/litmus-tests/atomic/README | 16 ----------------
>  2 files changed, 19 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/litmus-tests/atomic/README
> 
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> index c4307ea9f996..ac0b270b456c 100644
> --- a/Documentation/litmus-tests/README
> +++ b/Documentation/litmus-tests/README
> @@ -2,6 +2,25 @@
>  LITMUS TESTS
>  ============
>  
> +Each subdirectory contains litmus tests that are typical to describe the
> +semantics of respective kernel APIs.
> +For more information about how to "run" a litmus test or how to generate
> +a kernel test module based on a litmus test, please see
> +tools/memory-model/README.
> +
> +
> +atomic (/atomic derectory)
> +--------------------------
> +
> +Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> +    Test that an atomic RMW followed by a smp_mb__after_atomic() is
> +    stronger than a normal acquire: both the read and write parts of
> +    the RMW are ordered before the subsequential memory accesses.
> +
> +Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> +    Test that atomic_set() cannot break the atomicity of atomic RMWs.
> +
> +
>  RCU (/rcu directory)
>  --------------------
>  
> diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
> deleted file mode 100644
> index 714cf93816ea..000000000000
> --- a/Documentation/litmus-tests/atomic/README
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -This directory contains litmus tests that are typical to describe the semantics
> -of our atomic APIs. For more information about how to "run" a litmus test or
> -how to generate a kernel test module based on a litmus test, please see
> -tools/memory-model/README.
> -
> -============
> -LITMUS TESTS
> -============
> -
> -Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
> -	Test that an atomic RMW followed by a smp_mb__after_atomic() is
> -	stronger than a normal acquire: both the read and write parts of
> -	the RMW are ordered before the subsequential memory accesses.
> -
> -Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> -	Test that atomic_set() cannot break the atomicity of atomic RMWs.
> -- 
> 2.17.1
> 
> 
