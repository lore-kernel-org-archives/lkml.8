Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B02C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C494923126
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P71jGAlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgDFOk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:40:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgDFOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q0f2YWsYPlAo6pLHq6S1UJzc1Ws491iljyLHs6eXhb0=; b=P71jGAlhJ7V1shMm9q8Ea8oUc9
        QlBS289wnjA74bov0bROeyWiTsE28JDy07IOsvJs8vSQ9UKSj36/8cOUKVSria86giI29IPzRRhto
        +EvpWMlnApfdu5ax53T8rvHCcIMj/Lo06m+sk+8UBa9DzJGo8+MtPaZV8dAUTb0nXA0+1gYNHD058
        QUW3Oqjqu+NYzbnPOP7NNItte7v/KEm/7i9TZKTPHUpwpJhgEC+qUzbBObveG+3WaLuVoDDa3di58
        61KC67AcSEPjsO+PXqZWvz4JvVygkgC/VdaZjR7B9OqVkzl/ADPr09h2D4u8vbq8JvO5k2aSLPqZ8
        czuw4zbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSvG-00004v-Hw; Mon, 06 Apr 2020 14:40:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABEA930477A;
        Mon,  6 Apr 2020 16:40:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5FA972BAC764B; Mon,  6 Apr 2020 16:40:20 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:40:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20200406144020.GP20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200406122343.GA10683@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406122343.GA10683@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 05:23:43AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 02, 2020 at 02:32:59PM +0200, Thomas Gleixner wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > It turns out that with Split-Lock-Detect enabled (default) any VMX
> > hypervisor needs at least a little modification in order to not blindly
> > inject the #AC into the guest without the guest being ready for it.
> > 
> > Since there is no telling which module implements a hypervisor, scan the
> > module text and look for the VMLAUNCH instruction. If found, the module is
> > assumed to be a hypervisor of some sort and SLD is disabled.
> > 
> > Hypervisors, which have been modified and are known to work correctly,
> > can add:
> > 
> >   MODULE_INFO(sld_safe, "Y");
> > 
> > to explicitly tell the module loader they're good.
> > 
> > NOTE: it is unfortunate that struct load_info is not available to the
> >       arch module code, this means CONFIG_CPU_SUP_INTEL gunk is needed
> >       in generic code.
> > 
> > NOTE: while we can 'trivially' fix KVM, we're still stuck with stuff
> >       like VMware and VirtualBox doing their own thing.
> 
> This is just crazy.  We have never cared about any out tree module, why
> would we care here where it creates a real complexity.  Just fix KVM
> and ignore anything else.

It is absolutely bonkers, but at the same time we can extend this
infrastructure to scan for dubious code patterns we don't want to
support. Like for instance direct manipulation of CR4.

Look at is as another layer to enforce sanity on binary only modules.

Do we want to go that way, and do you know of other code patterns you'd
want to fail module loading for?
