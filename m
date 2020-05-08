Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A75C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537CF217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588982285;
	bh=YRqqtfHhUeECV3a07G0Ts+WJ74qbMuVFbkgCy+O7SN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qx+sUqBuY4TjOfDCs7JLSRa4mrn0k2TOaV/SMoY9my8N/bJfrByWF4jCRBKkxvUSN
	 WEJraN8wqqR2Km5ga8JRPMudD+Y3AYghTc1k7CPXXTbU27Ns2IhrZor6kq3HjMT1Ml
	 dIVk3tjfeO1KW0FRmkHSJRrQ9NL2qba5krWgrRMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgEHX6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgEHX6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:58:04 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 691662495C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 23:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588982283;
        bh=YRqqtfHhUeECV3a07G0Ts+WJ74qbMuVFbkgCy+O7SN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIEuabiJEg2cqBqTSKuTtJFiPgB/n5LPuFcktX8Mcpgu56idVl2HZdoP++Hawge3z
         VmoIHxrHUvJiMyouM6wrw9GCaV2SSOqeaR9cN3Ygci7JgUP6+cEwALfhVuWC3PVluS
         v9qz0ANxiIjQQi0aFwvJ842DtJJI2qB4rovSVdfE=
Received: by mail-wm1-f42.google.com with SMTP id m24so2342021wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 16:58:03 -0700 (PDT)
X-Gm-Message-State: AGi0PuYiZ+HYzUHd82O+7WfuWBZAa0JqIgFiKUzeyxZQ9LI2UOwc7nOZ
        tL2uMEBKSWhKFoOXyL3iH/crGn20vAjcnVcecxPXpg==
X-Google-Smtp-Source: APiQypKQZNEwwX4h0fk2nHcrXKPOKkEGYndYO96klga8zo5b2LESL3vuvCxvl69OBwDucGzQm1kbDXFMs9oHRsA/5TA=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr17955310wmk.36.1588982281881;
 Fri, 08 May 2020 16:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134112.272268764@linutronix.de> <20200505134340.703783926@linutronix.de>
In-Reply-To: <20200505134340.703783926@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 16:57:50 -0700
X-Gmail-Original-Message-ID: <CALCETrWAWHByoifmzcXpMpYgcABkRNNM3ihsJ1pe5jzaayvkHA@mail.gmail.com>
Message-ID: <CALCETrWAWHByoifmzcXpMpYgcABkRNNM3ihsJ1pe5jzaayvkHA@mail.gmail.com>
Subject: Re: [patch V4 part 2 06/18] x86/entry: Move irq flags tracing to prepare_exit_to_usermode()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This is another step towards more C-code and less convoluted ASM.
>
> Similar to the entry path, invoke the tracer before context tracking which
> might turn off RCU and invoke lockdep as the last step before going back to
> user space. Annotate the code sections in exit_to_user_mode() accordingly
> so objtool won't complain about the tracer invocation.

Acked-by: Andy Lutomirski <luto@kernel.org>

Note to self: the nmi code needs to be reworked to go through
prepare_exit_to_usermode(), too.  I'll do this once this whole pile
lands.
