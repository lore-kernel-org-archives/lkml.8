Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB492C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B007820CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZrLkzLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgDTJUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:20:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82957C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xsDgFULRevrMl2sYWxpKGSHmJwAeC5VY0bWDB58Zd2A=; b=MZrLkzLPpycDjQP6LwIrPimNRM
        5L8jsbG/Mo/aSiWJWStljnn2qE06Q5cgrHi6ryTY8LuSjSGBRtHSIb1gGf65z0dZMwQ9Uv5JIGL1f
        qK1I5blOxqykYjfzrJ7UrzcbYZAKhmeVw1JVt6216hkQUsgTdb0VZOj09iowMR5fcBkIHLWcbsqDM
        JpsNoZWlI2Lv5MZ/y2+nFKkCimMZBfhbS4wpZEQz0NXYH/EMT1itRPifzI9AKIGAMmwx+TlF1emPf
        Vb3SiXzESC0epAhuWHEhlvZpLuLu96rcdyY1lpgcsrebCcnz+ohepTncH84NZEtpJchv6CHhfUmDb
        BwvjitWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQSbd-0007ea-N1; Mon, 20 Apr 2020 09:20:45 +0000
Date:   Mon, 20 Apr 2020 02:20:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
Message-ID: <20200420092045.GC24518@infradead.org>
References: <20200419203137.214111265@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419203137.214111265@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just looking over some exports at the end of the series (and thus
ignoring bisection issues):

 - Is there any good reason to keep __flush_tlb_all inline vs moving it
   out of line and kill the flush_tlb_local and flush_tlb_global exports.
   Also there is just a single modular users in SVM, I wonder if there is
   any way to get rid of that one as well.

Also I think cpu_tlbstate itself could be marked static in tlb.c with
a few more changes, I wonder if would be worth it?
