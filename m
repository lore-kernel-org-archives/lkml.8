Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDBC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F84D20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vwCspbL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1i1Qe7Tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGWXlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:41:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGWXlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:41:25 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595547681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4EvAkRC4BPL7n1n7Kr+wNjah1Z1o4ZKLr91LS2HGWWY=;
        b=2vwCspbL9kpSyGS1BGvqDAv6arPrdN6uebhNpupdJ/Nn23YX0YiC6tJKrVUbNSQOxVVVmO
        Lph51+YJtFQUbiSISOJmFASMBSiN8PMF0bpewFvN9bAhpTx7krb8X/UfhL7sWBiv548p3Z
        PRPQMeQ7Jy/EXAecfFRdV07zdklINIOfIwMwIpzLnyPvaKuGSXmT819fjboFMWZ7w6n2X6
        Gqp2tDYXDem/r0cGqrEq1egE3thRCzbTOFRUMuHc/UakCIAyd/JFXaXCjUzhHwTQHH+q6+
        H0RYZRgMVUI9n2QrfyjwXRdUgbTYj8df4hTGzLrH/lYUyqxn1eTKhnhzSSkrfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595547681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4EvAkRC4BPL7n1n7Kr+wNjah1Z1o4ZKLr91LS2HGWWY=;
        b=1i1Qe7Tlu3AEqraTlPmchPk0txy7Maf8ZebbpTycWER2HDP339mkPH7e+5pvMpFo57aUlv
        ZyK7mxLjfcT3B2Aw==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com> <87r1t2vwi7.fsf@nanos.tec.linutronix.de> <20200723220435.GI844235@iweiny-DESK2.sc.intel.com>
Date:   Fri, 24 Jul 2020 01:41:20 +0200
Message-ID: <87mu3pvly7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira,

Ira Weiny <ira.weiny@intel.com> writes:
> On Thu, Jul 23, 2020 at 09:53:20PM +0200, Thomas Gleixner wrote:
> I think, after fixing my code (see below), using idtentry_state could still
> work.  If the per-cpu cache and the MSR is updated in idtentry_exit() that
> should carry the state to the new cpu, correct?

I'm way too tired to think about that now. Will have a look tomorrow
with brain awake.

>> > It seems like we should start passing this by reference instead of
>> > value.  But for now this works as an RFC.  Comments?
>> 
>> Works as in compiles, right?
>> 
>> static void noinstr idt_save_pkrs(idtentry_state_t state)
>> {
>>         state.foo = 1;
>> }
>> 
>> How is that supposed to change the caller state? C programming basics.
>
> <sigh>  I am so stupid.  I was not looking at this particular case but you are
> 100% correct...  I can't believe I did not see this.
>
> In the above statement I was only thinking about the extra overhead I was
> adding to idtentry_enter() and the callers of it.

Fun. That statement immediately caught my attention and made me look at
that function.

> "C programming basics" indeed... Once again sorry...

Don't worry.

One interesting design bug of the human brain is that it tricks you into
seeing what you expect to see no matter how hard you try not to fall for
that. You can spend days staring at the obvious without seeing it. The
saying 'you can't see the forest for the trees' exists for a reason.

Yes, I know it's embarrassing, but that happens and it happens to all of
us no matter how experienced we are. Just search the LKML archives for
'brown paperbag'. You'll find amazing things.

If you show your problem to people who are not involved in that at all
there is a high propability that it immediately snaps for one of
them. But there is no guarantee, just look at this mail thread and the
number of people who did not notice.

Move on and accept the fact that it will happen again :)

Thanks,

        tglx
