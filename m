Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D823C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6224920736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDTUJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgDTUJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:09:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E9C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 13:09:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQcio-00068z-3f; Mon, 20 Apr 2020 22:08:50 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 580D5101623; Mon, 20 Apr 2020 22:08:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
In-Reply-To: <913b9a53-1df4-e371-a3d8-867d1242c341@oracle.com>
References: <20200419203137.214111265@linutronix.de> <20200420092045.GC24518@infradead.org> <913b9a53-1df4-e371-a3d8-867d1242c341@oracle.com>
Date:   Mon, 20 Apr 2020 22:08:49 +0200
Message-ID: <87368xx6lq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:
> On 4/20/20 11:20 AM, Christoph Hellwig wrote:
>> Just looking over some exports at the end of the series (and thus
>> ignoring bisection issues):
>> 
>>   - Is there any good reason to keep __flush_tlb_all inline vs moving it
>>     out of line and kill the flush_tlb_local and flush_tlb_global exports.
>>     Also there is just a single modular users in SVM, I wonder if there is
>>     any way to get rid of that one as well.
>> 
>> Also I think cpu_tlbstate itself could be marked static in tlb.c with
>> a few more changes, I wonder if would be worth it?
>> 
> For Address Space Isolation (ASI), I was planning on storing the ASI session
> into cpu_tlbstate (https://lkml.org/lkml/2020/2/26/699) as the ASI session
> then provides the TLB flushing information based on the ASI used. In that case,
> I would need cpu_tlbstate to be non-static. Otherwise I can have my own percpu
> asi_session structures, but using cpu_tlbstate seemed more appropriate to me.
> This is opened for discussion; for now, I am waiting for more changes that tglx
> is making, before rebasing ASI.

Even in that case we could restrict the availability to arch/x86/mm/
which would still make it available for ASI.

Thanks,

        tglx
