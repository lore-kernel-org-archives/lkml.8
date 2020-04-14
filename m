Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2FAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3572075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOGD0uXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502506AbgDNNCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502475AbgDNNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:02:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952DC061A0C;
        Tue, 14 Apr 2020 06:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T6z0bd+fqDvkVl7fHhA0/8UcwUryWcByqLrcGyIrH5s=; b=bOGD0uXfBJxjATisnWE13caPpw
        yM9EhSXpjZ/69j68Wx2mvv4rPOnCCnL4tZZOnQ/NrScoRBkaop1XY/iOcVOh0AkRZpQOQz5AVjtpv
        cMV61Q/X5bapJJYHYlrURSsjHy7o3Gg83EN4vlKiDfRTyRH5zdQnD3aKzJJQD/Kfm9D/MZmyrS5dF
        6Bl0eEJCl5IRt9WB6xgPE10wzHrxN2D4jZ8Wklbvo3XU7xQtw94VjIEPtaSS9ZKYl/NsjwULmC+Yi
        /zy17VuWZ3bNc0Ndims46fX3T7ww6xbwzSO+4eEXTFMbss0b2VRfn9nH14CqQ8MjZl0Uf7RSHY+CP
        kRablIbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOLCV-0005fb-Ei; Tue, 14 Apr 2020 13:02:03 +0000
Date:   Tue, 14 Apr 2020 06:02:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200414130203.GA20867@infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
 <20200414072316.GA5503@infradead.org>
 <1586864403.0qfilei2ft.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586864403.0qfilei2ft.astroid@bobo.none>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:13:44PM +1000, Nicholas Piggin wrote:
> Which case? Usually the answer would be because you don't want to use
> contiguous physical memory and/or you don't want to use the linear 
> mapping.

But with huge pages you do by definition already use large contiguous
areas.  So you want allocations larger than "small" huge pages but not
using gigantic pages using vmalloc?
