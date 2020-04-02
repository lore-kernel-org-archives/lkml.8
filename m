Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35AA206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GGpF3sT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389741AbgDBQ0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:26:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbgDBQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a/KDs39ormLqYNyLDXxwevKak24hvsf4Webm/o9jua4=; b=GGpF3sT/GT1ehshCwxDJ11YFlz
        GcGkq2F5vRMTQuZwqK5zL5KoB86HbBCLJYbf+WpUhglk7xWQlpNOlgQjCxqmQVyS9IfxCbeUDysJI
        akM7TfiHrFikfOd1j7HJc++qyNZDTUl1yCT4UHxHxslyWiYrIZJo04oPtUAPsFn4dtFxR2Uambvop
        SvkN+r8qhf6ZvvNMi0jMFmlDvPiVUTHATU8Ipab6XH8hQI/NZEjZFiTXByCnbOPzq3zYM1nYePyFU
        NzzwOXY1ITC+f9+GuXYf43Nlk/m6nfNDRLdpKYIAsmTasltFzreB/LuUKpwP2uuWS8eoLxMeRQF1X
        qy1V0oDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK2f9-0000hd-9t; Thu, 02 Apr 2020 16:25:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC0B63010BC;
        Thu,  2 Apr 2020 18:25:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99DF12B0DC2C1; Thu,  2 Apr 2020 18:25:48 +0200 (CEST)
Date:   Thu, 2 Apr 2020 18:25:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200402162548.GH20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
 <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Learn to trim your replies already!

On Fri, Apr 03, 2020 at 12:20:08AM +0800, Xiaoyao Li wrote:
> On 4/2/2020 11:23 PM, Peter Zijlstra wrote:

> > +bad_module:
> > +	pr_warn("disabled due to VMX in module: %s\n", me->name);
> > +	sld_state = sld_off;
> 
> shouldn't we remove the __ro_after_init of sld_state?

Oh, that's probably a good idea. I can't actually test this due to no
hardware.

> And, shouldn't we clear X86_FEATURE_SPLIT_LOCK_DETECT flag?

Don't think you can do that this late. Also, the hardware has the MSR
and it works, it's just that we should not.
