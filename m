Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F8BC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B78206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHVvXef8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbgDBOqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:46:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388516AbgDBOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FD6RE/EUN36dlCHL75oNHHohhJhXaMYfinWxOVbw1CY=; b=eHVvXef8PjKYyExPlFfxyoyNjF
        hwvfsn3JI9j8p4suyKUdfY/5O77Kb3NbGnxt709tlyIJ9iR4vB5iiK8LOveTk5NWLxYpMmjJFc2go
        onrReXMC4xjtYntlNqA3FRskIO9oQZpx/zrnmyxrd/a5sSdl4r/aYAjM0rYz/c9wh8KFkvuVlVO03
        4+b9x163MxRLQ3JdLiQyZX9eOgaBoR85baqXVnoGCgO0YEu0rxL0gj0ba/RY2qaoHr26c4/yjlq32
        +ubLrUcFqIVI0fCOQ7HPCAJWtFuoLTFayZmk5t3NL6r4efR3U+2yN6qjxRRN1X2U6XKyrt0+pEUjP
        zLy0pTCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK16q-0003jx-4L; Thu, 02 Apr 2020 14:46:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C4473056DE;
        Thu,  2 Apr 2020 16:46:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C5D72B0D9C8F; Thu,  2 Apr 2020 16:46:18 +0200 (CEST)
Date:   Thu, 2 Apr 2020 16:46:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX
 hypervisors
Message-ID: <20200402144618.GC20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <alpine.DEB.2.21.2004020641470.7052@xps-7390>
 <20200402143203.GJ20713@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.2004020735210.10453@xps-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004020735210.10453@xps-7390>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:41:41AM -0700, Kenneth R. Crudup wrote:
> 
> On Thu, 2 Apr 2020, Peter Zijlstra wrote:
> 
> > Hmm, you're not seeing this:
> >   +       pr_warn("disabled due to VMLAUNCH in module: %s\n", me->name);
> > fire when you load the vmware kernel module?
> 
> I just looked back at the syslog's copy of the kernel messages at the time
> I'd tried it, and no, I don't see that message.

Dang!

> > Could you slip me a copy of that thing by private mail?
> 
> OK, gimme a couple of days though, I've gotta get a little work done.
> (Also, what "thing" exactly did you want?)

All the .ko files that come with vmware. I want to dig through them to
see why the VMLAUNCH detection thing isn't working.
