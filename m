Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FBAC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C76D221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H0Myrcdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgDQKiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726632AbgDQKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:38:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7830C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Q4shkXgooXPUkXPVjWvprAz5T+GPx0IRz49akwY8gA=; b=H0MyrcdgRx+SjGjeXOzd4oRjUe
        7Wjy45/9ipQWMMwgvGKojeyoouW2uK0yUOcA4PFWRCOx8pVWm0JTpJ9z6ifQeh27thKxIpwe1PpZq
        fRyLiiZkt4aScsnFxIxMGsedYh3pO6ygaJPPnYkcr2kl0zZXK608t2tHG67zYObR+bCFCzblwIZNs
        WUqOr1BPQEf9jn3Irnb7epVzsD1KuQKXDt2ll1ImqWbPKFeDgzvxnI+nI97dUNRGpqgdtJ1Zz3wup
        WcPZp3bnHgNjXqpzAYoI92Lx3/pRnaYs6a/X2GfUZ0frTVQ05kb4qNt8QJPvcqYcdVI2zPj54Bnj8
        UMtb8GEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPONu-0003Ho-Du; Fri, 17 Apr 2020 10:38:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8712C3006E0;
        Fri, 17 Apr 2020 12:38:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EEBB2B121452; Fri, 17 Apr 2020 12:38:08 +0200 (CEST)
Date:   Fri, 17 Apr 2020 12:38:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200417103808.GW20730@hirez.programming.kicks-ass.net>
References: <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic>
 <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417085859.GU2424@tucnak>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:58:59AM +0200, Jakub Jelinek wrote:
> Or go with the for (;;);, I don't think any compiler optimizes those away;
> GCC 10 for C++ can optimize away infinite loops that have some conditional
> exit because the language guarantees forward progress, but the C language
> rules are different and for unconditional infinite loops GCC doesn't
> optimize them away even if explicitly asked to -ffinite-loops.

'Funnily' there are people building the kernel with C++ :/
