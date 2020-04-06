Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44106C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D292490F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KdTrjxqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgDFQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:02:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgDFQCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AjGUynrRciwyUds0cPwv+//plSo8KNkLBd68f5hndqU=; b=KdTrjxqEMWJ/jVtzqWPnfs4DaL
        MfHycs5aBj9AYi4aW0E+hrcC5PI7cNdVLsdUxEKuBDhRjUunRxc/OmComInaLWnE4yN2U6q7gkvEV
        ZrnzQLfNiAvNQfZ8iSax1XmlH1DhP7YcScbHGwocsoQh7+GomlieDyX6BOwDgppBtaEYR0t4TOVQ/
        N0Lh2CUt8jfU7C+zuui/p21emg2UsLiYkRSY9koSmVVrpKisxhIZKwcAPi3IK/dubQqZd0wJoOho/
        c307xAqd++5rQDQ6WbB8A0U21VABMDDff3FyuIrI5+H1sF2uwotxtOL40nAKfer4xRulRrZu7xKDT
        1nDxoC8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLUCX-0000DM-I3; Mon, 06 Apr 2020 16:02:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC2E23025C3;
        Mon,  6 Apr 2020 18:01:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0AB42BAC77C4; Mon,  6 Apr 2020 18:01:57 +0200 (CEST)
Date:   Mon, 6 Apr 2020 18:01:57 +0200
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
Message-ID: <20200406160157.GS20730@hirez.programming.kicks-ass.net>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org>
 <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org>
 <20200406153902.GA9939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406153902.GA9939@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:39:02AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 06, 2020 at 08:24:11AM -0700, Christoph Hellwig wrote:
> > > and this
> > > removes __get_vm_area() and with the ability to custom ranges. It also
> > > removes map_vm_area() and replaces it with map_vm_area_nx() which kills
> > > adding executable maps.
> 
> Also there seems to be various other ways to create exectuable mappings,
> pretty much everything in vmalloc.c that gets a pgprot_t..

Please feel free to use my pgprot_nx() and apply liberally on any
exported function.

But crucially, I don't think any of the still exported functions allows
getting memory in the text range, and if you want to run code outside of
the text range, things become _much_ harder. That said, modules
shouldn't be able to create executable code, full-stop (IMO).
