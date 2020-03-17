Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4113C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFDE206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oA4YhiHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCQOtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:49:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36778 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgCQOtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:49:41 -0400
Received: from zn.tnic (p200300EC2F0C9600080652A9D2B77226.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:806:52a9:d2b7:7226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E0FE11EC023E;
        Tue, 17 Mar 2020 15:49:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584456580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tkKlfKN8wNeUINPgpvJm8j9GVsp+dcrzB7iyyg4e4UQ=;
        b=oA4YhiHKxAgrqVpJ7c9C5AIF3sfB7GX289kjBJjxoDxnM1DE3/ScEUnq8kOJ1oUC930rvz
        48zTxN9XoZBvcES4G9LJHAC9VJfV/q59EbQ2dKuhwzaEO0QiTsVnVQBbJTRkGfx3YXg05o
        34fla+jAy//k77iK088FoCTuYVkTbO8=
Date:   Tue, 17 Mar 2020 15:49:42 +0100
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
Message-ID: <20200317144942.GE15609@zn.tnic>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316180303.GR2156@tucnak>
 <20200317143602.GC15609@zn.tnic>
 <20200317143914.GI2156@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317143914.GI2156@tucnak>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:39:14PM +0100, Jakub Jelinek wrote:
> That is because the option is called -fno-stack-protector, so one needs to
> use __attribute__((optimize("no-stack-protector")))

Ha, that works even! :-)

And my guest boots.

I guess we can do that then. Looks like the optimal solution to me.

Also, I'm assuming older gccs will simply ignore unknown optimize
options?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
