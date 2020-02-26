Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28268C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB57421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBZUVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:21:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59550 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgBZUVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:21:25 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j73B9-0005mQ-R6; Wed, 26 Feb 2020 21:21:11 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 47A7E104099; Wed, 26 Feb 2020 21:21:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 16/16] x86/entry: Disable interrupts in IDTENTRY
In-Reply-To: <20200226092335.GS18400@hirez.programming.kicks-ass.net>
References: <20200225223321.231477305@linutronix.de> <20200225224145.764810350@linutronix.de> <20200226092335.GS18400@hirez.programming.kicks-ass.net>
Date:   Wed, 26 Feb 2020 21:21:11 +0100
Message-ID: <87eeuhp0aw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Feb 25, 2020 at 11:33:37PM +0100, Thomas Gleixner wrote:
>> Not all exceptions guarantee to return with interrupts disabled. Disable
>> them in idtentry_exit() which is invoked on all regular (non IST) exception
>> entry points. Preparatory patch for further consolidation of the return
>> code.
>
> ISTR a patch that undoes cond_local_irq_enable() in the various trap
> handlers. Did that get lost or is that still on the TODO list
> somewhere?

Hmm. I ditched it after we decided that fixing the #PF cases is ugly as
hell. Lemme find that stuff again.

> Once we do that, this can turn into an assertion that IRQs are in fact
> disabled.

Right.

Thanks,

        tglx

