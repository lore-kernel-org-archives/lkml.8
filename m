Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB28C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E6420757
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585660320;
	bh=C4z6bLsgCUsUXpNs+07nkuMCLbbtGzUm2/UZT5f2VDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmIZa+/ZT/IWkWXBcBj+d+4MrBvKmiiZT4qbWU5MI/btpvNbWtvZT2teA4LZk6F6K
	 cOvR4aAF1epyxgfq1WX/Ek8uf/vnRC6nZNRxnVN7VVXFy7wS8J33zh4bbzefOnJ1wz
	 QiQoXIo5oxJE3lYMpcD6nwW9XzAgZBqyB6DPlBSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgCaNL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbgCaNL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:11:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C49A206F5;
        Tue, 31 Mar 2020 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585660319;
        bh=C4z6bLsgCUsUXpNs+07nkuMCLbbtGzUm2/UZT5f2VDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDyMaOIuFYL2OPYRlanpB+zCrBj+VAdJdLyumi/WLOjuNjpmicwMmy761XmmzOuUf
         w4tbemfSc178iooJo7SYmeCJalI49A0bXwz9TscqfPkHfEjkkga+X8QtcIMfvR2iCm
         zQCjNN2n3yGIWKd8NdX9ZXfk+TOiL/vDYVSyf0O8=
Date:   Tue, 31 Mar 2020 14:11:54 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20200331131153.GB30975@willie-the-truck>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-9-will@kernel.org>
 <20200330232505.GD19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330232505.GD19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 04:25:05PM -0700, Paul E. McKenney wrote:
> On Tue, Mar 24, 2020 at 03:36:30PM +0000, Will Deacon wrote:
> > This reverts commit 2f073848c3cc8aff2655ab7c46d8c0de90cf4e50.
> > 
> > There is no need to use WRITE_ONCE() to initialise a non-RCU 'list_head'.
> > 
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> And attention to lockless uses of list_empty() here, correct?
> 
> Depending on the outcome of discussions on 3/21, I should have added in
> all three cases.

Yes, patch 3 is where this will get sorted. It looks like we'll have to
disable KCSAN around the READ_ONCE() over there, but I also need to finish
wrapping my head around list_empty_careful() because I'm deeply suspicious!

Will
