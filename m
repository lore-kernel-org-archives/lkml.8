Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A420BC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795BF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkG5AvKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBFPLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:11:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBFPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qAWbALPQo8/7ZJiptwDEhRrrdBNpEoxar+lbkVRuAXo=; b=kkG5AvKqs7FgbTx1sDRnpdMTZc
        BzBObTMElPe+LuKQATTxfQxOvzCr3lBLeGAPdfZafBDKaD6N+Fky8AcloGDTeDfemb1S9o3tCt5b5
        VkwP0brh0w4wzD18UdcrDhuClv2L6gzwKCJLEFR+ZbYALVSceI2+qwGF0tgRyP2yTuGegFc9hv7iI
        bgoJ8j2XLkrtmkg5E3CXbXjDyKxQUox1dMxnAmCa9sFuohwnzWxKUz7Cg5bLsKE/M7Q6PPhlYZuh0
        15zhBPgDeNPdYUSxuBsvE53LMnBRjYeWXa9LizeXtRg8Wz9V9+7J1SjVOs4mK/e9B1qCad6uZ6vD7
        l+u1K4uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iziWV-0004zG-P7; Thu, 06 Feb 2020 14:52:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC8623016E5;
        Thu,  6 Feb 2020 15:51:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 549F42B811ED7; Thu,  6 Feb 2020 15:52:53 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:52:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
Message-ID: <20200206145253.GT14914@hirez.programming.kicks-ass.net>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-9-kristen@linux.intel.com>
 <20200206103830.GW14879@hirez.programming.kicks-ass.net>
 <202002060356.BDFEEEFB6C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002060356.BDFEEEFB6C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:06:17AM -0800, Kees Cook wrote:
> On Thu, Feb 06, 2020 at 11:38:30AM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 05, 2020 at 02:39:47PM -0800, Kristen Carlson Accardi wrote:
> > > +static long __start___ex_table_addr;
> > > +static long __stop___ex_table_addr;
> > > +static long _stext;
> > > +static long _etext;
> > > +static long _sinittext;
> > > +static long _einittext;
> > 
> > Should you not also adjust __jump_table, __mcount_loc,
> > __kprobe_blacklist and possibly others that include text addresses?
> 
> These don't appear to be sorted at build time. 

The ORC tables are though:

  57fa18994285 ("scripts/sorttable: Implement build-time ORC unwind table sorting")

> AIUI, the problem with
> ex_table and kallsyms is that they're preprocessed at build time and
> opaque to the linker's relocation generation.

I was under the impression these tables no longer had relocation data;
that since they're part of the main kernel, the final link stage could
completely resolve them.

That said, I now see we actually have .rela__extable .rela.orc_unwind_ip
etc.

> For example, looking at __jump_table, it gets sorted at runtime:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/jump_label.c#n474

For now, yes. Depends a bit on how hard people are pushing on getting
jump_labels working earlier and ealier in boot.

> As you're likely aware, we have a number of "special"
> sections like this, currently collected manually, see *_TEXT:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/vmlinux.lds.S#n128

Right.

> I think we can actually add (most of) these to fg-kaslr's awareness (at
> which point their order will be shuffled respective to other sections,
> but with their content order unchanged), but it'll require a bit of
> linker work. I'll mention this series's dependency on the linker's
> orphaned section handling in another thread...

I have some patches pending where we rely on link script order. That's
data sections though, so I suppose that's safe for the moment.

