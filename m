Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D54C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF701206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NyXrTY6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgFDNgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgFDNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:36:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED6C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZMaPZF+V7CfNghVvBnaqgqTzlHf579PrFooouexO+HQ=; b=NyXrTY6mOBpfJPW9mEVjz8IdPn
        ou/ApnWtA/3t/wrqRoMll4Of8KRD/Kbm4pjgarwN0XSTZp8x2GDHBcNsCiXYoqG+ksI/Z32KHVW7p
        Y8BwJINAVFWHBlqHIXN6rCuftZ5H7qGIdnpfq0XIwahFYJn0itcQuHL2MzCECHi1jO6m7rm86hrWP
        SKxdYNQNYDhDlDUifnnyNpU3xUJpS3ueqpHS0ym+F2PHesd3KQpt45i9bsT68Ocp6QwZu46iJ/ZLR
        X6RWCIlYrTN18Kx0ZZXFm4/i4h8hrIQMPvdv0wFwq+/3EbdznTvulmXu3L6dcZjqaUR+lbhFikJEC
        uBx5CKCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgq28-0003ym-1p; Thu, 04 Jun 2020 13:35:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95AF43035D4;
        Thu,  4 Jun 2020 15:35:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A40620D6E7D9; Thu,  4 Jun 2020 15:35:45 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:35:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
Message-ID: <20200604133545.GB3976@hirez.programming.kicks-ass.net>
References: <20200521200513.656533920@linutronix.de>
 <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
 <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
 <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
 <20200604132537.GA3976@hirez.programming.kicks-ass.net>
 <c150c709-15d6-b126-4522-364b6663dcd5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c150c709-15d6-b126-4522-364b6663dcd5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:29:26PM +0200, Paolo Bonzini wrote:
> On 04/06/20 15:25, Peter Zijlstra wrote:
> > It being enabled through IA32_DEBUGCTL instead of through DR7 means that
> > the current code doesn't disable it and this then means we can have
> > nested #DB again.
> 
> /me bangs head on door
> 
> > Who sodding throught this was a good idea ?! What happened to #AC that
> > SLD currently uses?
> 
> It was per-core and (presumably) considered unfixable?

Yeah, but I don't see how changing the exception vector helps with that.
#DB is an IST, and it must be, because of that lovely MOV SS thing. #AC
has none of that, _please_ use #AC.
