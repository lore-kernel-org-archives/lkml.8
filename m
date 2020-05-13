Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F3720675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJpGEnR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgEMVnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:43:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729196AbgEMVnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589406195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14UosuVRXMChRoyaxAqU3xlncdZ3hrjsmYgbi9ygQkw=;
        b=HJpGEnR8hafWL5fjEG+KV0oWsCF7nWNPRqIcgRlhpR6elV/O0H0vlyw1oavRXyFs/4N57I
        xZXk50KPFco8ry6YILxbxomJ3IoO152xU60hwdTuNbSTD4Rh21Hui3upY/FqGwBHCugqu2
        mFAgN05P+NqRmj9u7q6mAzD6PYj8O68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-flou5OPuPb-Z3p6bv_Qvmw-1; Wed, 13 May 2020 17:43:13 -0400
X-MC-Unique: flou5OPuPb-Z3p6bv_Qvmw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4E4C18A0768;
        Wed, 13 May 2020 21:43:05 +0000 (UTC)
Received: from treble (ovpn-117-14.rdu2.redhat.com [10.10.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8159510013D9;
        Wed, 13 May 2020 21:43:02 +0000 (UTC)
Date:   Wed, 13 May 2020 16:43:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V5 06/38] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200513214300.ruikp7ldnko7t5pi@treble>
References: <20200512210059.056244513@linutronix.de>
 <20200512213809.997307469@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200512213809.997307469@linutronix.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:01:05PM +0200, Thomas Gleixner wrote:
> Device interrupt handlers and system vector handlers are executed on the
> interrupt stack. The stack switch happens in the low level assembly entry
> code. This conflicts with the efforts to consolidate the exit code in C to
> ensure correctness vs. RCU and tracing.
> 
> As there is no way to move #DB away from IST due to the MOV SS issue, the
> requirements vs. #DB and NMI for switching to the interrupt stack do not
> exist anymore. The only requirement is that interrupts are disabled.
> 
> That allows to move the stack switching to C code which simplifies the
> entry/exit handling further because it allows to switch stacks after
> handling the entry and on exit before handling RCU, return to usermode and
> kernel preemption in the same way as for regular exceptions.
> 
> The initial attempt of having the stack switching in inline ASM caused too
> much headache vs. objtool and the unwinder. After analysing the use cases
> it was agreed on that having the stack switch in ASM for the price of an
> indirect call is acceptable as the main users are indirect call heavy
> anyway and the few system vectors which are empty shells (scheduler IPI and
> KVM posted interrupt vectors) can run from the regular stack.
> 
> Provide helper functions to check whether the interrupt stack is already
> active and whether stack switching is required.
> 
> 64 bit only for now. 32 bit has a variant of that already. Once this is
> cleaned up the two implementations might be consolidated as a cleanup on
> top.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20200507161020.783541450@infradead.org
> ---
> V5: Moved the actual switch to ASM code

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

