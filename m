Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC10C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340BC24889
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J27Ee6mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgDFPSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:18:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgDFPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7MKSuB7C2ecyeclexzHOiYfjTnKEm6Ap6DGoMSchwIE=; b=J27Ee6mqiT3vYTPrWksmkUr0MC
        aQ4rJegTUFq9UtuIIbuOCVFFb9sY3UqUqLEwleIhYvUhXfMFFfEHI6erszMKLa163l6QgUuL7TP3M
        TZUB75GeW54SizGh0kZPsAKviLQSY0YaT+aAlDaCHGbBp++iBCDakOn2KMJKWm7S7eGlI9bAiLXrn
        q3ndSeha0TI9fGNYkmTJMyyvqVqPut7CvujN9buQm8C9XUPyHz0tWyfjne7gA8LPhapparu1uz/Om
        +fjnvZrhd5QXbrprfCsP0Cn5AooLEVS8rYJk1HM3ssF4oTEVy+9s+6BtnFiUefU6mEGJfzLloEHvO
        y5aGspaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLTWR-0006cE-74; Mon, 06 Apr 2020 15:18:47 +0000
Date:   Mon, 6 Apr 2020 08:18:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200406151847.GA25147@infradead.org>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200406122343.GA10683@infradead.org>
 <20200406144020.GP20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406144020.GP20730@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 04:40:20PM +0200, Peter Zijlstra wrote:
> It is absolutely bonkers, but at the same time we can extend this
> infrastructure to scan for dubious code patterns we don't want to
> support. Like for instance direct manipulation of CR4.

But that is not what this code does - it disables split lock detection.
If it failed to load the module the whole thing would make a little
more sense.
