Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ADAC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ED920737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvpWO4LM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkGbJWCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHZSaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHZSa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:30:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63372C061574;
        Wed, 26 Aug 2020 11:30:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598466625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sNGll/xT6FzW7aAsxR2/1F9E14nVz0yEahFp4wbolY=;
        b=VvpWO4LMHDFZHVSgSqAx6+8nELbGExgJi7K66pgCPkHFID1PJUKXJGAAnT4vMZgCwmea9P
        TBxTZBZWPOiP80H2aoosS87VFLjX+l4EmLSilMWcl68LAmPJYAJMAwXtxbdubAiAtYoF2r
        4ZH6ILu2IRqW+/dBgNjJWdEkYqsIVEoDty6wJzDYQOSU335qt8x+GPgwsD2QEZHHw+jhfJ
        /K90bfkGt3u73xxKmeaOJSjKSQRCg4q0HgHSxCxBz7CPSWBnq8VF5o8hdEqx4G/7Fz0Ghs
        0464uvXvBgRbh5xL/AFkOKu7tbZ5fAJmIiwUxKMxMKMFQ1CZ9M3CDF0Ys0vNYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598466625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sNGll/xT6FzW7aAsxR2/1F9E14nVz0yEahFp4wbolY=;
        b=kkGbJWCIw5MpdAVJzhVcLwSNabgyB0+VqViYUz+WHTsHX01pahPauNZELQZFui7zJUUazJ
        sdrr2+8lPMn2RLBQ==
To:     Alexander Graf <graf@amazon.com>, X86 ML <x86@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Avi Kivity <avi@scylladb.com>,
        "Herrenschmidt\, Benjamin" <benh@amazon.com>, robketr@amazon.de,
        amos@scylladb.com, Brian Gerst <brgerst@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/irq: Preserve vector in orig_ax for APIC code
In-Reply-To: <fd87a87d-7d8a-9959-6c81-f49003a43c21@amazon.com>
References: <20200826115357.3049-1-graf@amazon.com> <87k0xlv5w5.fsf@nanos.tec.linutronix.de> <fd87a87d-7d8a-9959-6c81-f49003a43c21@amazon.com>
Date:   Wed, 26 Aug 2020 20:30:25 +0200
Message-ID: <87blixuuny.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26 2020 at 18:33, Alexander Graf wrote:
> On 26.08.20 16:27, Thomas Gleixner wrote:
>> The below nasty hack cures it, but I hate it with a passion. I'll look
>> deeper for a sane variant.
>
> An alternative (that doesn't make the code easier to read, but would fix 
> the issue at hand) would be touse a pushq imm16 with vector | 0x8000 
> instead to always make the value negative, no?

Which makes each entry larger than 8 byte which was frowned upon before.

And it does not solve the issue that we abuse orig_ax which Andy
mentioned.

Thanks,

        tglx
