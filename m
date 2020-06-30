Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087AFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9248206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eAS27j4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgF3UV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgF3UV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:21:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE4C061755;
        Tue, 30 Jun 2020 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pAld+PmSm3uQ9OLHyA9LsKDVn58a/UVYkn4lwoGnumM=; b=eAS27j4l5VKQ8En/OF9eH/i5RP
        +zf93Ed62vvzDVNpm3OQPePdECVVSJpOKoPHPo0qto2p1L5df+7KSwptQDd/nIrdnpM5pzrhFjqJW
        Gay6KM35iiIdnoVMtvL/4zFrkRmS8yLmL8kAueTKNarZQya4QhxBswEHfzITY6U2oKozvVDs84Yl7
        8YFxk3ukDS3ImbkleuGENzLAnxsGWZJK4RrZ92k+myKvwxG+jTKqc4UERDxZlwKgkAJCQy/4cc2Xk
        2MFT8Aygu1X6cIf9AXIRkGnOEsa+DHSPoHT2y4I+azRP5RQAjvGtlG/6aByC0gvgXiSJN2XicZtSl
        46R2yNXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqMkd-0000sY-D6; Tue, 30 Jun 2020 20:21:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A75C130015A;
        Tue, 30 Jun 2020 22:20:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 850D8203A69CB; Tue, 30 Jun 2020 22:20:59 +0200 (CEST)
Date:   Tue, 30 Jun 2020 22:20:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200630202059.GE4817@hirez.programming.kicks-ass.net>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPOO=AVsVJMdL8sq03jwHsDR_1_FfWccwaLKEBRn1RFtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:47:30PM +0200, Marco Elver wrote:
> I do wonder, though, if there is some way to make the compiler do
> something better for us. Clearly, implementing real
> memory_order_consume hasn't worked out until today. But maybe the
> compiler could promote dependent loads to acquires if it recognizes it
> lost dependencies during optimizations. Just thinking out loud, it
> probably still has some weird corner case that will break. ;-)

I'd be very hesitant to let the compiler upgrade the ordering for us,
specifically because we're not using C11 crud and are using a lot of
inline asm.
