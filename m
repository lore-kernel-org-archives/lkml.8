Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2718EC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D9E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:27:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53686 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:27:00 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jE8Ur-0004sf-Uy; Tue, 17 Mar 2020 10:26:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 37F12101161; Tue, 17 Mar 2020 10:26:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
In-Reply-To: <20200317095628.4f3690afe24e059a146a4b6f@kernel.org>
References: <20200312134107.700205216@infradead.org> <20200312162337.GU12561@hirez.programming.kicks-ass.net> <20200317095628.4f3690afe24e059a146a4b6f@kernel.org>
Date:   Tue, 17 Mar 2020 10:26:49 +0100
Message-ID: <87h7yncox2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:
> BTW, out of curiously, if BUG*() or WARN*() cases happens in the noinstr
> section, do we also need to move them (register dump, stack unwinding,
> printk, console output, etc.) all into noinstr section?

The current plan is to declare BUG()/WARN() "safe". On x86 it is kinda
safe as it uses UD2. That raises an exception which handles the bug/warn
after establishing the correct state.

Of course it's debatable, but moving all of this into the noinstr
section might be just a too wide scope.

Thanks,

        tglx
