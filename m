Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7489C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C74A20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585662447;
	bh=R71iqxDbmN5qBzBbVcwabUWqDS8g8zCCaR8V499sGfs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FWY6IbDcL1ZW37HFsOHuxnh/Cy1NZkRjy3zrclaY1IWmBTkxEB491BM6mMtE6mbX7
	 TlcUS6fDN8QLuJPwtlqIRBQ7oZHHVbeAJzmVZ+4prU5Xmvt7zlawkvb811aoHMQFis
	 abiJ3x84B/FbvgOtzdbP2zR4D0QAbuSZc4p97S/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgCaNr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgCaNr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:47:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BB220784;
        Tue, 31 Mar 2020 13:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585662445;
        bh=R71iqxDbmN5qBzBbVcwabUWqDS8g8zCCaR8V499sGfs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fWEfKH3ToKbYebfVQboQTyMO7fnq/t781SL9RRFbS+C6jElLBCOZGi+k5yxUVv30R
         damOI2Uip5PsVyXV5VYj/YoWrCSRRJcLdE9OVK4+o/NhTUJHUqDENdckSxjm8IkNK6
         0lXwscxJ8QHLfuSIW2AmUWy1HugSxm+X/0fHvx1w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 900DD35226AE; Tue, 31 Mar 2020 06:47:25 -0700 (PDT)
Date:   Tue, 31 Mar 2020 06:47:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/21] Revert "list: Use WRITE_ONCE() when
 initializing list_head structures"
Message-ID: <20200331134725.GL19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-9-will@kernel.org>
 <20200330232505.GD19865@paulmck-ThinkPad-P72>
 <20200331131153.GB30975@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331131153.GB30975@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 02:11:54PM +0100, Will Deacon wrote:
> On Mon, Mar 30, 2020 at 04:25:05PM -0700, Paul E. McKenney wrote:
> > On Tue, Mar 24, 2020 at 03:36:30PM +0000, Will Deacon wrote:
> > > This reverts commit 2f073848c3cc8aff2655ab7c46d8c0de90cf4e50.
> > > 
> > > There is no need to use WRITE_ONCE() to initialise a non-RCU 'list_head'.
> > > 
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > And attention to lockless uses of list_empty() here, correct?
> > 
> > Depending on the outcome of discussions on 3/21, I should have added in
> > all three cases.
> 
> Yes, patch 3 is where this will get sorted. It looks like we'll have to
> disable KCSAN around the READ_ONCE() over there, but I also need to finish
> wrapping my head around list_empty_careful() because I'm deeply suspicious!

At the very least, it does have the disadvantage of touching an additional
cache line, and up to two additional cache lines in the non-empty case.  :-(

							Thanx, Paul
