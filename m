Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB924C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C882620731
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgEGVY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgEGVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:24:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F639C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:24:58 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWo0g-0006ba-T3; Thu, 07 May 2020 23:24:51 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D660E102652; Thu,  7 May 2020 23:24:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org
Subject: Re: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about stack irq swizzles
In-Reply-To: <20200507183048.rlf2bgj4cf2g4jy6@treble>
References: <20200507161020.783541450@infradead.org> <20200507161828.801097834@infradead.org> <20200507173809.GK5298@hirez.programming.kicks-ass.net> <20200507183048.rlf2bgj4cf2g4jy6@treble>
Date:   Thu, 07 May 2020 23:24:49 +0200
Message-ID: <878si3e8v2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Thu, May 07, 2020 at 07:38:09PM +0200, Peter Zijlstra wrote:
>> On Thu, May 07, 2020 at 06:10:23PM +0200, Peter Zijlstra wrote:
>> Much simpler, also works.
>
> Doing the stack switch in inline asm is just nasty.

Matter of personal preference :)

> Also, a frame pointer makes this SO much easier for ORC/objtool, no
> funky hints needed.  In fact maybe we can get rid of the indirect hint
> things altogether, which means even more deleted code.
>
> This is much cleaner, and it boots:

Well, yes. I thought about that and it clearly works fine. There is a
downside because it adds the indirect call to all system vectors.

The device interrupt part is fine, it has an indirect call already, but
for system vectors and in particular the rescheduling IPI its bad. Not
bad because of the indirect call per se, but bad because of the
ratpoutine mitigation mess.

My other alternative was to emit switcheroo into ASM for each system
vector. Not pretty either

But over our IRC conversation I came up with a 3rd variant:

  For most of the vectors the indirect call overhead is just noise, so
  we can run them through the ASM switcher, but for the resched IPI
  we can just use a separate direct call stub in ASM.

I can live with that. I might have to pay up for Peter's headaches to
teach objtool, but that's a different story. Let me check how many beers
he owes me first ...

Thanks,

        tglx




