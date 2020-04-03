Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0330BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EFF206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tzZR5jEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404193AbgDCPW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:22:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404171AbgDCPW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uzmJljZM/KQ/xQJa18Yo/qe+BC3A7JIGAtH95frw7pI=; b=tzZR5jEhA7wgjH8i/Ea1meQj6J
        i1KwzmuPePDp5V9IznG6eVCK3KH4zGNk8ue4fa60OCVzz71RVCnswmDcWsaXzRnhYsLu6gjxBbOx3
        X1HpYa+lW/l0zGtSMYbdX1o4/WaCee7btfhAFA8MKvB5lpQK1m6iUqROC4L1/18A/BmMnKZCalL7k
        z7HY3P4ap/SwYwKGbsJ8PSuaQA+xRH0JKCLI/EaGfvqx08mjDXucm8BAXzGvS3hjavpG9cQ5b+ATa
        5Lpp22o6ofbDTO/gSQO83p+D3skfXD0kdzSNriG/DwiX7si82MOofjh3eg0TkWf7BBIIAyzcTIE5y
        xsKbrpDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKO8v-0001dj-7N; Fri, 03 Apr 2020 15:22:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0EA73304DB2;
        Fri,  3 Apr 2020 17:21:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDCC52B12426C; Fri,  3 Apr 2020 17:21:58 +0200 (CEST)
Date:   Fri, 3 Apr 2020 17:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403152158.GR20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
 <20200403143459.GA30424@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403143459.GA30424@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:
> +++ Rasmus Villemoes [03/04/20 01:42 +0200]:
> > On 02/04/2020 14.32, Thomas Gleixner wrote:
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > 
> > > It turns out that with Split-Lock-Detect enabled (default) any VMX
> > > hypervisor needs at least a little modification in order to not blindly
> > > inject the #AC into the guest without the guest being ready for it.
> > > 
> > > Since there is no telling which module implements a hypervisor, scan the
> > > module text and look for the VMLAUNCH instruction. If found, the module is
> > > assumed to be a hypervisor of some sort and SLD is disabled.
> > 
> > How long does that scan take/add to module load time? Would it make
> > sense to exempt in-tree modules?
> > 
> > Rasmus
> 
> I second Rasmus's question. It seems rather unfortunate that we have
> to do this text scan for every module load on x86, when it doesn't
> apply to the majority of them, and only to a handful of out-of-tree
> hypervisor modules (assuming kvm is taken care of already).
> 
> I wonder if it would make sense then to limit the text scans to just
> out-of-tree modules (i.e., missing the intree modinfo flag)?

It would; didn't know there was one.
