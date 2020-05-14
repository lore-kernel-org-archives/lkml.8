Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C67A206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OMlkiSty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgENQjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgENQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:39:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17504C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:39:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bbd008499a97412b4f89f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bd00:8499:a974:12b4:f89f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6BA691EC0351;
        Thu, 14 May 2020 18:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589474391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RGov0R+2vKmVwOTCdPFIbjKwSHhb2dT0UH4D5to6ewA=;
        b=OMlkiStyr3E38Yx7TZBpgEYcVTlKoAIh9/LI4rWAFCKGCJUtqfzRiMuOW9bF2WW9HeSkz2
        mXyMJZi19uYv3X2jQwCducgit9ZUrMoj023IrpG4KuhkOsm9TtvPaVBPHU9RAr5lFbJJ5W
        O7SwoDJ6coAAUBCGZcuLjmVyiGHeD3s=
Date:   Thu, 14 May 2020 18:39:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
Message-ID: <20200514163947.GF9266@zn.tnic>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.957390899@linutronix.de>
 <20200514141703.GD9266@zn.tnic>
 <1278452779.21179.1589472210183.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1278452779.21179.1589472210183.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 12:03:30PM -0400, Mathieu Desnoyers wrote:
> - #MC triggered, queuing task work,
> - unrelated signal happens to be delivered to task,
> - exit to usermode loop handles do_signal first,
> - then it runs task work.

How can that even happen?

exit_to_usermode_loop->do_signal->get_signal and that does:

        if (unlikely(current->task_works))
                task_work_run();

at the top.

So the task work will always run before the signal handler.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
