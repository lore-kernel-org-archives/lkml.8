Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF87E2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ic34yzC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgDGPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:24:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbgDGPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=73/OdYk6towkWtlmLp8roybn6u+Kwi6UysMkYnFTwAw=; b=ic34yzC8jfAK6FHvDGoHtdnFri
        8RTBeuy9bbhvRpOWS6jk1ZSn3JUv9GpnuowgVT9fV5VfI6YxEhDfo2HJ2YHRm8FGhwNYywwF7280j
        55RzG2RGEQwK/JEpJ/TTQaOUmZVc7N6umgNZIl9lVjpQDCPMeFn5FcrISPevRthntprv++0iJHOiE
        hkTpX+EDTg+6Dmdnw9O0aiqXodVDPHCJTbPyprkTo3qj5qUCjodZimw5ClEU9U3GLdMAG/n6SI0dI
        W5jCFbtgzXcYeX01336Wyob2Yq7uddtJB2HleQwmLJEXPbgXOvRxew4Sgp3Zn1Qj52VnrOiOr8rCq
        lhn6VVPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLq5H-0005Qf-Rb; Tue, 07 Apr 2020 15:24:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A27703007CD;
        Tue,  7 Apr 2020 17:24:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 854362BA83E28; Tue,  7 Apr 2020 17:24:12 +0200 (CEST)
Date:   Tue, 7 Apr 2020 17:24:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        pbonzini@redhat.com, fenghua.yu@intel.com, xiaoyao.li@intel.com,
        nadav.amit@gmail.com, thellstrom@vmware.com, tony.luck@intel.com,
        rostedt@goodmis.org, jannh@google.com, keescook@chromium.org,
        David.Laight@aculab.com, dcovelli@vmware.com, mhiramat@kernel.org
Subject: Re: [PATCH 3/4] x86,module: Detect VMX vs SLD conflicts
Message-ID: <20200407152412.GE20730@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.352324393@infradead.org>
 <20200407143543.GB876345@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407143543.GB876345@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 04:35:43PM +0200, Greg KH wrote:
> On Tue, Apr 07, 2020 at 01:02:39PM +0200, Peter Zijlstra wrote:
> > It turns out that with Split-Lock-Detect enabled (default) any VMX
> > hypervisor needs at least a little modification in order to not blindly
> > inject the #AC into the guest without the guest being ready for it.
> > 
> > Since there is no telling which module implements a hypervisor, scan
> > all out-of-tree modules' text and look for VMX instructions and refuse
> > to load it when SLD is enabled (default) and the module isn't marked
> > 'sld_safe'.
> > 
> > Hypervisors, which have been modified and are known to work correctly,
> > can add:
> > 
> >   MODULE_INFO(sld_safe, "Y");
> > 
> > to explicitly tell the module loader they're good.
> 
> What's to keep any out-of-tree module from adding this same module info
> "flag" and just lie about it?  Isn't that what you are trying to catch
> here, or is it a case of, "if you lie, your code will break" as well?

If they lie they get to keep both pieces.

The thing I worry about is them lying about "intree", is there anything
that avoids that?
