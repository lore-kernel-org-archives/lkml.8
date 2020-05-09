Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E77C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334A0218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588984754;
	bh=lxWn3FHGQGcJm4LWAcdUb4NKG7yY8eIfeb3fsbkUvBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L7iyiiB6/wpP8S6vbkPv7fByKmytFt/HxR0ZgBsElgnZvhaICYcdIJm0V18XHvXKd
	 3q1Ha1orrIO6mVUIYbD8K+EBkF6Dv3pQ0sy1q1jIV04eLMldDcxxoX99QXNx2KARL8
	 z1gGikxhSvRy3a0rpyU3KpHK3YrV6tIEfcr8M1vA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgEIAjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgEIAjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:39:13 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4562024956
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588984752;
        bh=lxWn3FHGQGcJm4LWAcdUb4NKG7yY8eIfeb3fsbkUvBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mqmH9p0+kmT/7Ix3yaDgfmi9THxpI8yayvNF0LbPiT0MEYsHEe9+HmJr2HS3lCTTQ
         LeJTtVQwxYPZZByYVAXBY9xaAw4KQhjwZkEFeGP/zXo4EoRRs8RXObITaRwvkRYFvr
         X4gPJ/fdjOlFwvt9TsDDm4bl2XK9gvy6P8A0ayls=
Received: by mail-wm1-f50.google.com with SMTP id g12so12582315wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:39:12 -0700 (PDT)
X-Gm-Message-State: AGi0PuaxYvZfnFWTrMs/ivErXF8isxxysRS5evcxxv5CDg54uV3osrB7
        xNrEajuCiox3ER/z+pywWWekk87o77bCwmvim/8l4Q==
X-Google-Smtp-Source: APiQypJctJGbkHPQllk3eiT1/t67YE09f7WUr1xjjnb8tt8cLxtwplao1oMqmduaFArFbLO/BCTJpCx2lp7Eg9QH6Fs=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr11653491wmk.21.1588984750777;
 Fri, 08 May 2020 17:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134903.346741553@linutronix.de>
In-Reply-To: <20200505134903.346741553@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:39:00 -0700
X-Gmail-Original-Message-ID: <CALCETrW1pZ0NiN3F4g3=S+KpM79T9PbaYVC3Zr5p6P2rvk4v0A@mail.gmail.com>
Message-ID: <CALCETrW1pZ0NiN3F4g3=S+KpM79T9PbaYVC3Zr5p6P2rvk4v0A@mail.gmail.com>
Subject: Re: [patch V4 part 3 01/29] x86/traps: Mark fixup_bad_iret() noinstr
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
> This is called from deep entry ASM in a situation where instrumentation
> will cause more harm than providing useful information.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

Maybe add to changelog:

Switch from memmove() to memcpy() because memmove() can't be called
from noinstr code.
