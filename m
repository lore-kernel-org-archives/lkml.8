Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64259C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44483207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589474405;
	bh=l8KlupapD/DQqbO1ltF4cHN9x5tXVGgg6oUCIyCA1co=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SBiuqgcL5fSsWS1Qpfqh6+cMxjAC1mxrZ3dKBBSYs9JKq8RUgjWXQrY9m0xDQG15B
	 dkDjMdOLKVfIdfLoRC/5J9d2eZHlLYM4RQ6OLnKi5rQhx58SZRF/ucvOeGVBs5nH6Y
	 ExjhRhyphInY69da+9XBQTGdsahgmL/tzoOSzSOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgENQkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:40:03 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F96C207EA
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589474403;
        bh=l8KlupapD/DQqbO1ltF4cHN9x5tXVGgg6oUCIyCA1co=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IWklW7V80wyHY8GIER5LnKXO3fYL2EA3c/XR6W/xgZ0E9us5UYSkh8PMutL/UHJTe
         hHxkKYgPfEW0aBfm5g7Qss3djH3Ds2AXHA5ikElri17OGE7JtHDo4Ga6q3H6RfT01h
         3ESaMOxzKGvzPThQ8zEeal+K02S4PxsKD3sCQixg=
Received: by mail-wr1-f50.google.com with SMTP id l11so5153173wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:40:03 -0700 (PDT)
X-Gm-Message-State: AOAM533zET4CU5vct1ROZlVRgvj6cBNKgB3L8LXT/dK8NOI55z2Buu/Q
        cwBvf55Wx+Y2a+AflWUQU/JWhYW9kfgWL+U7sHSxEQ==
X-Google-Smtp-Source: ABdhPJwzq1NtH+BVF7nw7GSMn1nrWla6u5YljqKQUBcxDpEiHfx19aRXvnL2VaDhHmIIA+Rb9xZmjlHRBD6Ju/ZnkWA=
X-Received: by 2002:adf:a298:: with SMTP id s24mr6311879wra.184.1589474401317;
 Thu, 14 May 2020 09:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.137125609@linutronix.de>
In-Reply-To: <20200505135314.137125609@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 09:39:49 -0700
X-Gmail-Original-Message-ID: <CALCETrWKi=+GUbAi+3OJ3CMaegz2HqQYNQKdwmRHb_xoc+YVgQ@mail.gmail.com>
Message-ID: <CALCETrWKi=+GUbAi+3OJ3CMaegz2HqQYNQKdwmRHb_xoc+YVgQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 08/24] x86/entry: Provide IDTENTRY_IST
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Same as IDTENTRY but for exceptions which run on Interrupt STacks (IST) on
> 64bit. For 32bit this maps to IDTENTRY.
>
> There are 3 variants which will be used:
>       IDTENTRY_MCE
>       IDTENTRY_DB
>       IDTENTRY_NMI
>
> These map to IDTENTRY_IST, but only the MCE and DB variants are emitting
> ASM code as the NMI entry needs hand crafted ASM still.
>
> The function defines do not contain any idtenter/exit calls as these
> exceptions need special treatment.

Okay I guess, but in the long run I'm guessing that we'll want to
merge a bunch of this to DECLARE_IDTENTRY_NOASM and just manually emit
the special cases in entry_32/64.S.

Acked-by: Andy Lutomirski <luto@kernel.org>
