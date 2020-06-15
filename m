Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436B82078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AKdMnBO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgFOQGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgFOQGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:06:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78895C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qrKBJFe3yFlrMjIAOwsfJ20n17pd7jkHQNcwSDFSIXk=; b=AKdMnBO7xavRKuRYG0bo9E6z8j
        QRkOn0k9wSipmqeTCWgHf4kLjI1n0i7+XyQA/muxYLNNS9WNUTBfRm0auJ+QG46HXdpfZI8dhwqGW
        YvDDEVDloMxawm8lfW/3QySneq2ZMHYMnSU0ASIUM7SrUF+nKRO+u3dk5NWDIGqriuMaa/fugGOtf
        jSY6AYf1GIXFL1RhnSlUekRBfevBGkjXa/o0Ko8ye0LMB+lUflzqtG0xGbau13vc5GQGWFG21IOxR
        BGNit194HzhBaoCmaXdHTy8AroAjvSQlxJWGYwmVahaBODGTiQfo4/fn+KLqGGPwfbNACNDi/bgkm
        qfV9kY0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkrcy-0001cG-IV; Mon, 15 Jun 2020 16:06:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15C6B30604B;
        Mon, 15 Jun 2020 18:06:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F175221441C0D; Mon, 15 Jun 2020 18:06:26 +0200 (CEST)
Date:   Mon, 15 Jun 2020 18:06:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200615160626.GB2531@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200603164600.GQ29598@paulmck-ThinkPad-P72>
 <20200615153052.GY2531@hirez.programming.kicks-ass.net>
 <20200615155220.GE2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615155220.GE2723@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:52:20AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 15, 2020 at 05:30:52PM +0200, Peter Zijlstra wrote:
> > What shall we do with this patch?
> 
> I plan to submit it to the v5.9 merge window.  Do you need it to get
> to mainline earlier?

Yeah, we need it this round, to make KASAN/KCSAN work with the noinstr
stuff that just landed.
