Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92ED20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y42ytlTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgCZRJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:09:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgCZRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a539vHbP59dCN42zHZGrS9FBttWhIEeGHZQEI/IR5hA=; b=Y42ytlTjN+qXW1Pi3nIDVEf243
        3YPQkN/zXF6RP2o5BaI5+JLyZYw1luc6eKa5EczlogRMBeLwRTYt+0ZnMvJJQqYZfaekjfjPNhE9r
        mjR018RlyiBkGesw1w/kEn9G6yVLHn9Wx5OZTB+n5MeTNYPWlz21+yHDm+S//EX6kRjXB9lWZ+ME2
        +D42nV49S4b1ymdYYy8e8Mcs50tqOGX5S01n/h7bezT8+ErD1RaogpEc3zEwo4fqJ3ccTtSviWSkG
        6z4CKTWf1FAxvLQ0tHPKDYTcBZ/8qX+kt3mIihGwZAeHGJw1krH6bWygbEuUAh7jZLSasW5Havm/s
        TDz1Mt5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHVzy-0001Md-UR; Thu, 26 Mar 2020 17:08:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2DE1303D97;
        Thu, 26 Mar 2020 18:08:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4B06203B8786; Thu, 26 Mar 2020 18:08:52 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:08:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [RESEND][PATCH v3 11/17] static_call: Simple self-test
Message-ID: <20200326170852.GR20713@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.940973110@infradead.org>
 <20200326154439.GD11398@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326154439.GD11398@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:44:39PM +0100, Borislav Petkov wrote:
> On Tue, Mar 24, 2020 at 02:56:14PM +0100, Peter Zijlstra wrote:
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/Kconfig         |    6 ++++++
> >  kernel/static_call.c |   28 ++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> 
> Should we say something?

Dunno, that just clutters dmesg, the important bit is it complaining
when it goes sideways. But no strong feelings either way.
