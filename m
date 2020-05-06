Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C8C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A1420736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfP/8Pnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgEFLhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgEFLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:37:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E2C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kqU6VorUIgGWfY+iiAfCqor/IMA70ztBrMTXurwWktE=; b=IfP/8PnwOXoiv6AGKP6OYgSHvs
        5vMHrqYyhQ/Xyc0foE5Xy1R/WbPI+19dCEzg1GtgCzd/L8gGGGj8IjMIDrVKVsnYrbf2pNu1lsoX2
        wI8qLonKFxaF7JlpX41k3wKFAp9jAAPOBp+lwxFnS2uFFB4JZcCSSFeE27FPqLzh4G8XKIHw02Tnl
        3aOugXSrqTLzORQasi4kR1yJOXSz9q6hjD4pOwPSGOz/MH3m6eeSfZapg++CzvewSIR20b4HoYarE
        LBBfok13aGPKtfGPEOwgK90G+ORmiOk0c5Hw4ebu/xPO3h5advFs1tS33uIyU7ObzolQRrkX7PbqU
        aoVW1AtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWIMX-0001bV-QN; Wed, 06 May 2020 11:37:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB7AE300739;
        Wed,  6 May 2020 13:37:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A249F2B74FC73; Wed,  6 May 2020 13:37:14 +0200 (CEST)
Date:   Wed, 6 May 2020 13:37:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>, jpoimboe@redhat.com,
        "Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>
Subject: Re: callchain ABI change with commit 6cbc304f2f360
Message-ID: <20200506113714.GA5281@hirez.programming.kicks-ass.net>
References: <CABPqkBQ13AEPrV=pUcF1L6iYOaDgN2dsVanXBa8+AqgUh87kEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ13AEPrV=pUcF1L6iYOaDgN2dsVanXBa8+AqgUh87kEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 08:37:40PM -0700, Stephane Eranian wrote:
> Hi,
> 
> I have received reports from users who have noticed a change of
> behaviour caused by
> commit:
> 
> 6cbc304f2f360 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
> 
> When using PEBS sampling on Intel processors.
> 
> Doing simple profiling with:
> $ perf record -g -e cycles:pp ...
> 
> Before:
> 
> 1 1595951041120856 0x7f77f8 [0xe8]: PERF_RECORD_SAMPLE(IP, 0x4002):
> 795385/690513: 0x558aa66a9607 period: 10000019 addr: 0
> ... FP chain: nr:22
> .....  0: fffffffffffffe00
> .....  1: 0000558aa66a9607
> .....  2: 0000558aa66a8751
> .....  3: 0000558a984a3d4f
> 
> Entry 1: matches sampled IP 0x558aa66a9607.
> 
> After:
> 
> 3 487420973381085 0x2f797c0 [0x90]: PERF_RECORD_SAMPLE(IP, 0x4002):
> 349591/146458: 0x559dcd2ef889 period: 10000019 addr: 0
> ... FP chain: nr:11
> .....  0: fffffffffffffe00
> .....  1: 0000559dcd2ef88b
> .....  2: 0000559dcd19787d
> .....  3: 0000559dcd1cf1be
> 
> entry 1 does not match sampled IP anymore.
> 
> Before the patch the kernel was stashing the sampled IP from PEBS into
> the callchain. After the patch it is stashing the interrupted IP, thus
> with the skid.
> 
> I am trying to understand whether this is an intentional change or not
> for the IP.
> 
> It seems that stashing the interrupted IP would be more consistent across all
> sampling modes, i.e., with and without PEBS. Entry 1: would always be
> the interrupted IP.
> The changelog talks about ORC unwinder being more happy this the
> interrupted machine
> state, but not about the ABI expectation here.
> Could you clarify?

Intentional; fundamentally, we cannot unwind a stack that no longer
exists.

The PEBS record comes in after the fact, the stack at the time of record
is irretrievably gone. The only (and best) thing we can do is provide
the unwind at the interrupt.

Adding a previous IP on top of a later unwind gives a completely
insane/broken call-stacks.
