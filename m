Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EEDC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09DF2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HPqpl9aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCWBbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:31:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45739 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgCWBbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:31:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so13687157qke.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 18:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qbZKelnf9av4oEdayiPkq2WIuUvuqILBE4whTz9Zy2k=;
        b=HPqpl9aRL2IrrGwnAOvgDAi/cVDDDaGlZqNH/RHRtShz8vnbD0h7gid7z52XPaRGbX
         XnyuJ9t9ds7SP5R4oV4L0ZFj23FgypcAaUZMUeGraJJzPdOdF4t7ju67lq/GCsmkTCUU
         qE7OKB/zrZv39pb12o9DOvH70d7RRh6IGW7zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qbZKelnf9av4oEdayiPkq2WIuUvuqILBE4whTz9Zy2k=;
        b=DXaWy9p4aBbm9tc70sWI1lbZob/DWfZExRTWosj4/enXvUr89N8j1WhXJ7zu1I3qSb
         A/FdGmaed/REi0bmXGWgpc9qzTmjFzWcmXZwM3MQ0qlJWfdZwdRcjU+s4rpnqS984Kag
         pvqv6InG/sSvvYaKtCzoLxj9THz76ttbuCANqdv4RhkYD48EE/SNb+bLiwXqwHQFs2bQ
         FEpciTNzhO+7+i7g1i+5D1Ub0uObG/nmf/OPvTZQE6JAhPF32G4gSlCOd+bCO3s2DX79
         WH+SxFaG798t3js9j39Wt7ayGzeCztvVVOtfVZZLBlEGwkwcn6rcdudU/y4y0DlX0P0N
         h+5Q==
X-Gm-Message-State: ANhLgQ2hM9bx9UtHvJx/j29ZDdurZx8usshgewnCOtY7R2l9wDOYZLDL
        tJ4+GCHy28Dt6j2TzUgonlEifQ==
X-Google-Smtp-Source: ADFU+vvl/ceqkZSABdKNWG2+QDkHNSdEo2qVpqX7fZIzcLTum3BEMWl2hOTneYuMX9D2cX934TdQ0g==
X-Received: by 2002:a37:cc1:: with SMTP id 184mr19167675qkm.430.1584927061435;
        Sun, 22 Mar 2020 18:31:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f26sm9918119qkl.119.2020.03.22.18.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 18:31:00 -0700 (PDT)
Date:   Sun, 22 Mar 2020 21:31:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20200323013100.GA207949@google.com>
References: <20200320165948.GB155212@google.com>
 <Pine.LNX.4.44L0.2003201643370.31761-100000@netrider.rowland.org>
 <20200320214432.GB129293@google.com>
 <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321020501.GF105953@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 10:05:01AM +0800, Boqun Feng wrote:
> On Fri, Mar 20, 2020 at 05:44:32PM -0400, Joel Fernandes wrote:
> > On Fri, Mar 20, 2020 at 04:56:59PM -0400, Alan Stern wrote:
> > > On Fri, 20 Mar 2020, Joel Fernandes wrote:
> > > 
> > > > On Fri, Mar 20, 2020 at 11:03:30AM -0400, Alan Stern wrote:
> > > > > On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:
> > > > > 
> > > > > > This adds an example for the important RCU grace period guarantee, which
> > > > > > shows an RCU reader can never span a grace period.
> > > > > > 
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
> > > > > >  1 file changed, 37 insertions(+)
> > > > > >  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > > 
> > > > > > diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > > new file mode 100644
> > > > > > index 0000000000000..73557772e2a32
> > > > > > --- /dev/null
> > > > > > +++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
> > > > > 
> > > > > Do these new tests really belong here?  I thought we were adding a new 
> > > > > directory under Documentation/ for litmus tests that illustrate parts 
> > > > > of the LKMM or memory-barriers.txt.
> > > > > 
> > > > > By contrast, the tests under tools/memory-model are merely to show 
> > > > > people what litmus tests look like and how they should be written.
> > > > 
> > > > I could add it to tools/memory-model/Documentation/ under a new
> > > > 'examples' directory there. We could also create an 'rcu' directory in
> > > > tools/memory-model/litmus-tests/ and add these there. Thoughts?
> > > 
> > > What happened was that about a month ago, Boqun Feng added
> > > Documentation/atomic-tests for litmus tests related to handling of
> > > atomic_t types (see
> > > <https://marc.info/?l=linux-kernel&m=158276408609029&w=2>.)  Should we
> > > interpose an extra directory level, making it
> > > Documentation/litmus-tests/atomic?  Or
> > > Documentation/LKMM-litmus-tests/atomic?
> > > 
> > > Then the new tests added here could go into
> > > Documentation/litmus-tests/rcu, or whatever.
> > 
> > That's fine with me. Unless anyone objects, I will add to
> > Documentation/litmus-tests/rcu and resend.
> > 
> 
> Seems good to me, I will resend my patchset with the new directory. And
> I assume in your patchset you will include the MAINTAINERS part for
> adding Documentation/litmus-tests/ as a diretory watched by LKMM group?
> In that case, I won't need to add any change to MAINTAINERS file in mine
> and we won't have any conflict. ;-)

Yes, will add to MAINTAINERS so that you don't have to :) About to send my
queue now.

thanks,

 - Joel

