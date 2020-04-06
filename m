Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E75C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9B206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gq3ggIF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgDFMu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:50:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgDFMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yJdiqRUTuGzJsIc9YdNsg+wOhFQED1U03A0cfa6MRI=; b=gq3ggIF38sLmUn7QoaZUANArfs
        yoRMRHz6q60UmstjEVzGVRJnM1vDyNx/7iZiiHGDgttp/BY0ZofnMnwBwSr4coe9IXm6AItylx/gw
        xrq8ONsMH7SqNNf6AIrAxM7bnuWmIErs7w0ppTo57slOM2QvktSCxUeZAbjUShh5N7h4Pg/j0lMT/
        p/nX0y5RG9+gkf/ifOlDkHCOhycW0dccTjNY95PKjCJzWdE3tenws74NKPYmKp/liH1yHbSCPuGTl
        j8B0FplBVWVO/Z37xspkCl5mbRaD6xJ4FQJfFXvDl6Qmo/Va8lvVJ01cDF2crrTbdpgr0nzMmRlhu
        5vK6eC6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLRCc-0004y8-QG; Mon, 06 Apr 2020 12:50:10 +0000
Date:   Mon, 6 Apr 2020 05:50:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200406125010.GA29306@infradead.org>
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403163007.6463-1-sean.j.christopherson@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:30:07AM -0700, Sean Christopherson wrote:
> Hook into native CR4 writes to disable split-lock detection if CR4.VMXE
> is toggled on by an SDL-unaware entity, e.g. an out-of-tree hypervisor
> module.  Most/all VMX-based hypervisors blindly reflect #AC exceptions
> into the guest, or don't intercept #AC in the first place.  With SLD
> enabled, this results in unexpected #AC faults in the guest, leading to
> crashes in the guest and other undesirable behavior.

Out of tree modules do not matter, so we should not add code just to
work around broken third party code.  If you really feel strongly just
make sure something they rely on for their hacks stops being exported
and they are properly broken.
