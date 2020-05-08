Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22E4C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E0D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R2Z1iM0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEHLeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgEHLen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:34:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD4C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zmT/9HhrK4nvh4JtdKN0+HN2mb+fKCeU0dPRJaqTdWU=; b=R2Z1iM0AMAYz6h8BFNxy4mK7Uq
        Nze/KtgV9jYKq2lfhk1VhalsciUS3MhU0MXdKnSZolSc3zU+9asFuTV9Or+DwN9nnA9jNsggtPYsU
        nkrPejgfjzV4PjQB/u6keTM/26AUOA8gK4BznngTK8UhhlGBejAeIqkYVrI6ps0bQdt88V0zPih7Q
        VUxKYnWkc0wNzUaZu4OsXySCVo9YgWNpYyMtNFkIdsQecYPbFbZ6YY8kLK9KPJWhskc4ER8z3rK68
        OE52fKPkDohG4qPdDK/m9DHyZ1x0U95ohHU/8r7E8+G76xDafIGArTOlRnIhor/3fAPD8L4CHjEeI
        ARwuLU/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX1H5-0003xB-NZ; Fri, 08 May 2020 11:34:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 403CB30018B;
        Fri,  8 May 2020 13:34:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27A962B8CAD9A; Fri,  8 May 2020 13:34:38 +0200 (CEST)
Date:   Fri, 8 May 2020 13:34:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Use INVPCID mnemonic in invpcid.h
Message-ID: <20200508113438.GC5298@hirez.programming.kicks-ass.net>
References: <20200508092247.132147-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508092247.132147-1-ubizjak@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:22:47AM +0200, Uros Bizjak wrote:
> Current minimum required version of binutils is 2.23,
> which supports INVPCID instruction mnemonic.
> 
> Replace the byte-wise specification of INVPCID with
> this proper mnemonic.

Excellent, thanks for doing these cleanups.

(also for the rand one):

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
