Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1758FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80A02469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wa3ZaFht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB1SEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:04:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1SEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CmBWpIKnnVWtlhcroBgVPn++r+PthFu+2xU5l1vUPNA=; b=Wa3ZaFhtWJ4Hy9wtAsjYEfN2o4
        V0PZ+M9bh68HsduPFTOqG8No+xXjnGXslx1yHoBU+ikNAFzs6lLd6T6nYgR4khNxBJsLWySctRIi4
        /ggGthuLa2kTOn2v7eqBXJQ6ntSg7Hh7FC874lLxj5htTN2H+hfB/HBxFaiw7ER/zIYGRDEu4SjoB
        NwLVY7/kRcm34FMiRHvzAvORSt42Ol1iaTbeFuKK48t6P0K36fo+0dnVzHD1A62iVCWzDu59ohPKp
        wkOva5VlewEX9Eob2QG+yRVZqOCWfp9e9SbCWjoUDkNuMfgLJghiy2egmjYD9RteV09lT+btsA67j
        QlDIFWYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7k0B-0004dA-Ox; Fri, 28 Feb 2020 18:04:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCFB030067C;
        Fri, 28 Feb 2020 19:02:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 386F3209E76B5; Fri, 28 Feb 2020 19:04:41 +0100 (CET)
Date:   Fri, 28 Feb 2020 19:04:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Minimize uaccess exposure in
 i915_gem_execbuffer2_ioctl()
Message-ID: <20200228180441.GL18400@hirez.programming.kicks-ass.net>
References: <ed52cfb852d2772bf20f48614d75f1d1b1451995.1582841072.git.jpoimboe@redhat.com>
 <20200227223542.GE23230@ZenIV.linux.org.uk>
 <20200228010342.3j3awgvvgvitif7z@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228010342.3j3awgvvgvitif7z@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 07:03:42PM -0600, Josh Poimboeuf wrote:
> > And why not mark gen8_canonical_addr() __always_inline?
> 
> Right, marking those two functions as __always_inline is the other
> option.  The problem is, if you keep doing it, eventually you end up
> with __always_inline-itis spreading all over the place.  And it affects
> all the other callers, at least in the CONFIG_CC_OPTIMIZE_FOR_SIZE case.
> At least this fix is localized.

I'm all for __always_inline in this case, the compiler not inlining sign
extention is just retarded,
