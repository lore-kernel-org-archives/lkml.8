Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CB1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77982071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqW+siR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389782AbgEYSIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgEYSIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:08:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC08C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KtQ2SC4NpHGImf+Tkc9R2teElcvTerbBEl4X1UzaM28=; b=lqW+siR8qtiAMM7Ddod74VaBie
        aKsujkrzo3JVXxk/qIICnnccnJVJQt884GIWER0zPUzXJx2nqGRAaNsxMYV8Sq6Q/SEEGo0XkPDGZ
        /EJvlWvTNo1OW7TwjorFNCsMZnnwVc0WmjxVSUXHy8V1ZyVlr8uQ7YU4BrKmAF9keKI60F6cjpSNg
        an2IerjCCfGD+L39XIeikvdlcQdIiZOWtxTy40xrRZxC6jNg7FnMWiSLlWJA/aDKrheGokOqDoKtm
        SkSbxJdQZexIBIGyFAH6W4D0YCbhbsX5YwUmOyZ60cOtstxHtc8GrwuxBawUvvZepEO7UwJX52gKD
        MuSgxKyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdHWe-0004PD-Vv; Mon, 25 May 2020 18:08:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D698300478;
        Mon, 25 May 2020 20:08:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5847720BD4F43; Mon, 25 May 2020 20:08:34 +0200 (CEST)
Date:   Mon, 25 May 2020 20:08:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Message-ID: <20200525180834.GF317569@hirez.programming.kicks-ass.net>
References: <20200525110101.GG325303@hirez.programming.kicks-ass.net>
 <2E6DBDE0-FEEA-467F-A380-4ED736B6C912@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2E6DBDE0-FEEA-467F-A380-4ED736B6C912@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 10:19:08AM -0700, Andy Lutomirski wrote:

> How about adding it to cpu_tlbstate?  A lot of NMIs are going to read
> that anyway to check CR3.

That might work I suppose; we're really pushing the name of it though.
Also, that's PTI specific IIRC, and we're getting to the point where a
significant number of CPUs no longer need that, right?

> And blaming KVM is a bit misplaced. This isn’t KVM’s fault — it’s
> Intel’s. VT-x has two modes: DR access exits and DR access doesn’t
> exit. There’s no shadow mode.

It's virt, I can't be arsed to care, whoever misdesigned it.
We already have debugreg pvops, they can do shadow there.
