Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01090C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1D624899
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBsYL8Q3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgDFPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:22:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37652 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgDFPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hSSA57/kq2jGLv7cKGf5V/mcMd9DLKO5kjFvYDFqo0E=; b=GBsYL8Q3jsrRhCyXWLh4rRvCGz
        UgvQ83PgquW4rpUQ0tLiGrlfpUWBgkN9e86OyqWxOM5w6u8hbJCvVtbty3Od/UzVKlG0d5fRbIoN2
        nSaqD4BObf2OlCPjZoRogX4CYO9jc8l5RYjltMImH8+IaWvJtaio8h5s+IjHeljGaT0BJQ5zlhuj8
        zBvYp8aUYLzg8u+OV+9+Aj9oauH8MYt89ZVgNcWbGoBhbckX2wDxywMF03+qfXm4PGDMZI9QcxyO/
        zLHl3Om0LK6QcYT9+wiCNN0jjp65vfwDtPM/qOU3S/Q77LTOv3TcEgHray/je7NOfmUtN11vG/vq1
        ovFzKVIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLTa6-0007T4-Un; Mon, 06 Apr 2020 15:22:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 268683025C3;
        Mon,  6 Apr 2020 17:22:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A1392BAC76FF; Mon,  6 Apr 2020 17:22:31 +0200 (CEST)
Date:   Mon, 6 Apr 2020 17:22:31 +0200
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
Message-ID: <20200406152231.GQ20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200406122343.GA10683@infradead.org>
 <20200406144020.GP20730@hirez.programming.kicks-ass.net>
 <20200406151847.GA25147@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406151847.GA25147@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:18:47AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 06, 2020 at 04:40:20PM +0200, Peter Zijlstra wrote:
> > It is absolutely bonkers, but at the same time we can extend this
> > infrastructure to scan for dubious code patterns we don't want to
> > support. Like for instance direct manipulation of CR4.
> 
> But that is not what this code does - it disables split lock detection.
> If it failed to load the module the whole thing would make a little
> more sense.

If this lives, it'll be to just to fail module loading. IIRC the same
was suggested elsewhere in the thread.
