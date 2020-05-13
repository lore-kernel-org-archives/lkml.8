Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D9C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EBA206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgEMGfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgEMGfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:35:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A157CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:35:29 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYkyi-0001gu-4c; Wed, 13 May 2020 08:34:52 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6ED8D100605; Wed, 13 May 2020 08:34:51 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V5 02/38] x86/entry/64: Use native swapgs in asm_native_load_gs_index()
In-Reply-To: <20200512220230.629a230f@oasis.local.home>
References: <20200512210059.056244513@linutronix.de> <20200512213809.583980272@linutronix.de> <20200512220230.629a230f@oasis.local.home>
Date:   Wed, 13 May 2020 08:34:51 +0200
Message-ID: <8736845oms.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> On Tue, 12 May 2020 23:01:01 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> When PARAVIRT_XXL is in use, then load_gs_index() uses
>> xen_load_gs_index() and (asm_))native_load_gs_index() is unused.
>> 
>> It's therefore pointless to use the paravirtualized SWAPGS implementation
>> in asm_native_load_gs_index(). Switch it to a plain swapgs.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/entry/entry_64.S |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1043,11 +1043,11 @@ idtentry simd_coprocessor_error		do_simd
>>   */
>>  SYM_FUNC_START(asm_native_load_gs_index)
>
> Small nit, but I would just call this: asm_load_gs_index.
>
> The "native" word is usually reserved for functions that are for bare
> metal and have a paravirt counterpart. As there is a
> native_load_gs_index(), I don't envision a need for a paravirt version
> of the asm function.

Fair enough.
