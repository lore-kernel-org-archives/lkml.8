Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0B0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CA1206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DaOIMy8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgDLIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:15:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pSSwln3aLppcpE4xqhflaqxu5mGVGF8itmWUGnMf2Tw=; b=DaOIMy8jBOwtO8CHaskzAV+V+h
        0WK2KOvnQxBvWA+jBBcoidio1dCMseYNrcUZZ9wyshfdTMUGcQhGSGwB7HQWH6yUQVqWBNvgd1uEe
        2itca0xlRsVMxSYoY1O7FpAdTMsvk0lIxTSvj1pYRRo2fJ5A/uwLsVXEXF4i7NgPDatNY6KDkZsUE
        lH8oiL1QFsTrmqlS4kI9DaE5kc0NOH1PH6qBKW8ubtgrWQxM/L3oOMTNKCSOb64YMpjebNvYy5C2N
        sg9LXF+RWjj4U18lrWxasDzXamvDoZqr6PVaRJg8LQHbhZ+f92izc/+r4+mJavwZtKxqQKqT5fDNG
        qYZULJDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNXlW-00056k-WC; Sun, 12 Apr 2020 08:14:54 +0000
Date:   Sun, 12 Apr 2020 01:14:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 6/9] mm: export-GPL get_pageblock_migratetype
Message-ID: <20200412081454.GA7464@infradead.org>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
 <20200409193543.18115-7-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409193543.18115-7-mathieu.desnoyers@efficios.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 03:35:40PM -0400, Mathieu Desnoyers wrote:
> The macro include/linux/mmzone.h:get_pageblock_migratetype() uses
> the symbol get_pfnblock_flags_mask, which is not exported. That macro is
> used within the kmem and page_ref trace events to trace the migrate type
> of the target page.
> 
> Exporting this symbol to GPL modules allows GPL kernel tracers to be
> implemented as modules.

Which might make some sense if we had such intree modules (and then even
some as we could have higher level functions).  Without that is
obviously is a no-go.
