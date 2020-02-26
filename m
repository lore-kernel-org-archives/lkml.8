Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BFFC4BA25
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6C320714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PUNAfuZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBZSmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:42:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60252 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgBZSmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:42:43 -0500
Received: from zn.tnic (p200300EC2F08E3000C0800EF15AE70EC.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:e300:c08:ef:15ae:70ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B5F311EC01D4;
        Wed, 26 Feb 2020 19:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582742561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QOLbKvGIVeO+bnGDtjPE871jDv/Zu6peumehaSdxHyI=;
        b=PUNAfuZ9Ok7gAisFgmN/CJ9//QKmrwEcmX8++apJPH9cVaoioOMquyHvIaq976PMUXAiCL
        LCZrN30lSazsb23bnTSY4o3xDbSPAdeYFLsUvIilpNbZPIyZG0kJ9D6RdKPlgiT3V1bfqH
        05lpe1sc/+ybTGPsU6t4SVGmlENaOFQ=
Date:   Wed, 26 Feb 2020 19:42:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226184237.GB16756@zn.tnic>
References: <20200226160818.GY18400@hirez.programming.kicks-ass.net>
 <C06C32B4-BD69-4287-BC67-C3E225061A46@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C06C32B4-BD69-4287-BC67-C3E225061A46@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:28:51AM -0800, Andy Lutomirski wrote:
> > It entirely depends on what the goal is :-/ On the one hand I see why
> > people might want function tracing / kprobes enabled, OTOH it's all
> > mighty frigging scary. Any tracing/probing/whatever on an MCE has the
> > potential to make a bad situation worse -- not unlike the same on #DF.

FWIW, I had this at the beginning of the #MC handler in a feeble attempt
to poke at this:

+       hw_breakpoint_disable();
+       static_key_disable(&__tracepoint_read_msr.key);
+       tracing_off();

But then Tony noted that some recoverable errors do get reported with an
#MC exception so we would have to look at the error severity and then
decide whether to allow tracing or not.

But the error severity happens all the way down in __mc_scan_banks() -
i.e., we've executed the half handler already.

So, frankly, I wanna say, f*ck tracing etc - there are certain handlers
which simply don't allow it. And we'll only consider changing that when
a really good reason for it appears...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
