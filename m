Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D6C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D953B206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AgkshhTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgCQOf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:35:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34208 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgCQOf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:35:59 -0400
Received: from zn.tnic (p200300EC2F0C9600080652A9D2B77226.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:806:52a9:d2b7:7226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E9951EC0C68;
        Tue, 17 Mar 2020 15:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584455757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLtUF7XMg1WrGT46sBhFehgi7iRI9WIwUnnPY7j9O94=;
        b=AgkshhTIJ83v/dovDgtoI3tBP38gaaau4yDq4L4PBgiI3fqCy32xxbMnAqQ9NXlb61Kf8B
        qE+NP+c2KmmTVazrG2xoo3BtTLmHKBPhpsKXK1Ir7TEhAs9yMoxy/ku3BVyZ2qCBcgRdO/
        IuziBmxUmpCXrZegdBYzmuV3YHgd5KM=
Date:   Tue, 17 Mar 2020 15:36:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200317143602.GC15609@zn.tnic>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316180303.GR2156@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200316180303.GR2156@tucnak>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 07:03:03PM +0100, Jakub Jelinek wrote:
> On Mon, Mar 16, 2020 at 06:54:50PM +0100, Borislav Petkov wrote:
> > So having a way to state "do not add stack canary checking to this
> > particular function" would be optimal. And since you already have the
> > "stack_protect" function attribute I figure adding a "no_stack_protect"
> > one should be easy...
> 
> Easy, but a waste when GCC already has the optimize attribute that can
> handle also ~450 other options that are per-function rather than per-TU.

Ok, Micha explained to me what you mean here and I did:

static void __attribute__((optimize("no-stack-protect"))) notrace start_secondary(void *unused)
{

but it said

arch/x86/kernel/smpboot.c:216:1: warning: bad option ‘-fno-stack-protect’ to attribute ‘optimize’ [-Wattributes]
  216 | {
      | ^

because -fno-stack-protect is not implemented yet.

Regardless, yes, that can work too, if we had the -fno-stack-protect
variant.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
