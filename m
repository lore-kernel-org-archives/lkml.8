Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61243C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ysjg7rsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgDQPrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728593AbgDQPrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:47:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C27C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HDRDbJd2M4qiCgjpoZQhZ31JvaoOb1sTaN9fveDaTJE=; b=Ysjg7rsRv8f4AtxBOZkNUdzkap
        jjG9O7xTEECfR1lzCTGcK40z/woI/GZqIa0YJhR0qkMw+62vqvxwSLJ8qx/y5gpu9BOwINgi5BT8B
        5wBi/VqyuCZq/RAdNMPahC1amqdi3pQHOobCM9s2Td7hFQ1YdffHNrq777ocJJa45J8iVG6z0bIAD
        VzgH+xK0aPb1LT3lZbrpRicKuPv28WciTB9BNqH9yxQ4fFiLTeVxVQCdcMnri6yCQR0B5SAPg0Ojc
        v+m7WUhL6pjRMf9jfv3Ae77lLFUY+FnOZUBl5XvZLH/ZNTedT5aUtkf1DZTzjG3eOloV4r6IioGfi
        1Ol16sPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPTD3-0005ex-C2; Fri, 17 Apr 2020 15:47:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB5F730477A;
        Fri, 17 Apr 2020 17:47:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD0592B12192B; Fri, 17 Apr 2020 17:47:14 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:47:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] x86/mm/pat: Restore large pages after fragmentation
Message-ID: <20200417154714.GI20730@hirez.programming.kicks-ass.net>
References: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416213229.19174-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:32:29AM +0300, Kirill A. Shutemov wrote:
> +static void cpa_restore_large_pages(struct cpa_data *cpa,
> +		struct list_head *pgtables)
> +{
> +	unsigned long start, addr, end;
> +	int i;
> +

> +	start = __cpa_addr(cpa, 0);
> +	end = start + PAGE_SIZE * cpa->numpages;
> +
> +	for (addr = start; addr >= start && addr < end; addr += PUD_SIZE)
> +		restore_large_pages(addr, pgtables);

Isn't that loop slightly broken?

Consider:

	         s                     e
	|---------|---------|---------|---------|
                 a0        a1        a2        a3

Where s,e are @start,@end resp. and a# are the consecutive values of
@addr with PUD sized steps.

Then, since a3 is >= @end, we'll not take that iteration and we'll not
try and merge that last PUD, even though we possibly could. One fix is
to truncate @start (and with that @addr) to the beginning of the PUD.

Also, I'm afraid that with my proposal this loop needs to do PMD size
steps. In that regard your version does make some sense. But it is
indeed less efficient for small ranges.

One possible fix is to pass @start,@end into the
restore/reconstruct/collapse such that we can iterate the minimal set of
page-tables for each level.



