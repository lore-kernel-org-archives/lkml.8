Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1226C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10A42063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FBu4Z94X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbgDBPLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:11:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56816 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388910AbgDBPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4boUc8yqYKOgnT+886f3JGYhVM1rD+O9Z6mA5uBaoLY=; b=FBu4Z94X6s9X9Rr40z43GFuwAJ
        SPD1rDakWUVAGDUNIgFUZi3CNVAD4SjEKXNphXyMuVdAhY2P4A7/Ep2/8ZTjEryzUONivzyslc6eP
        LpIeEuT5jtW9GEZTNtjzz+zfjNbNeCJLX/wO6ihBWIWYzJVWBpLBV8Fv8Mt9XRjiq9Rq3lTkiuHyG
        Scd07cl0YreITJdNh100Iym9bDRhHYvepIfxoY6qAkqZNbPDVZUL0wnJiyTegcax3JJBrOU8IiZ8e
        tO/fZ6mlUou9nWk3JAwEDOWH5BKePwqkRFs0TAVV1tNcg9nTgYhZRpbiRpt4x9pgmGPtTh3V508ll
        tEhEz5mQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK1V2-0004Zo-UC; Thu, 02 Apr 2020 15:11:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4273E3010BC;
        Thu,  2 Apr 2020 17:11:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E7C682B0DEBCD; Thu,  2 Apr 2020 17:11:18 +0200 (CEST)
Date:   Thu, 2 Apr 2020 17:11:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 0/2] x86: Prevent Split-Lock-Detection wreckage on VMX
 hypervisors
Message-ID: <20200402151118.GK20713@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <alpine.DEB.2.21.2004020641470.7052@xps-7390>
 <875zeinecr.fsf@nanos.tec.linutronix.de>
 <D07135B9-576F-4232-8A1B-BEC5D26F35B8@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D07135B9-576F-4232-8A1B-BEC5D26F35B8@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:47:33PM +0000, Nadav Amit wrote:
> > On Apr 2, 2020, at 7:37 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > "Kenneth R. Crudup" <kenny@panix.com> writes:
> > 
> >> On Thu, 2 Apr 2020, Thomas Gleixner wrote:
> >> 
> >>> As Peter and myself don't have access to a SLD enabled machine, the
> >>> KVM/VMX part is untested. The module scan part works.
> >> 
> >> I just applied both of these patches to my (Linus' tip) tree, and unfortunately
> >> VMWare still hangs if split_lock_detect= is set to anything but "off".
> >> 
> >> Was there anything else I'd needed to do?
> > 
> > Hmm. Not really. Does dmesg show the warning when the VMWare module loads?
> > Something like:
> > 
> >  x86/split lock detection: disabled due to VMLAUNCH in module: ….
> 
> I ran an objdump on VMware workstation and indeed I do not see a
> VMLAUNCH/VMRESUME. I do see however VMXON which should also be good for
> detecting hypervisors. I will try to understand why VMLAUNCH is not there.

Let me send a version with VMXON detection added in as well.
