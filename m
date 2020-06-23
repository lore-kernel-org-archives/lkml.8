Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB1C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA2C20716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgFWO3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:29:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732731AbgFWO3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:29:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41652AF3D;
        Tue, 23 Jun 2020 14:28:59 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:28:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: build failure after merge of the printk tree
Message-ID: <20200623142858.GB8444@alley>
References: <20200621131554.5a662afe@canb.auug.org.au>
 <20200623102655.6d16e610@canb.auug.org.au>
 <20200623121637.GA8444@alley>
 <20200623121937.GA9671@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623121937.GA9671@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-23 22:19:37, Herbert Xu wrote:
> On Tue, Jun 23, 2020 at 02:16:38PM +0200, Petr Mladek wrote:
> >
> > I have removed the problematic commit for now. It tried to remove
> > some cyclic dependencies from heavily used include files. It clearly
> > needs more love.
> 
> Hmm, the cyclic dependencies are there because you didn't pull in
> the lockdep_types patch.  The printk patch must go on top of the
> lockdep_types patch.  How about just putting this into the x86 tree
> alongside the lockdep_types patch?

I see the problem with both patches.

> In file included from include/linux/printk.h:10,
>                  from include/linux/kernel.h:15,
>                  from include/linux/list.h:9,
>                  from include/linux/lockdep.h:43,
>                  from include/linux/spinlock_types.h:18,
>                  from include/linux/genalloc.h:32,
>                  from drivers/soc/fsl/qe/qe_common.c:16:
> include/linux/ratelimit_types.h:16:2: error: unknown type name 'raw_spinlock_t'
>    16 |  raw_spinlock_t lock;  /* protect the state */

It is similar cycle:

spinlock_types.h -> lockdep.h -> printk.h -> ratelimit.h -> spinlock_types.h

But this time it happens via list.h -> kernel.h ->printk.h.
Where list.h needs READ_ONCE() stuff from compiler.h.


My "allmodconfig" build has successfully finished with the following extra
 fix on top of the two patches:

diff --git a/include/linux/list.h b/include/linux/list.h
index aff44d34f4e4..6d606c4036ce 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -6,7 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/poison.h>
 #include <linux/const.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 
 /*
  * Simple doubly linked list implementation.

I suggest to bundle this into the 2nd patch that makes linux/printk.h
self-contained.

Best Regards,
Petr

PS: And yes, it makes sense to push both patches via a single tree to
make sure that the lockdep.h split is done first.
