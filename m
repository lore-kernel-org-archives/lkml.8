Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D100020671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HAbXWhxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgENORE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:17:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50774 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENORD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:17:03 -0400
Received: from zn.tnic (p200300EC2F0BBD00DC45039F589BC722.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bd00:dc45:39f:589b:c722])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C9C31EC015C;
        Thu, 14 May 2020 16:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589465822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L/7YnQ+kNL3Q5YC63tSTUBj8eb6tXih/NbkQSzEPndI=;
        b=HAbXWhxsivatZF1kn9wC7NAG1048ANHXznHBvZEbZXYclfhh2RFuRzkmaduObDJKP8zpxT
        lvjUdlJUIIqOqqOWVwviDQHO9jRFcTkgCV7Es8/mqqy0wMPbxUEf62a+KplHFjuKXzm1ef
        l2su/xkwCsuIM35Wy4PhbVngMPKbpzs=
Date:   Thu, 14 May 2020 16:17:03 +0200
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
Message-ID: <20200514141703.GD9266@zn.tnic>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.957390899@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200505134100.957390899@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Tony.

On Tue, May 05, 2020 at 03:16:31PM +0200, Thomas Gleixner wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Convert #MC over to using task_work_add(); it will run the same code
> slightly later, on the return to user path of the same exception.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  arch/x86/kernel/cpu/mce/core.c |   56 ++++++++++++++++++++++-------------------
>  include/linux/sched.h          |    6 ++++
>  2 files changed, 37 insertions(+), 25 deletions(-)

I like this:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
