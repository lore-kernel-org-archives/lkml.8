Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F3C2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E4120740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="J8S5wxrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgELVnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgELVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:43:46 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:43:45 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c24so6061802qtw.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Jz0N2qi039/ltHYIrFe1r2pYgMJDcOi9Hazab0EYXU=;
        b=J8S5wxrP9OdTJgIMV52j8dzoXsMsesXUxZW9T8t54cvdAUBztE1dh/QAdWEw2meILQ
         7B/M5erCff1ZFASZalwLnNtJ/RwJpxWZbqLmgxPlpYPb5n+/hNXVf+1h+4AsG/SRXEiN
         /0juhDLwgkGGOUIMtoM/nobBES0mxGVEKNIQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Jz0N2qi039/ltHYIrFe1r2pYgMJDcOi9Hazab0EYXU=;
        b=kSg9CfrwcsMzN2ycXSqq07lBXU9XV5SAxbA3snf0NptjMTrHpJmPFS+j8lvps7C/JH
         V0P5/vAQT33cQlV7brdEmF+wgdQnQ5dM7zAP+SxMTYLmaguae9YQULDK1OPzNvbxPSG6
         RJwyCdsnDmlE3yBUtJaOzzrfy4NSQ5El4aeAnjZ24AWkdP4rnMXNBnAMAJgfa3HtM73M
         f7hgeHGvIh4NA3Z+mKFPnign9M3qiRyc0yG+PxjEwO3N4u+2+ohdKNEtDUSwQ+42Bkbt
         MxqaetzqFsxFzmAAywtASbmrrmJ/ZrAt/9atjABPlchv69JWomTTLg3CB1zDerc+Y5KY
         Mm1w==
X-Gm-Message-State: AGi0PuY3KsXRNJ78G7fkrr+hlQARU9LKNAeVTYZgxRNG8kwUDiJLClW/
        sHkLahmDxh8mrDR8PHmRc5mhFQ==
X-Google-Smtp-Source: APiQypI1IRxHiLeOSmgZPvYgvz5Wtf6UdoSDfZ8yaONkacSf24QwSBM1uUPZeuzTJqKtQtdg70zuTQ==
X-Received: by 2002:ac8:1c3d:: with SMTP id a58mr23419689qtk.52.1589319824174;
        Tue, 12 May 2020 14:43:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z65sm8500011qkc.91.2020.05.12.14.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:43:43 -0700 (PDT)
Date:   Tue, 12 May 2020 17:43:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Subject: Re: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU
 pre-initialization test
Message-ID: <20200512214342.GA89170@google.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512163022.GI2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:30:22AM -0700, Paul E. McKenney wrote:
> On Tue, May 12, 2020 at 11:41:01AM -0400, Joel Fernandes wrote:
> > On Tue, May 12, 2020 at 11:07 AM Akira Yokosawa <akiyks@gmail.com> wrote:
> > >
> > > From 7bb979aacd8788d174df8a56e9803ba9e5b7a381 Mon Sep 17 00:00:00 2001
> > > From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Date: Mon, 11 May 2020 22:06:46 -0400
> > > Subject: [PATCH 4/3] docs: litmus-tests: Clarify about the RCU pre-initialization test
> > >
> > > Since this test returned to tools/memory-model/, make sure that it is
> > > at least referenced from Documentation/litmus-tests/'s README.
> > >
> > > Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
> > > [Alan: grammar nit]
> > > Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > > ---
> > > I said in the earlier message:
> > >
> > > > The explanation under tools/memory-model/litmus-tests/README also need the same
> > > > rewording.
> > >
> > > , but obviously I was confused. It is good as is.
> > >
> > > This is on top of my earlier patch series.
> > >
> > > Joel, Alan, does this work with you?
> > 
> > Yes, thanks a lot for doing it. Paul are you Ok with it too?
> 
> Looks good to me!
> 
> Could one of you please send a patch series and instructions, which I
> -think- will be of the form:
> 
> o	Revert a5cca3485d92 ("Documentation: LKMM: Move
> 	MP+onceassign+derefonce to new litmus-tests/rcu/")
> 
> o	Apply a series of patches.

Rebased Akira's 3 and my 1 on top of your /dev branch with the ordering done as above:

Could you pull?

git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch for-paul-dev)

Thanks!

 - Joel

