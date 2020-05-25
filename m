Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE14C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93C820787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vj94z+hZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbgEYKkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389720AbgEYKkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:40:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59340C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sIUI+YPLgD2hagR/iJQt63IkQVxKJY9bIci/+8x+1dk=; b=Vj94z+hZdyKBPeRdZwlWWDAU6x
        N2qUL8WOfOY0c4eGSqrpuaktGUf95PbOJF6lWgO/Y02ZYBQ7o7KmHgDF+Cjy1xgqaE2Jbxs13B1M0
        MOD/vuyB+EupihuS7Y2H6EjEUJrWlF0UyPDkJj+sKNVqyxtKVhyaeu6a8I0/YYfLI9ikA7IpYUFjL
        kOC3+wmAo9kLVUIGcf+t8CcTBHm29FfL17gRg5UBW+D/9VQgMks7p8su9cEyP1R/PM/J3IyXnBvXU
        WjPLgl3XkMBjUaOwyOVRC5JMxfa3kMO16TKUzY/PlIsw98dGRlksNcBOdkdK3ldm4QDfY5hIwtpU4
        XY1YLb8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdAXB-0002T9-0c; Mon, 25 May 2020 10:40:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E5D730018B;
        Mon, 25 May 2020 12:40:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EE510286BFC17; Mon, 25 May 2020 12:40:38 +0200 (CEST)
Date:   Mon, 25 May 2020 12:40:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Message-ID: <20200525104038.GC317569@hirez.programming.kicks-ass.net>
References: <20200522204738.645043059@infradead.org>
 <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
 <20200523125940.GA2483@worktop.programming.kicks-ass.net>
 <20200523213235.GB4496@worktop.programming.kicks-ass.net>
 <cd2f91e4-aa90-eb98-7f8c-218e8521ac85@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd2f91e4-aa90-eb98-7f8c-218e8521ac85@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 12:02:48PM +0200, Rasmus Villemoes wrote:

> Naive question: did you check disassembly to see whether gcc threw your
> native_get_debugreg() away, given that the asm isn't volatile and the
> result is not used for anything? Testing here only shows a "mov
> %r9,%db7", but the read did seem to get thrown away.

Argh.. no I did not. Writing it all in asm gets me:

[    1.627405] XXX: 3900 8304 22632

which is a lot worse...
