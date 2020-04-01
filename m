Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BA4C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694C020658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qARTqRBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbgDAUuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:50:15 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:41105 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732710AbgDAUuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:50:14 -0400
Received: by mail-qt1-f173.google.com with SMTP id i3so1400450qtv.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ChzHASHm/TaTfFYQF8dFqluK5hccbTbRDahFmV/GYAg=;
        b=qARTqRBehTmAwNC2T13cmie795aSz9hOx+Z+GpD1GXwTWnXyRaHIGFvPnnMp19QkJw
         hwFtyHpCx8LiBOZlOPi5WFcbxDYY/C7GU+nTFtAbvbVyJN2nJMl8T8gvy56c0JtbaUq5
         HiuZwbUrjOvZoPvkhXmftgH+T+rEbfCI8l1G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ChzHASHm/TaTfFYQF8dFqluK5hccbTbRDahFmV/GYAg=;
        b=pDPnceKQtVHyZXR5eJbih+b81IXocfi+S+fzrOV79euqovn08hLXu0BhizQsBY38NF
         w6uT3mp4wUPry6D9qau3IZZJMFaHj8607MU3pNytVFRPdaDV1yDAe55COKc4hTQDbILw
         Kwhk+RuWXNkn1SYly5cCuNCzqEAqCQMxpltaYmDUq0GKnLbXXfZN+eNt9Li6L6PQGwED
         ISoqL2TPEiEuRidOt/sitqbmtWb8Yc+GhjdmthdjYUSAigTZ2ad2mw3UhsLmh+P13T84
         iz6hXvuFlIWqEp6Wsjv3KLlF3xiGht+oyKcAoSrUtI+y0EuUrHkIy4Nlpla5nSpDZxA9
         UKbQ==
X-Gm-Message-State: ANhLgQ0QrLVamna+0OXdS4SCuaYdNqpjNnwG0Hlo/bFk1bLD3N06AfO9
        nghwXE78v39+x03sxQNGinuWJQ==
X-Google-Smtp-Source: ADFU+vszhUVBo8rk6zQ/KP2nDIHemw/whCCufwEnjdP5HFQ3SxUOc40tK7hbpV8NdfvvfFfglUakww==
X-Received: by 2002:ac8:266c:: with SMTP id v41mr12580604qtv.174.1585774213440;
        Wed, 01 Apr 2020 13:50:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y41sm2234552qtc.72.2020.04.01.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 13:50:12 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:50:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     urezki@gmail.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: What should we be doing to stress-test kfree_rcu()?
Message-ID: <20200401205012.GC206273@google.com>
References: <20200401184415.GA7619@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401184415.GA7619@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:44:15AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> What should we be doing to stress-test kfree_rcu(), including its ability
> to cope with OOM conditions?  Yes, rcuperf runs are nice, but they are not
> currently doing much more than testing base functionality, performance,
> and scalability.

I already stress kfree_rcu() with rcuperf right now to a point of OOM and
make sure it does not OOM. The way I do this is set my VM to low memory (like
512MB) and then flood kfree_rcu()s. After the shrinker changes, I don't see
OOM with my current rcuperf settings.

Not saying that my testing is sufficient, just saying this is what I do. It
would be good to get a real workload to trigger lot of kfree_rcu() activity
as well especially on low memory systems. Any ideas on that?

One idea could be to trigger memory pressure from unrelated allocations (such
as userspace memory hogs), and see how it perform with memory-pressure. For
one, the shrinker should trigger in such situations to force the queue into
waiting for a GP in such situations instead of batching too much.

We are also missing vmalloc() tests. I remember Vlad had some clever vmalloc
tests around for his great vmalloc rewrites :). Vlad, any thoughts on getting
to stress kvfree_rcu()?

thanks,

 - Joel

