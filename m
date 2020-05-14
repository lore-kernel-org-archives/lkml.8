Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D112E2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgENRjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbgENRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:39:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DEC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 10:39:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZHob-0004fZ-Mj; Thu, 14 May 2020 19:38:37 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1415C1004CE; Thu, 14 May 2020 19:38:37 +0200 (CEST)
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
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
In-Reply-To: <409359846.20366.1589413337072.JavaMail.zimbra@efficios.com>
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de> <409359846.20366.1589413337072.JavaMail.zimbra@efficios.com>
Date:   Thu, 14 May 2020 19:38:37 +0200
Message-ID: <87y2puxvqa.fsf@nanos.tec.linutronix.de>
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
>> From: Peter Zijlstra <peterz@infradead.org>
>> 
>
> Patch title: singal -> signal.
>
>> Convert #MC over to using task_work_add(); it will run the same code
>> slightly later, on the return to user path of the same exception.
>
> So I suspect that switching the order between tracehook_notify_resume()
> (which ends up calling task_work_run()) and do_signal() done by an
> earlier patch in this series intends to ensure the information about the
> instruction pointer causing the #MC is not overwritten by do_signal()
> (but I'm just guessing).

No, it does not. See the ordering discussion.

Aside of that signal never transported any address information. It uses
force_sig(SIGBUS).

Even if a different signal would be sent first then the register frame
of the #MC is still there when the fatal signal is sent later.

But even w/o changing the ordering the taskwork check in do_signal()
runs the pending work before delivering anything.

Thanks,

        tglx

