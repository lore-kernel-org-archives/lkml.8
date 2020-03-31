Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D16C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15915212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TceaVzPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgCaRsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:48:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44744 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgCaRsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:48:32 -0400
Received: from zn.tnic (p200300EC2F0C0900F1B8AEA007893A5C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:900:f1b8:aea0:789:3a5c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FBE11EC0CC3;
        Tue, 31 Mar 2020 19:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585676911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FfjbbwtF7FGDeVUNh7GVhRJaQHIJbHSKbcyegihWkhQ=;
        b=TceaVzPKPBzULblMEgOQwNOjY7VAUzPR6j7hpkncsOqrLB+zEQo305ZQSxRS21mu9EY+Ou
        YV4DCVHFSmy2ohvBgvbq/dLEbRv3irzzytKaShHlH5Ud9Wg5LlpkNekwJDIyowAZnkOT1K
        GWXKLTAGSVcx/nv8m+VwmracnjDF9Cg=
Date:   Tue, 31 Mar 2020 19:48:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/boot changes for v5.7
Message-ID: <20200331174826.GD29131@zn.tnic>
References: <20200331075305.GA57035@gmail.com>
 <CAHk-=wjFiniKY80uDdSmZVXqXJdvLQS8xeKo9TnN1POqiU5Qxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFiniKY80uDdSmZVXqXJdvLQS8xeKo9TnN1POqiU5Qxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:36:51AM -0700, Linus Torvalds wrote:
> Wouldn't it be much better to try to standardize around that arm model
> instead?

Yap, as a matter of fact, this did came up recently as one thing that we
should do to avoid "fixes" like that. I'll put it on my TODO list and
won't be mad - at all, actually - if someone beats me to it. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
