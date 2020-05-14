Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAD3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051F5205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q6Aij/a0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgENPLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgENPLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:11:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NBNcKq7QYzrg1uKWtIz2EqtZTFuMJnDm85WUYzbR/G8=; b=q6Aij/a08HABfbtl8iagxjFNDq
        Yjp5v2qGISczJfPFEfDeeD0zYujKyHomxE3TQO5JrYt8DP4WInPuDXaqT6gvruxFSu14xmYGvTKd3
        CwvzFGHPbVXINCLJ6PsUbbTFvnBE1I6gqxTbwBsRwGYfzrn1HHwI3my9wyEscLmCqPZieV9PIDm+a
        CMDzuOQc4B4W6zXaNerKnnqj+Y19hVSy7KisMOo54KoW1Fsw4t56Iic1p8LK3VAvJMYyvgEnrwy9V
        FIExz9saX8LEPOBnxxF7WtmBsVzLEIuuifI/RSQFyNUeMtMe+gs4YicW9HTDBhJmPs7euzFtlwOjY
        rW59wlBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZFVW-0002QI-Fv; Thu, 14 May 2020 15:10:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 236653062BA;
        Thu, 14 May 2020 17:10:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 156262B870EB1; Thu, 14 May 2020 17:10:43 +0200 (CEST)
Date:   Thu, 14 May 2020 17:10:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
Message-ID: <20200514151043.GD2978@hirez.programming.kicks-ass.net>
References: <878shuzhcx.fsf@nanos.tec.linutronix.de>
 <B72D7A5A-B54A-4128-9EB3-BF85E74DA5B1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B72D7A5A-B54A-4128-9EB3-BF85E74DA5B1@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 08:08:46AM -0700, Andy Lutomirski wrote:
> Alternatives should be valid regardless. Isn’t the world essentially stopped while we apply them?

Yes, we do that before we go SMP.
