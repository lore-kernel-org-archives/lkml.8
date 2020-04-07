Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A789C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D76720768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J76qXVdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDGTje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:39:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGTje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=L57MpBBnVLVuDtoKaJgc+4+22T0mnh8u8fyo+UeNRq8=; b=J76qXVdf64rbNhDMoTdWaIzY2A
        XuqAHOLk3Nl6ZyEJcxSsvo7M+OSGCvJqYemPGD22PUYoRtTcjhweRBzfNx9OI33++tZ6ruqMLrJwc
        ThwCpZqEbO2bejgMGCqZy4vZoitLj0RXgq7i+uTw3L99BjUylAsnyNITuGA/GCSJ1KfE+NPj+iGp9
        WWr1cfK05CT703qkXg1gJKD3rZmSSmJKeE3tsYJuz+VCBYC1FUxgrkfVQuv6XfC5GfvFeCRTrDtJ9
        FdoJVAUM5BCLn4KvfML5dqHOZMr9M6V6kfHhKX31xxC/y0ai/1rk0Jt0e7Qqbt9nWIh2S0LBsf+y9
        ebGAnxXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLu3k-0000tH-JA; Tue, 07 Apr 2020 19:38:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DB7F983507; Tue,  7 Apr 2020 21:38:53 +0200 (CEST)
Date:   Tue, 7 Apr 2020 21:38:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200407193853.GP2452@worktop.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 11:55:21AM -0700, Nadav Amit wrote:
> > On Apr 7, 2020, at 4:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > Since we now have infrastructure to analyze module text, disallow
> > modules that write to CRn and DRn registers.
> 
> Assuming the kernel is built without CONFIG_PARAVIRT, what is the right way
> for out-of-tree modules to write to CRs? Let’s say CR2?

Most of them there is no real justification for ever writing to. CR2 I
suppose we can have an exception for given a sane rationale for why
you'd need to rewrite the fault address.
