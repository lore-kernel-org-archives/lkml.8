Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE75C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110B2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="r5V5pidG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbgAOWpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:45:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40462 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbgAOWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:45:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so9192171pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2E4ZVUUfLbzpLrVBEB+deJES/rw45hxzAWWuIoxmTL8=;
        b=r5V5pidGXOJVHi9WCUNRSyKfZQNzn2Az0BwDRgA3qaBi6+AfYKt3KVJ5Eg/6kggpFF
         q1RNL1lnq9le+u4d4Sl1fPqGgZXwkAGgzzrV0tjj8Ma+qrhIJqjqGtegLW3UvKBTclw5
         jb7vwOhPrfiZr5qlsXN1PIfsrcr1mPRx9JHIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2E4ZVUUfLbzpLrVBEB+deJES/rw45hxzAWWuIoxmTL8=;
        b=tw5Bcm/upCu32Z0t3E7ibQ9Bma868HjVd5lfk7XZbZR3jK8TyFV6VYx9yOQvEcygZP
         t43AHJ7GP6Ioz9tj/jRZAnMjIKySXvsNTQgQA7Dmp4wjA5AFDfdH0zuIpKAwjFJjxcNA
         lZ4fASnSb3qH879ptIaLtWUM0NHhP9+G2kn3nCMdhzpErU28lKmyTJSlQIwYEu7pBsVn
         NreaBcDR8yeQlyS1Xtiu47TdFSCBEJ2CnRVbJ0TbMXvyPELBJEh+595XI7T0wI3DnJ2X
         BLM7zQll0Zqsi+Ia2W78pa1QxI4Ep9F4R7Jz1a7rlLsgpw/S46SAoWX5yxLjZLowI2Ij
         z44g==
X-Gm-Message-State: APjAAAV6uqsLFvcJZjHwnTwpjNAtjT0EwWfMEX8CMV2KNTPQUhNQpACO
        Ot2SObj5M4WFM79Xi4aIbh9XqA==
X-Google-Smtp-Source: APXvYqzteva7NK73fn8eM2ETrJHg0uJ/CJGFnPvaoFG0ne8N1doNSANgs5bfgCEHcpwVumccS01Apg==
X-Received: by 2002:a62:8602:: with SMTP id x2mr34085776pfd.39.1579128344007;
        Wed, 15 Jan 2020 14:45:44 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j2sm22623663pfi.22.2020.01.15.14.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 14:45:43 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:45:42 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200115224542.GB94036@google.com>
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
 <20200115220300.GA94036@google.com>
 <20200115224251.GK2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115224251.GK2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:42:51PM -0800, Paul E. McKenney wrote:
> > [snip]
> > > > We can certainly refine it further but at this time I am thinking of spending
> > > > my time reviewing Lai's patches and learning some other RCU things I need to
> > > > catch up on. If you hate this patch too much, we can also defer this patch
> > > > review for a bit and I can carry it in my tree for now as it is only a patch
> > > > to test code. But honestly, in its current form I am sort of happy with it.
> > > 
> > > OK, I will keep it as is for now and let's look again later on.  It is not
> > > in the bucket for the upcoming merge window in any case, so we do have
> > > quite a bit of time.
> > > 
> > > It is not that I hate it, but rather that I want to be able to give
> > > good answers to questions that might come up.  And given that I have
> > > occasionally given certain people a hard time about their statistics,
> > > it is only reasonable to expect them to return the favor.  I wouldn't
> > > want you to be caught in the crossfire.  ;-)
> > 
> > Since the weights were concerning, I was thinking of just using a weight of
> > (1 / N) where N is the number of samples. Essentially taking the average.
> > That could be simple enough and does not cause your concerns with weight
> > tuning. I tested it and looks good, I'll post it shortly.
> 
> YES!!!  ;-)
> 
> Snapshot mem_begin before entering the loop.  For the mean value to
> be solid, you need at least 20-30 samples, which might mean upping the
> default for kfree_loops.  Have an "unsigned long long" to accumulate the
> sum, which should avoid any possibility of overflow for current systems
> and for all systems for kfree_loops less than PAGE_SIZE.  At which point,
> forget the "%" stuff and just sum up the si_mem_available() on each pass
> through the loop.
> 
> Do the division on exit from the loop, preferably checking for divide
> by zero.
> 
> Straightforward, fast, reasonably reliable, and easy to defend.

I mostly did it along these lines. Hopefully the latest posting is reasonable
enough ;-) I sent it twice because I messed up the authorship (sorry).

thanks,

 - Joel

