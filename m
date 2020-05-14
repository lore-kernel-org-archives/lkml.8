Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B801C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E434206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589430708;
	bh=zl3jEjDdHHsLyqPz83LYn1KOjUo1N49J7Zaj/EbrBrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1ulX1520X6VDnMiPgNHhIZ9w+QcZd/uW3MfnBcXyAkGfqVTXHiGeHqbFIN8LEt22z
	 IDLgWgVbRynwaAao3ReQgSXHWuFsYel+WqBNfURGxIe3eL8xr8XoQsbW+Ufu96Cw4f
	 CjLct/TZaD7vFfEv398FU/fu0bS52XLuLxN/Z384=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgENEbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgENEbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:31:46 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE9120748
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589430706;
        bh=zl3jEjDdHHsLyqPz83LYn1KOjUo1N49J7Zaj/EbrBrg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cj7XNy68bRQOX0yKQ7mNNsvaoADyu+6qVLjA/ObAbTtbM0EqQVhz/Rwz9eS66x+ED
         RfY8wHCR8tJqFSDCDOZPyGqY5rJPAnUSwNe3/UJ8nvdxaaKoiPDvK5o/DCPSTqmrnr
         cIlYWsvDyyh0dbEZJn/bPcNAMvLfQUAGsXOJSowc=
Received: by mail-wm1-f43.google.com with SMTP id y24so30888148wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:31:45 -0700 (PDT)
X-Gm-Message-State: AGi0PuYUwrjmgve5bskBFf4wJO8jOmY2KsMCmuxgi/1t72DNtcWWyZDI
        QZAZm7OXTw6dmeGQtUXhdNFoiIPpDKOdkmsCWBLxpQ==
X-Google-Smtp-Source: APiQypKbysOY3c+gRinfdq+0VIiJqMYY2wb7uUD0pUgiMjMcdGzgM04OMfBPR6FZ4oc89Yhiyx5Vyk6UcvZbzQ03LIY=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr25570949wmf.138.1589430704269;
 Wed, 13 May 2020 21:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.166735365@linutronix.de>
 <835459920.20630.1589420674977.JavaMail.zimbra@efficios.com>
In-Reply-To: <835459920.20630.1589420674977.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:31:32 -0700
X-Gmail-Original-Message-ID: <CALCETrXFv59dX5K5R_KO6D5uznD9E8DCDR5fQ7_fCwTTGOgS5Q@mail.gmail.com>
Message-ID: <CALCETrXFv59dX5K5R_KO6D5uznD9E8DCDR5fQ7_fCwTTGOgS5Q@mail.gmail.com>
Subject: Re: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT
 entry stubs
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 6:44 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On May 5, 2020, at 9:44 AM, Thomas Gleixner tglx@linutronix.de wrote:
>
> [...]
>
> > +.macro idtentry vector asmsym cfunc has_error_code:req sane=0
> > +SYM_CODE_START(\asmsym)
> > +     ASM_CLAC
> > +     cld
>
> Looking at the various interrupt and trap entry points for 32 and 64-bit
> x86, I notice a lack of consistency in use of the following instruction
> sequence at the asm entry point:
>
> - ASM_CLAC,
> - cld (clear direction flag).
>
> Are they always needed, or only for interrupt handlers ?

They're needed for all entries except SYSCALL, but they're hidden
inside helpers in many cases.
