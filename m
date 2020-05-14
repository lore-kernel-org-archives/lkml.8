Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B567206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431820;
	bh=SUo3K1/X1O0pqZGotedOINoTOj4rVrBjP2H1Mpj/Qw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pQ/CYXJxAUJTnUUkMnyRYZ8T0ptN5jQbtSv4T2OPaHmuVV+OK8mnOlF8WusjIZQeG
	 Ls3NIsdoB1szwyDRqkK3Gl6gXgvcXb7NXwV+SpdMUjE/5j4TsOA0WppB169UaLBtZR
	 ScErenYMVrk3IUR8kgNH0w8ZTUkJjBIExlcX8XBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgENEuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:50:18 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF36206D8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431818;
        bh=SUo3K1/X1O0pqZGotedOINoTOj4rVrBjP2H1Mpj/Qw8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XCmMv3YyuQwjpc3crxqXTUbpOB7M6MeiLJhtSEJ2pMa9au3xqoR40bjHYkxNib3bE
         cmyoUq1dTUEyAYIVyxSJ9XlTI5O0V0wqi5Di7i1OvCK4fRaTEfSrRsVFHOr85OMWSh
         2NeBEtt+BosaU3WOFAAbRnPebInHM7FpQea04DM4=
Received: by mail-wm1-f42.google.com with SMTP id h4so28766972wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:50:17 -0700 (PDT)
X-Gm-Message-State: AGi0PuY0pshthQpOWFKup7CRigHovfCDUq01Ms9nkrH4tfKq3y21RF48
        GyvocjdrSvCSQ4ey9FG/tJLnwPOnDJ8yW1c5OdRjdg==
X-Google-Smtp-Source: APiQypJ/X1A0tNZ/iiECCEbLbX9mDuBZira41w4/dSCEflxAkNVdxLo6XD9423hm2Z+OQ3U+/iOZ1hDnf1n8Vbxodg8=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr45750764wme.176.1589431816323;
 Wed, 13 May 2020 21:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.637269946@linutronix.de>
In-Reply-To: <20200505134905.637269946@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:50:05 -0700
X-Gmail-Original-Message-ID: <CALCETrXTU_TLQC25SxsGNx3L__COEM9aPEsvjLYThAqNVv803Q@mail.gmail.com>
Message-ID: <CALCETrXTU_TLQC25SxsGNx3L__COEM9aPEsvjLYThAqNVv803Q@mail.gmail.com>
Subject: Re: [patch V4 part 3 24/29] x86/entry: Convert General protection
 exception to IDTENTRY
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #GP to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>   - Remove the RCU warning as the new entry macro ensures correctness
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
