Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F54AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AF720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 14:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgHNO0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:26:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgHNO0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 10:26:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC8ADB1EF;
        Fri, 14 Aug 2020 14:26:42 +0000 (UTC)
Date:   Fri, 14 Aug 2020 16:26:17 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
Message-ID: <20200814142617.GD3786@suse.de>
References: <20200803190354.GA1293087@gmail.com>
 <20200805110348.GA108872@zx2c4.com>
 <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
 <20200806131034.GA2067370@gmail.com>
 <20200806185723.GA24304@suse.de>
 <CAHk-=wg7PHCUMD1xY=YCCeVHspAhw0YNEhyO3CnHfRPwsf6P8A@mail.gmail.com>
 <20200806212019.GA2149204@gmail.com>
 <20200807084728.GA29510@suse.de>
 <20200813193008.GB2338781@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813193008.GB2338781@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Thu, Aug 13, 2020 at 09:30:08PM +0200, Ingo Molnar wrote:
> Mind re-sending it, with an updated changelog that explains why it's 
> now truly safe?

I have updated the commit and will send it out later today, maybe
together with a comment update in the preallocate_vmalloc_pages()
function.

Thanks,

	Joerg

