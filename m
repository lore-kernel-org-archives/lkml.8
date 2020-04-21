Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B90C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F77A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgDUJJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgDUJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:09:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:09:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQotw-0007kp-0K; Tue, 21 Apr 2020 11:09:08 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 709D1104099; Tue, 21 Apr 2020 11:09:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
In-Reply-To: <20200421080905.GF11134@linux.intel.com>
References: <20200419203137.214111265@linutronix.de> <20200420092045.GC24518@infradead.org> <87sggyax05.fsf@nanos.tec.linutronix.de> <20200421080905.GF11134@linux.intel.com>
Date:   Tue, 21 Apr 2020 11:09:07 +0200
Message-ID: <87tv1durws.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Apr 20, 2020 at 07:27:06PM +0200, Thomas Gleixner wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>> > Just looking over some exports at the end of the series (and thus
>> > ignoring bisection issues):
>> >
>> >  - Is there any good reason to keep __flush_tlb_all inline vs moving it
>> >    out of line and kill the flush_tlb_local and flush_tlb_global exports.
>> >    Also there is just a single modular users in SVM, I wonder if there is
>> >    any way to get rid of that one as well.
>> 
>> I'll have a look again.
>
> Regarding the SVM case, the only usage is for a TLB errata.  At a glance,
> svm_init_erratum_383() and is_erratum_383() don't use any KVM hooks, i.e. I
> don't see anything that would prevent moving those to .../kernel/cpu/amd.c.

Right, but that would trade one export vs. two SVM errata specific
exports. Not really a win.

Thanks,

        tglx
