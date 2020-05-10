Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1565EC54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE466206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 10:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgEJKPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgEJKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 06:15:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB5EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 03:15:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXizf-0004wH-LN; Sun, 10 May 2020 12:15:35 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 987FC100D21; Sun, 10 May 2020 12:15:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     tony.luck@intel.com, ak@linux.intel.com, chang.seok.bae@intel.com,
        x86@kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
In-Reply-To: <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
References: <20200423232207.5797-1-sashal@kernel.org> <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com> <d7111932-6ba5-1484-4347-210d9e80316f@oracle.com>
Date:   Sun, 10 May 2020 12:15:34 +0200
Message-ID: <87h7wo3xkp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:
> On 5/10/20 10:09 AM, Vegard Nossum wrote:
>
> I spoke a few minutes too soon. Just hit this, if anybody wants to have
> a look:
>
> [ 6402.786418] ------------[ cut here ]------------
> [ 6402.787769] WARNING: CPU: 0 PID: 13802 at arch/x86/kernel/traps.c:811 
> do_debug+0x16c/0x210

> [ 6402.820353] Call Trace:
> [ 6402.821043]  <#DB>
> [ 6402.821622]  debug+0x37/0x70
> [ 6402.822449] RIP: 0010:arch_stack_walk_user+0x79/0x110

That's a cute way to trigger that WARN_ON in the #DB handler.

> [ 6402.816468] DR0: 0000000000000001 DR1: 0000000040006070 DR2: 00007ffff7ffd000
> [ 6402.818406] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000003b3062a

#DB recursion

  [ 6402.832288] RDX: 0000000040006073 

27:	48 8b 1a      mov    (%rdx),%rbx

Breakpoint on user space stack, #DB triggers and the low level ASM
irqflags tracepoint has stacktrace enabled which unwinds into the user
stack and triggers #DB again.

Bah. I know why I want to ban all that tracing muck from low level entry code.

> It might not be related to the patch set, mind.

It's unrelated.

Thanks,

        tglx
