Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD6C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C172074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sqpylSrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgDHJMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:12:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDHJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YuWUAhtQoyJ0yUbUeGpr/y1oUIjbtiukjM28xeLeV5E=; b=sqpylSrnXQkmoOxTQxvUfVZ9dD
        adoXjMoyigkzrQS1H/X0sq2NFbHYS0sykUZYolGdKqKp9WWCnhPzL+CPwTotAXIzIVJaIohOupSiu
        PzVDC4tqa83jz956iw6smh9WtE4UEa/cu7XRAtzvRWrTwNQRKDuoH4CHuqd1bWjOE/mAfxABYGKIP
        eeY9rsXZiumS7FYhwDT3T6wbwfguo08jHT9si1ajZbwMBK7wF6VuV9AeLqH7zcIgcuWEHZw6AkcU7
        +Q1skNnGmIV+Ae4PAjSHcRbsRi7Gpx8nF+CZkleHC/qwQvpoOnCuQShZTPJ8mmoZ5nLLNwjZ3ugB7
        pwRFoCeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM6kr-0006DF-S8; Wed, 08 Apr 2020 09:12:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 232E0304DB2;
        Wed,  8 Apr 2020 11:12:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06DC92B9C8A02; Wed,  8 Apr 2020 11:12:15 +0200 (CEST)
Date:   Wed, 8 Apr 2020 11:12:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
Message-ID: <20200408091214.GK20730@hirez.programming.kicks-ass.net>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org>
 <20200406153902.GA9939@infradead.org>
 <20200406160157.GS20730@hirez.programming.kicks-ass.net>
 <20200406171058.GA5352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406171058.GA5352@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:10:58AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 06, 2020 at 06:01:57PM +0200, Peter Zijlstra wrote:
> > Please feel free to use my pgprot_nx() and apply liberally on any
> > exported function.
> > 
> > But crucially, I don't think any of the still exported functions allows
> > getting memory in the text range, and if you want to run code outside of
> > the text range, things become _much_ harder. That said, modules
> > shouldn't be able to create executable code, full-stop (IMO).
> 
> This is what i've got for now:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api

Should we not also apply pgprot_nx() to __vmalloc(), that's also
EXPORT_SYMBOL().
