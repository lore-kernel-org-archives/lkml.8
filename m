Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DC5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090F320663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oVFWJM2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404261AbgFWVBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391320AbgFWVBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:01:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2072AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:01:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c139so2353887qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IJiEAsm35OSf4Kwkxjuxcv6ZYgsjC9KkGStnrzjC88Y=;
        b=oVFWJM2bXi+g6I82oVYXQLlJ9lk1WSeyy3qQIY7hXM1+QNiyL941g9vTUMmMF2+NZj
         jO57gJMY8YB4KiVWgfaxBYL5R7ILDVFDX5GoulqsBQvOIyBuNRFYDjD4Tl3g70DrkOVQ
         FJDsY8GpK2/cuO9HayQAONyJQty6l81z3Zg5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJiEAsm35OSf4Kwkxjuxcv6ZYgsjC9KkGStnrzjC88Y=;
        b=D8jitMye7x/uLF3jKsfB1rzBrBrxWJhBs6vnUUN8Z1GDJjVkDoc/xhUjNxSaD3rMhT
         SIx9LRLCvyUnK6HymAu2tWPpYnz9Q4qfiIzxGJY6YP1aLNDmzGYntnWKPf8t+3CriDbm
         MRDBe+wuQCpbIG45t/MMJfP059LtBP4oo+yO3tt5yBZI7QrZRdU5B7eCc/5NjroD/HbL
         qIDcyb6f++S/omn4P/nFaR6mv/gyMUlJFWLDtRibaHAbQMNuVv0R9DHRoc6D+pH86hrP
         D0wVRzo5AGRl3WDWWbApSquFfhs+Lpng6Xi6abZ9a8LBFf8v/x2iEJVaAKLIKxCXo2DP
         kiLA==
X-Gm-Message-State: AOAM530S9o64uSuL9rintKIeZISr5N02ORquSbq0gSe38B3Adzwx+2bZ
        66r/2latBzrR+TpnG8FTDM0o7g==
X-Google-Smtp-Source: ABdhPJyGfilx6CEztNReVMBgYC0n2g4vy+LYXCPCtYQvtlo+uVU0OgHhBU/jN8roRMjV0yw8NAAcyA==
X-Received: by 2002:a37:9b04:: with SMTP id d4mr21002794qke.58.1592946072304;
        Tue, 23 Jun 2020 14:01:12 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 185sm1595326qke.92.2020.06.23.14.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:01:11 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:01:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH tip/core/rcu 02/26] mm/mmap.c: Add cond_resched() for
 exit_mmap() CPU stalls
Message-ID: <20200623210111.GA117936@google.com>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
 <20200623002147.25750-2-paulmck@kernel.org>
 <20200623193431.GA68372@google.com>
 <20200623205508.GS9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623205508.GS9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:55:08PM -0700, Paul E. McKenney wrote:
[..] 
> > Just for my understanding, cond_resched_tasks_rcu_qs() may not help here
> > because preemption is not disabled right? Still I see no harm in using it
> > here either as it may give a slight speed up for tasks-RCU.
> 
> The RCU-tasks stall-warning interval is ten minutes, and I have not yet
> seen evidence that we are getting close to that.  If we do, then yes,
> a cond_resched_tasks_rcu_qs() might be in this code's future.  But it
> does add overhead, so we need to see the evidence first.

Yes, true about that overhead. Ok, this is fine with me too, thanks :)

 - Joel

