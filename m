Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF3C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E08207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="stwK/rg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHIop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgEHIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:44:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B85C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vvsnZdJK1KPGBbaDhgFcB52JNykKzmJoeey033uXyMA=; b=stwK/rg8jeJmIa697Y0bt+U7tI
        mnpguk5kmkLxPeJ3VYZi8vYTL7tm1vYoStmTWRejPI6T1raQRCfrf7EbsdVZy6vtTv5+NK187A6ey
        q3u4H1f/vvB8ig9uXHjxP8r12F02k4ozcxx+rrubFWq3lTsfyOTWCBZv0kMShBuTGWFziNt0GUrk/
        mjYxO0/XVGye7K9Br/Rarvvaq6vRYpVw1kDNdZjNc+3QQtNNb4x/9Jkig2QJoctvPk4Vfs00TzdqT
        RbgNXr5OkT8Y/bMLc7EgSpVB/d/+rBf+lvoLTkc1ECkk7ximys08Ds5T9AmYY42Vjz6+LWZmfBzsu
        MEVGwV/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWycP-0004tZ-Bo; Fri, 08 May 2020 08:44:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D91130018B;
        Fri,  8 May 2020 10:44:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0740E2B93BDBC; Fri,  8 May 2020 10:44:27 +0200 (CEST)
Date:   Fri, 8 May 2020 10:44:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 24/36] lockdep: Prepare for noinstr sections
Message-ID: <20200508084426.GR5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.484532537@linutronix.de>
 <20200507202339.0abc360f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507202339.0abc360f@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:23:39PM -0400, Steven Rostedt wrote:

> > +void lockdep_hardirqs_on_prepare(unsigned long ip)

> > +void noinstr lockdep_hardirqs_on(unsigned long ip)

> Would be nice to have some kerneldoc explaining the difference between
> lockdep_hardirqs_on_prepare() and lockdep_hardirqs_on().

As the naming suggests, it's not a matter of difference, but of order,
first you call on_prepare(), then you call on(). The function signature
as per the above gives clue why.

