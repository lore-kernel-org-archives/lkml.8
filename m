Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D486C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D6321D91
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgIJTfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbgIJPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:43:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 06CFEACC8;
        Thu, 10 Sep 2020 15:24:33 +0000 (UTC)
Date:   Thu, 10 Sep 2020 17:24:47 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     ltp@lists.linux.it,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [LTP] [PATCH v2] syscall/ptrace08: Simplify the test.
Message-ID: <20200910152447.GA10844@yuki.lan>
References: <20200904140931.10153-1-chrubis@suse.cz>
 <5d127ee5-56d1-01c5-c364-dcb004204e9d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d127ee5-56d1-01c5-c364-dcb004204e9d@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> looks good and the test passes on older fixed kernels. Just one
> compatibility issue below.

I've fixed that and also the kernel version when the behavior had
changed and pushed, thanks for the review and testing.

...

> > +	if (TST_RET != -1) {
> > +		tst_res(TFAIL, "ptrace() breakpoint with kernel addr succeeded");
> > +	} else {
> > +		if (TST_ERR == EINVAL) {
> > +			tst_res(TPASS | TTERRNO,
> > +				"ptrace() breakpoint with kernel addr failed");
> > +		} else {
> > +			tst_res(TFAIL | TTERRNO,
> > +				"ptrace() breakpoint on kernel addr should return EINVAL, got");
> > +		}
> > +	}
> > +
> > +	unsigned long addr;
> 
> AFAICT, we're not compiling with --std=c99 so older compilers may
> complain about the variable declaration here.

The default std for gcc has been at least gnu90 for ages, which includes
subset of c99 features as well including this one. So unless you
explicitly pass --std=c90 or older it will work just fine.

I've moved the declaration to the top of the function nevertheless.

-- 
Cyril Hrubis
chrubis@suse.cz
