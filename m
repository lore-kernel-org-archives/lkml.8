Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7672C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C22124676
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583173724;
	bh=z9zhIT1vPAfrmNBpotFtHXIOWrViALvBVI5P6LPwJo4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TuHBMMaj0zwGZSQMRY+0kVypzDWfCxx1kuxSZ4dqlqz7JOypcvrfDfW8j/AOlX3MP
	 cpxPa2HWpYlRhnN03tOD2PDWQjpXMg+T4Yx3TnB+f+4CwWLNMc0Lvx07KKFpAgembU
	 CkUdhByTS+6iWG2i3XondJUX5Nc6hV8cpIBZYFT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCBS2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBS2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:28:43 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAD620842;
        Mon,  2 Mar 2020 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583173722;
        bh=z9zhIT1vPAfrmNBpotFtHXIOWrViALvBVI5P6LPwJo4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A8NiIANrs8V+JX1DzQjlfsGUvZ4fkFUjfUaA/kcPUFm2MbTlTdbjE9/2LfwNdZJMY
         p0AqjCmRzNP85wfdeYrnb9pCmeWMEyWOs/eqBO3GQKG4KBMG1QvTIFzL5LXhvnp5ue
         1cjDZOIheRXNqDUcDOhFHtPRJyrfCL3uKozt7rJE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 073EC35226C8; Mon,  2 Mar 2020 10:28:42 -0800 (PST)
Date:   Mon, 2 Mar 2020 10:28:42 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Marco Elver' <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model/Documentation: Fix "conflict"
 definition
Message-ID: <20200302182841.GJ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200302141819.40270-1-elver@google.com>
 <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d5fdc95ed3847508bf0d523f41a5862@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:44:11PM +0000, David Laight wrote:
> From: Marco Elver
> > Sent: 02 March 2020 14:18
> > 
> > The definition of "conflict" should not include the type of access nor
> > whether the accesses are concurrent or not, which this patch addresses.
> > The definition of "data race" remains unchanged.
> > 
> > The definition of "conflict" as we know it and is cited by various
> > papers on memory consistency models appeared in [1]: "Two accesses to
> > the same variable conflict if at least one is a write; two operations
> > conflict if they execute conflicting accesses."
> 
> I'm pretty sure that Linux requires that the underlying memory
> subsystem remove any possible 'conflicts' by serialising the
> requests (in an arbitrary order).
> 
> So 'conflicts' are never relevant.
> 
> There are memory subsystems where conflicts MUST be avoided.
> For instance the fpga I use have some dual-ported memory.
> Concurrent accesses on the two ports for the same address
> must (usually) be avoided if one is a write.
> Two writes will generate corrupt memory.
> A concurrent write+read will generate a garbage read.
> In the special case where the two ports use the same clock
> it is possible to force the read to be 'old data' but that
> constrains the timings.
> 
> On such systems the code must avoid conflicting cycles.

That would be yet another definition of "conflicts".  Quite relevant on
some older hardware I have worked with.  But what we are concerned with
here are cases where (as you say) the memory subsystem will do just fine,
but where the fact that the memory subsystem is called upon to do the
necessary serialization constitutes a bug of some sort.

There are unfortunately a wide variety of definitions and opinions as
to exactly what sorts of conflicts constitute bugs.  The generic pattern
for these definitions and opinions is "a concurrent set of insufficiently
marked accesses to a given location, at least one of which is a write".

The differences in definitions and opinions center around exactly what
is meant by the word "insufficiently" in this last sentence.  We will
probably be tolerating some variety of definitions in the kernel,
and given the wide variety of code contained therein, this should be
just fine.

							Thanx, Paul
