Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34190C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1073F2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zc3NNU9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFQOix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgFQOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:38:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF7C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kz+LMLXOVZt0DhWuklquEirxsE+Y/8beNA/Kd+7/KLk=; b=Zc3NNU9CE/FA3EHevP4Wvy/DuS
        rPJVvum9vS4DXvB7GyGP/8H/UMmfIUTxk6PeluJOy7vk8JPg15tEY6xlEgc0F2gRKq8ezhPWPALwN
        UpIEIDhfYr49Z43uzuRCQuvtbQFTsbS4DvAm2Zd0IfHLbJDBSmSWnH0zokWENblhaHWUPGsJ/cdbR
        nHKvmLmdU+cvsMP3a35uS3EfDG8NifkmMbP9JX4zBy3okUv7uOPgVeY511J/NQcQUL/gwE+y+YwW7
        P0TRxeyJVJR288qi6jFtJZNSgCNG/mnmqQqAJr6OONb2iAxquFrCmcFklCLFNV3bQ77frYWq4rVIH
        Ihc5AFoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlZCx-0007S4-A5; Wed, 17 Jun 2020 14:38:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2736301A32;
        Wed, 17 Jun 2020 16:38:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5C0A203CE7EE; Wed, 17 Jun 2020 16:38:26 +0200 (CEST)
Date:   Wed, 17 Jun 2020 16:38:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] powerpc/8xx: Provide ptep_get() with 16k pages
Message-ID: <20200617143826.GJ2531@hirez.programming.kicks-ass.net>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
 <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu>
 <20200615132244.GR2531@hirez.programming.kicks-ass.net>
 <87wo45db8d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo45db8d.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:21:22AM +1000, Michael Ellerman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Mon, Jun 15, 2020 at 12:57:59PM +0000, Christophe Leroy wrote:

> >> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> >> +#define __HAVE_ARCH_PTEP_GET
> >> +static inline pte_t ptep_get(pte_t *ptep)
> >> +{
> >> +	pte_t pte = {READ_ONCE(ptep->pte), 0, 0, 0};
> >> +
> >> +	return pte;
> >> +}
> >> +#endif
> >
> > Would it make sense to have a comment with this magic? The casual reader
> > might wonder WTH just happened when he stumbles on this :-)
> 
> I tried writing a helpful comment but it's too late for my brain to form
> sensible sentences.
> 
> Christophe can you send a follow-up with a comment explaining it? In
> particular the zero entries stand out, it's kind of subtle that those
> entries are only populated with the right value when we write to the
> page table.

static inline pte_t ptep_get(pte_t *ptep)
{
	unsigned long val = READ_ONCE(ptep->pte);
	/* 16K pages have 4 identical value 4K entries */
	pte_t pte = {val, val, val, val);
	return pte;
}

Maybe something like that?
