Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D1DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42ACE2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgENOIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgENOIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:08:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F58C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:08:30 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZEWr-0008Ob-Nu; Thu, 14 May 2020 16:08:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DAAF71004CE; Thu, 14 May 2020 16:08:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>,
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
Subject: Re: [patch V4 part 3 09/29] x86/entry/32: Provide macro to emit IDT entry stubs
In-Reply-To: <1225010168.20900.1589463536204.JavaMail.zimbra@efficios.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.166735365@linutronix.de> <835459920.20630.1589420674977.JavaMail.zimbra@efficios.com> <CALCETrXFv59dX5K5R_KO6D5uznD9E8DCDR5fQ7_fCwTTGOgS5Q@mail.gmail.com> <1225010168.20900.1589463536204.JavaMail.zimbra@efficios.com>
Date:   Thu, 14 May 2020 16:08:04 +0200
Message-ID: <87eermzk1n.fsf@nanos.tec.linutronix.de>
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
> ----- On May 14, 2020, at 12:31 AM, Andy Lutomirski luto@kernel.org wrote:
>> On Wed, May 13, 2020 at 6:44 PM Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> They're needed for all entries except SYSCALL, but they're hidden
>> inside helpers in many cases.
>
> Indeed, on x86-32 the macro SAVE_ALL contains cld. That architecture
> appears to be OK.
>
> What I am concerned about is the idtentry, idtentry_mce_db,
> and idtentry_df macros introduced in entry_64.S by this series.
> Those are supposed to be technically equivalent to the prior
> code, which indeed has the ASM_CLAC but no "cld".
>
> So maybe the cld happens to be hidden elsewhere, but I'm clearly
> missing it ? Or is it not needed for some reason ?

It's needed and it is there where it was forever in error_entry and
paranoid_entry.

It probably makes sense to stick it right after the CLAC.

Thanks,

        tglx


