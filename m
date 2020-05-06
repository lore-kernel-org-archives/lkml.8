Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD71C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B01520753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XmQBFBEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgEFKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:03:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgEFKDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:03:03 -0400
Received: from zn.tnic (p200300EC2F06960035CE382CC05E0B20.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9600:35ce:382c:c05e:b20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E32101EC030F;
        Wed,  6 May 2020 12:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588759382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hisy4FfcANfVY69ugOc5P7tdWlvofA+codCJ8A0yxi8=;
        b=XmQBFBEAiiKlfQyRzFFR90/blg4/TDHouBNQXaKylX6xkWGUrba+zsYjvLIOP91IcIV1iG
        EwA907JiLyyOM2mmrK61zahgehT1R6L2f9Sn2S7AgLkkh/yWgXenkseXvC/cUzBt7sXxTY
        2LBUo/C+wc62tXB4U72qcxy6uuNzliM=
Date:   Wed, 6 May 2020 12:02:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
Message-ID: <20200506100256.GC25532@zn.tnic>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.361859938@linutronix.de>
 <20200506084019.GB25532@zn.tnic>
 <87ftcdo29o.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftcdo29o.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:12:35AM +0200, Thomas Gleixner wrote:
> It was NOP long ago. Now it's Minimal OPeration :)

LOL, a new instruction: MOP. I can think of a couple of x86 instructions
which can be MOPs.

:-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
