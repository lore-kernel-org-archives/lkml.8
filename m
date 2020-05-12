Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4762CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784E0206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="H50XxLww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgELPlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgELPlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:41:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:41:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id b71so5877151ilg.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZEt6Bk+o2CEVmWjiD/tqdGL4EUw3Dt3tU4Mvz4zdyc=;
        b=H50XxLwwzTwWMTLvuDVA8ZQUXzC+KY+g5iyAm1yq+wFQL3d6R/fX36RMhyGD5h7PXZ
         YIDGYt6oxNYuPnqStjR10Q81h+vwk3TZabD/jd1vjFFMf1mC+U9mh64EzzhPM439CaS/
         QWRFgLt1/d6yzSR2xUyFQZYRUaoTNDcxG1GlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZEt6Bk+o2CEVmWjiD/tqdGL4EUw3Dt3tU4Mvz4zdyc=;
        b=gkkxNBY0mnIG1ZHYcmKOzrkvIWUtfjCpyk31NsRWmHjVHR3yTN5T9xGco4IcQGSnVo
         gBfImU+Ab8otCL386fsaZZedKD1S7sWEdDfxBnL8jaYSA41iOXnd54qR80VwHLu5ilxO
         kbs8nBex7nsIbkSfPiXq9Qf1AdarZhBFkwzx3DrA0pdHbeYDoonEYzgzp3rnyXjmqfAs
         J2ZRg850ymrKNSPFhERU0Bx+DBVY6hImcbrK5uRqBr7msWtY/+qYkPrpQdSUX0xnavcE
         XzeoHvlJfWqUC8eRl9ftoDXgeRgfhTzMajB9jqRlPXL44zNPxP+OnF686pu2touqspeL
         1c5g==
X-Gm-Message-State: AGi0PuaIJj5lJZJ8kobL26cYzvksavI+90+xRpIh1iwCCgjWi4za3zNl
        xKcT+dEfLtk+l0Kpv9V1J403LzdlmmrELwfx7xNJ4Q==
X-Google-Smtp-Source: APiQypI2A50rkFpFjbWz1r6m0LUlWLGwS+mwemu7TvfX8LeXbw78+E7+arqxu8PPtFLm3l3yNd509eVzsCOnXdOexw8=
X-Received: by 2002:a92:194f:: with SMTP id e15mr22969825ilm.78.1589298072514;
 Tue, 12 May 2020 08:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com> <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
In-Reply-To: <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 12 May 2020 11:41:01 -0400
Message-ID: <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
Subject: Re: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:07 AM Akira Yokosawa <akiyks@gmail.com> wrote:
>
> From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> Date: Mon, 11 May 2020 22:06:46 -0400
> Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test
>
> Since this test returned to tools/memory-model/, make sure that it is
> at least referenced from Documentation/litmus-tests/'s README.
>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
> [Alan: grammar nit]
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> I said in the earlier message:
>
> > The explanation under tools/memory-model/litmus-tests/README also need the same
> > rewording.
>
> , but obviously I was confused. It is good as is.
>
> This is on top of my earlier patch series.
>
> Joel, Alan, does this work with you?

Yes, thanks a lot for doing it. Paul are you Ok with it too?

thanks,

 - Joel


>
>         Thanks, Akira
> --
>  Documentation/litmus-tests/README | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> index ac0b270b456c..b79e640214b9 100644
> --- a/Documentation/litmus-tests/README
> +++ b/Documentation/litmus-tests/README
> @@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  RCU (/rcu directory)
>  --------------------
>
> +MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
> +    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
> +    ensure that an RCU reader will not see pre-initialization garbage.
> +
>  RCU+sync+read.litmus
>  RCU+sync+free.litmus
>      Both the above litmus tests demonstrate the RCU grace period guarantee
> --
> 2.17.1
>
>
