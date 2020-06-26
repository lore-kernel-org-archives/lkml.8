Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77880C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3525A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tIuW0RUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgFZLcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgFZLcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:32:47 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D8C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9F5sFgP9Bn8cXiYViW8jd6fQuEsP0WlFlPFHdqj9h4w=; b=tIuW0RUDKUL0tHC3tOR/EvjGtb
        EvACl84kLjv98Gf3yBaaYcFik7AgLAnDjSC8JECnwfVhnsyoY1jWNEC45cBf08vvItZgktkTmk1qH
        aamaQMyYgdtU7VgxtH/AU6DTD0ALcgQnMSlmnFTspApQsFOKJUUcldcnT5s9Kkrs3XEvt4QJzKXFM
        z8FmeM549x+GwIrmP6S3hljAC8FvkxacFXNryIH4qPTXL/xSgWgfhJ9hIm7IZ9lvG55ECzdtzGNJe
        XFh+uhZ9mP1unuTJOMEEVIR4bPJV+uSDsC2GFLkwC4sKR0HoWhKPewoERWd6h+nbmASoB+qri9Co/
        W0DgtV6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jomad-00085b-Oh; Fri, 26 Jun 2020 11:32:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A6F0301DFC;
        Fri, 26 Jun 2020 13:32:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C13729C4228A; Fri, 26 Jun 2020 13:32:15 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:32:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] x86/mm: Pre-allocate p4d/pud pages for vmalloc area
Message-ID: <20200626113215.GG117543@hirez.programming.kicks-ass.net>
References: <20200626093450.27741-1-joro@8bytes.org>
 <20200626110731.GC4817@hirez.programming.kicks-ass.net>
 <20200626111711.GO14101@suse.de>
 <20200626113101.GG4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626113101.GG4817@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:31:01PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 01:17:11PM +0200, Joerg Roedel wrote:
> > On Fri, Jun 26, 2020 at 01:07:31PM +0200, Peter Zijlstra wrote:
> > > Can't we now remove arch_sync_kernel_mappings() from this same file?
> > 
> > Only if we panic on allocation failure.
> 
> I think we do that in plenty places already, so sure ;-)

That is, this is boot time only, right? clone() would return -ENOMEM, as
it's part of the normal page-table copy.
