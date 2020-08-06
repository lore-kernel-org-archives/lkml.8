Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B266BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA18D221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHFTXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:23:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:33610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgHFTXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:23:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 545E9AF19;
        Thu,  6 Aug 2020 19:23:52 +0000 (UTC)
Date:   Thu, 6 Aug 2020 21:23:33 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200806192333.GB24304@suse.de>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com>
 <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 12:02:40PM -0700, Linus Torvalds wrote:
> But you may obviously have different settings for CONFIG_X86_5LEVEL,
> and maybe that ends up changing something?
> 
> But since apparently it's not immediately obvious what the problem is,
> I'll revert it for now.

Yes, that's the best for now. My gut feeling is that the fault Jason is
seeing didn't happen on a vmalloc address, but I can't prove that yet.

And if this is true it means that more work is needed before the syncing
on x86-64 can be removed, so reverting is the best for now.

Jason, can you share more details about the test setup which triggers
this? Like the .config and the machine setup, ideally a qemu
command-line, and how to reproduce it on that setup.

Thanks,

	Joerg
