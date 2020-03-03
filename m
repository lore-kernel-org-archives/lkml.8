Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A20C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D00220CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 20:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQHpYVWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbgCCU3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:29:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731014AbgCCU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2KSB++ZbtkifqshAnPPnsHVWacXwMvTsEnkWHJwAWlM=; b=dQHpYVWCdTn5oEcaKBDZ8URmYN
        qfcjKgs2XftzS9NaT4au9d/LpTHvdlH0nxN1VaRg+Dog1JuAHeOSCr9rJIHpouyW1t/qhBBQSMCYZ
        KFaZnhhLauDttQKoUHDh9GBzRwfBa9kbcMhKWT0oYkFoFl/gmUL+Jdw7GeNHg/+zmciT5ZRzQpN7/
        08x5jN+Urzz47dqy0nnxcwa32ljpyWB0QKCMz4h1FWChBAQWFurKWlCtD8OTSF7fF/v1G5ptWAIkB
        vYDfDXahCu7VwUH9/EIEA5zxFnUuqmvDITRBvNnXozMEWEx3276hW15ijiTrm+fcoQoNj6unQ29ob
        FYmNUKpg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9EAN-0001fs-JQ; Tue, 03 Mar 2020 20:29:23 +0000
Date:   Tue, 3 Mar 2020 12:29:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] proc: Use ppos instead of m->version
Message-ID: <20200303202923.GT29971@bombadil.infradead.org>
References: <20200229165910.24605-1-willy@infradead.org>
 <20200229165910.24605-4-willy@infradead.org>
 <20200303195529.GA17768@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303195529.GA17768@avx2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:55:29PM +0300, Alexey Dobriyan wrote:
> On Sat, Feb 29, 2020 at 08:59:08AM -0800, Matthew Wilcox wrote:
> > -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> > +static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
> 
> This looks like hungarian notation.

It's the standard naming convention used throughout the VFS.  loff_t is
pos, loff_t * is ppos.

$ git grep 'loff_t \*' fs/*.c |wc
     77     556    5233
$ git grep 'loff_t \*ppos' fs/*.c |wc
     43     309    2974
$ git grep 'loff_t \*pos' fs/*.c |wc
     22     168    1524

