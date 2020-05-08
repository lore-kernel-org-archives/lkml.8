Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C778C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBFC21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgEHMo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727119AbgEHMot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:44:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06DC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:44:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jX2Mr-0005c9-E8; Fri, 08 May 2020 14:44:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id DDF83101175; Fri,  8 May 2020 14:44:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [RFC][PATCH 3/3] x86/entry, ORC: Teach objtool/unwind_orc about stack irq swizzles
In-Reply-To: <87sggak3yf.fsf@nanos.tec.linutronix.de>
References: <20200507161020.783541450@infradead.org> <20200507161828.801097834@infradead.org> <20200507173809.GK5298@hirez.programming.kicks-ass.net> <20200507183048.rlf2bgj4cf2g4jy6@treble> <878si3e8v2.fsf@nanos.tec.linutronix.de> <20200508101209.GY5298@hirez.programming.kicks-ass.net> <87sggak3yf.fsf@nanos.tec.linutronix.de>
Date:   Fri, 08 May 2020 14:44:39 +0200
Message-ID: <87pnbek348.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Peter Zijlstra <peterz@infradead.org> writes:
>> Are we sure the rat-poison crap is noise for all the other system
>> vectors? I suppose it is for most since they'll do indirect calls
>> themselves anyway, right?
>
>  3) Quick
>
>     RESCHEDULE_VECTOR
>
>     POSTED_INTR_VECTOR
>     POSTED_INTR_NESTED_VECTOR
>
>         These two postit ones are weird because they are both empty and
>         just increment different irq counts.

For those 3 it's also pointless to run them on IST stack at all.

>     HYPERV_REENLIGHTENMENT_VECTOR
>
>         schedules delayed work, i,e. arms a timer which should be
>         straight forward, but does it matter?

This one shouldn't have an issue when running on task stack either, but
we can run it through the regular indirect path for now and switch it
over when it matters performance wise.

Thanks,

        tglx
