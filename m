Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A45C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA0C208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEHOCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbgEHOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:02:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544EBC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 07:02:00 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jX3ZD-0002K2-7D; Fri, 08 May 2020 16:01:31 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 70D40101175; Fri,  8 May 2020 16:01:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V5 part 2 15/18] x86/kvm/svm: Handle hardirqs proper on guest enter/exit
In-Reply-To: <bf4c1124-836e-2903-401a-7ced619371ac@redhat.com>
References: <20200505134112.272268764@linutronix.de> <20200505134341.579034898@linutronix.de> <baf61125-72f4-5fd1-9ba1-6d55a2efdddd@redhat.com> <87imh9o3e1.fsf@nanos.tec.linutronix.de> <cade8b44-4330-2dc1-e490-c2f001cc1c95@redhat.com> <875zd7g5zb.fsf@nanos.tec.linutronix.de> <bf4c1124-836e-2903-401a-7ced619371ac@redhat.com>
Date:   Fri, 08 May 2020 16:01:30 +0200
Message-ID: <87k11mjzk5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> On 07/05/20 16:44, Thomas Gleixner wrote:
>> Add hardirq tracing to guest enter/exit functions in the same way as it
>> is done in the user mode enter/exit code, respecting the RCU requirements.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> ---
>> V5: Adjust comments and changelog
>
> Apart from the subject being svm and not vmx, it looks great.  Thanks!

Yeah, stupid me. I have the same change locally for SVM of course.

Thanks,

        tglx
