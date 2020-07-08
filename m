Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7185C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E81520720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="siEl9fgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgGHO4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:56:42 -0400
Received: from casper.infradead.org ([90.155.50.34]:36540 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgGHO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eu/kYmb813u1ZgBXd0rdHnEokAFSGGHrxUlCHt8bJuY=; b=siEl9fgU4Uy0PenzYaRquRLGvb
        b1ZJK0+WjPwBiQRFzcuY61wsylkiuNmCkSoJAjH1N8epNxmvTh0l0+iQohckauW6bZEIAvjJqv0WT
        iTE7ljss9oefyA9LMa9JGNWjxdhPxQNXa+ka2XO+tKj2eFGPg5FkxGyoREbfxjxU3LtktWwmu7aw+
        j3c+NvZBzG4JYMbWqfzWZREYYvWMf5SZmNbdwIil3mv1t2W0XLhBjQkQ74r8PnF+8Sr371ZYwBnBh
        Rf4+KH+jLtzVmksfFrpBcni1mr2IN6rAjYC/+ggiRIkGPmDbXUrqwiVUMdXOBWZDNAchr7vxX5z+B
        SB6sIlUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtBUn-0000ln-DI; Wed, 08 Jul 2020 14:56:26 +0000
Date:   Wed, 8 Jul 2020 15:56:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: use 16KB kernel stack on 64-bit
Message-ID: <20200708145625.GA438@infradead.org>
References: <mvmeepoddt1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmeepoddt1.fsf@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 02:32:26PM +0200, Andreas Schwab wrote:
> With the current 8KB stack size there are frequent overflows in a 64-bit
> configuration.

Adding irqstack support would be the better fix..
