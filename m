Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D9FC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5032076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="O244h4YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCYNbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:31:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgCYNbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:31:40 -0400
Received: from zn.tnic (p200300EC2F0B060010E890E7BB95F8DC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:600:10e8:90e7:bb95:f8dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDD431EC0716;
        Wed, 25 Mar 2020 14:31:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585143099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8kZyeaI5oOo91uXYyG7kPVenFF4gjZf+S4YQBpUAj8c=;
        b=O244h4YGCltekNAcmTTxiV9SeigtjeyNTY5ZCESFQStvEZLOwRESjeBAnWUCDwyWZ3z/im
        pWO7PMStP7PPzrNLtD+nRY7c2Ll+nDy0EH/7JWCFK8Ulw5OoZa3x3y8dHJha8lxQ/8idok
        UPmfX3Kss5d7UXoutgSMBYLXn6+21ro=
Date:   Wed, 25 Mar 2020 14:31:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200325133137.GC27261@zn.tnic>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
 <20200316134234.GE12561@hirez.programming.kicks-ass.net>
 <20200316175450.GO26126@zn.tnic>
 <20200316180303.GR2156@tucnak>
 <20200317143602.GC15609@zn.tnic>
 <20200317143914.GI2156@tucnak>
 <20200317144942.GE15609@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317144942.GE15609@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 03:49:42PM +0100, Borislav Petkov wrote:
> On Tue, Mar 17, 2020 at 03:39:14PM +0100, Jakub Jelinek wrote:
> > That is because the option is called -fno-stack-protector, so one needs to
> > use __attribute__((optimize("no-stack-protector")))
> 
> Ha, that works even! :-)
> 
> And my guest boots.
> 
> I guess we can do that then. Looks like the optimal solution to me.
> 
> Also, I'm assuming older gccs will simply ignore unknown optimize
> options?

Sergei,

wanna send v2 where you add the function attribute to start_secondary()
only instead?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
