Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA97C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B727320643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEOJf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbgEOJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:35:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:35:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZWjz-00049l-9B; Fri, 15 May 2020 11:34:51 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B1E28100606; Fri, 15 May 2020 11:34:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 14/36] x86/entry: Get rid of ist_begin/end_non_atomic()
In-Reply-To: <1777514130.20137.1589410645669.JavaMail.zimbra@efficios.com>
References: <20200505131602.633487962@linutronix.de> <20200505134059.462640294@linutronix.de> <1777514130.20137.1589410645669.JavaMail.zimbra@efficios.com>
Date:   Fri, 15 May 2020 11:34:50 +0200
Message-ID: <877dxdy211.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

> ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
>
>> This is completely overengineered and definitely not an interface which
>> should be made available to anything else than this particular MCE case.
>
> This patch introduces a significant change under the radar (not explained
> in the changelog): it turns preempt_enable_no_resched() into preempt_enable().
>
> Why, and why was it a no_resched() in the first place ? Was it for performance
> or correctness reasons ?

_no_resched() is an optimization when in code which cannot schedule
anyway. But #MC is definitely not a performance critical hotpath.

So yes, it's a change but really not significant.

>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
< Remove useless gunk >

Can you please trim your replies?

Thanks,

        tglx
