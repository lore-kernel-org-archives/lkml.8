Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C57C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6077C20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EN+phhAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388372AbgDBOcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:32:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbgDBOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rNA/ZKP+zwR7ZAV/3D8mTRew1XZVl++cypDGaRhgstA=; b=EN+phhAxCqTXo0CSpOlH2mbR6L
        dHXMISMAeJD0ens5KmWa+N7WqGJNlLEbo5Gd9GTYirFiRd5n+OAir61cH8G/L2KdbOCX9cyR+d+DW
        rxGf0A7cPVQcrVda+d58a/xBrIGELNy6AQ1u51AUhFZDuOfNsB41tT0VrpmKW118GNPL5ii8JVeCP
        6bdIh/+q3KZDltu6b/0HiegpiR8vu5cEYIlM2L1lwd5RkV1pzveeoSFZA5lu5CcXKwSTJNZ2Igezk
        YgF9rjFav4f6bRTxmQU58bwe9YW4QfRnoQm/NOpMlOnEdHiZgBZEryvkAYKW1ROq4R9H3CRP3yd5x
        gT+baGYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK0t3-0003LJ-6S; Thu, 02 Apr 2020 14:32:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8E363056DE;
        Thu,  2 Apr 2020 16:32:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 690C92B0D920E; Thu,  2 Apr 2020 16:32:03 +0200 (CEST)
Date:   Thu, 2 Apr 2020 16:32:03 +0200
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
Message-ID: <20200402143203.GJ20713@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <alpine.DEB.2.21.2004020641470.7052@xps-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004020641470.7052@xps-7390>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 06:43:19AM -0700, Kenneth R. Crudup wrote:
> 
> On Thu, 2 Apr 2020, Thomas Gleixner wrote:
> 
> > As Peter and myself don't have access to a SLD enabled machine, the
> > KVM/VMX part is untested. The module scan part works.
> 
> I just applied both of these patches to my (Linus' tip) tree, and unfortunately
> VMWare still hangs if split_lock_detect= is set to anything but "off".
> 
> Was there anything else I'd needed to do?

Hmm, you're not seeing this:

  +       pr_warn("disabled due to VMLAUNCH in module: %s\n", me->name);

fire when you load the vmware kernel module? Could you slip me a copy of
that thing by private mail?
