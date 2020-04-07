Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A8F2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EcH2LrXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDGV2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:28:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDGV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dF5pQpdVBqNC0kSnylLZyPWPJXxXRLznWdsyFigAa+Y=; b=EcH2LrXbGkY/A0oFSOCNRu8Kzn
        Jm1L3B8w2Z0EJIp1E6FXqTJGekUCp/ghbnSAyfVRBBjan/Awl8/21Lfwj/nIyORskbTf1sSOFcZud
        Viil12cmJ+sFXFpXtS22jYZXLfyNjo18kIQh0BOV2LpsI0NNohRe0UpZaQ9kVJO5EJ/fcROu58KjZ
        XOD9UXnK1HSXIqXhb7u7Lf9lwNhiyEAfyFSLG0wBF5L/yd2bY0nLJ0Ac9wAJbdktKkmjjS6dG8Rtg
        UTdM6fuAZpK8buCxz7vmKIRKqZOglWpvEJd5/g0W5TXtXmJtSisb2P4mDRXgwuNbVxFs9rL6W6SqR
        Mul4V5hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLvlF-0002vH-0a; Tue, 07 Apr 2020 21:27:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E13B89803E1; Tue,  7 Apr 2020 23:27:54 +0200 (CEST)
Date:   Tue, 7 Apr 2020 23:27:54 +0200
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
Message-ID: <20200407212754.GU2452@worktop.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 02:22:11PM -0700, Nadav Amit wrote:
> Anyhow, I do not think it is the only use-case which is not covered by your
> patches (even considering CRs/DRs alone). For example, there is no kernel
> function to turn on CR4.VMXE, which is required to run hypervisors on x86.

That needs an exported function; there is no way we'll allow random
writes to CR4, there's too much dodgy stuff in there.
