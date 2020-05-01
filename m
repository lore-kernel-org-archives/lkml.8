Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA449C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A442F20787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lDsKQuLy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgEASHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbgEASHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:07:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7D8C061A0C;
        Fri,  1 May 2020 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CCU7COW6TmuLlpd3D8olwzP6MeUGfBALcg7l9bZ+L6o=; b=lDsKQuLyt8dSCCyWvNbGxrsxVi
        ag11nO5AZ7PpT8J0JqUP/25/z+jtILd25a7PqmRVtY/uOBBWYPMdORBqRGxspy7PbRWRSJd4aIXbX
        aOJkocCHCjYoFjDXNhoWO3hBkg8LaCbOpJJqAqedszFeATpQV7pZe8gchBJzx/9MdurbQGehXR+4w
        6fLd7cRRLGCr3bHPMCwKGZ3FMS9/74Kz6WHawoEe4rhX3CVrPvtvTNbGYiR8gE3YAnhzSnOnQ7QVp
        Ra2JKSjcQjYRXHfGcxkouCbHzVqQKCF6RSZYfHawzuqd7deLquZrCTW271AxVg07y4vByoPGl/18Y
        6p2GU2Yw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUa4R-0004pn-M6; Fri, 01 May 2020 18:07:31 +0000
Date:   Fri, 1 May 2020 11:07:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, bigeasy@linutronix.de,
        tglx@linutronix.de, chris@chris-wilson.co.uk,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: check to see if SIMD registers are available
 before using SIMD
Message-ID: <20200501180731.GA2485@infradead.org>
References: <20200430221016.3866-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430221016.3866-1-Jason@zx2c4.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:10:16PM -0600, Jason A. Donenfeld wrote:
> Sometimes it's not okay to use SIMD registers, the conditions for which
> have changed subtly from kernel release to kernel release. Usually the
> pattern is to check for may_use_simd() and then fallback to using
> something slower in the unlikely case SIMD registers aren't available.
> So, this patch fixes up i915's accelerated memcpy routines to fallback
> to boring memcpy if may_use_simd() is false.

Err, why does i915 implements its own uncached memcpy instead of relying
on core functionality to start with?
