Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25209C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EE92068F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y4UGOrjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgFVITt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgFVITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:19:49 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB68CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rYw04hwsJEB97m8It9k5K0reIDQ2667gp8U3Y7MXakY=; b=y4UGOrjdI8Kb5oATsBYmmSzaZt
        y2WgvH7nECQavnlt+kzLVye3ErIkEeKc9om8RbT0fRQBeOpC7kSNsKDXlzwv9UmRJ9I9ZKIFmBREd
        klIopMr3TKyBdH1Ba37xZyFn09O4sOI4t0iKQPDSdwLQlddXxuwk65pBo5Fjb+auy9YZIOzodsK1S
        D6vV/x8agKIYs2LYskQyCHaDe3CiV8oBaFGlBisEo4Ngkh64whnhEqoWzqSfHiwXLnfZPV46eEEAg
        rFkOT5gokg/Ha7xNQfSekm7LCvZ1JMIv9I+0Pih7gCWQlfiy8t6JuvnSayZIDXqpU0gkdllnwB0gl
        Jk74/n6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnHft-00030R-PV; Mon, 22 Jun 2020 08:19:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 97F7A301631;
        Mon, 22 Jun 2020 10:18:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7763C2BF7CC09; Mon, 22 Jun 2020 10:18:58 +0200 (CEST)
Date:   Mon, 22 Jun 2020 10:18:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Biggers <ebiggers@kernel.org>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip: sched/urgent] sched: Fix RANDSTRUCT build fail
Message-ID: <20200622081858.GD577403@hirez.programming.kicks-ass.net>
References: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2>
 <202006192008.337CB5212E@keescook>
 <CAHk-=wgj17RR3zetey4fpbOxbC58A=jMt87bQ9QRe4QDnxE46w@mail.gmail.com>
 <20200622081027.GM576888@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622081027.GM576888@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:10:27AM +0200, Peter Zijlstra wrote:
> On Sat, Jun 20, 2020 at 09:32:26AM -0700, Linus Torvalds wrote:
> > Peter/Ingo?
> 
> I have the below (and a whole fair number of even more patches), but
> I've been struggling with a possibly related NULL pointer deref, which
> is why I've been holding off on landing this.

FYI the NULL pointer thing:

  https://lkml.kernel.org/r/20200620184622.GA19696@paulmck-ThinkPad-P72
