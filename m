Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D292078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgE0MbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgE0MbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:31:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67BC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:31:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jdvCA-0001lZ-I0; Wed, 27 May 2020 14:30:06 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A9496100D19; Wed, 27 May 2020 14:30:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wei Liu <wei.liu@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
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
Subject: Re: [patch V9 30/39] x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC
In-Reply-To: <20200527083803.gpigonfy2kd2g5t4@debian>
References: <20200521200513.656533920@linutronix.de> <20200521202119.647997594@linutronix.de> <20200527014616.GA123239@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net> <20200527083803.gpigonfy2kd2g5t4@debian>
Date:   Wed, 27 May 2020 14:30:04 +0200
Message-ID: <87mu5tpnlf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:
> On Wed, May 27, 2020 at 09:46:16AM +0800, Boqun Feng wrote:
> VMBus is being loaded. That gives me some clue.
>
> I notice a hunk in the patch:
>
> @@ -331,17 +327,19 @@ static void __init ms_hyperv_init_platfo
>         x86_platform.apic_post_init = hyperv_init;
>         hyperv_setup_mmu_ops();
>         /* Setup the IDT for hypervisor callback */
> -       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, hyperv_callback_vector);
> +       alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
>
> It is not using the asm variant.
>
> Could this be the culprit? Thomas?

Of course ... Sorry
