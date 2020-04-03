Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743BBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4480220721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Od5mHxiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbgDCNfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:35:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Fv+UOKy4KHt2Z9usek/+CovcC6jaN8rXPg7IhrjHeJc=; b=Od5mHxiEexHfiHhDYreDpAjqc2
        HoL9QFJUHhnmyc0umq4xGl+rKisEKFaEUXgSqbfbg6yYyQsy9WM+WfEPBks+D8xH5Jc21ZX+PjSzA
        Gv6PHcrrMR2ckHx2QgIsfc7gKMvILb/9dcI3lr03m+0BDjZ/x7srP+bsJ29Yo5vd1/Ktw1NRGZt8R
        gv4+71LE0qGQukKBUMwYCOfYvHg+ngRecjIYNphecSHc/Em3q89N9DeBkI408jkIj1wjvIqJI5mvA
        dIwd/8pZEdDDDkKibFlXfmTZgYPQPwrCAAgf2clmhs6EBNjZWcvjpdXtTEtvBW//e2i354xKHw7E5
        +Z7AqNOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKMTt-0003hr-58; Fri, 03 Apr 2020 13:35:33 +0000
Date:   Fri, 3 Apr 2020 06:35:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Question on "uaccess: Add strict non-pagefault kernel-space read
 function"
Message-ID: <20200403133533.GA3424@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I just stumbled over your above commit, and it really confuses me.

Not the newly added functions, which seems perfectly sane, but why you
left the crazy old functions in place instead of investing a little
bit of extra effort to clean the existing mess up and switch everyone
to the sane new variants?

