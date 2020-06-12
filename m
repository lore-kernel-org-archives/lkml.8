Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBBFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F30206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFLNOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:14:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgFLNOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8964AB98;
        Fri, 12 Jun 2020 13:14:09 +0000 (UTC)
Date:   Fri, 12 Jun 2020 15:14:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [v2 PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200612131405.GI4311@linux-b0ei>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200612043634.GA30181@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612043634.GA30181@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-06-12 14:36:35, Herbert Xu wrote:
> As it stands if you include printk.h by itself it will fail to
> compile because it requires definitions from ratelimit.h.  However,
> simply including ratelimit.h from printk.h does not work due to
> inclusion loops involving sched.h and kernel.h.
> 
> This patch solves this by moving bits from ratelimit.h into a new
> header file which can then be included by printk.h without any
> worries about header loops.
> 
> The build bot then revealed some intriguing failures arising out
> of this patch.  On s390 there is an inclusion loop with asm/bug.h
> and linux/kernel.h that triggers a compile failure, because kernel.h
> will cause asm-generic/bug.h to be included before s390's own
> asm/bug.h has finished processing.  This has been fixed by not
> including kernel.h in arch/s390/include/asm/bug.h.
> 
> A related failure was seen on powerpc where asm/bug.h leads to
> the inclusion of linux/kernel.h via asm-generic/bug.h which then
> prematurely tries to use the very macros defined in asm/bug.h.
> The particular inclusion path which led to this involves lockdep.h.
> I have fixed this moving the type definitions lockdep.h into the
> new lockdep_types.h.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I am fine with the changes as long as the kernel test robot
does not complain ;-)

Acked-by: Petr Mladek <pmladek@suse.com>

Well, I wonder if PeterZ is fine with the lockdep part. It might make
sense to split it into separate patch as a prerequisite.

Best Regards,
Petr
