Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F29C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9231820724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vnZJZuwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCTQ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:59:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45985 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:59:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id c145so7519558qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fy1EKStjgBl7IErqlbsHwxSrZ9X93MqXTOV8yWF9uKI=;
        b=vnZJZuwAhrkWGHhScUwpwtHGJSwqn5BYJXIRhKTfDelMK24qoC6q7X0LldMJBVRj+r
         wROnVgB6icc0k829vaBIh2QqIrVP4XgFBAMC5vSNmrsoE6VDugsXWqbJVRD6siDk6VXL
         p+I//Z7gqcoOReI8+XcCqC7aP7dkgiFYyJMCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fy1EKStjgBl7IErqlbsHwxSrZ9X93MqXTOV8yWF9uKI=;
        b=DaSZIs0xj8cRHrnYxW9VjfFMtXI+0ctQJQnAmR/suv3ROOqdcid+QbcCqzHFBMMsIr
         D0GwIx0I3pKTMtPq5Nzn5DaMBuD0+7VjzUvpargOZSX21iW9SBfoddOr84h4XlCwlBdG
         pV5wPBXr2G4ZY6wt1t6AaVm2ynZTReKi1UBsGnuj3j1wXOszW/ZLB5xkdgRxj3Z2V85+
         AhKah4CoiGMNRLZ2JKn/iPUxI/qSd5P8UYhw7neTNydCBxVlsfLtDAi1yvT6cJ5izG4+
         P6CU8JchfVtqzysOU5uqQ1a594xHu1eIp2cm7GkGfI1xmgn05pZC3cWQ+gXBjOwoHzHo
         H2dA==
X-Gm-Message-State: ANhLgQ0ko0ozXwWZ3z+kOlfKHcpUgMa+tHuFUCeJQP2HSRCvNChowV88
        ICfYt5FwMNA9ZJXlEG8WC7OHbg==
X-Google-Smtp-Source: ADFU+vtpTXi7ia7zBNQKhkmUrRua//p9mBvFWrsFOpaU3/tF19lLjkU7mw+2GkSxoA8wGqEpA3ISow==
X-Received: by 2002:a37:6e06:: with SMTP id j6mr8958597qkc.171.1584723590390;
        Fri, 20 Mar 2020 09:59:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p22sm4340783qki.124.2020.03.20.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:59:49 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:59:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where
 reader stores
Message-ID: <20200320165948.GB155212@google.com>
References: <20200320065552.253696-2-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.2003201101060.27303-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003201101060.27303-100000@netrider.rowland.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> 
> > This adds an example for the important RCU grace period guarantee, which
> > shows an RCU reader can never span a grace period.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > 
> > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > new file mode 100644
> > index 0000000000000..73557772e2a32
> > --- /dev/null
> > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> 
> Do these new tests really belong here?  I thought we were adding a new 
> directory under Documentation/ for litmus tests that illustrate parts 
> of the LKMM or memory-barriers.txt.
> 
> By contrast, the tests under tools/memory-model are merely to show 
> people what litmus tests look like and how they should be written.

I could add it to tools/memory-model/Documentation/ under a new
'examples' directory there. We could also create an 'rcu' directory in
tools/memory-model/litmus-tests/ and add these there. Thoughts?

thanks,

 - Joel


