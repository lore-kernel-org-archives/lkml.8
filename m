Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2712C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D540206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pPgANI9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgENRFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:05:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:54186 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgENRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:05:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 336062A6EC1;
        Thu, 14 May 2020 13:05:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YUwEbBenprlJ; Thu, 14 May 2020 13:05:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CF9832A6A79;
        Thu, 14 May 2020 13:05:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CF9832A6A79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589475903;
        bh=LQXqwpa3nj6Fc4ZCrj9+GEMOkkY0i7tuMwEgpzs19zc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pPgANI9yCeAOJbolI55NgwdCwA2Z46JYDTqrFyr2093oVkWPi/JniF8Lkd1QymGmD
         r4JYCA34Jx8u/EY/1pGwDzU7TcgsP0dZKzpnunr7HLwsR4P3A9oZdbUETPAL0nPZ4l
         zwhSHWfwOwGYFGSBIF2A0r+r8Y2MtjrUY7Z1QGoDJmgtgwyqvR5/XUhLvfOflIo2n2
         jd9aoPOCZKnHUYjGvtxKVe+HNFBdP2NcWtk+nOfyLwjVplzdtaPn3W6+hiBrO+5ZZg
         FpgcSd4Xtfy6K7PYJ0MMVmMTtPJFCks0GKQk6u+tcwVlcK4POp0Rb7Rw5tYZA6c1uy
         0V/g+LfgXRq1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C-79SLDiHFAQ; Thu, 14 May 2020 13:05:03 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BBAEC2A7103;
        Thu, 14 May 2020 13:05:03 -0400 (EDT)
Date:   Thu, 14 May 2020 13:05:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>
Message-ID: <981919093.21263.1589475903673.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200514163947.GF9266@zn.tnic>
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de> <20200514141703.GD9266@zn.tnic> <1278452779.21179.1589472210183.JavaMail.zimbra@efficios.com> <20200514163947.GF9266@zn.tnic>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/mce: Send #MC singal from task work
Thread-Index: HgI41vOZKsWdU0dWCWo+PNlydfISwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 14, 2020, at 12:39 PM, Borislav Petkov bp@alien8.de wrote:

> On Thu, May 14, 2020 at 12:03:30PM -0400, Mathieu Desnoyers wrote:
>> - #MC triggered, queuing task work,
>> - unrelated signal happens to be delivered to task,
>> - exit to usermode loop handles do_signal first,
>> - then it runs task work.
> 
> How can that even happen?
> 
> exit_to_usermode_loop->do_signal->get_signal and that does:
> 
>        if (unlikely(current->task_works))
>                task_work_run();
> 
> at the top.
> 
> So the task work will always run before the signal handler.

OK yes, nevermind. I focused on its invocation from tracehook_notify_resume
and missed this invocation in do_signal. My bad.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
