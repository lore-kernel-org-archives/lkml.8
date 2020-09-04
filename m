Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A3CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7AA2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="clSU95wH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgIDNBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730311AbgIDNAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:00:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D2AC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EJr4/0pOzIyMgNRBIBv/XOtcgAjh5svDusRASQ+9TJY=; b=clSU95wH459cRR7GBjGVumHpp2
        zpLmTEy2jUnWn0DFKYJkaI4Z/7WE49Ls/EbHHzU1E7gCt3KMw38OCkJm95ue6yd92ZSTpd+UYCLD8
        SVF0NwfM0bObt6ebhl8rYZgCaFgpxAJUGlMctnrrqNccn4zORLPPMB3tMd2b5ijb8fFTC2Asew+ER
        fHYlLf5hqN/UTQ4MgI6e8EhL+68LK78d6CSa/uBFeu/mQVv0/4ngg39Eq9J3Xb5b3zTRs//z/12SL
        GrkZLjpZFAf5n+8P2GH5XOIU8yV45LkFFmNB8DDV70YkaxePItCA+gBtNoQmxWbzwfkTBrkb/gqQB
        6JHiDS+Q==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEBKf-00029q-1C; Fri, 04 Sep 2020 13:00:45 +0000
Date:   Fri, 4 Sep 2020 14:00:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qiu Wenbo <qiuwenbo@kylinos.com.cn>
Cc:     Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
Message-ID: <20200904130044.GA7842@infradead.org>
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
 <20200904083109.GA9182@infradead.org>
 <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
 <20200904094617.GA27846@infradead.org>
 <CAAhSdy2x0ROqoTzzZRZgKCTL99WPy-8e4CQ921sf-=GQDm_gxA@mail.gmail.com>
 <f1be6ee1-0802-82ca-ffdb-4c294925cd9a@kylinos.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1be6ee1-0802-82ca-ffdb-4c294925cd9a@kylinos.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:58:25PM +0800, Qiu Wenbo wrote:
> I can confirm this patch also breaks K210 support. It seems that
> csr_read(CSR_TIME) will trigger an illegal instruction exception on K210.

CSR_TIME is trapped by just about every implementation I know (which is
explicitly allowed by the spec).  That is why we should never use it
from common M-mode code.
