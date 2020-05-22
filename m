Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D3EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C540206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a+N5qy4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgEVSc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbgEVScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:32:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3ACC061A0E;
        Fri, 22 May 2020 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YiWX8PSe+YxoZE0lzb3waTVzRHLdsNcuaqQrt0IUe8I=; b=a+N5qy4ROAfaKBFeC1Bw25/wmJ
        0XO+eBGZCD/2xnaKt4lupSjjTn3yoKcRX4p+RYxAWFKwvDhv27yQZN3vkG9nrQZS+raSgKGU/dtnK
        fL/RNqwiV/GwLg8+2UETcn0B55i5zB947IHPoP352Wj6tfLx2lmZj0Ye788RNnMTcqqeXvIy4AkLx
        DITIF8MPabWn3oqBKBGGow23tm6TN36C/qCtgtSRYTFXzgc4Akqt130pRHa/YyuLSS/CWJWxBC3K0
        zVe5HM6lt5nuWalMQ8AdLLqZyMpH3OA0Dlny5gDsClKPsGqxZDK1UfugIGmFrNineSY7o1nQcjSPF
        UMbb7X6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcCSx-0002ts-0D; Fri, 22 May 2020 18:32:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FEEC301AC6;
        Fri, 22 May 2020 20:32:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F127321462C28; Fri, 22 May 2020 20:32:16 +0200 (CEST)
Date:   Fri, 22 May 2020 20:32:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 10/25] seqlock: Add RST directives to kernel-doc code
 samples and notes
Message-ID: <20200522183216.GT325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-11-a.darwish@linutronix.de>
 <20200522180254.GS325280@hirez.programming.kicks-ass.net>
 <20200522180336.GD325303@hirez.programming.kicks-ass.net>
 <871rnbsu57.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rnbsu57.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:26:44PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Fri, May 22, 2020 at 08:02:54PM +0200, Peter Zijlstra wrote:
> >> On Tue, May 19, 2020 at 11:45:32PM +0200, Ahmed S. Darwish wrote:
> >> > Mark all C code samples inside seqlock.h kernel-doc text with the RST
> >> > 'code-block: c' directive. Sphinx won't properly format the example code
> >> > and will produce noisy text indentation warnings otherwise.
> >> 
> >> I so bloody hate RST.. and now it's infecting perfectly sane comments
> >> and turning them into unreadable junk :-(
> >
> > The correct fix is, as always, to remove the kernel-doc marker.
> 
> Get over it already.

I will not let sensible code comments deteriorate to the benefit of some
external piece of crap.

As a programmer the primary interface to all this is a text editor, not
a web broswer or a pdf file or whatever other bullshit.

If comments are unreadable in your text editor, they're useless.
