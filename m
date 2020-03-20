Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E49C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BA220637
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="frbrR8Hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgCTVog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:44:36 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33894 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTVof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:44:35 -0400
Received: by mail-qv1-f66.google.com with SMTP id o18so3879204qvf.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BAzbDtmZAHhIVI3isgozFeCUOHFLvbhSC32LcQm9W2Y=;
        b=frbrR8HjPQCQFQlD342AbFZorPhi7qjUrR9wevcYQ/LNNITUhRBlu10kVc3HLhYVJQ
         GxTwwAtdtzRdvri0jJ44aUO3k6lNb8ub6+qBosUfJv0+x3CQu8xxmv0pszYtqYgW6WIM
         RNPR+W6kRbirTlKnhVoOQKnpzZX2MW8RJCFCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAzbDtmZAHhIVI3isgozFeCUOHFLvbhSC32LcQm9W2Y=;
        b=HaJaa5tRHcLGurdbTqA1pcS7CaVpWZpv6DBwYLiV5HWJzf/CmlJ7I16M+uhwBJhagN
         7BaiHhxVEu4C1ibruqDx8s+Jhvny8G+yfYYL6zx+vEEKu1zfW1davDeqf3ToBJ+XE6m/
         J/MwRU9+PQekJq6kUtU8YemcMJvABzI/pQyn0s54nVEO2/8oJleA4aLjRDErEB6Uz8hh
         GClqYgFCLqLIGLlTSxsOH0bTHIxPk0LgklSKNdCNS5cIMw/XWlsgoh8TwIAZXct9HrlC
         EwrDxa5lpHeEPo/KoU+BWvt8T/NAa2o/mdDig5ONfbvbq91wlYB6Hlr5RX43Yn8uufvX
         Wceg==
X-Gm-Message-State: ANhLgQ08d/OU3v9tL/fetnO3/YMsNRYeY2XfXKBI5VrSmR2hziBZOm0X
        40tTGiIs9rgPbvyu0aNYNYHp4w==
X-Google-Smtp-Source: ADFU+vtSk/XSWBPhuxpvwVb2qwz4gz8vm5LpPz8cfoeNWK8+voEOLHfmKuV//WPPxkJ5Oqp//cHqtg==
X-Received: by 2002:a0c:a2c4:: with SMTP id g62mr10694287qva.107.1584740673961;
        Fri, 20 Mar 2020 14:44:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y41sm5739506qtc.72.2020.03.20.14.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:44:33 -0700 (PDT)
Date:   Fri, 20 Mar 2020 17:44:32 -0400
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
Message-ID: <20200320214432.GB129293@google.com>
References: <20200320165948.GB155212@google.com>
 <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 04:56:59PM -0400, Alan Stern wrote:
> On Fri, 20 Mar 2020, Joel Fernandes wrote:
> 
> > On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > > 
> > > > This adds an example for the important RCU grace period guarantee, which
> > > > shows an RCU reader can never span a grace period.
> > > > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > > >  1 file changed, 37 insertions(+)
> > > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > 
> > > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > new file mode 100644
> > > > index 0000000000000..73557772e2a32
> > > > --- /dev/null
> > > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > 
> > > Do these new tests really belong here?  I thought we were adding a new 
> > > directory under Documentation/ for litmus tests that illustrate parts 
> > > of the LKMM or memory-barriers.txt.
> > > 
> > > By contrast, the tests under tools/memory-model are merely to show 
> > > people what litmus tests look like and how they should be written.
> > 
> > I could add it to tools/memory-model/Documentation/ under a new
> > 'examples' directory there. We could also create an 'rcu' directory in
> > tools/memory-model/litmus-tests/ and add these there. Thoughts?
> 
> What happened was that about a month ago, Boqun Feng added
> Documentation/atomic-tests for litmus tests related to handling of
> atomic_t types (see
> <https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
> interpose an extra directory level, making it
> Documentation/litmus-tests/atomic?  Or
> Documentation/LKMM-litmus-tests/atomic?
> 
> Then the new tests added here could go into
> Documentation/litmus-tests/rcu, or whatever.

That's fine with me. Unless anyone objects, I will add to
Documentation/litmus-tests/rcu and resend.

thanks,

 - Joel

