Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8B22076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQ2F/4dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCRLC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:02:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRLC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mwfvDj/eaZ0pv7OSWbFQbRzvMXJOloFIlf7imRJqKpM=; b=RQ2F/4dYe7psPozH1k0vudFYrF
        XEqIXsd0JxWUIX4FHUEiXSpvwn20vGU5efZ2qJDVQk3e/vH/QIpdV63L/vQyZnXdyf7mLO4NkZ9i1
        npavPc/tQqY/kMt4+p21JVuLjw+mYoeGAlSatgNjJ4bLSaMQPgpNJgua1ixm10FTO9fGrXNofMU+u
        XD7eoI9Jev+HXyPdxieT3BFq2asuR9gMlULWlC1c3TlU0q9QI3qb0wOQ9sAGxvxPdm4wmwVs60yEa
        OmNB3E5EDjNRg5fh5M10QWKK+KqYV7HKffYRgjY/2nmGj2RSPi3mx9Ni2jhYjvCcw3TbEueFVQ53r
        XCxmb3RQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEWTG-0001Ri-0i; Wed, 18 Mar 2020 11:02:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8834B30047A;
        Wed, 18 Mar 2020 12:02:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7643A203D72A3; Wed, 18 Mar 2020 12:02:43 +0100 (CET)
Date:   Wed, 18 Mar 2020 12:02:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, mbenes@suse.cz,
        brgerst@gmail.com, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 19/19] objtool: Detect loading function pointers
 across noinstr
Message-ID: <20200318110243.GE20730@hirez.programming.kicks-ass.net>
References: <20200317170910.983729109@infradead.org>
 <202003180747.qU4yJl06%lkp@intel.com>
 <CAKwvOdmU57K8vRRZd0cfUve2WZXJT0ysEwi+zRTngD3VhLxm3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmU57K8vRRZd0cfUve2WZXJT0ysEwi+zRTngD3VhLxm3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:43:47PM -0700, Nick Desaulniers wrote:
> Just needs a `default:` case.  From personal experience, this warning
> helps you track down every switch on an enum when you add a new
> enumeration value.

Except of course if those switch statements have a default clause and
still need updating for the new state.

Anyway, I'll go add the silly line.
