Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D0DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594172078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 18:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbgE1SoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 14:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391498AbgE1SoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 14:44:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863DC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 11:44:10 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeNVf-0006XD-7t; Thu, 28 May 2020 20:44:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id ABC47100D01; Thu, 28 May 2020 20:44:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: [patch 2/5] x86/idt: Add comments about early #PF handling
In-Reply-To: <20200528161440.GJ2483@worktop.programming.kicks-ass.net>
References: <20200528145315.727724091@linutronix.de> <20200528145522.807135882@linutronix.de> <20200528161440.GJ2483@worktop.programming.kicks-ass.net>
Date:   Thu, 28 May 2020 20:44:06 +0200
Message-ID: <87pnanoq6h.fsf@nanos.tec.linutronix.de>
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
> On Thu, May 28, 2020 at 04:53:17PM +0200, Thomas Gleixner wrote:
>> The difference between 32 and 64 bit vs. early #PF handling is not
>> documented. Replace the FIXME at idt_setup_early_pf() with proper comments.
>> + * Note, that X86_64 cannot install the real #PF handler in
>> + * idt_setup_early_traps() because the memory intialization needs the #PF
>> + * handler from the early_idt_handler_array to initialize the early page
>> + * tables.
>
> + "See early_make_pgtables()" ?
>
> I had to frob around in head_64.S to find wth that early handler
> actually did.

True.
